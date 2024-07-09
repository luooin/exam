package cn.com.exam.dao;

import cn.com.exam.entity.Topic;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Mapper
@Repository
public interface TopicDao {
    int deleteByPrimaryKey(Integer topicId);

    int insert(Topic record);

    int insertSelective(Topic record);

    Topic selectByPrimaryKey(Integer topicId);

    int updateByPrimaryKeySelective(Topic record);

    int updateByPrimaryKey(Topic record);

    boolean deleteByTopicIdList(List<Integer> topicList);

    List<Topic> selectTopicByTpParam(@Param("queryParam") Topic Topic);

    //在一个难度区间
    List<Topic> queryTitleByDifficulty(@Param("difficulty") String difficulty, @Param("subjectId") Integer subjectId);
}