package cn.com.exam.controller;

import cn.com.exam.dao.ClassesDao;
import cn.com.exam.dao.ExamDao;
import cn.com.exam.dao.SubjectsDao;
import cn.com.exam.dao.UserDao;
import cn.com.exam.enums.Role;
import cn.com.exam.service.ClassesService;
import cn.com.exam.utils.JwtUtil;
import cn.com.exam.utils.Msg;
import cn.com.exam.utils.ResultUtil;
import org.apache.commons.lang3.StringUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.util.HashMap;
import java.util.Map;

@RestController
@RequestMapping("/home")
public class HomeController {

    @Resource
    private ClassesDao classesDao;
    @Resource
    private ClassesService classesService;
    @Resource
    private UserDao userDao;
    @Resource
    private SubjectsDao subjectsDao;
    @Resource
    private ExamDao examDao;

    @GetMapping("/data")
    public Msg<Map<String, Object>> getHomeData(HttpServletRequest request) {
        String token = request.getHeader("token");
        String role = JwtUtil.getUserStatus(token);
        if (StringUtils.equals(Role.teacher.getValue(), role)) {
            return ResultUtil.success(getHomeDataTeacher());
        }
        return ResultUtil.success(getHomeDataStudent(token));
    }

    private Map<String, Object> getHomeDataTeacher() {
        Map<String, Object> dataMap = new HashMap<>();
        // 班级数量
        dataMap.put("classesCount",classesDao.count());
        // 学生数量
        dataMap.put("userCount",userDao.countByStudent());
        // 科目数量
        dataMap.put("subjectCount",subjectsDao.count());
        // 试卷数量
        dataMap.put("examCount",examDao.count());
        return dataMap;
    }

    private Map<String, Object> getHomeDataStudent(String token) {
        Map<String, Object> dataMap = new HashMap<>();
        // 班级名称
        classesService.findStudentClassesName(token,dataMap);
        // 班级人数

        return dataMap;
    }

}
