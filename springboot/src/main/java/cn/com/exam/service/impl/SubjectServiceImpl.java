package cn.com.exam.service.impl;

import cn.com.exam.DTO.ClassesSubjectsDTO;
import cn.com.exam.DTO.SubjectsCountDTO;
import cn.com.exam.dao.ClassesSubjectDao;
import cn.com.exam.dao.ExamDao;
import cn.com.exam.dao.SubjectsDao;
import cn.com.exam.entity.ClassesSubjects;
import cn.com.exam.entity.Subjects;
import cn.com.exam.service.SubjectService;
import cn.com.exam.utils.ResultUtil;
import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Service;
import org.springframework.util.ObjectUtils;

import javax.annotation.Resource;
import java.util.List;
import java.util.Map;
import java.util.Objects;
import java.util.function.Function;
import java.util.stream.Collectors;

@Service
public class SubjectServiceImpl implements SubjectService {

    @Resource
    private SubjectsDao subjectsDao;
    @Resource
    private ClassesSubjectDao classesSubjectDao;
    @Resource
    private ExamDao examDao;

    @Override
    public List<SubjectsCountDTO> findAll() {
        List<Subjects> subjectsList = subjectsDao.findAll();
        return subjectsList
                .stream()
                .map(val -> {
                    SubjectsCountDTO subjectsCountDTO = new SubjectsCountDTO();
                    subjectsCountDTO.setName(val.getName());
                    subjectsCountDTO.setId(val.getId());
                    subjectsCountDTO.setNumberCount(classesSubjectDao.countBySubjectId(val.getId()));
                    subjectsCountDTO.setExamCount(examDao.countBySubjectId(val.getId()));
                    return subjectsCountDTO;
                })
                .collect(Collectors.toList());
    }

    @Override
    public Boolean create(String name) {
        Subjects subjects = subjectsDao.findByName(name);
        if (ObjectUtils.isEmpty(subjects)) {
            return subjectsDao.create(name);
        } else {
            return false;
        }
    }

    @Override
    public Boolean update(Subjects subjects) {
        return subjectsDao.update(subjects);
    }

    @Override
    public List<ClassesSubjectsDTO> findSubjectsByClassesId(Integer classesId) {
        Map<Integer, ClassesSubjects> classesSubjectsMap =
                classesSubjectDao.findByClassesId(classesId)
                        .stream()
                        .collect(Collectors.toMap(ClassesSubjects::getSubjectId, Function.identity(), (v1, v2) -> v2));
        return findAll()
                .stream()
                .map(var -> {
                    ClassesSubjectsDTO classesSubjectsDTO = new ClassesSubjectsDTO();
                    classesSubjectsDTO.setClassesId(classesId);
                    classesSubjectsDTO.setSubjectsId(var.getId());
                    classesSubjectsDTO.setSubjectsName(var.getName());
                    classesSubjectsDTO.setIsHave(Objects.nonNull(classesSubjectsMap.get(var.getId())));
                    return classesSubjectsDTO;
                })
                .collect(Collectors.toList());
    }

    @Override
    public Boolean updateByClassesId(Integer classesId, List<Integer> subjectsDataList, Boolean isJoin) {
        if (isJoin) {
            // 代表是当前课程加入班级
            return subjectAddClasses(classesId, subjectsDataList);
        }
        // 代表当前课程退出班级
        return subjectDeleteClasses(classesId, subjectsDataList);
    }

    private Boolean subjectDeleteClasses(Integer classesId, List<Integer> subjectsDataList) {
        // 查询出来相关的id
        List<ClassesSubjects> classesSubjects = classesSubjectDao.findByClassesIdAndSubjectsIds(classesId, subjectsDataList);
        List<Integer> ids = classesSubjects.stream().map(ClassesSubjects::getId).collect(Collectors.toList());
        return classesSubjectDao.deleteByIds(ids);
    }

    private Boolean subjectAddClasses(Integer classesId, List<Integer> subjectsDataList) {
        List<ClassesSubjects> subjectsList = subjectsDataList
                .stream()
                .map(val -> {
                    ClassesSubjects classesSubjects = new ClassesSubjects();
                    classesSubjects.setClassesId(classesId);
                    classesSubjects.setSubjectId(val);
                    return classesSubjects;
                }).collect(Collectors.toList());
        return classesSubjectDao.add(subjectsList);
    }
}
