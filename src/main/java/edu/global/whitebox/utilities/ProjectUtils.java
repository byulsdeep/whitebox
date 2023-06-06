package edu.global.whitebox.utilities;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;

@Configuration
public class ProjectUtils {
	
	@Bean
	public Gson gson() {
		return new Gson();
	}
	
	@Bean
	public Gson gsonPretty() {
		return new GsonBuilder().setPrettyPrinting().create();
	}
}
