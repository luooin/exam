package cn.com.exam.entity;

import java.io.Serializable;
import java.util.Date;

import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.Data;

/**
 * exam

 */
@Data
public class Exam implements Serializable {
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
     * 允许页面切换次数  -1: 允许多次切换 (默认)
     */
    private Integer switchPage;

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
     * 是否发布中 0:否   1:是
     */
    private Integer releasing;

    private static final long serialVersionUID = 1L;
}