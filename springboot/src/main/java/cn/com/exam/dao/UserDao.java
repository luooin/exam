package cn.com.exam.dao;

import cn.com.exam.DTO.UserClassesDTO;
import cn.com.exam.entity.User;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;
import org.springframework.stereotype.Repository;

import java.util.List;

@Mapper
@Repository
public interface UserDao {
    int deleteByPrimaryKey(Integer userId);

    int insert(User record);

    int insertSelective(User record);

    User selectByPrimaryKey(Integer userId);

    int updateByPrimaryKeySelective(User record);

    int updateByPrimaryKey(User record);

    User selectByEmail(String email);

    User selectByUserName(String username);

    User selectByPhone(String phone);

    List<UserClassesDTO> selectByC_id(Integer classesId);

    User loginByEmail(Integer userId, String email, String password);

    User loginByPhone(Integer userId, String phone, String password);

    User loginByUserName(Integer userId, String username, String password);
    List<User> selectAll(String username);

    @Select("select count(1) from user where role = 'student'")
    Integer countByStudent();
}