package cn.com.exam.DTO;

import com.fasterxml.jackson.annotation.JsonFormat;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import java.util.Date;

@Data
public class ExamClassesDTO {
    /**
     * 试卷id
     */
    private Integer examId;

    /**
     * 试卷名称
     */
    private String examName;

    /**
     * 创建者id
     */
    private Integer creatorId;

    /**
     * 创建者名称
     */
    private String creatorName;

    /**
     * 答题时间(分钟)
     */
    private Integer time;

    /**
     * 创建时间
     */
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss",timezone = "GMT+8")
    private Date createDate;

    /**
     * 修改时间
     */
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss",timezone = "GMT+8")
    private Date updateDate;

    /**
     * 科目类型id
     */
    private Integer subjectId;

    /**
     * 科目类型名称
     */
    private String subjectName;

    /**
     * 题目数量
     */
    private Integer topicNum;

    /**
     * 总分
     */
    private Double totalScore;

    /**
     * 及格分数
     */
    private Double passMark;

    /**
     * 是否允许复制  0:不允许  1:允许(默认)
     */
    private Integer permitCopy;

    /**
     * 是否打乱题目顺序 0:不打乱(默认) 1:打乱顺序
     */
    private Integer disruptOrder;

    /**
     * 允许考生考试次数 默认1
     */
    private Integer repeatTest;

    /**
     * 是否自动评分 0:否   1:是(默认)
     */
    private Integer autoMack;


    /**
     * 发布时间
     */
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss",timezone = "GMT+8")
    @ApiModelProperty(value="发布时间")
    private Date releaseTime;

    /**
     * 开始时间
     */
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss",timezone = "GMT+8")
    @ApiModelProperty(value="开始时间")
    private Date startDate;

    /**
     * 结束时间
     */
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss",timezone = "GMT+8")
    @ApiModelProperty(value="结束时间")
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
     * 试卷得分
     */
    @ApiModelProperty(value="试卷得分")
    private Double grade;

    /**
     * 批改状态 0:待批改 1:批改完成
     */
    @ApiModelProperty(value="批改状态 0:待批改 1:批改完成")
    private Integer markStatus;

    /**
     * 试卷状态 0:未完成  1:已完成
     */
    @ApiModelProperty(value="试卷状态 0:未完成  1:已完成")
    private Integer examStatus;

    /**
     * 批改日期
     */
    @ApiModelProperty(value="批改日期")
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss",timezone = "GMT+8")
    private Date markDate;
}
