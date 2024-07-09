package cn.com.exam.DTO;

import cn.com.exam.entity.UserTopic;
import com.fasterxml.jackson.annotation.JsonFormat;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import java.util.Date;
import java.util.List;

@Data
public class UserGradeDTO {
    /**
     * 用户id
     */
    @ApiModelProperty(value="用户id")
    private Integer userId;

    /**
     * 班级id
     */
    @ApiModelProperty(value="班级id")
    private Integer classesId;

    /**
     * 考试id
     */
    @ApiModelProperty(value="考试id")
    private Integer examId;

    /**
     * 用户名称
     */
    @ApiModelProperty(value="用户名称")
    private String userName;

    /**
     * 班级名称
     */
    @ApiModelProperty(value="班级名称")
    private String classesName;

    /**
     * 考试名称
     */
    @ApiModelProperty(value="考试名称")
    private String examName;

    /**
     * 得分
     */
    @ApiModelProperty(value="得分")
    private Double grade;

    /**
     * 得分(自动评分)
     */
    @ApiModelProperty(value="得分(自动评分)")
    private Double gradeAuto;

    /**
     * 答题日期
     */
    @ApiModelProperty(value="答题日期")
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss",timezone = "GMT+8")
    private Date answerDate;

    /**
     * 答题时长
     */
    @ApiModelProperty(value="答题时长")
    private Integer answerTime;

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

    private List<UserTopic> userTopicList;
}
