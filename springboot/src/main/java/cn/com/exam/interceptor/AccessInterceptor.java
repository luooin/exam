package cn.com.exam.interceptor;

import cn.com.exam.utils.JwtUtil;
import com.alibaba.fastjson.JSONObject;
import org.springframework.web.servlet.HandlerInterceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.PrintWriter;

public class AccessInterceptor implements HandlerInterceptor {
    @Override
    public boolean preHandle(HttpServletRequest request,
                             HttpServletResponse response, Object object) throws Exception {

        //response.setCharacterEncoding("UTF-8");
        //response.setContentType("application/json; charset=utf-8");
        response.setHeader("Access-Control-Allow-Credentials", "true");
        response.setHeader("Access-Control-Allow-Origin", "http://localhost:8080");
        response.setHeader("Access-Control-Allow-Headers", "Origin, X-Requested-With, Content-Type, Accept,token");
        response.setHeader("Access-Control-Allow-Methods", "GET, HEAD, POST, PUT, DELETE, TRACE, OPTIONS, PATCH");
        response.setHeader("Access-Control-Expose-Headers", "Token");


        //验证token
        String token = request.getHeader("token");
        boolean result = JwtUtil.verify(token);
        if (result) {
            return true;
        } else {
            response.setCharacterEncoding("UTF-8");
            response.setContentType("application/json; charset=utf-8");
            JSONObject res = new JSONObject();
            res.put("code", 300);
            res.put("msg", "token验证失败,请先登录");
            PrintWriter out = null;
            out = response.getWriter();
            out.write(res.toString());
            out.flush();
            out.close();
            return false;
        }

    }


}