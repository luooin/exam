package cn.com.exam.dao;

import cn.com.exam.entity.ClassesSubjects;
import org.apache.ibatis.annotations.*;

import java.util.List;

@Mapper
public interface ClassesSubjectDao {

    String TABLE_NAME = "classes_subject";

    @Select("select * from " + TABLE_NAME + " where classes_id = #{classesId}")
    List<ClassesSubjects> findByClassesId(Integer classesId);

    @Insert({
            "<script>",
            "INSERT INTO " + TABLE_NAME + " (subject_id, classes_id) VALUES ",
            "<foreach item='item' collection='subjectsList' separator=','>",
            " ( #{item.subjectId}, #{item.classesId} )",
            "</foreach>",
            "</script>"
    })
    Boolean add(@Param("subjectsList") List<ClassesSubjects> subjectsList);

    @Select({
            "<script>",
            "select * from " + TABLE_NAME + " where ",
            " classes_id = #{classesId}  ",
            " and subject_id IN",
            "<foreach item='id' collection='subjectsDataList' open='(' separator=',' close=')'>",
            " #{id} ",
            "</foreach>",
            "</script>"
    })
    List<ClassesSubjects> findByClassesIdAndSubjectsIds(Integer classesId, List<Integer> subjectsDataList);

    @Delete({
            "<script>",
            "delete from " + TABLE_NAME + " where ",
            " id IN",
            "<foreach item='id' collection='ids' open='(' separator=',' close=')'>",
            "#{id}",
            "</foreach>",
            "</script>"
    })
    Boolean deleteByIds(List<Integer> ids);

    @Select("select count(1) from " + TABLE_NAME + " where subject_id = #{id}")
    Integer countBySubjectId(Integer id);

    @Select("select count(1) from " + TABLE_NAME + " where classes_id = #{classesId}")
    Integer countByClassesId(Integer classesId);
}
