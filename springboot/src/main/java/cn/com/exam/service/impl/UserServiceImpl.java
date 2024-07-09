package cn.com.exam.service.impl;

import cn.com.exam.DTO.UserAddClassesDTO;
import cn.com.exam.DTO.UserClassesDTO;
import cn.com.exam.dao.ClassesDao;
import cn.com.exam.dao.UserClassesDao;
import cn.com.exam.dao.UserDao;
import cn.com.exam.dao.UserPasswordDao;
import cn.com.exam.entity.Classes;
import cn.com.exam.entity.User;
import cn.com.exam.entity.UserClasses;
import cn.com.exam.entity.UserPassword;
import cn.com.exam.enums.Position;
import cn.com.exam.enums.Role;
import cn.com.exam.service.UserService;
import cn.com.exam.utils.MD5Util;
import cn.com.exam.utils.Msg;
import cn.com.exam.utils.Page;
import cn.com.exam.utils.RedisUtil;
import cn.com.exam.utils.ResultUtil;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.BeanUtils;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.transaction.interceptor.TransactionAspectSupport;
import org.springframework.util.CollectionUtils;
import org.springframework.util.ObjectUtils;

import javax.annotation.Resource;
import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.Objects;
import java.util.function.Function;
import java.util.stream.Collectors;

@Service
@Transactional  //事务的注解
public class UserServiceImpl implements UserService {

    @Resource
    private UserDao userDao;
    @Resource
    private ClassesDao classesDao;
    @Resource
    private UserPasswordDao userPasswordDao;
    @Resource
    private UserClassesDao userClassesDao;
    @Resource
    private RedisUtil redisUtil;

    @Resource
    private MD5Util md5Util;

    @Override
    public User login(String username, String password) {
        User user = userDao.selectByUserName(username);
//        if (user == null) {
//            user = userDao.selectByPhone(name);
//        }
//        if (user == null) {
//            return null;
//        }
//        System.out.println(user);
//        User isUser = userDao.loginByEmail(user.getUserId(), name, password);
//        if (isUser == null) {
//            isUser = userDao.loginByPhone(user.getUserId(), name, password);
//        } else {
//            return isUser;
//        }
        return userDao.loginByUserName(user.getUserId(), username, password);
    }

    @Override
    public Msg queryUserByC_id(int c_id, int userId) {
        Classes classes = classesDao.selectByPrimaryKey(c_id);
        List<UserClassesDTO> userList = userDao.selectByC_id(c_id);
        for (UserClassesDTO u_c : userList) {
            switch (u_c.getPosition()) {
                case "creator":
                    u_c.setPosition("创建者");
                    break;
                case "admin":
                    u_c.setPosition("管理员");
                    break;
                case "student":
                    u_c.setPosition("学生");
                    break;
            }
        }

        if (userList.size() >= 0) {
            return ResultUtil.success(userList);
        } else {
            return ResultUtil.error(100, "请求失败");
        }
    }

    @Override
    public int updateUser(User user) {
        user.setUpdateDate(new Date());
        return userDao.updateByPrimaryKeySelective(user);
    }

    @Override
    public Msg queryUserList(int currentPage, int pageSize, String username) {
        // 1.查询出所有的数据
        List<User> users = userDao.selectAll(username);
        if (CollectionUtils.isEmpty(users)) {
            return ResultUtil.error(100, "无用户数据");
        }
        Page<UserAddClassesDTO> page = new Page<>(pageSize, currentPage);

        Map<Integer, Classes> classesMap =
                classesDao.findAll().stream().collect(Collectors.toMap(Classes::getClassesId, Function.identity(), (v1, v2) -> v2));

        page.build(users.stream().map(user -> {
            UserAddClassesDTO userAddClassesDTO = new UserAddClassesDTO();
            BeanUtils.copyProperties(user, userAddClassesDTO);
            userAddClassesDTO.setPhoto("http://localhost:8081/images/" + user.getPhoto());
            // 查询当前用户的所属班级
            UserClasses userClasses = userClassesDao.selectByUserId(user.getUserId());
            if (Objects.nonNull(userClasses)) {
                Classes classes = classesMap.get(userClasses.getClassesId());
                if (Objects.nonNull(classes)) {
                    userAddClassesDTO.setClassesName(classes.getClassesName());
                }
            }
            return userAddClassesDTO;
        }).collect(Collectors.toList()));
        return ResultUtil.success(page);
    }

    @Override
    public Msg deleteByUserId(Integer userId) {
        try {
            // 删除user表信息
            int i = userDao.deleteByPrimaryKey(userId);
            if (i < 1) {
                return ResultUtil.error(100, "删除错误");
            }
            return ResultUtil.success("删除成功");
        } catch (Exception e) {
            System.out.println(e);
            //强制手动事务回滚
            TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
            return ResultUtil.error(100, "请求失败", e.toString());
        }
    }

    @Override
    public Msg addUserByAdmin(UserAddClassesDTO user) {
        try {
            if (userDao.selectByEmail(user.getEmail()) != null) {
                return ResultUtil.error(1001, "该邮箱地址已被使用");
            }
            if (userDao.selectByPhone(user.getPhone()) != null && !user.getPhone().equals("")) {
                return ResultUtil.error(1002, "该手机号码已被使用");
            }
            user.setPhoto("user.jpg");
            user.setCreateDate(new Date());
            user.setUpdateDate(new Date());
            user.setPassword(MD5Util.md5(user.getPassword()));
            userDao.insert(user);
            userPasswordDao.insert(new UserPassword(user.getUserId(), user.getPassword()));

            if (user.getClassesId() != null) {
                // 直接加入班级
                userAddClasses(user.getUserId(), user.getClassesId());
            }

            return ResultUtil.success("新增成功");
        } catch (Exception e) {
            System.out.println(e);
            //强制手动事务回滚
            TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
            return ResultUtil.error(100, "请求失败", e.toString());
        }
    }

    public void userAddClasses(Integer userId, Integer classesId) {
        Classes classes = classesDao.selectByPrimaryKey(classesId);
        classes.setPeopleNum(classes.getPeopleNum() + 1);
        classesDao.updateByPrimaryKeySelective(classes);
        userClassesDao.insert(new UserClasses(null, userId, classesId, Position.student.getValue(), new Date()));
    }

    @Override
    public Msg findOneByUserId(Integer id) {
        User user = userDao.selectByPrimaryKey(id);
        if (user == null) {
            return ResultUtil.error(100, "查询失败");
        }
        user.setPassword(userPasswordDao.selectByPrimaryKey(id).getPassword());
        user.setPhoto("http://localhost:8081/images/" + user.getPhoto());
        return ResultUtil.success(user);
    }

    @Override
    public List<User> getUserNoClasses() {
        List<User> users = userDao.selectAll("");
        return users
                .stream()
                .filter(val -> !StringUtils.equals(val.getRole(), Role.teacher.getValue()) && userClassesDao.selectByUserId(val.getUserId()) == null)
                .peek(val -> val.setPhoto("http://localhost:8081/images/" + val.getPhoto()))
                .collect(Collectors.toList());
    }
}
