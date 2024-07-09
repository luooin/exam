package cn.com.exam.DTO;

import lombok.Data;

@Data
public class TopicStuDTO {
    /**
     * 题目id
     */
    private Integer topicId;

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
     * 分数
     */
    private Double score;

    /**
     * 难度  简单,中等(默认),困难
     */
    private String difficulty;


}
