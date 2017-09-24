package com.bjxc.school.service;

import java.lang.reflect.Method;

import javax.annotation.Resource;

import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Before;
import org.aspectj.lang.annotation.Pointcut;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Component;

import com.bjxc.school.OperationLog;
import com.bjxc.school.controller.UserControllerLog;
import com.bjxc.school.security.UsinInfo;

@Aspect
@Component
public class UserLogAspect {
private  static  final Logger logger = LoggerFactory.getLogger(UserLogAspect.class);
	
	@Resource
	private OperationLogService operationLogService;

	@Pointcut("@annotation(com.bjxc.school.controller.UserControllerLog)")
	public void controllerAspect() {
	}

	@Before("controllerAspect()")
	public void doBefore(JoinPoint joinPoint) {
		handleLog(joinPoint, null);
	}

	/**
	 * 处理日志
	 * @param joinPoint
	 * @param e
	 */
	private void handleLog(JoinPoint joinPoint,Exception e) {
	    try {
	        //获得注解
	        String logEvent = getControllerMethodDescription(joinPoint);
	        
	        //获取用户名
			UsinInfo usinInfo = (UsinInfo)SecurityContextHolder.getContext().getAuthentication().getPrincipal();
			
			//保存到数据库
			OperationLog operationLog = new OperationLog();
			operationLog.setInsId(usinInfo.getInsId());
			operationLog.setLogUser(usinInfo.getUsername());
			operationLog.setLogEvent(logEvent);
			operationLog.setLogTime(new java.util.Date());
			operationLog.setRemark(logEvent);
			operationLogService.add(operationLog);
			
	    } catch (Exception exp) {
	        logger.error("异常信息:{}", exp.getMessage());
	        exp.printStackTrace();
	       }
	}
	
	 /**  
     * 获取注解中对方法的描述信息 用于Controller层注解  
     *  
     * @param joinPoint 切点  
     * @return 方法描述  
     * @throws Exception  
     */    
     public  static String getControllerMethodDescription(JoinPoint joinPoint)  throws Exception {    
        String targetName = joinPoint.getTarget().getClass().getName();    
        String methodName = joinPoint.getSignature().getName();    
        Object[] arguments = joinPoint.getArgs();    
        Class targetClass = Class.forName(targetName);    
        Method[] methods = targetClass.getMethods();    
        String description = "";    
         for (Method method : methods) {    
             if (method.getName().equals(methodName)) {    
                Class[] clazzs = method.getParameterTypes();    
                 if (clazzs.length == arguments.length) {    
                    description = method.getAnnotation(UserControllerLog. class).description();    
                     break;    
                }    
            }    
        }    
         return description;    
    }    
}
