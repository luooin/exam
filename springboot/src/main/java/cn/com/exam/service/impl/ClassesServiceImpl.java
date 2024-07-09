package cn.com.exam.service.impl;

import cn.com.exam.DTO.ClassesExamDTO;
import cn.com.exam.DTO.ClassesUserDTO;
import cn.com.exam.dao.ClassesDao;
import cn.com.exam.dao.ClassesSubjectDao;
import cn.com.exam.dao.ExamDao;
import cn.com.exam.dao.UserClassesDao;
import cn.com.exam.entity.Classes;
import cn.com.exam.entity.ClassesSubjects;
import cn.com.exam.entity.Exam;
import cn.com.exam.entity.UserClasses;
import cn.com.exam.enums.Role;
import cn.com.exam.service.ClassesService;
import cn.com.exam.utils.JwtUtil;
import cn.com.exam.utils.Msg;
import cn.com.exam.utils.ResultUtil;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.lang3.StringUtils;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.transaction.interceptor.TransactionAspectSupport;
import org.springframework.util.CollectionUtils;

import javax.annotation.Resource;
import java.util.*;
import java.util.stream.Collectors;

@Service
@Transactional  //事务的注解
@Slf4j
public class ClassesServiceImpl implements ClassesService {

    @Resource
    private UserClassesDao userClassesDao;
    @Resource
    private ClassesDao classesDao;
    @Resource
    private UserServiceImpl userService;
    @Resource
    private ClassesSubjectDao classesSubjectDao;
    @Resource
    private ExamDao examDao;

    private static org.slf4j.Logger logger = LoggerFactory.getLogger(ClassesServiceImpl.class);

    //根据用户ID查找班级
    @Override
    public Msg<List<ClassesUserDTO>> queryClassesByU_id(Integer u_id, String role, String keyword, Integer examIdTwo) {
        try {
            System.out.println(role);
            List<ClassesUserDTO> userClassesList = new ArrayList<>();
            if (role.equals(Role.student.getValue())) {
                userClassesList = classesDao.selectByUserId(u_id, keyword);
            }
            if (role.equals(Role.teacher.getValue())) {
                userClassesList = classesDao.selectByCreatorId(u_id, keyword);
            }
            if (!CollectionUtils.isEmpty(userClassesList)) {
                Exam exam = examDao.selectById(examIdTwo);
                if (Objects.nonNull(exam)) {
                    userClassesList = userClassesList
                            .stream()
                            .peek(val -> {
                                List<ClassesSubjects> byClassesId = classesSubjectDao.findByClassesIdAndSubjectsIds(val.getClassesId(), Collections.singletonList(exam.getSubjectId()));
                                val.setSelected(CollectionUtils.isEmpty(byClassesId));
                            })
                            .collect(Collectors.toList());
                }
            }
            return ResultUtil.success(userClassesList);
        } catch (Exception e) {
            logger.debug("根据用户查找班级失败" + e);
            //强制手动事务回滚
            TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
            return ResultUtil.error(100, "请求失败", e.toString());
        }
    }

    //退出班级
    @Override
    public Msg outClasses(int u_id, int c_id) {
        try {
            Classes classes = classesDao.selectByPrimaryKey(c_id);
            int people_num = classes.getPeopleNum();
            classes.setPeopleNum(people_num - 1);
            classesDao.updateByPrimaryKeySelective(classes);
            userClassesDao.deleteRecord(u_id, c_id);
            return ResultUtil.success();
        } catch (Exception e) {
            System.out.println(e);
            //强制手动事务回滚
            TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
            return ResultUtil.error(100, "请求失败", e.toString());
        }

    }

    @Override
    public Msg queryClassesByC_id(int c_id) {
        Classes classes = classesDao.selectByPrimaryKey(c_id);
        if (classes != null) {
            return ResultUtil.success(classes);
        } else {
            return ResultUtil.error(2001, "该班级不存在");
        }
    }

