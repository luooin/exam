package cn.com.exam.dao;

import cn.com.exam.DTO.ClassesExamDTO;
import cn.com.exam.DTO.ClassesUserDTO;
import cn.com.exam.entity.Classes;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;
import org.springframework.stereotype.Repository;

import java.util.List;

@Mapper
@Repository
public interface ClassesDao {
    int deleteByPrimaryKey(Integer classesId);

    int insert(Classes record);

    int insertSelective(Classes record);

    Classes selectByPrimaryKey(Integer classesId);

    int updateByPrimaryKeySelective(Classes record);

    int updateByPrimaryKey(Classes record);

    List<ClassesUserDTO> selectByUserId(Integer userId, String keyword);

    List<ClassesUserDTO> selectByCreatorId(Integer userId, String keyword);

    List<ClassesExamDTO> selectByExamId(Integer examId);

    @Select("select * from classes")
    List<Classes> findAll();

    @Select("select count(1) from classes")
    Integer count();

    List<ClassesExamDTO> selectByClassName(String classesName);
}