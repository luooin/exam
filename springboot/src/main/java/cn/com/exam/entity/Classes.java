package cn.com.exam.entity;

import java.io.Serializable;
import java.util.Date;

import com.fasterxml.jackson.annotation.JsonFormat;
import io.swagger.annotations.ApiModel;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.springframework.format.annotation.DateTimeFormat;

/**
 * classes

 */
@Data
@AllArgsConstructor
@NoArgsConstructor
@ApiModel
public class Classes implements Serializable {
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
    @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss",timezone = "GMT+8")
    private Date updateDate;

    /**
     * 创建时间
     */
    @DateTimeFormat(pattern="yyyy-MM-dd HH:mm:ss")
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

    private static final long serialVersionUID = 1L;
}