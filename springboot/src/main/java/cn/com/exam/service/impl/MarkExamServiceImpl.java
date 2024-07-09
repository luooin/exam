package cn.com.exam.service.impl;


import cn.com.exam.DTO.MarkExamInfoDTO;
import cn.com.exam.DTO.StuSubmitExamDTO;
import cn.com.exam.DTO.UserGradeDTO;
import cn.com.exam.dao.*;
import cn.com.exam.entity.*;
import cn.com.exam.service.MarkExamService;
import cn.com.exam.utils.Msg;
import cn.com.exam.utils.ResultUtil;
import org.springframework.beans.BeanUtils;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.transaction.interceptor.TransactionAspectSupport;
import org.springframework.util.CollectionUtils;
import org.springframework.util.ObjectUtils;

import javax.annotation.Resource;
import java.util.Arrays;
import java.util.Date;
import java.util.Iterator;
import java.util.List;
import java.util.stream.Collectors;

@Service
@Transactional  //事务的注解
public class MarkExamServiceImpl implements MarkExamService {
    @Resource
    private TopicDao topicDao;
    @Resource
    private UserTopicDao userTopicDao;
    @Resource
    private UserGradeDao userGradeDao;
    @Resource
    private ExamDao examDao;
    @Resource
    private ClassesDao classesDao;
    @Resource
    private ExamTopicDao examTopicDao;
    @Resource
    private ExamClassesDao examClassesDao;

    @Override
    public Msg submitTestPaper(StuSubmitExamDTO stuSubmitExamDTO, Integer userId) {
        try {
            UserGrade userGrade = new UserGrade();
            BeanUtils.copyProperties(stuSubmitExamDTO, userGrade);
            userGrade.setAnswerDate(new Date());
            userGrade.setUserId(userId);
            userGrade.setMarkStatus(0);
            userGrade.setExamStatus(1);

            double grade = 0;

            //总分
            for (UserTopic ut : stuSubmitExamDTO.getUserTopicList()) {

                Topic topic = topicDao.selectByPrimaryKey(ut.getTopicId());

                /*判断回答是否正确*/
                //填空题
                if (topic.getTopicType() == 3) {
                    String[] correctAnswerArr = topic.getCorrectAnswer().split("\n");
                    String[] userAnswerArr = ut.getUserAnswer().split("\n");
                    double topicGrade = 0;
                    for (int i = 0; i < correctAnswerArr.length; i++) {
                        for (int j = 0; j < userAnswerArr.length; j++) {
                            if (correctAnswerArr[i].equals(userAnswerArr[j])) {
                                topicGrade = topicGrade + (int) (topic.getScore() / correctAnswerArr.length);
                            }
                        }
                    }
                    ut.setUserScore(topicGrade);
                    grade = grade + topicGrade;
                }
                //简答题
                else if (topic.getTopicType() == 4) {
                    String[] correctAnswerArr = topic.getCorrectAnswer().split("\n");
                    double topicGrade = 0;
                    for (String ca : correctAnswerArr) {
                        if (ut.getUserAnswer().contains(ca)) {
                            topicGrade = topicGrade + (int) (topic.getScore() / correctAnswerArr.length);
                        }
                    }
                    ut.setUserScore(topicGrade);
                    grade = grade + topicGrade;


                }
                // 多选题
                else if (topic.getTopicType() == 1) {
                    String[] correctAnswerArr = topic.getCorrectAnswer().split("\n");
                    String[] userAnswerArr = ut.getUserAnswer().split("\n");
                    double topicGrade = 0;
                    if(!ObjectUtils.isEmpty(userAnswerArr) &&userAnswerArr.length <= correctAnswerArr.length){ // 多选不得分，少选或者正确选择得分
                        for(int i = 0; i < correctAnswerArr.length; i++) {
                            for(int j = 0; j < userAnswerArr.length; j++) {
                                if(correctAnswerArr[i].equals(userAnswerArr[j])){
                                    topicGrade = topicGrade + (int) (topic.getScore() / correctAnswerArr.length);
                                }
                            }
                        }
                    }
                    ut.setUserScore(topicGrade);
                    grade = grade + topicGrade;
                }
                //其他题型
                else if (topic.getCorrectAnswer().equals(ut.getUserAnswer())) {
                    //评判分数
                    ut.setUserScore(topic.getScore());
                    //计算总分
                    grade = grade + topic.getScore();
                } else {
                    ut.setUserScore(0.0);
                }


                //设置为未批改状态
                ut.setTopicStatus("0");
                ut.setUserId(userId);
                userTopicDao.insert(ut);
            }
            userGrade.setGradeAuto(grade);
            System.out.println(userGrade);

            Exam exam = examDao.selectByPrimaryKey(stuSubmitExamDTO.getExamId());
            if (exam.getAutoMack() == 1) {
                userGrade.setGrade(grade);
            }
            userGradeDao.insert(userGrade);
            return ResultUtil.success();
        } catch (Exception e) {
            //强制手动事务回滚
            TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
            return ResultUtil.error(100, "请求失败", e.toString());
        }
    }

