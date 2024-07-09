package cn.com.exam.service.impl;

import cn.com.exam.DTO.*;
import cn.com.exam.dao.*;
import cn.com.exam.entity.*;
import cn.com.exam.service.ExamService;
import cn.com.exam.utils.DateUtil;
import cn.com.exam.utils.Msg;
import cn.com.exam.utils.Page;
import cn.com.exam.utils.ResultUtil;
import com.alibaba.fastjson.JSON;
import org.springframework.beans.BeanUtils;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.transaction.interceptor.TransactionAspectSupport;
import org.springframework.util.ObjectUtils;

import javax.annotation.Resource;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Date;
import java.util.List;
import java.util.Objects;
import java.util.stream.Collectors;

@Service
@Transactional  //事务的注解
public class ExamServiceImpl implements ExamService {

    @Resource
    private ExamDao examDao;
    @Resource
    private UserClassesDao userClassesDao;
    @Resource
    private TopicDao topicDao;
    @Resource
    private ExamTopicDao examTopicDao;
    @Resource
    private ExamClassesDao examClassesDao;
    @Resource
    private UserGradeDao userGradeDao;
    @Resource
    private SubjectsDao subjectsDao;
    @Resource
    private TopicSubjectDao topicSubjectDao;

    @Override
    public Msg deleteByPrimaryKey(Integer examId) {
        return null;
    }

    @Override
    public Msg insert(ExamTopicTchDTO examTopicTchDTO, Integer userId) {
        try {
            Exam exam = new Exam();
            BeanUtils.copyProperties(examTopicTchDTO, exam);
            exam.setCreatorId(userId);
            exam.setCreateDate(new Date());
            exam.setUpdateDate(new Date());
            examDao.insert(exam);

            Topic t = new Topic();
            for (TopicTchDTO topic : examTopicTchDTO.getTopicTchDTOList()) {
                BeanUtils.copyProperties(topic, t);

                t.setCreatorId(userId);
                t.setCreateDate(new Date());
                t.setUpdateDate(new Date());

                topicDao.insert(t);
                examTopicDao.insert(new ExamTopic(null, exam.getExamId(), t.getTopicId(), t.getTopicType()));
            }

            return ResultUtil.success(exam);
        } catch (Exception e) {
            //强制手动事务回滚
            TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
            return ResultUtil.error(100, e.toString());
        }
    }


    @Override
    public Msg updateByPrimaryKeySelective(ExamTopicTchDTO examTopicTchDTO, Integer userId) {
        try {

            if (examTopicTchDTO.getCreatorId() != userId) {
                return ResultUtil.error(3002, "您没有权利更改该试卷");
            }

            //获取试卷_题目记录
            List<ExamTopic> examTopicList = examTopicDao.selectByExamId(examTopicTchDTO.getExamId());

            //获取旧的试卷id集合
            List<Integer> oldTopicIdList = new ArrayList<Integer>();
            for (ExamTopic tt : examTopicList) {
                oldTopicIdList.add(tt.getTopicId());
            }

            //判断更新后的题目是否存在  存在则更新   不存在则添加  剩下没有匹配到的则删除记录
            for (TopicTchDTO t : examTopicTchDTO.getTopicTchDTOList()) {
                t.setSubjectId(examTopicTchDTO.getSubjectId());
                Topic topic = new Topic();
                BeanUtils.copyProperties(t, topic);

                boolean isHas = false;
                for (int i = 0; i < oldTopicIdList.size(); i++) {
                    if (t.getTopicId() == oldTopicIdList.get(i)) {
                        isHas = true;
                        //存在则更新
                        topicDao.updateByPrimaryKeySelective(topic);
                        //移出旧的试卷id集合
                        oldTopicIdList.remove(i);
                        break;
                    }
                }
                //不存在则添加
                if (isHas == false) {
                    topic.setCreatorId(examTopicTchDTO.getCreatorId());
                    topic.setUpdateDate(new Date());
                    topic.setCreateDate(new Date());
                    topicDao.insert(topic);
                    examTopicDao.insert(new ExamTopic(null, examTopicTchDTO.getExamId(), topic.getTopicId(), topic.getTopicType()));
                }
            }
            //剩下没有匹配到的则删除
            for (Integer oldT_id : oldTopicIdList) {
                examTopicDao.deleteRecord(examTopicTchDTO.getExamId(), oldT_id);
            }

            //修改试卷信息
            Exam exam = new Exam();
            BeanUtils.copyProperties(examTopicTchDTO, exam);
            exam.setUpdateDate(new Date());
            examDao.updateByPrimaryKeySelective(exam);

            return ResultUtil.success("保存试卷成功！");
        } catch (Exception e) {
            //强制手动事务回滚
            TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
            return ResultUtil.error(100, e.toString());
        }
    }

