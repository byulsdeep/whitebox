package edu.global.whitebox.utilities;

import java.io.UnsupportedEncodingException;
import java.security.InvalidAlgorithmParameterException;
import java.security.InvalidKeyException;
import java.security.Key;
import java.security.NoSuchAlgorithmException;
import java.util.HashMap;

import javax.crypto.BadPaddingException;
import javax.crypto.Cipher;
import javax.crypto.IllegalBlockSizeException;
import javax.crypto.NoSuchPaddingException;
import javax.crypto.spec.IvParameterSpec;
import javax.crypto.spec.SecretKeySpec;

import org.apache.commons.codec.binary.Base64;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Component;

@Component
public class Encryption implements PasswordEncoder {

	private PasswordEncoder passwordEncoder;

	public Encryption() {
		this.passwordEncoder = new BCryptPasswordEncoder();
	}
	@Override
	public String encode(CharSequence rawPassword) {
		return passwordEncoder.encode(rawPassword);
	}
	@Override
	public boolean matches(CharSequence rawPassword, String encodedPassword) {
		return passwordEncoder.matches(rawPassword, encodedPassword);
	}
	// AES256 암호화
	public String aesEncode(String str, String hint)
			throws java.io.UnsupportedEncodingException, NoSuchAlgorithmException, NoSuchPaddingException,
			InvalidKeyException, InvalidAlgorithmParameterException, IllegalBlockSizeException, BadPaddingException {

		String keyValue = key(hint.length() > 24 ? hint.substring(0, 23) : hint);
		HashMap<String, Object> mapAES = AES256Key(keyValue);

		Cipher c = Cipher.getInstance("AES/CBC/PKCS5Padding");
		c.init(Cipher.ENCRYPT_MODE, (Key) mapAES.get("key"),
				new IvParameterSpec(mapAES.get("iv").toString().getBytes()));

		byte[] encrypted = c.doFinal(str.getBytes("UTF-8"));
		String enStr = new String(Base64.encodeBase64(encrypted));

		return enStr;
	}
	// AES256 복호화
	public String aesDecode(String encryptionData, String hint)
			throws java.io.UnsupportedEncodingException, NoSuchAlgorithmException, NoSuchPaddingException,
			InvalidKeyException, InvalidAlgorithmParameterException, IllegalBlockSizeException, BadPaddingException {
		String keyValue = key(hint.length() > 24 ? hint.substring(0, 23) : hint);
		HashMap<String, Object> mapAES = AES256Key(keyValue);

		Cipher c = Cipher.getInstance("AES/CBC/PKCS5Padding");
		c.init(Cipher.DECRYPT_MODE, (Key) mapAES.get("key"),
				new IvParameterSpec(mapAES.get("iv").toString().getBytes("UTF-8")));

		byte[] byteStr = Base64.decodeBase64(encryptionData.getBytes());

		return new String(c.doFinal(byteStr), "UTF-8");
	}
	// key값 리턴
	private String key(String hint) {
		// 24자리(24바이트)만 key 값으로 입력 가능
		char[] compareValue = ("k1cj4w@3ib9!lhv#sd7$x0a%qtm^rg2&y6?epu5zn8fo").toCharArray();
		char[] addRootKey = ("KoreaHoonZZangVictoryWin").toCharArray();

		String keyValue = "";

		// 파라미터로 전달 받은 rootKey를 char[]에 저장
		char[] keyValueArray = new char[24];
		char[] charHint = hint.toCharArray();
		for (int index = 0; index < charHint.length; index++) {
			keyValueArray[index] = charHint[index];
		}

		// rootKey의 값이 24bytes가 안될 경우 모자란 bytes만큼 임의의 값을 대입
		for (int i = 0; i < 24 - hint.length(); i++) {
			keyValueArray[hint.length() + i] = addRootKey[i];
		}

		// keyValueArray에 저장된 값을 keyValue의 값과 비교하여 일치하는 index값을 idx에 저장
		for (int i = 0; i < keyValueArray.length; i++) {
			for (int j = 0; j < compareValue.length; j++) {
				if (keyValueArray[i] == compareValue[j]) {
					int index = j % 24;
					keyValue += addRootKey[index];
					break;
				}
			}
		}
		return keyValue;
	}
	// AES 256
	private HashMap<String, Object> AES256Key(String keyValue) throws UnsupportedEncodingException {
		String iv;
		Key key;
		HashMap<String, Object> mapAES = new HashMap<String, Object>();

		iv = keyValue.substring(0, 16);
		mapAES.put("iv", iv);

		byte[] keyBytes = new byte[16];
		byte[] b = keyValue.getBytes("UTF-8");
		int len = b.length;
		if (len > keyBytes.length) {
			len = keyBytes.length;
		}
		System.arraycopy(b, 0, keyBytes, 0, len);
		SecretKeySpec keySpec = new SecretKeySpec(keyBytes, "AES");

		key = keySpec;
		mapAES.put("key", key);
		return mapAES;
	}
}
