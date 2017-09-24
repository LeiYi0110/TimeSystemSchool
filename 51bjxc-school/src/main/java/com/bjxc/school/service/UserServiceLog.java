package com.bjxc.school.service;
import java.lang.annotation.*;    

/**  
 *自定义注解 拦截service  
 */    
    
@Target({ElementType.PARAMETER, ElementType.METHOD})    
@Retention(RetentionPolicy.RUNTIME)    
@Documented    
public  @interface UserServiceLog {    
    
    String description()  default "";    
    
    
}  