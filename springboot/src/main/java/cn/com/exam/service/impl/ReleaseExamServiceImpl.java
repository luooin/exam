package cn.com.exam.service.impl;

import cn.com.exam.DTO.ReleasExamVO;
import cn.com.exam.DTO.ReleaseExamDTO;
import cn.com.exam.dao.ExamClassesDao;
import cn.com.exam.dao.UserGradeDao;
import cn.com.exam.entity.ExamClasses;
import cn.com.exam.entity.UserGrade;
import cn.com.exam.service.ReleaseExamService;
import cn.com.exam.utils.Msg;
import cn.com.exam.utils.ResultUtil;
import org.springframework.beans.BeanUtils;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.transaction.interceptor.TransactionAspectSupport;

import javax.annotation.Resource;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

@Service
@Transactional  //事务的注解
public class ReleaseExamServiceImpl implements ReleaseExamService {
    @Resource
    private ExamClassesDao examClassesDao;
    @Resource
    private UserGradeDao userGradeDao;


    @Override
    public Msg releaseTest(ReleasExamVO releasExamVO) {
        try {
            List<ExamClasses> examClassesList = examClassesDao.selectByExamId(releasExamVO.getExamId());
            //未发布的班级id
            List<Integer> addRecord = new ArrayList<Integer>();
            //已发布的班级id
            List<Integer> updateRecord = new ArrayList<Integer>();
            //按是否已发布分类
            for (int i = 0; i < releasExamVO.getClassesId().length; i++) {
                Boolean isHas = false;
                for (ExamClasses ec : examClassesList) {
                    if (releasExamVO.getClassesId()[i] == ec.getClassesId()) {
                        updateRecord.add(releasExamVO.getClassesId()[i]);
                        isHas = true;
                        break;
                    }
                }
                if (!isHas) {
                    addRecord.add(releasExamVO.getClassesId()[i]);
                }

            }

            ExamClasses examClasses = new ExamClasses();
            BeanUtils.copyProperties(releasExamVO, examClasses);

            examClasses.setStatus(0);
            examClasses.setReleaseTime(new Date());

            for (Integer i : addRecord) {
                examClasses.setClassesId(i);
                examClassesDao.insert(examClasses);
            }
            for (Integer i : updateRecord) {
                examClasses.setClassesId(i);
                examClassesDao.updateRecord(examClasses);
            }
            return ResultUtil.success();
        } catch (Exception e) {
            System.out.println(e);
            //强制手动事务回滚
            TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
            return ResultUtil.error(100, "请求失败", e.toString());
        }
    }

//    @Override
//    public int updateRecord(int tp_id, int c_id,String release_time, String start_date, String deadline) {
//        return releaseTestPaperMapper.updateRecord(tp_id, c_id,release_time, start_date, deadline);
//    }

    @Override
    public int deleteRecord(Integer examId, Integer classesId) {
        return examClassesDao.deleteRecord(examId, classesId);
    }

    @Override
    public Msg getReleaseInfo(Integer classesId, Integer examId) {
        try {
            ReleaseExamDTO examClasses = examClassesDao.selectRecord(classesId, examId);
            List<UserGrade> userGradeList = userGradeDao.selectByClassesId(classesId, examId);
            double totalScore = 0.0;
            int commitNumber = 0;
            double passNumber = 0;
            for (UserGrade ug : userGradeList) {
                if (ug.getExamStatus() == null) {
                    continue;
                }
                commitNumber += 1;
                System.out.println(ug);
                if (ug.getExamStatus() == 1 && ug.getMarkStatus() == 1) {
                    totalScore += ug.getGrade();
                    if (ug.getGrade() >= examClasses.getPassMark()) {
                        passNumber += 1;
                    }
                }
            }
            if (commitNumber == 0) {
                examClasses.setAverage(0.0);
                examClasses.setPassRate(0.0);
            } else {
                examClasses.setAverage(totalScore / commitNumber);
                examClasses.setPassRate((passNumber / commitNumber) * 100);
            }


            return ResultUtil.success(examClasses);
        } catch (Exception e) {
            System.out.println(e);
            //强制手动事务回滚
            TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
            return ResultUtil.error(100, "请求失败", e.toString());
        }
    }
}