    @Override
    public Msg selectByClassesId(Integer classesId, Integer examId, Integer userId) {
        try {
            Classes classes = classesDao.selectByPrimaryKey(classesId);
            if (userId != classes.getCreatorId()) {
                return ResultUtil.error(400, "您不是该班级管理员");
            }

            List<UserGrade> userGradeList = userGradeDao.selectByClassesId(classesId, examId);
            //删除创建者数据
            for (int i = 0; i < userGradeList.size(); i++) {
                if (userGradeList.get(i).getUserId() == userId) {
                    userGradeList.remove(i);
                }
            }
            return ResultUtil.success(userGradeList);

        } catch (Exception e) {
            System.out.println(e);
            //强制手动事务回滚
            TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
            return ResultUtil.error(100, "请求失败", e.toString());
        }
    }

    @Override
    public Msg selestStuExamInfo(Integer classesId, Integer examId, Integer userId) {
        try {
            MarkExamInfoDTO markExamInfoDTO = examDao.selestStuExamInfo(classesId, examId, userId);
            return ResultUtil.success(markExamInfoDTO);
        } catch (Exception e) {
            System.out.println(e);
            //强制手动事务回滚
            TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
            return ResultUtil.error(100, "请求失败", e.toString());
        }
    }

    @Override
    public Msg tchMarkExam(UserGradeDTO userGradeDTO, Integer userId) {
        try {
            Exam exam = examDao.selectByPrimaryKey(userGradeDTO.getExamId());
            if (exam.getCreatorId() != userId) {
                return ResultUtil.error(3004, "您没有权利批改该试卷(身份不正确)");
            }

            UserGrade userGrade = new UserGrade();
            BeanUtils.copyProperties(userGradeDTO, userGrade);
            userGrade.setMarkStatus(1);
            userGrade.setMarkDate(new Date());
            userGradeDao.updateByForeignKeySelective(userGrade);

            for (UserTopic ut : userGradeDTO.getUserTopicList()) {
                ut.setTopicStatus("1");
                userTopicDao.updateByForeignKeySelective(ut);
            }
            return ResultUtil.success();
        } catch (Exception e) {
            System.out.println(e);
            //强制手动事务回滚
            TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
            return ResultUtil.error(100, "请求失败", e.toString());
        }
    }

    @Override
    public Msg deletePaper(Integer examId) {
        // 开启事务 要么全部成功 要么全部失败
        try {
            // 1.删除试卷下的所有题目
            List<ExamTopic> examTopics = examTopicDao.selectByExamId(examId);
            List<Integer> topicList = examTopics.stream().map(ExamTopic::getTopicId).collect(Collectors.toList());
            boolean isTopicList = topicDao.deleteByTopicIdList(topicList);
            if (!isTopicList) {
                TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
                return ResultUtil.error(100, "删除试题失败");
            }

            // 2.删除试卷和题目之间的绑定
            int deleteByPrimaryKey = examTopicDao.deleteByPrimaryKey(examId);
            if (deleteByPrimaryKey < 1) {
                TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
                return ResultUtil.error(100, "删除试题和试卷的绑定关系失败");
            }

            // 3.删除班级和试卷之间的绑定 首先查询是否有绑定关系
            List<ExamClasses> examClasses = examClassesDao.selectByExamId(examId);
            if (!CollectionUtils.isEmpty(examClasses)) {
                int deleteByExamId = examClassesDao.deleteByExamId(examId);
                if (deleteByExamId < 1) {
                    TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
                    return ResultUtil.error(100, "删除班级和试卷的绑定关系失败");
                }
            }

            // 4.删除试卷
            int primaryKey = examDao.deleteByPrimaryKey(examId);
            if (primaryKey < 1) {
                TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
                return ResultUtil.error(100, "删除试卷的失败");
            }
            return ResultUtil.success("删除成功");
        } catch (Exception e) {
            System.out.println(e);
            //强制手动事务回滚
            TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
            return ResultUtil.error(100, "请求失败", e.toString());
        }
    }
}
