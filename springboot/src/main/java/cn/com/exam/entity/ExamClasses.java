package cn.com.exam.entity;

import com.fasterxml.jackson.annotation.JsonFormat;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import java.io.Serializable;
import java.util.Date;
import lombok.Data;

/**
 * exam_classes

 */
@ApiModel(value="cn.com.exam.entity.ExamClasses")
@Data
public class ExamClasses implements Serializable {
    /**
     * 主键
     */
    @ApiModelProperty(value="主键")
    private Integer id;

    /**
     * 考试id
     */
    @ApiModelProperty(value="考试id")
    private Integer examId;

    /**
     * 班级id
     */
    @ApiModelProperty(value="班级id")
    private Integer classesId;

    /**
     * 考试名称
     */
    @ApiModelProperty(value="考试名称")
    private String examName;

    /**
     * 班级名称
     */
    @ApiModelProperty(value="班级名称")
    private String classesName;

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

    private static final long serialVersionUID = 1L;
}