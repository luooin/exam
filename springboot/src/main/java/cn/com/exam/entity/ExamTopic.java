package cn.com.exam.entity;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import java.io.Serializable;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

/**
 * exam_topic

 */
@ApiModel(value="cn.com.exam.entity.ExamTopic")
@Data
@AllArgsConstructor
@NoArgsConstructor
public class ExamTopic implements Serializable {
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
     * 题目id
     */
    @ApiModelProperty(value="题目id")
    private Integer topicId;

    /**
     * 题目类型  0:单选题 1:多选题 2:判断题 3:填空题 4:简答题
     */
    @ApiModelProperty(value="题目类型  0:单选题 1:多选题 2:判断题 3:填空题 4:简答题")
    private Integer topicType;

    private static final long serialVersionUID = 1L;
}