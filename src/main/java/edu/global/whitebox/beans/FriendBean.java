package edu.global.whitebox.beans;

import lombok.Data;

@Data
public class FriendBean extends UserBean {
	
	private String friendId;
	private String friSender;
	private String friReceiver;
	private String friState;
	private String friDate;
	
	private String myId;
	private String query;
	
	// UserBean 상속 
//	private String usrLastname;
//	private String usrFirstname;
//	private String usrImage;
//	private String memGender;
//	private String memBirthday;
}
