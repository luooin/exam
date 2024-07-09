package cn.com.exam.service;


import cn.com.exam.DTO.UserAddClassesDTO;
import cn.com.exam.entity.User;
import cn.com.exam.utils.Msg;

import java.util.List;

public interface UserService {
    //登陆
    User login(String name, String password);

    Msg queryUserByC_id(int c_id, int userId);

    //修改用户信息
    int updateUser(User user);

    Msg queryUserList(int currentPage, int pageSize, String username);

    Msg deleteByUserId(Integer userId);

    Msg addUserByAdmin(UserAddClassesDTO user);

    Msg findOneByUserId(Integer id);

    List<User> getUserNoClasses();

}
