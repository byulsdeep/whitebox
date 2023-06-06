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
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;

@Service
public class LineAuthentication implements SocialLogin{

	private static final Logger logger = LogManager.getLogger(LineAuthentication.class);

	public JsonElement execute(ModelAndView mav) {
		
		JsonElement element = null;

		String authorizationCode = (String) mav.getModel().get("authorizationCode");
		String idToken = this.getAccessToken(authorizationCode);
		try {element = this.getUserInfo(idToken);} catch (Exception e) {e.printStackTrace();}
		
		return element;
	}

	public String getAccessToken(String authorizationCode) {

		String idToken = null;
		logger.info("getAccessToken(String) : " + authorizationCode);

		try {
			URL url = new URL("https://api.line.me/oauth2/v2.1/token");
			HttpURLConnection conn = (HttpURLConnection) url.openConnection();

			conn.setRequestMethod("POST");
			conn.setDoOutput(true);
			conn.setRequestProperty("Content-Type", "application/x-www-form-urlencoded");

			BufferedWriter bw = new BufferedWriter(new OutputStreamWriter(conn.getOutputStream()));
			StringBuilder sb = new StringBuilder();

			sb.append("grant_type=authorization_code");
			sb.append("&client_id=YOUR_CLIENT_ID_HERE");
			sb.append("&client_secret=YOUR_CLIENT_SECRET_HERE");
			sb.append("&redirect_uri=" + URLEncoder.encode("http://localhost/oauth/line", "UTF-8"));
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

			idToken = JsonParser.parseString(result).getAsJsonObject().get("id_token").getAsString();

			conn.disconnect();
			br.close();
			bw.close();

		} catch (IOException e) {
			e.printStackTrace();
		}
		return idToken;
	}

	public JsonElement getUserInfo(String token) {
		logger.info("getUserInfo(String) : " + token);
		JsonElement element = null;
		String reqURL = "https://api.line.me/oauth2/v2.1/verify";

		try {
			URL url = new URL(reqURL);
			HttpURLConnection conn = (HttpURLConnection) url.openConnection();

			conn.setRequestMethod("POST");
			conn.setDoOutput(true);
			conn.setRequestProperty("Content-Type", "application/x-www-form-urlencoded");

			BufferedWriter bw = new BufferedWriter(new OutputStreamWriter(conn.getOutputStream()));
			StringBuilder sb = new StringBuilder();

			sb.append("id_token=" + URLEncoder.encode(token, "UTF-8"));
			sb.append("&client_id=1661019082");

			System.out.println(sb);
			bw.write(sb.toString());
			bw.flush();

			// 결과 코드가 200이라면 성공
			int responseCode = conn.getResponseCode();
			logger.info("responseCode(createLineUser) : " + responseCode);

			// 요청을 통해 얻은 JSON타입의 Response 메세지 읽어오기
			BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream()));
			String line = "";
			String result = "";

			while ((line = br.readLine()) != null) {
				result += line;
			}
			logger.info("response body : " + result);

			// Gson 라이브러리로 JSON파싱
			JsonParser parser = new JsonParser();
			element = parser.parse(result);

			// sub값 id로 저장
		    JsonObject jsonObject = element.getAsJsonObject();
		    jsonObject.addProperty("id", element.getAsJsonObject().get("sub").getAsString());
			
			br.close();

		} catch (IOException e) {
			e.printStackTrace();
		}
		return element;
	}

}