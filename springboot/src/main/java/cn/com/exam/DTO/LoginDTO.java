package cn.com.exam.DTO;

import lombok.Data;

@Data
public class LoginDTO {
    private String name;

    private String password;

    private String verCode;

    private String verKey;
}
