package cn.com.exam.entity;

import lombok.Data;

@Data
public class ClassesSubjects {

    /**
     * id
     */
    private Integer id;

    /**
     * 科目id
     */
    private Integer subjectId;

    /**
     * 班级id
     */
    private Integer classesId;
}
