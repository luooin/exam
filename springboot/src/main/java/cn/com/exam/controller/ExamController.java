package cn.com.exam.controller;

import cn.com.exam.DTO.ExamTopicTchDTO;
import cn.com.exam.DTO.StuSubmitExamDTO;
import cn.com.exam.service.ExamService;
import cn.com.exam.service.MarkExamService;
import cn.com.exam.utils.JwtUtil;
import cn.com.exam.utils.Msg;
import cn.com.exam.utils.Page;
import cn.com.exam.utils.ResultUtil;
import io.swagger.annotations.ApiOperation;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.List;
import java.util.Objects;

@RestController
public class ExamController {
    @Resource
    private ExamService examService;
    @Resource
    private MarkExamService markExamService;

    @ApiOperation(value = "获取用户创建的试卷")
    @GetMapping("/getTestPaperByU_id")
    public Msg getTestPaperByU_id(HttpServletRequest request,
                                  @RequestParam(defaultValue = "10") int pageSize,
                                  @RequestParam(defaultValue = "1") int currentPage,
                                  @RequestParam(required = false, defaultValue = "") String keyword) {
        if (keyword == null) {
            keyword = "";
        }
        String token = request.getHeader("token");
        //获取token中的id
        int u_id = Integer.parseInt(Objects.requireNonNull(JwtUtil.getUserId(token)));

        Msg result = examService.selectByCreatorId(u_id, keyword);
        Page page = new Page(pageSize, currentPage);
        page.build((List) result.getData());
        return ResultUtil.success(page);
    }

    @ApiOperation(value = "获取班级下的试卷列表")
    @GetMapping("/getExamByClasses")
    public Msg getExamByClassesId(HttpServletRequest request, @RequestParam Integer classesId, @RequestParam int pageSize, @RequestParam int currentPage) {
        String token = request.getHeader("token");

        //获取token中的id
        int u_id = Integer.parseInt(JwtUtil.getUserId(token));

        Msg result = examService.selectByClassesId(classesId, u_id);
        Page page = new Page(pageSize, currentPage);
        page.build((List) result.getData());
        return ResultUtil.success(page);
    }

    @ApiOperation(value = "获取学生已完成的试卷列表")
    @GetMapping("/getFinishExam")
    public Msg getFinishExam(HttpServletRequest request, @RequestParam int pageSize, @RequestParam int currentPage) {
        String token = request.getHeader("token");

        //获取token中的id
        int u_id = Integer.parseInt(JwtUtil.getUserId(token));

        return examService.selectFinishExamList(u_id, pageSize, currentPage);
    }

    //通过试卷id获取试卷信息(教师角色)
    @ApiOperation(value = "获取试卷信息(教师角色)")
    @GetMapping("/getTestPaperByTp_id")
    public Msg getTestPaperByTp_id(HttpServletRequest request, @RequestParam int examId) {
        String token = request.getHeader("token");
        if (!JwtUtil.getUserStatus(token).equals("teacher")) {
            return ResultUtil.error(400, "用户身份不正确");
        }
        int userId = Integer.parseInt(JwtUtil.getUserId(token));
        return examService.tchSelectByPrimaryKey(userId, examId);
    }

    //通过试卷id,班级id获取试卷信息(学生角色)
    @ApiOperation(value = "获取试卷信息(学生角色)")
    @GetMapping("/getTestPaper")
    public Msg getTestPaper(HttpServletRequest request, @RequestParam int examId, @RequestParam int classesId) {
        String token = request.getHeader("token");
        int userId = Integer.parseInt(JwtUtil.getUserId(token));
        return examService.stuSelectByPrimaryKey(userId, classesId, examId);
    }

    @ApiOperation(value = "创建试卷")
    @PostMapping(value = "/createTestPaper")
    public Msg createTestPaper(@RequestBody ExamTopicTchDTO examTopicTchDTO, HttpServletRequest request) {
        String token = request.getHeader("token");
        if (!JwtUtil.getUserStatus(token).equals("teacher")) {
            return ResultUtil.error(400, "用户身份不正确");
        }

        int userId = Integer.parseInt(JwtUtil.getUserId(token));
        return examService.insert(examTopicTchDTO, userId);
    }

    //更改试卷
    @ApiOperation(value = "更改试卷")
    @PostMapping(value = "/updateTestPaper")
    public Msg updateTestPaper(@RequestBody ExamTopicTchDTO examTopicTchDTO, HttpServletRequest request) {
        //获取token
        String token = request.getHeader("token");

        if (!JwtUtil.getUserStatus(token).equals("teacher")) {
            return ResultUtil.error(400, "用户身份不正确");
        }

        //获取token中的id
        int u_id = Integer.parseInt(JwtUtil.getUserId(token));

        return examService.updateByPrimaryKeySelective(examTopicTchDTO, u_id);

    }


    //提交试卷(学生角色)
    @ApiOperation(value = "提交试卷(学生角色)")
    @PostMapping(value = "/submitTestPaper")
    public Msg submitTestPaper(@RequestBody StuSubmitExamDTO stuSubmitExamDTO, HttpServletRequest request) {
        System.out.println(stuSubmitExamDTO);
        String token = request.getHeader("token");
        int u_id = Integer.parseInt(JwtUtil.getUserId(token));

        return markExamService.submitTestPaper(stuSubmitExamDTO, u_id);
    }

    @ApiOperation(value = "删除试卷")
    @GetMapping(value = "/deletePaper")
    public Msg deletePaper(@RequestParam Integer examId) {
        if (examId == null || examId == 0) {
            return ResultUtil.error(100, "试卷id不能为空");
        }
        return markExamService.deletePaper(examId);
    }

    //组卷功能
    @ApiOperation(value = "自动组卷")
    @RequestMapping("/audioExam")
    public Msg audioExam(ExamTopicTchDTO paperInfo, HttpServletRequest request) {
        String token = request.getHeader("token");
        if (!JwtUtil.getUserStatus(token).equals("teacher")) {
            return ResultUtil.error(400, "用户身份不正确");
        }

        int userId = Integer.parseInt(JwtUtil.getUserId(token));
        return examService.audioPaper(paperInfo, userId);
    }


}
