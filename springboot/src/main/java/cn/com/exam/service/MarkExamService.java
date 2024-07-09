package cn.com.exam.service;

import cn.com.exam.DTO.StuSubmitExamDTO;
import cn.com.exam.DTO.UserGradeDTO;
import cn.com.exam.utils.Msg;

public interface MarkExamService {
    public Msg submitTestPaper(StuSubmitExamDTO stuSubmitExamDTO,Integer userId);

    public Msg selectByClassesId(Integer classesId,Integer examId,Integer userId);

    public Msg selestStuExamInfo(Integer classesId, Integer examId, Integer userId);

    //教师批改试卷
    public Msg tchMarkExam(UserGradeDTO userGradeDTO, Integer userId);

    Msg deletePaper(Integer examId);
}
