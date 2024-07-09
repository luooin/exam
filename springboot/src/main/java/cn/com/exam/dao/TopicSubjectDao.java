
package cn.com.exam.dao;

import cn.com.exam.entity.TopicSubject;
import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * <p>
 * TopicSubjectDao
 * </p >
 *
 

 */
@Mapper
@Repository
public interface TopicSubjectDao {
    int deleteByPrimaryKey(Integer id);

    int deleteBySubjectId(Integer id);

    int insert(TopicSubject topicSubject);

    int insertSelective(TopicSubject topicSubject);

    TopicSubject selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(TopicSubject topicSubject);

    int updateByPrimaryKey(TopicSubject topicSubject);

    List<TopicSubject> selectByExamId(Integer examId);
}