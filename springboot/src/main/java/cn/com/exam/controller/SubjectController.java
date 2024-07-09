package cn.com.exam.controller;

import cn.com.exam.DTO.ClassesSubjectsDTO;
import cn.com.exam.DTO.SubjectsCountDTO;
import cn.com.exam.entity.Subjects;
import cn.com.exam.service.SubjectService;
import cn.com.exam.utils.Msg;
import cn.com.exam.utils.ResultUtil;
import org.springframework.util.ObjectUtils;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import java.util.List;

@RestController
@RequestMapping("/subject")
public class SubjectController {

    @Resource
    private SubjectService subjectService;

    /**
     * 查询所有科目
     */
    @GetMapping("/findAll")
    public Msg<List<SubjectsCountDTO>> findAll() {
        return ResultUtil.success(subjectService.findAll());
    }

    /**
     * 新建科目
     */
    @PostMapping("/create")
    public Msg<Boolean> create(@RequestBody Subjects subjects) {
        if (!ObjectUtils.isEmpty(subjects.getName())) {
            Boolean flag = subjectService.create(subjects.getName());
            if (!flag) {
                return ResultUtil.error(100,"科目："+subjects.getName()+"已存在！");
            }
        }
        return ResultUtil.success(subjectService.create(subjects.getName()));
    }

    /**
     * 修改科目
     */
    @PostMapping("/update")
    public Msg<Boolean> update(@RequestBody Subjects subjects) {
        return ResultUtil.success(subjectService.update(subjects));
    }

    /**
     * 查询当前班级下的所有科目
     */
    @GetMapping("/findSubjectsByClassesId")
    public Msg<List<ClassesSubjectsDTO>> findSubjectsByClassesId(@RequestParam("classesId") Integer classesId) {
        return ResultUtil.success(subjectService.findSubjectsByClassesId(classesId));
    }

    /**
     * 更新当前班级下的课程信息
     */
    @GetMapping("/updateByClassesId")
    public Msg<Boolean> updateByClassesId(@RequestParam("classesId") Integer classesId,
                                          @RequestParam("subjectsDataList") List<Integer> subjectsDataList,
                                          @RequestParam("isJoin") Boolean isJoin) {
        return ResultUtil.success(subjectService.updateByClassesId(classesId, subjectsDataList, isJoin));
    }

}