    @Override
    public Msg queryClassesByExamId(Integer examId) {
        try {
            List<ClassesExamDTO> classesExamDTOList = classesDao.selectByExamId(examId);
            return ResultUtil.success(classesExamDTOList);
        } catch (Exception e) {
            logger.debug("");
            //强制手动事务回滚
            TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
            return ResultUtil.error(100, "请求失败", e.toString());
        }
    }

    //创建班级
    @Override
    public Msg createClasses(Classes classes, Integer userId) {
        try {
            classes.setUpdateDate(new Date());
            classes.setCreateDate(new Date());
            classes.setPeopleNum(0);
            classes.setCreatorId(userId);
            if (StringUtils.isNotEmpty(classes.getClassesName())) {
                List<ClassesExamDTO> classesExamDTOS = classesDao.selectByClassName(classes.getClassesName());
                if (CollectionUtils.isEmpty(classesExamDTOS)) {
                    classesDao.insert(classes);
                    return ResultUtil.success();
                } else {
                    return ResultUtil.error(100, "请求失败,已存在相同的班级名称，请重新编辑！");
                }
            } else {
                return ResultUtil.error(100, "请求失败,班级名称不能为空，请重新编辑！");
            }

        } catch (Exception e) {
            //强制手动事务回滚
            TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
            return ResultUtil.error(100, "请求失败", e.toString());
        }
    }

    //修改班级信息
    @Override
    public Msg updateClasses(Classes classes, Integer userId) {
        try {
//            Classes classes1 = classesDao.selectByPrimaryKey(classes.getClassesId());
//            int creatorId = classes1.getCreatorId();

            if (!userId.equals((classesDao.selectByPrimaryKey(classes.getClassesId())).getCreatorId())) {
                return ResultUtil.error(400, "您不是该班级管理员");
            }
            if(classes.getClassesName().isEmpty()){
                return ResultUtil.error(400, "班级名称不能为空");
            }
            List<ClassesExamDTO> classesExamDTOS = classesDao.selectByClassName(classes.getClassesName());
            if (CollectionUtils.isEmpty(classesExamDTOS)) {
                classesDao.updateByPrimaryKeySelective(classes);
            } else {
                return ResultUtil.error(100, "请求失败,已存在相同的班级名称，请重新编辑！");
            }
            return ResultUtil.success();
        } catch (Exception e) {
            logger.debug("您不是该班级管理员，修改班级信息失败", e);
            //强制手动事务回滚
            TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
            return ResultUtil.error(100, "请求失败", e.toString());
        }
    }


    //删除班级
    @Override
    public Msg deleteClasses(int id) {
        try {
            // 1.踢出所有和班级有绑定关系的学生
            List<UserClasses> userClasses = userClassesDao.selectByClassesId(id);
            if (!CollectionUtils.isEmpty(userClasses)) {
                int i = userClassesDao.deleteClasses(id);
                if (i <= 0) {
                    return ResultUtil.error(100, "删除失败");
                }
            }
            // 2.删除班级
            int count = classesDao.deleteByPrimaryKey(id);
            if (count <= 0) {
                return ResultUtil.error(100, "删除失败");
            }
            return ResultUtil.success("删除成功");
        } catch (Exception e) {
            logger.debug("删除班级失败" + e);
            //强制手动事务回滚
            TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
            return ResultUtil.error(100, "请求失败", e.toString());
        }
    }

    @Override
    public List<Classes> findAll() {
        return classesDao.findAll();
    }

    @Transactional
    @Override
    public Boolean userAddClasses(Integer classesId, List<Integer> userIds) {
        for (Integer userId : userIds) {
            userService.userAddClasses(userId, classesId);
        }
        return Boolean.TRUE;
    }

    @Override
    public void findStudentClassesName(String token, Map<String, Object> dataMap) {
        int u_id = Integer.parseInt(JwtUtil.getUserId(token));
        UserClasses userClasses = userClassesDao.selectByUserId(u_id);
        if (userClasses != null) {
            Classes classes = classesDao.selectByPrimaryKey(userClasses.getClassesId());
            dataMap.put("classesName", classes.getClassesName());
            dataMap.put("classesNumber", classes.getPeopleNum());
        }
    }
}
