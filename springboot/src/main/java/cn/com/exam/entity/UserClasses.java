package cn.com.exam.entity;

import java.io.Serializable;
import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Data;

/**
 * user_classes

 */
@Data
@AllArgsConstructor
public class UserClasses implements Serializable {
    private Integer id;

    /**
     * 用户id
     */
    private Integer userId;

    /**
     * 班级id
     */
    private Integer classesId;

    /**
     * 身份   creator:创建者  student:学生  admin:管理员
     */
    private String position;

    /**
     * 加入时间
     */
    private Date enterDate;

    private static final long serialVersionUID = 1L;
}