    @Override
    public Msg<List<Exam>> selectByCreatorId(Integer userId, String keyword) {
        List<Exam> examList = examDao.selectByCreatorId(userId, keyword);
        for (Exam e : examList) {
            List<ExamClasses> examClassesList = examClassesDao.selectByExamId(e.getExamId());
            e.setReleasing(examClassesList.size() > 0 ? 1 : 0);

            Subjects subjects = subjectsDao.findById(e.getSubjectId());
            e.setSubjectName(subjects.getName());
        }
        return ResultUtil.success(examList);
    }

    @Override
    public Msg tchSelectByPrimaryKey(Integer userId, Integer examId) {
        ExamTopicTchDTO examTopicTchDTO = examDao.tchSelectByPrimaryKey(examId);
        if (examTopicTchDTO == null) {
            return ResultUtil.error(100, "请求失败");
        }
        examTopicTchDTO.setReleasing(0);
        List<ExamClasses> examClassesList = examClassesDao.selectByExamId(examId);
        if (examClassesList.size() > 0) {
            examTopicTchDTO.setReleasing(1);
        }
        if (!Objects.equals(examTopicTchDTO.getCreatorId(), userId)) {
            return ResultUtil.error(3001, "您没有权利查看该试卷");
        }
        return ResultUtil.success(examTopicTchDTO);

    }

    @Override
    public Msg stuSelectByPrimaryKey(Integer userId, Integer classesId, Integer examId) {
        UserClasses userClasses = userClassesDao.selectRecord(userId, classesId);
        if (userClasses == null) {
            return ResultUtil.error(3003, "您不是该班级的学生");
        }

        ExamTopicStuDTO examTopicStuDTO = examDao.stuSelectByPrimaryKey(examId, classesId, userId);
        if (examTopicStuDTO == null) {
            return ResultUtil.error(100, "请求失败");
        }
        ReleaseExamDTO examClasses = examClassesDao.selectRecord(classesId, examId);

        //不公布答案
        if (examClasses.getPublishAnswer() != 1 || examTopicStuDTO.getUserGrade().getExamStatus() == null) {
            for (TopicTchDTO t : examTopicStuDTO.getTopicTchDTOList()) {
                t.setAnalysis(null);
                t.setCorrectAnswer(null);
            }
        }

        //不公布分数
        if (examClasses.getPublishScore() != 1) {
            examTopicStuDTO.getUserGrade().setGrade(null);
            examTopicStuDTO.getUserGrade().setGradeAuto(null);
        }

        //不公布答案和分数
        if (examClasses.getPublishScore() != 1 && examClasses.getPublishAnswer() != 1) {
            for (UserTopic ut : examTopicStuDTO.getUserTopicList()) {
                ut.setUserScore(null);
            }
        }

        //学生未完成试卷
        if (examTopicStuDTO.getUserGrade().getExamStatus() == null) {
            examTopicStuDTO.setUserGrade(null);
            examTopicStuDTO.setUserTopicList(null);
        }

        // 科目名称
        examTopicStuDTO.setSubjectName(subjectsDao.findById(examTopicStuDTO.getSubjectId()).getName());

        return ResultUtil.success(examTopicStuDTO);
    }

    @Override
    public Msg selectByClassesId(Integer classesId, Integer userId) {
        try {
            List<ExamClassesDTO> examClassesDTOList = examDao.selectByClassesId(classesId, userId);
            examClassesDTOList.forEach(val -> {
                Subjects subjects = subjectsDao.findById(val.getSubjectId());
                val.setSubjectName(subjects.getName());
            });
            return ResultUtil.success(examClassesDTOList);
        } catch (Exception e) {
            System.out.println(e);
            //强制手动事务回滚
            TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
            return ResultUtil.error(100, "请求失败", e.toString());
        }
    }

    @Override
    public Msg selectFinishExamList(Integer userId, int pageSize, int currentPage) {
        List<UserGrade> userGradeDTOList = userGradeDao.selectByUserId(userId);
        for (UserGrade ug : userGradeDTOList) {
            ReleaseExamDTO examClasses = examClassesDao.selectRecord(ug.getClassesId(), ug.getExamId());
            if (examClasses != null && examClasses.getPublishScore() != 1) {
                ug.setGrade(null);
            }
        }
        Page<UserGrade> page = new Page<UserGrade>(pageSize, currentPage);
        page.build(userGradeDTOList);
        return ResultUtil.success(page);
    }

