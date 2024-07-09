package cn.com.exam.entity;

import java.io.Serializable;
import java.util.Date;
import lombok.Data;

/**
 * topic

 */
@Data
public class Topic implements Serializable {
    /**
     * 题目id
     */
    private Integer topicId;

    /**
     * 创建者id
     */
    private Integer creatorId;

    /**
     * 题目
     */
    private String question;

    /**
     * 选项
     */
    private String choice;

    /**
     * 图片
     */
    private String photo;

    /**
     * 题目类型  0:单选题 1:多选题 2:判断题 3:填空题 4:简答题
     */
    private Integer topicType;

    /**
     * 正确答案
     */
    private String correctAnswer;

    /**
     * 分数
     */
    private Double score;

    /**
     * 难度  简单,中等(默认),困难
     */
    private String difficulty;

    /**
     * 答案分析
     */
    private String analysis;

    /**
     * 非必填:0   必填:1
     */
    private Integer required;

    /**
     * 创建时间
     */
    private Date createDate;

    /**
     * 修改时间
     */
    private Date updateDate;

    /**
     * 科目id
     */
    private Integer subjectId;

    private static final long serialVersionUID = 1L;
}