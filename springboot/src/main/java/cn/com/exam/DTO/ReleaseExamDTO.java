package cn.com.exam.DTO;

import com.fasterxml.jackson.annotation.JsonFormat;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import java.util.Date;

@Data
public class ReleaseExamDTO {
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

    /**
     * 及格分数
     */
    @ApiModelProperty(value="及格分数")
    private Double passMark;

    /**
     * 及格率
     */
    @ApiModelProperty(value="及格率")
    private Double passRate;

    /**
     * 平均分
     */
    @ApiModelProperty(value="平均分")
    private Double average;

    private static final long serialVersionUID = 1L;
}