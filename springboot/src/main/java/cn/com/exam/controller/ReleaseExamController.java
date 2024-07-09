package cn.com.exam.controller;

import cn.com.exam.DTO.ReleasExamVO;
import cn.com.exam.dao.ExamClassesDao;
import cn.com.exam.entity.ExamClasses;
import cn.com.exam.service.ReleaseExamService;
import cn.com.exam.utils.JwtUtil;
import cn.com.exam.utils.Msg;
import cn.com.exam.utils.ResultUtil;
import io.swagger.annotations.ApiOperation;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.util.Date;

@RestController
public class ReleaseExamController {
    @Resource
    private ReleaseExamService releaseExamService;
    @Resource
    private ExamClassesDao examClassesDao;

    @ApiOperation(value = "获取发布考试信息")
    @GetMapping(value = "/getReleaseInfo")
    public Msg getReleaseInfo(HttpServletRequest request,@RequestParam Integer classesId,@RequestParam Integer examId){
        String token =  request.getHeader("token");

        return releaseExamService.getReleaseInfo(classesId,examId);
    }

    @ApiOperation(value = "发布考试")
    @PostMapping(value = "/releaseTest")
    public Msg releaseTest(HttpServletRequest request, @RequestBody ReleasExamVO releasExamVO){
        System.out.println(releasExamVO);
        String token =  request.getHeader("token");

        if(!JwtUtil.getUserStatus(token).equals("teacher")){
            return ResultUtil.error(400,"用户身份不正确");
        }


        return releaseExamService.releaseTest(releasExamVO);
    }

    @ApiOperation(value = "修改试卷发布信息")
    @PostMapping(value = "/updateReleaseTest",consumes = "application/json")
    public Msg updateReleaseTest(HttpServletRequest request, @RequestBody ExamClasses examClasses){

        String token =  request.getHeader("token");

        if(!JwtUtil.getUserStatus(token).equals("teacher")){
            return ResultUtil.error(400,"用户身份不正确");
        }

        examClasses.setReleaseTime(new Date());
        int result=examClassesDao.updateRecord(examClasses);
        if(result>0){
            return ResultUtil.success();
        }else{
            return ResultUtil.error(100,"请求失败");
        }
    }

    @ApiOperation(value = "取消试卷发布")
    @DeleteMapping(value = "/cancelRelease")
    public Msg cancelRelease(HttpServletRequest request,@RequestParam int tp_id,@RequestParam int c_id){
        String token =  request.getHeader("token");

        if(!JwtUtil.getUserStatus(token).equals("teacher")){
            return ResultUtil.error(400,"用户身份不正确");
        }

        int result= releaseExamService.deleteRecord(tp_id, c_id);
        if(result>0){
            return ResultUtil.success();
        }else{
            return ResultUtil.error(100,"请求失败");
        }
    }
}
