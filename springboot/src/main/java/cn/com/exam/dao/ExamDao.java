package cn.com.exam.dao;

import cn.com.exam.DTO.ExamClassesDTO;
import cn.com.exam.DTO.ExamTopicStuDTO;
import cn.com.exam.DTO.ExamTopicTchDTO;
import cn.com.exam.DTO.MarkExamInfoDTO;
import cn.com.exam.entity.Exam;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;
import org.springframework.stereotype.Repository;

import java.util.List;

@Mapper
@Repository
public interface ExamDao {
    int deleteByPrimaryKey(Integer examId);

    int insert(Exam record);

    int insertSelective(Exam record);

    Exam selectByPrimaryKey(Integer examId);

    int updateByPrimaryKeySelective(Exam record);

    int updateByPrimaryKey(Exam record);

    List<Exam> selectByCreatorId(Integer userId, String keyword);

    List<ExamClassesDTO> selectByClassesId(Integer classesId,Integer userId);

    ExamTopicStuDTO stuSelectByPrimaryKey(Integer examId,Integer classesId,Integer userId);

    ExamTopicTchDTO tchSelectByPrimaryKey(Integer examId);

    MarkExamInfoDTO selestStuExamInfo(Integer classesId, Integer examId, Integer userId);

    @Select("select count(1) from  exam where subject_id = #{id}")
    Integer countBySubjectId(Integer id);

    @Select("select * from exam where exam_id = #{id}")
    Exam selectById(Integer id);

    @Select("select count(1) from exam")
    Integer count();

}