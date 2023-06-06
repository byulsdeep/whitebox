package edu.global.whitebox.services;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.stereotype.Service;
import org.springframework.web.servlet.ModelAndView;

import com.google.gson.JsonElement;
import com.google.gson.JsonParser;

@Service
public class GoogleAuthentication implements SocialLogin{

	private static final Logger logger = LogManager.getLogger(GoogleAuthentication.class);

	public JsonElement execute(ModelAndView mav) {
		
		JsonElement element = null;

		String authorizationCode = (String) mav.getModel().get("authorizationCode");
		logger.info(authorizationCode);
		String accessToken = this.getAccessToken(authorizationCode);
		try {element = this.getUserInfo(accessToken);} catch (Exception e) {e.printStackTrace();}

		return element;
	}

	public String getAccessToken(String authorizationCode) {

		String accessToken = null;
		logger.info("getAccessToken(String) : " + authorizationCode);

		try {
			URL url = new URL("https://oauth2.googleapis.com/token");
			HttpURLConnection conn = (HttpURLConnection) url.openConnection();

			conn.setRequestMethod("POST");
			conn.setDoOutput(true);

			BufferedWriter bw = new BufferedWriter(new OutputStreamWriter(conn.getOutputStream()));
			StringBuilder sb = new StringBuilder();
			
			sb.append("grant_type=authorization_code");
			sb.append("&client_id=YOUR_CLIENT_ID_HERE"); // TODO REST_API_KEY 입력
			sb.append("&client_secret=YOUR_CLIENT_SECRET_HERE");
			sb.append("&redirect_uri=http://localhost/oauth/google"); // TODO 인가코드 받은 redirect_uri 입력
			sb.append("&code=" + URLEncoder.encode(authorizationCode, "UTF-8"));
			bw.write(sb.toString());
			bw.flush();

			logger.info("responseCode : " + conn.getResponseCode());

			BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream()));
			String line = "";
			String result = "";

			while ((line = br.readLine()) != null) {
				result += line;
			}
			logger.info("response body : " + result);

			accessToken = JsonParser.parseString(result).getAsJsonObject().get("access_token").getAsString();
			logger.info(accessToken);

			conn.disconnect();
			br.close();
			bw.close();

		} catch (IOException e) {
			e.printStackTrace();
		}
		return accessToken;
	}

	public JsonElement getUserInfo(String token) {
		logger.info("getUserInfo(String) : " + token);
		JsonElement element = null;
		String reqURL = "https://www.googleapis.com/oauth2/v1/userinfo";

		try {
			URL url = new URL(reqURL);
			HttpURLConnection conn = (HttpURLConnection) url.openConnection();

			conn.setRequestMethod("GET");
			conn.setDoOutput(true);
			conn.setRequestProperty("Authorization", "Bearer " + token);

			BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream()));
			String line = "";
			String result = "";

			while ((line = br.readLine()) != null) {
				result += line;
			}
			logger.info("response body : " + result);

			JsonParser parser = new JsonParser();
			element = parser.parse(result);

			br.close();

		} catch (IOException e) {
			e.printStackTrace();
		}
		return element;
	}

}