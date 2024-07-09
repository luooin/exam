package cn.com.exam.service.impl;

import cn.com.exam.dao.TopicDao;
import cn.com.exam.entity.Topic;
import cn.com.exam.service.TopicService;
import cn.com.exam.utils.Msg;
import cn.com.exam.utils.ResultUtil;
import org.apache.commons.lang3.ObjectUtils;
import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.transaction.interceptor.TransactionAspectSupport;
import org.springframework.util.CollectionUtils;

import javax.annotation.Resource;
import java.util.List;

@Service
@Transactional  //事务的注解
public class TopicServiceImpl implements TopicService {

    @Resource
    private TopicDao topicDao;

    //创建题目
    @Override
    public Msg createTopic(Topic topic) {
        try {
            List<Topic> topics = topicDao.selectTopicByTpParam(topic);
            if (CollectionUtils.isEmpty(topics)) {
                topicDao.insert(topic);
                return ResultUtil.success(topic);
            }else{
                return ResultUtil.error(100, "题库中已存在相同的题目");
            }
        }catch (Exception e) {
            //强制手动事务回滚
            TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
            return ResultUtil.error(100, e.toString());
        }
    }

    //
}
