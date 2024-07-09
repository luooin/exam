package cn.com.exam.DTO;

import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.Data;

import java.util.Date;
import java.util.List;

@Data
public class ExamTopicTchDTO {
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
     * 科目类型id
     */
    private Integer subjectId;

    /**
     * 是否打乱题目顺序 0:不打乱(默认) 1:打乱顺序
     */
    private Integer disruptOrder;

    /**
     * 允许页面切换次数  -1: 允许多次切换 (默认)
     */
    private Integer switchPage;

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

    /**
     * 难度  简单,中等(默认),困难
     */
    private String difficulty;

    /**
     * 题目类型  0:单选题 1:多选题 2:判断题 3:填空题 4:简答题
     */
    private Integer topicType;

    /**
     * 题目信息(教师)
     */
    private List<TopicTchDTO> topicTchDTOList;
}
