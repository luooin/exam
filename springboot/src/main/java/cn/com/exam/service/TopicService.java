package cn.com.exam.service;

import cn.com.exam.entity.Topic;
import cn.com.exam.utils.Msg;

public interface TopicService {

    //创建题目
    public Msg createTopic(Topic topic);

}
