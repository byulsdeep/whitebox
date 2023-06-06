package edu.global.whitebox.security;

import java.io.IOException;
import java.io.ObjectInputStream;
import java.io.ObjectOutputStream;
import java.io.Serializable;
import java.util.Collection;
import java.util.Collections;
import java.util.List;
import java.util.stream.Collectors;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;

import edu.global.whitebox.beans.UserBean;

public class WhiteBoxUserDetails implements UserDetails, Serializable { // DB와 연결 || ID/PW/Authority를 가져와 연결
	private static final long serialVersionUID = 1L;
	private UserBean userInfo;
	private List<GrantedAuthority> authorities;
	
	private void writeObject(ObjectOutputStream oos) throws IOException {
        oos.defaultWriteObject();
        oos.writeObject(this.userInfo);
    }

    private void readObject(ObjectInputStream ois) throws IOException, ClassNotFoundException {
        ois.defaultReadObject();
        this.userInfo = (UserBean) ois.readObject();
    }
    
	public WhiteBoxUserDetails(UserBean userInfo) {
		if (userInfo != null) {
			this.userInfo = userInfo;
			this.authorities = userInfo.getAuthorities() != null ? userInfo.getAuthorities().stream()
					.map(authorityBean -> new SimpleGrantedAuthority(authorityBean.getAutAuthority()))
					.collect(Collectors.toList()) : Collections.singletonList(new SimpleGrantedAuthority(userInfo.getAuthority()));
		} else {
//			// loadByUsername에게 null을 전달하면 아이디 비번 비교를 못한다고 불평하니 다람쥐라도 쥐어주자
//			UserBean mock = new UserBean();
//			mock.setUsrId("Squirrel");
//			mock.setUsrPassword("Squirrel");
//			mock.setUsrEnabled(0);
//			this.userBean = mock;
//			this.authorities = Arrays.asList(new SimpleGrantedAuthority("ROLE_SQUIRREL"));
		}
	}
	public UserBean getUserInfo() {
		return this.userInfo;
	}

	@Override
	public Collection<? extends GrantedAuthority> getAuthorities() {
		return this.authorities;
	}
	@Override
	public String getPassword() {
		return this.userInfo.getUsrPassword();
	}
	@Override
	public String getUsername() {
		return this.userInfo.getUsrId();
	}
	// 계정이 만료 되지 않았는가?
	@Override
	public boolean isAccountNonExpired() {
		return true;
	}
	// 계정이 잠기지 않았는가?
	@Override
	public boolean isAccountNonLocked() {
		return true;
	}
	// 패스워드가 만료되지 않았는가?
	@Override
	public boolean isCredentialsNonExpired() {
		return true;
	}
	// 계정이 활성화 되었는가?
	@Override
	public boolean isEnabled() {
		return this.userInfo.getUsrEnabled() == 1;
	}
}