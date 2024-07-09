package cn.com.exam.dao;

import cn.com.exam.entity.UserGrade;
import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import java.util.List;

@Mapper
@Repository
public interface UserGradeDao {
    int deleteByPrimaryKey(Integer id);

    int insert(UserGrade record);

    int insertSelective(UserGrade record);

    UserGrade selectByPrimaryKey(Integer id);

    int updateByForeignKeySelective(UserGrade record);

    int updateByPrimaryKey(UserGrade record);

    List<UserGrade> selectByClassesId(Integer classesId, Integer examId);

    List<UserGrade> selectByUserId(Integer userId);
}