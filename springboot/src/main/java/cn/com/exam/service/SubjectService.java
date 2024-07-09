package cn.com.exam.service;

import cn.com.exam.DTO.ClassesSubjectsDTO;
import cn.com.exam.DTO.SubjectsCountDTO;
import cn.com.exam.entity.Subjects;

import java.util.List;

public interface SubjectService {
    List<SubjectsCountDTO> findAll();

    Boolean create(String name);

    Boolean update(Subjects subjects);

    List<ClassesSubjectsDTO> findSubjectsByClassesId(Integer classesId);

    Boolean updateByClassesId(Integer classesId, List<Integer> subjectsDataList, Boolean isJoin);

}
