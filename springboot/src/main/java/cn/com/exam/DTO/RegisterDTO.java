package cn.com.exam.DTO;

import lombok.Data;

@Data
public class RegisterDTO {
    private String userName;

    private String email;

    private String phone;

    private String password;
}
