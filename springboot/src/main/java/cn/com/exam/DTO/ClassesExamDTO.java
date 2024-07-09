package cn.com.exam.DTO;

import com.fasterxml.jackson.annotation.JsonFormat;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;
import org.springframework.format.annotation.DateTimeFormat;

import java.util.Date;

@Data
public class ClassesExamDTO {
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

    /**
     * 发布时间
     */
    @ApiModelProperty(value="发布时间")
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss",timezone = "GMT+8")
    private Date releaseTime;

    /**
     * 开始时间
     */
    @ApiModelProperty(value="开始时间")
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss",timezone = "GMT+8")
    private Date startDate;

    /**
     * 结束时间
     */
    @ApiModelProperty(value="结束时间")
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss",timezone = "GMT+8")
    private Date deadline;

    /**
     * 是否公布答案   0:不公布   1:公布答案
     */
    @ApiModelProperty(value="是否公布答案   0:不公布   1:公布答案")
    private Integer publishAnswer;

    /**
     * 是否公布分数   0:不公布   1:公布
     */
    @ApiModelProperty(value="是否公布分数   0:不公布   1:公布")
    private Integer publishScore;

    /**
     * 状态 0:待批改 1:批改完成
     */
    @ApiModelProperty(value="状态 0:待批改 1:批改完成")
    private Integer status;
}
