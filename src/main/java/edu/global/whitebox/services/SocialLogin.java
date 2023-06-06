package edu.global.whitebox.services;

import org.springframework.web.servlet.ModelAndView;

import com.google.gson.JsonElement;

public interface SocialLogin {
	public JsonElement execute(ModelAndView mav);
	public abstract String getAccessToken(String authorizationCode);
	public abstract JsonElement getUserInfo(String accessToken);
}
