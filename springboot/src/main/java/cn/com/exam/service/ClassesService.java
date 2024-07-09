package cn.com.exam.service;

import cn.com.exam.DTO.ClassesUserDTO;
import cn.com.exam.entity.Classes;
import cn.com.exam.utils.Msg;

import java.util.List;
import java.util.Map;

public interface ClassesService {

    //根据教师查找班级
    Msg<List<ClassesUserDTO>> queryClassesByU_id(Integer u_id, String role, String keyword, Integer examIdTwo);

    //用户退出班级
    Msg outClasses(int u_id, int c_id);

    //根据班级id查找班级
    Msg queryClassesByC_id(int c_id);

    Msg queryClassesByExamId(Integer examId);

    //创建班级
    Msg createClasses(Classes classes, Integer userId);

    //修改班级信息
    Msg updateClasses(Classes classes, Integer userId);

    //删除班级
    Msg deleteClasses(int id);


    List<Classes> findAll();

    Boolean userAddClasses(Integer classesId, List<Integer> userIds);

    void findStudentClassesName(String token, Map<String, Object> dataMap);

}
