package edu.global.whitebox.utilities;

import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Component;

@Component
public class SocialEncoder implements PasswordEncoder {
	
	private PasswordEncoder passwordEncoder;
	
	public SocialEncoder() {
		this.passwordEncoder = new BCryptPasswordEncoder();
	}

	@Override
	public String encode(CharSequence rawPassword) {
		// 암호화 안한다고 
		return (String) rawPassword;
	}

	@Override
	public boolean matches(CharSequence rawPassword, String encodedPassword) {
		// 시큐리티 부숴버리고 싶다
		return true;
	}

}
