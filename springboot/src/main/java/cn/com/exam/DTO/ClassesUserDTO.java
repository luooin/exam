package cn.com.exam.DTO;

import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.Data;

import java.util.Date;

@Data
public class ClassesUserDTO {
    /**
     * 班级id
     */
    private Integer classesId;

    /**
     * 班级名称
     */
    private String classesName;

    /**
     * 更新时间
     */
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss",timezone = "GMT+8")
    private Date updateDate;

    /**
     * 创建时间
     */
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss",timezone = "GMT+8")
    private Date createDate;

    /**
     * 班级简介
     */
    private String introduction;

    /**
     * 班级人数
     */
    private Integer peopleNum;

    /**
     * 创建者名称
     */
    private String creatorName;

    /**
     * 创建者id
     */
    private Integer creatorId;


    /**
     * 身份   creator:创建者  student:学生  admin:管理员
     */
    private String position;

    /**
     * 加入时间
     */
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss",timezone = "GMT+8")
    private Date enterDate;


    /**
     * 是否可以选择当前班级
     */
    private Boolean selected;
}
