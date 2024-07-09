package cn.com.exam.entity;

import java.io.Serializable;

import lombok.AllArgsConstructor;
import lombok.Data;

/**
 * user_password

 */
@Data
@AllArgsConstructor
public class UserPassword implements Serializable {
    /**
     * 用户id
     */
    private Integer userId;

    /**
     * 用户登录密码
     */
    private String password;

    private static final long serialVersionUID = 1L;
}