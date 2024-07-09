package cn.com.exam.DTO;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class UploadDTO {
    /*
    * 文件名称
    * */
    private String fileName;

    /*
    * 文件url
    * */
    private String fileUrl;
}
