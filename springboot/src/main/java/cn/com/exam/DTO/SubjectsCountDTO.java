package cn.com.exam.DTO;

import cn.com.exam.entity.Subjects;
import lombok.Data;
import lombok.EqualsAndHashCode;

@EqualsAndHashCode(callSuper = true)
@Data
public class SubjectsCountDTO extends Subjects {

    /**
     * 当前科目下的班级数量
     */
    private Integer numberCount;


    /**
     * 当前科目下的试卷数量
     */
    private Integer examCount;
}
