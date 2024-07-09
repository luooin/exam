package cn.com.exam.controller;

import cn.com.exam.DTO.UserGradeDTO;
import cn.com.exam.service.MarkExamService;
import cn.com.exam.utils.JwtUtil;
import cn.com.exam.utils.Msg;
import cn.com.exam.utils.Page;
import cn.com.exam.utils.ResultUtil;
import io.swagger.annotations.ApiOperation;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.util.List;

@RestController
public class MarkExamController {
    @Resource
    private MarkExamService markExamService;


    @ApiOperation(value = "获取班级考试下")
    @GetMapping("/getUserGradeList")
    public Msg getUserGradeList(HttpServletRequest request, @RequestParam Integer classesId, @RequestParam Integer examId,
                                @RequestParam int pageSize, @RequestParam int currentPage) {
        String token = request.getHeader("token");
        if (!JwtUtil.getUserStatus(token).equals("teacher")) {
            return ResultUtil.error(400, "用户身份不正确");
        }

        int teacher_id = Integer.parseInt(JwtUtil.getUserId(token));

        Msg result = markExamService.selectByClassesId(classesId, examId, teacher_id);
        Page page = new Page(pageSize, currentPage);
        page.build((List) result.getData());
        return ResultUtil.success(page);

    }

    @ApiOperation(value = "获取学生答卷")
    @GetMapping("/getStuExamInfo")
    public Msg getStuExamInfo(HttpServletRequest request, @RequestParam Integer classesId, @RequestParam Integer examId, @RequestParam Integer userId) {
        String token = request.getHeader("token");
        if (!JwtUtil.getUserStatus(token).equals("teacher")) {
            return ResultUtil.error(400, "用户身份不正确");
        }
        int teacher_id = Integer.parseInt(JwtUtil.getUserId(token));


        return markExamService.selestStuExamInfo(classesId, examId, userId);
    }

    @ApiOperation(value = "批改试卷(教师角色)")
    @PutMapping("/tchMarkExam")
    public Msg tchMarkExam(HttpServletRequest request, @RequestBody UserGradeDTO userGradeDTO) {
        String token = request.getHeader("token");
        //获取token中的id
        int teacher_id = Integer.parseInt(JwtUtil.getUserId(token));

        return markExamService.tchMarkExam(userGradeDTO, teacher_id);
    }


}
