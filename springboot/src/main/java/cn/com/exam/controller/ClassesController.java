package cn.com.exam.controller;


import cn.com.exam.DTO.ClassesUserDTO;
import cn.com.exam.dao.ClassesDao;
import cn.com.exam.entity.Classes;
import cn.com.exam.service.ClassesService;
import cn.com.exam.utils.JwtUtil;
import cn.com.exam.utils.Msg;
import cn.com.exam.utils.Page;
import cn.com.exam.utils.ResultUtil;
import io.swagger.annotations.ApiOperation;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.util.List;
import java.util.Objects;

@RestController
public class ClassesController {
    @Resource
    private ClassesService classesService;
    @Resource
    private ClassesDao classesDao;

    /*
     * 查找班级
     * */
    @ApiOperation(value = "查找班级")
    @GetMapping("/queryClasses")
    public Msg queryClasses(@RequestParam Integer classesId) {
        return classesService.queryClassesByC_id(classesId);
    }

    /*
     * 查找班级列表
     * */
    @ApiOperation(value = "查找班级列表")
    @GetMapping("/queryClassesList")
    public Msg queryClassesList(HttpServletRequest request,
                                @RequestParam(required = false) Integer examId,
                                @RequestParam(required = false) Integer examIdTwo,
                                @RequestParam int pageSize, @RequestParam int currentPage,
                                @RequestParam(required = false) String keyword) {
        if (examId != null) {
            return classesService.queryClassesByExamId(examId);
        }

        String token = request.getHeader("token");
        //获取token中的id
        int u_id = Integer.parseInt(JwtUtil.getUserId(token));

        if (keyword == null) {
            keyword = "";
        }
        String role = JwtUtil.getUserStatus(token);
        Msg<List<ClassesUserDTO>> result = classesService.queryClassesByU_id(u_id, role, keyword, examIdTwo);
        Page<ClassesUserDTO> page = new Page<>(pageSize, currentPage);
        page.build(result.getData());
        return ResultUtil.success(page);
    }

    @ApiOperation(value = "踢出班级（老师）")
    @DeleteMapping(value = "/outClassesByTeacher")
    public Msg outClassesByteacher(HttpServletRequest request, @RequestParam int u_id, @RequestParam int c_id) {
        String token = request.getHeader("token");
        if (!Objects.equals(JwtUtil.getUserStatus(token), "teacher")) {
            return ResultUtil.error(400, "用户身份不正确");
        }
        //获取token中的id
        int t_id = Integer.parseInt(Objects.requireNonNull(JwtUtil.getUserId(token)));
        Classes classes = classesDao.selectByPrimaryKey(c_id);
        if (t_id != classes.getCreatorId()) {
            return ResultUtil.error(400, "您不是该班级管理员");
        }

        return classesService.outClasses(u_id, c_id);
    }

    /*
    添加班级 createClasses
        班级名称          name
        班级简介          introduction
        创建人id          creator_id
         */
    @ApiOperation(value = "创建班级")
    @PostMapping(value = "/createClasses")
    public Msg createClasses(HttpServletRequest request, @RequestBody Classes classes) {
        String token = request.getHeader("token");
        if (!JwtUtil.getUserStatus(token).equals("teacher")) {
            return ResultUtil.error(400, "用户身份不正确");
        }
        //获取token中的id
        int u_id = Integer.parseInt(JwtUtil.getUserId(token));
        return classesService.createClasses(classes, u_id);
    }


    /*
   修改班级信息 createClasses
       班级名称          name
       班级简介          introduction
       班级允许加入方式    jionWay
        */
    @ApiOperation(value = "修改班级信息")
    @PutMapping(value = "/updateClasses")
    public Msg updateClasses(HttpServletRequest request, @RequestBody Classes classes) {
        String token = request.getHeader("token");
        if (!JwtUtil.getUserStatus(token).equals("teacher")) {
            return ResultUtil.error(400, "用户身份不正确");
        }
        //获取token中的id
        Integer userId = Integer.parseInt(JwtUtil.getUserId(token));

        return classesService.updateClasses(classes, userId);
    }

    @ApiOperation(value = "查询所有班级")
    @GetMapping(value = "/classes/findAll")
    public Msg<List<Classes>> findAll() {
        return ResultUtil.success(classesService.findAll());
    }

    @ApiOperation(value = "删除班级")
    @DeleteMapping(value = "/deleteClasses")
    public Msg deleteClasses(HttpServletRequest request, @RequestParam int id) {
        String token = request.getHeader("token");
        if (!Objects.equals(JwtUtil.getUserStatus(token), "teacher")) {
            return ResultUtil.error(400, "用户身份不正确");
        }
        return classesService.deleteClasses(id);
    }

    @ApiOperation("分配学生加入班级")
    @GetMapping("/classes/userAddClasses")
    public Msg<Boolean> userAddClasses(@RequestParam("classesId") Integer classesId,
                                       @RequestParam("userIds") List<Integer> userIds) {
        return ResultUtil.success(classesService.userAddClasses(classesId, userIds));
    }

}
