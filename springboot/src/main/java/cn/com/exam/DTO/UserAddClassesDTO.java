package cn.com.exam.DTO;

import cn.com.exam.entity.User;
import lombok.Data;
import lombok.EqualsAndHashCode;

@EqualsAndHashCode(callSuper = true)
@Data
public class UserAddClassesDTO extends User {

    /**
     * 加入班级id
     */
    private Integer classesId;

    /**
     * 加入班级名称
     */
    private String classesName;

}
