package generic.util;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.regex.Pattern;

//웹프로그램 작성에 필요한 기능을 제공하는 클래스
public class Utility {
	//문자열을 전달받아 태그 관련 문자열을 모두 제거하여 반환하는 메소드
	public static String stripTag(String source) {
		//Pattern : 정규표현식을 저장하기 위한 클래스
		//Pattern.compile(String regEx) : 문자열을 전달받아 정규표현식으로
		//변환하여 저장한 Pattern 인스턴스를 반환하는 메소드
		//Pattern.CASE_INSENSITIVE : 대소문자를 구분하지 않도록 설정하는 상수필드
		//Pattern htmlScript=Pattern.compile("\\]*?<.*?\\/script\\>",Pattern.CASE_INSENSITIVE);
		//Pattern htmlStyle=Pattern.compile("\\]*?<.*?\\/style\\>",Pattern.CASE_INSENSITIVE);
		//Pattern htmlOption=Pattern.compile("\\]*?<.*?\\/option\\>",Pattern.CASE_INSENSITIVE);
		Pattern htmlTag=Pattern.compile("\\<.*?\\>",Pattern.CASE_INSENSITIVE);
		
		//Pattern.matcher(String source) : 정규표현식과 전달값을 비교
		//처리하기 위한 Matcher 인스턴스를 반환하는 메소드
		//Matcher.replaceAll(String replacement) : 정규표현식과 같은 
		//패턴의 문자열을 찾아 원하는 문자열로 변경하는 메소드
		//source=htmlScript.matcher(source).replaceAll("");//태그제거
		//source=htmlStyle.matcher(source).replaceAll("");
		//source=htmlOption.matcher(source).replaceAll("");
		source=htmlTag.matcher(source).replaceAll("");
		
		return source;
	}
	
	//문자열을 전달받아 암호화 처리하여 반환하는 메소드
	public static String encrypt(String source) {
		//암호화된 문자열을 저장하기 위한 변수
		String password="";
		try {
			//MessageDigest : 암호화 처리 기능을 제공하는 클래스
			//MessageDigest.getInstance(String algorithm) : 암호화 알고리즘이
			//저장된 MessageDigest 인스턴스를 반환하는 메소드
			// => NoSuchAlgorithmException 발생 - 예외처리
			//암호화 알고리즘(단방향) : MD5, SHA-1, SHA-256(권장), SHA-512 등
			MessageDigest md=MessageDigest.getInstance("SHA-256");
			
			//MessageDigest.update(byte[] input) : MessageDigest 인스턴스에
			//암호화 처리하기 위한 값을 byte 배열로 전달받아 저장하는 메소드
			//String.getBytes() : 문자열을 byte 배열로 변환하여 반환하는 메소드
			md.update(source.getBytes());
			
			//MessageDigest.digest() : MessageDigest인스턴스에 저장된
			//byte 배열을 암호화 알고리즘을 이용하여 암호화 처리하고 
			//변환된 byte 배열을 반환하는 메소드 
			byte[] digest=md.digest();
			
			//byte 배열의 요소값을 16진수 형식의 문자열로 변환하여 문자열 추가
			for(int i=0;i<digest.length;i++) {
				password+=Integer.toHexString(digest[i]&0xff);
			}
		} catch (NoSuchAlgorithmException e) {
			System.out.println("[에러]잘못된 암호화 알고리즘을 사용 하였습니다.");
		}
		return password;
	}
}

