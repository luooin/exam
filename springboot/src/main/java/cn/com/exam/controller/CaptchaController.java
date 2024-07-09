package cn.com.exam.controller;

import cn.com.exam.utils.JsonResult;
import cn.com.exam.utils.RedisUtil;
import com.wf.captcha.SpecCaptcha;
import io.swagger.annotations.ApiOperation;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.HashMap;
import java.util.Map;
import java.util.UUID;

/**
 * <p>
 * CaptchaController 验证码
 * </p >
 *
 * @since
 */
@RestController
public class CaptchaController {
    @Autowired
    private RedisUtil redisUtil;


    @ApiOperation("获取验证码")
    @RequestMapping("/captcha")
    public JsonResult<Map<String, String>> captcha() throws Exception {
        Map<String, String> result = new HashMap<>();
        SpecCaptcha specCaptcha = new SpecCaptcha(140, 43, 5);
        // 设置内置字体
        specCaptcha.setFont(SpecCaptcha.FONT_1);
        String verCode = specCaptcha.text().toLowerCase();
        /*if(set){
//            CaptchaUtil.out(specCaptcha,request,response);
        }*/
        String key = UUID.randomUUID().toString();
        //存入redis并设置过期时间为30分钟
        boolean set = redisUtil.set(key, verCode, Long.valueOf(30 * 60));
        if (set) {
            //将key和base64返回给前端
            result.put("key", key);
            result.put("image", specCaptcha.toBase64());
//            CaptchaUtil.out(specCaptcha,request,response);
        } else {
            return JsonResult.error("验证码获取失败", result);// 返回空对象
        }
        return JsonResult.success(result);
    }

}