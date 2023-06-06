package edu.global.whitebox.security;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import edu.global.whitebox.beans.UserBean;

@Service
public class WhiteBoxUserDetailsService implements UserDetailsService {

	@Autowired
	private SqlSessionTemplate sqlSession;

	@Override
	public UserDetails loadUserByUsername(String usrId) throws UsernameNotFoundException {
		
		UserBean userInfo = this.sqlSession.selectOne("getUserInfo", usrId);
		return userInfo != null ? new WhiteBoxUserDetails(userInfo) : null;
	}
}
