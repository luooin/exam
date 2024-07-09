package cn.com.exam.dao;

import cn.com.exam.entity.UserClasses;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;
import org.springframework.stereotype.Repository;

import java.util.List;

@Mapper
@Repository
public interface UserClassesDao {
    int deleteByPrimaryKey(Integer id);

    int insert(UserClasses record);

    int insertSelective(UserClasses record);

    UserClasses selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(UserClasses record);

    int updateByPrimaryKey(UserClasses record);

    UserClasses selectRecord(Integer userId,Integer classesId);

    List<UserClasses> selectByClassesId(Integer classesId);

    int deleteRecord(int userId,int classesId);

    int deleteClasses(int classesId);

    @Select("select * from user_classes where user_id = #{userId}")
    UserClasses selectByUserId(Integer userId);
}