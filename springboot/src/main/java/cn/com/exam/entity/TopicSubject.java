
package cn.com.exam.entity;

import lombok.Data;

import java.util.Date;

/**
 * <p>
 * UserSubject
 * </p >
 *
 */
@Data
public class TopicSubject {
    /**
     * id
     */
    private Integer id;

    /**
     * 科目id
     */
    private Integer subjectId;

    /**
     * 试卷id
     */
    private Integer examId;

    /**
     * 题目id
     */
    private Integer topicId;

    /**
     * 创建时间
     */
    private Date createDate;

    /**
     * 修改时间
     */
    private Date updateDate;
}