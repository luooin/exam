package cn.com.exam.DTO;

import lombok.Data;

/**
 * 当前班级是否选择当前科目DTO
 */
@Data
public class ClassesSubjectsDTO {

    /**
     * 班级id
     */
    private Integer classesId;

    /**
     * 科目id
     */
    private Integer subjectsId;

    /**
     * 科目名称
     */
    private String subjectsName;

    /**
     * 是否选择当前科目
     */
    private Boolean isHave;

}
