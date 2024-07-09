package cn.com.exam.entity;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import java.io.Serializable;

/**
 * subjects
 *
 * @author
 */
@ApiModel(value = "cn.com.exam.entity.Subjects")
@Data
public class Subjects implements Serializable {
    /**
     * 科目id
     */
    @ApiModelProperty(value = "科目id")
    private Integer id;

    /**
     * 科目名称
     */
    @ApiModelProperty(value = "科目名称")
    private String name;


    private static final long serialVersionUID = 1L;
}