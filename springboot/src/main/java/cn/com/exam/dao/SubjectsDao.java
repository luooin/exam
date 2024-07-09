package cn.com.exam.dao;

import cn.com.exam.entity.Subjects;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
@Mapper
public interface SubjectsDao {
    @Select("select * from subject")
    List<Subjects> findAll();

    @Insert("insert into subject(name) values (#{name})")
    Boolean create(String name);

    @Update("update subject set name = #{name} where id = #{id}")
    Boolean update(Subjects subjects);

    @Select("select * from subject where id = #{id}")
    Subjects findById(Integer subjectId);

    @Select("select count(1) from subject")
    Integer count();

    @Select("select * from exam.subject where name = #{name}")
    Subjects findByName(String name);
}