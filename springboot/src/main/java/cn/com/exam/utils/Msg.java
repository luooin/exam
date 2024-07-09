package cn.com.exam.utils;

//import lombok.AllArgsConstructor;
import lombok.Data;
//import lombok.NoArgsConstructor;

@Data
//@AllArgsConstructor
//@NoArgsConstructor
public class Msg<T> {
    /*错误码*/
    private Integer code;

    /*提示信息 */
    private String msg;

    /*具体内容*/
    private  T data;

}
