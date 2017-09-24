package com.bjxc.school.security;

import java.net.URLDecoder;
import java.util.ArrayList;
import java.util.Collection;
import java.util.List;

import javax.annotation.Resource;

import org.apache.log4j.Logger;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;

import com.bjxc.json.JacksonBinder;


public class SchoolUserDetailsService implements UserDetailsService {
	protected static Logger logger = Logger.getLogger("service");
	@Resource
	private SchoolUserMapper schoolUserMapper;
	
	@Resource
	private RoleAuthMapper roleAuthMapper;
	
	@Resource
	private UserAuthMapper userAuthMapper;
	
	public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
			// 搜索数据库以匹配用户登录名.
			// 我们可以通过dao使用JDBC来访问数据库
			SchoolUser schoolUser = schoolUserMapper.loadSchoolUserByUserName(username);
			if(schoolUser != null){
				Boolean enabled = new Integer(1).equals(schoolUser.getStatus())?true:false;
				UsinInfo usinInfo = new UsinInfo(schoolUser.getUsername(), schoolUser.getPassword().toLowerCase(),schoolUser.getInsId(),schoolUser.getInsCode(), enabled, true, true, true,
						getAuthorities(schoolUser.getRole(),schoolUser.getId()));
				usinInfo.setInsName(schoolUser.getInsName());
				usinInfo.setStationId(schoolUser.getStationId());
				usinInfo.setId(schoolUser.getId());
				usinInfo.setInsCode(schoolUser.getInsCode());
				usinInfo.setRole(schoolUser.getRole());
				
				
				
				return usinInfo;
			}else{
				throw new UsernameNotFoundException("Error in retrieving user");
			}

	}

	/**
	 * 获得访问角色权限
	 * 
	 * @param access
	 * @return
	 */
	@SuppressWarnings("deprecation")
	private Collection<? extends GrantedAuthority> getAuthorities(Integer role, Integer platformUserId) {
		List<GrantedAuthority> authList = new ArrayList<GrantedAuthority>(2);
		// 所有的用户默认拥有ROLE_USER权限
		logger.debug("Grant ROLE_USER to this user");
		authList.add(new SimpleGrantedAuthority("ROLE_USER"));

		// 如果参数access为1.则拥有ROLE_ADMIN权限
		if (new Integer(1).equals(role)) {
			logger.debug("Grant ROLE_PLATFORM_MANAGER to this user");
			authList.add(new SimpleGrantedAuthority("ROLE_PLATFORM_MANAGER"));
			authList.add(new SimpleGrantedAuthority("ROLE_TIME_SYSTEM"));
		}
		if (new Integer(2).equals(role)) {
			logger.debug("Grant ROLE_SCHOOL_MANAGER to this user");
			authList.add(new SimpleGrantedAuthority("ROLE_SCHOOL_MANAGER"));
			authList.add(new SimpleGrantedAuthority("ROLE_TIME_SYSTEM"));
		}
		if (role.intValue() >= 3 && role.intValue() < 100) {
			logger.debug("Grant ROLE_SCHOOL_SERVICE to this user");
			authList.add(new SimpleGrantedAuthority("ROLE_SCHOOL_SERVICE"));
			authList.add(new SimpleGrantedAuthority("ROLE_TIME_SYSTEM"));
		}
		if (role.intValue() == 100) {
			logger.debug("Grant ROLE_TIME_SYSTEM to this user");
			authList.add(new SimpleGrantedAuthority("ROLE_SCHOOL_MANAGER"));
			authList.add(new SimpleGrantedAuthority("ROLE_PLATFORM_MANAGER"));
			authList.add(new SimpleGrantedAuthority("ROLE_TIME_SYSTEM"));
		}
		
		List<RoleAuth> roleAuthList = roleAuthMapper.getRoleAuthList(role);
		for(RoleAuth item : roleAuthList)
		{
			authList.add(new SimpleGrantedAuthority("ROLE_OPERATION_" + item.getOperationItemId().toString()));
		}
		
		List<UserAuth> userAuthList = userAuthMapper.getPlatformUserAuthList(platformUserId);
		
		for(UserAuth item : userAuthList)
		{
			authList.add(new SimpleGrantedAuthority("ROLE_UserOperation_" + item.getOperationItemId().toString()));
		}
		
		return authList;
	}

}
