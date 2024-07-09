package cn.com.exam.controller;

import cn.com.exam.DTO.LoginDTO;
import cn.com.exam.DTO.UserAddClassesDTO;
import cn.com.exam.dao.UserDao;
import cn.com.exam.dao.UserPasswordDao;
import cn.com.exam.entity.User;
import cn.com.exam.entity.UserPassword;
import cn.com.exam.service.UserService;
import cn.com.exam.utils.JwtUtil;
import cn.com.exam.utils.MD5Util;
import cn.com.exam.utils.Msg;
import cn.com.exam.utils.Page;
import cn.com.exam.utils.RedisUtil;
import cn.com.exam.utils.ResultUtil;
import cn.hutool.core.util.ObjectUtil;
import io.swagger.annotations.ApiOperation;
import org.apache.commons.lang3.StringUtils;
import org.springframework.util.ObjectUtils;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.util.HashMap;
import java.util.List;
import java.util.Objects;


@RestController
public class UserController {

    @Resource
    private UserService userService;
    @Resource
    private UserDao userDao;
    @Resource
    private UserPasswordDao userPasswordDao;

    @Resource
    private RedisUtil redisUtil;

    @Resource
    private MD5Util md5Util;

    @ApiOperation(value = "获取用户信息")
    @GetMapping("/getUserById")
    public Msg getUserById(HttpServletRequest request) {
        String token = request.getHeader("token");
        //获取token中的id
        int u_id = Integer.parseInt(Objects.requireNonNull(JwtUtil.getUserId(token)));

        User user = userDao.selectByPrimaryKey(u_id);

        if (user != null) {
            UserPassword userPassword = userPasswordDao.selectByPrimaryKey(user.getUserId());
            if (userPassword != null) user.setPassword(userPassword.getPassword());
            return ResultUtil.success(user);
        } else {
            return ResultUtil.error(100, "请求失败");
        }
    }

    @ApiOperation("获取没有班级的学生信息")
    @GetMapping("/user/getUserNoClasses")
    public Msg<List<User>> getUserNoClasses() {
        return ResultUtil.success(userService.getUserNoClasses());
    }

    @ApiOperation(value = "登录")
    @PostMapping(value = "/login")
    public Msg login(@RequestBody LoginDTO loginDTO) {
        String password = md5Util.md5(loginDTO.getPassword());

        // 获取redis中的验证码
        String redisCode = redisUtil.get(loginDTO.getVerKey()).toString();
        String lowerCase = loginDTO.getVerCode().trim().toLowerCase(); // 验证码
        // 判断验证码
        if (!"8888".equals(lowerCase) || (ObjectUtils.isEmpty(loginDTO.getVerCode()) && !redisCode.equals(lowerCase))) {
            return ResultUtil.error(10002, "验证码不正确");
        }

        User user = userService.login(loginDTO.getName(), password);

        if (user != null) {
            String token = JwtUtil.sign(user.getUserName(), user.getUserId() + "", user.getRole());
            if (token != null) {
                HashMap<String, Object> hm = new HashMap<>();
                hm.put("token", token);
                hm.put("status", user.getRole());
                hm.put("name", user.getUserName());
                return ResultUtil.success(hm);
            } else {
                return ResultUtil.error(10001, "用户名或密码错误，请重新输入！");
            }
        } else {
            return ResultUtil.error(10001, "用户名或密码错误，请重新输入！");
        }

    }

    @ApiOperation(value = "获取班级下的用户列表")
    @GetMapping("/queryUserByC_id")
    public Msg queryUserByC_id(HttpServletRequest request, @RequestParam int c_id, @RequestParam int pageSize, @RequestParam int currentPage) {
        String token = request.getHeader("token");
        //获取token中的id
        int u_id = Integer.parseInt(JwtUtil.getUserId(token));

        Msg result = userService.queryUserByC_id(c_id, u_id);
        Page<List> page = new Page(pageSize, currentPage);
        page.build((List) result.getData());
        return ResultUtil.success(page);
    }

    @ApiOperation(value = "获取班级下的用户列表")
    @GetMapping("/queryUserList")
    public Msg queryUser(@RequestParam(defaultValue = "10") int pageSize,
                         @RequestParam(defaultValue = "1") int currentPage,
                         @RequestParam String username) {
        return userService.queryUserList(currentPage, pageSize, username);
    }

    @ApiOperation(value = "删除用户")
    @GetMapping("/deleteByUserId")
    public Msg deleteByUserId(HttpServletRequest request, @RequestParam Integer userId) {
        if (userId == null || userId == 0) {
            return ResultUtil.error(100, "用户id不正确");
        }
        String token = request.getHeader("token");
        int u_id = Integer.parseInt(Objects.requireNonNull(JwtUtil.getUserId(token)));
        if (u_id == userId) {
            return ResultUtil.error(100, "禁止删除自己的角色信息");
        }
        return userService.deleteByUserId(userId);
    }


    @ApiOperation(value = "修改用户信息")
    @RequestMapping(value = "/updateUser")
    public Msg updateUser(@RequestBody User user) {
        UserPassword password = userPasswordDao.selectByPrimaryKey(user.getUserId());
        if (!ObjectUtils.isEmpty(password) && !password.getPassword().equals(user.getPassword()) && StringUtils.isNotBlank(user.getPassword())) {
            user.setPassword(md5Util.md5(user.getPassword()));
        } else if (StringUtils.isBlank(user.getPassword())) {
            return ResultUtil.error(100, "密码不允许为空，修改失败");
        }
        if (!ObjectUtils.isEmpty(user) && ("812524843a984da5a804e8bf82983d66.jpg".equals(user.getPhoto()) || "user.jpg".equals(user.getPhoto()))) {
            user.setPhoto(null); // 照片不通过修改按钮修改
            user.setPhotoName(null);
        }
        /*if (ObjectUtils.isEmpty(user.getUserName())) {
            return ResultUtil.error(100, "账号不允许为空，修改失败");
        }*/
        int result = userService.updateUser(user);
        UserPassword userPassword = new UserPassword(user.getUserId(), user.getPassword());
        int count = userPasswordDao.updateByPrimaryKeySelective(userPassword);
        if (result > 0 && count > 0) {
            return ResultUtil.success("更新成功");
        } else {
            return ResultUtil.error(100, "修改失败");
        }
    }

    @ApiOperation(value = "用户管理列表新增用户专属使用")
    @PostMapping("/addUser")
    public Msg addUser(@RequestBody UserAddClassesDTO user) {
        return userService.addUserByAdmin(user);
    }

    @ApiOperation(value = "获取一个用户信息")
    @GetMapping("/findOneByUserId")
    public Msg findOneByUserId(@RequestParam int id) {
        if (id == 0) {
            return ResultUtil.error(100, "查询失败");
        }
        return userService.findOneByUserId(id);
    }


}
