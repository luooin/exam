package cn.com.exam.controller;

import cn.com.exam.DTO.UploadDTO;
import cn.com.exam.utils.Msg;
import cn.com.exam.utils.ResultUtil;
import org.apache.commons.io.FilenameUtils;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.io.IOException;
import java.util.UUID;


@RestController
public class uploadController {

    //读取properties中的属性作为上传图片的父目录
    private final String path = System.getProperty("user.dir") + "/src/main/resources/static/images/";
    @PostMapping("/upload")
    public Msg fileUpload(@RequestParam("file") MultipartFile file, ModelMap map){

        //第一步，获取上传文件的文件名。
        String name =   file.getOriginalFilename();

        //第二步，判断是否有上传目录，没有则创建
        File fileParent = new File(path);
        if(!fileParent.exists()){
            fileParent.mkdir();
        }

        //获取上传文件的文件名（jpg）
        String ext = FilenameUtils.getExtension(name);

        //生成随机名字
        String uuidName = UUID.randomUUID().toString().replace("-","");

        //拼接后缀名
        String newFileName = uuidName+"."+ext;
        try {

            //实际就这一步骤起作用
            //可以结合linux的重命名移动文件命令来理解这句话
            //例子：将/a目录移动到/b下，并重命名为c ：mv /a /b/c
            //那么这个也是 ，将之前的上传的file直接重命名移动到目录下

            file.transferTo(new File(fileParent,newFileName));
            map.addAttribute("src",newFileName);

            return ResultUtil.success(new UploadDTO(name,newFileName));
        } catch (IOException e) {
            return ResultUtil.error(100,"请求失败",e.toString());

        }
    }

    @DeleteMapping("/upload/delete")
    public Msg deleteDileUpload(@RequestParam("fileName") String fileName){

        //判断是否有上传目录，没有则创建
        File fileParent = new File(path);
        if(!fileParent.exists()){
            fileParent.mkdir();
        }

        File file = new File(fileParent,fileName);
        if(file.delete()){
            return ResultUtil.success();
        }else {
            return ResultUtil.error(100,"请求失败");
        }
    }
}