    @Override
    public Msg audioPaper(ExamTopicTchDTO paperInfo, Integer userId) {
        Date currentDate = new Date();
/**
 * 通过科目ID查询该科目有多少试题
 **/
        Topic topic = new Topic();
        topic.setSubjectId(paperInfo.getSubjectId());
        List<Topic> zjTopics = topicDao.selectTopicByTpParam(topic);
        if (zjTopics.isEmpty()) {
            return ResultUtil.error(100, "该科目试题不够");
        }
        Double sum = zjTopics.stream().mapToDouble(Topic::getScore).sum();
        /**jdk8 Stream流处理计算出这个集合里所有的分数**/
        if (sum < 100) {
            return ResultUtil.error(100, "该科目试题分数不够100分");
        }
        topic.setDifficulty(paperInfo.getDifficulty());
        List<Topic> zjTopics1 = topicDao.queryTitleByDifficulty(topic.getDifficulty(), topic.getSubjectId());
        Double result1 = zjTopics1.stream().mapToDouble(Topic::getScore).sum();
        if (result1 < 100) {
            return ResultUtil.error(100, "该科目该难度的试题不够(分数不够组卷)");
        }
        List<Topic> zjTopicsList = new ArrayList<>();
        //过滤所有单选
        List<Topic> collect = zjTopics1.stream().filter(f -> f.getTopicType() == 0).collect(Collectors.toList());
        /**
         * 初始题库每次查出来的题目乱序，如果选择题只有10个那么  10道题乱序。如果20道  20道题乱序然后抽取
         */
        System.out.println(JSON.toJSONString(collect));
        Collections.shuffle(collect);
//        System.out.println("----------------------------------------");
//        System.out.println(JSON.toJSONString(collect));
        if (collect.size() <= 10) {
            collect.forEach(f -> {
                Topic topicInfo = new Topic();
                BeanUtils.copyProperties(f, topicInfo);
                zjTopicsList.add(topicInfo);
            });
        } else {
            List<Topic> zjTopicsList1 = collect.subList(0, 10);
            zjTopicsList1.forEach(f -> {
                Topic topicInfo = new Topic();
                BeanUtils.copyProperties(f, topicInfo);
                zjTopicsList1.add(topicInfo);
            });
        }
        //让选择题每次生成的题目排列随机
//        Collections.shuffle(zjTitleInfoList);
        //填空或者主观
        List<Topic> collect1 = zjTopics1.stream().filter(f -> f.getTopicType() == 3 || f.getTopicType() == 4).collect(Collectors.toList());
        for (Topic topicInfo : collect1) {
            Double sum1 = zjTopicsList.stream().mapToDouble(Topic::getScore).sum();
            if (sum1 + topicInfo.getScore() <= 100) {
                zjTopicsList.add(topicInfo);
            } else if (sum1 + topicInfo.getScore() > 100) {
                break;
            }
        }
        Double sum1 = zjTopicsList.stream().mapToDouble(Topic::getScore).sum();
        if (sum1 < 100) {
            return ResultUtil.error(100, "分数不足不能组卷");
        }
        topic.setScore(result1);
        topic.setCreateDate(currentDate);
        paperInfo.setUpdateDate(currentDate);
        topicDao.insertSelective(topic);
        zjTopicsList.forEach(f -> {
            TopicSubject topicSubjectLink = new TopicSubject();
            topicSubjectLink.setSubjectId(topic.getSubjectId());
            topicSubjectLink.setExamId(paperInfo.getExamId());
            topicSubjectLink.setTopicId(f.getTopicId());
            topicSubjectLink.setCreateDate(currentDate);
            topicSubjectLink.setUpdateDate(currentDate);
            topicSubjectDao.insertSelective(topicSubjectLink);
        });
        //组卷完成给这个班级里面的所有学生 生成试卷
        List<ExamTopic> zjUserInfos = examTopicDao.selectByExamId(paperInfo.getSubjectId());
        List<TopicSubject> zjSubjectUserLinks = topicSubjectDao.selectByExamId(paperInfo.getExamId());
        List<Integer> titleIdList = new ArrayList<>();
        if (!ObjectUtils.isEmpty(zjSubjectUserLinks)) {
            zjSubjectUserLinks.forEach(f -> {
                titleIdList.add(f.getTopicId());
            });
        }

        /*ZjSubjectUserLink userLink = zjSubjectUserLinks.get(0);
        List<ZjTitleInfo> zjTitleInfos2 = titleInfoMapper.queryListByTitleId(titleIdList);
        List<ZjPaperTest> paperTests = new ArrayList<>();
        zjUserInfos.forEach(y -> {
            zjTitleInfos2.forEach(f -> {
                ZjPaperTest paperTest = new ZjPaperTest();
                paperTest.setTitleAnswer(f.getTitleAnswer());
                paperTest.setClassId(userLink.getClassId());
                paperTest.setPaperId(paperInfo.getPaperId());
                paperTest.setTitleFraction(f.getTitleFraction());
                paperTest.setTitleId(f.getTitleId());
                paperTest.setUserId(y.getUserId());
                paperTest.setUserName(y.getUserName());
                paperTest.setCreateTime(DateUtil.getCurrentDateTime());
                paperTests.add(paperTest);
            });
            ZjPaperUser paperUser = new ZjPaperUser();
            paperUser.setPaperId(paperInfo.getPaperId());
            paperUser.setUserId(y.getUserId());
            paperUserMapper.insertSelective(paperUser);
        });
        paperTestMapper.insertList(paperTests);*/
        return ResultUtil.success();
    }
}
