package com.cafe24.goott351.util;

public class KakaoProperties {
	private static String client_id = "fedfd31e6211b6353700f2d410a0c0d5";
	private static String redirect_uri = "http://localhost:8081/customer/getCodeForKakao";
	
	public static String getClientId() {
		return client_id;
	}
	public static String getRedirectUri() {
		return redirect_uri;
	}
	
	
}
