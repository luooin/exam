package cn.com.exam.service;


import cn.com.exam.DTO.ExamTopicTchDTO;
import cn.com.exam.entity.Exam;
import cn.com.exam.utils.Msg;

import java.util.List;

public interface ExamService {
    Msg deleteByPrimaryKey(Integer examId);

    //创建试卷
    Msg insert(ExamTopicTchDTO examTopicTchDTO, Integer userId);

    //修改试卷
    Msg updateByPrimaryKeySelective(ExamTopicTchDTO examTopicTchDTO, Integer userId);

    //查用户下创建的试卷
    Msg<List<Exam>> selectByCreatorId(Integer userId, String keyword);

    //查看试卷(老师)
    Msg tchSelectByPrimaryKey(Integer userId, Integer examId);

    //查看试卷(学生)
    Msg stuSelectByPrimaryKey(Integer userId, Integer classesId, Integer examId);

    Msg selectByClassesId(Integer classesId, Integer userId);

    Msg selectFinishExamList(Integer userId, int pageSize, int currentPage);

    //自动组卷
    Msg audioPaper(ExamTopicTchDTO examTopicTchDTO, Integer userId);
}
