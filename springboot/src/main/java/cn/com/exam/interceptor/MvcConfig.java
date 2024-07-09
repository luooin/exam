package cn.com.exam.interceptor;

import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.CorsRegistry;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

/**
 * SpringBoot2使用这种写法
 */
@Configuration
public class MvcConfig implements WebMvcConfigurer {


    /* 拦截器配置 */
    @Override
    public void addInterceptors(InterceptorRegistry registry) {
        registry.addInterceptor(new AccessInterceptor())
                .addPathPatterns("/**")
                .excludePathPatterns("/getUserById/**")
                .excludePathPatterns("/captcha/**")
                .excludePathPatterns("/login/**")
                .excludePathPatterns("/register/**")
                .excludePathPatterns("/images/**")
                .excludePathPatterns("/swagger-resources/**", "/webjars/**", "/v2/**", "/swagger-ui.html/**")
        ;
    }

    @Override
    public void addResourceHandlers(ResourceHandlerRegistry registry) {
        registry.addResourceHandler("/images/**").addResourceLocations("file:" + System.getProperty("user.dir") + "/src/main/resources/static/images/");
    }

    @Override
    public void addCorsMappings(CorsRegistry registry) {
        registry.addMapping("/**")// 允许跨域访问的路径
                .allowedMethods("POST", "GET", "PUT", "OPTIONS", "DELETE")// 允许请求方法
                .maxAge(168000)// 预检间隔时间
                .allowedHeaders("*")// 允许头部设置
                .allowCredentials(true); // 是否发送cookie

    }

}