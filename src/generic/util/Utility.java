package generic.util;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.regex.Pattern;

//�����α׷� �ۼ��� �ʿ��� ����� �����ϴ� Ŭ����
public class Utility {
	//���ڿ��� ���޹޾� �±� ���� ���ڿ��� ��� �����Ͽ� ��ȯ�ϴ� �޼ҵ�
	public static String stripTag(String source) {
		//Pattern : ����ǥ������ �����ϱ� ���� Ŭ����
		//Pattern.compile(String regEx) : ���ڿ��� ���޹޾� ����ǥ��������
		//��ȯ�Ͽ� ������ Pattern �ν��Ͻ��� ��ȯ�ϴ� �޼ҵ�
		//Pattern.CASE_INSENSITIVE : ��ҹ��ڸ� �������� �ʵ��� �����ϴ� ����ʵ�
		//Pattern htmlScript=Pattern.compile("\\]*?<.*?\\/script\\>",Pattern.CASE_INSENSITIVE);
		//Pattern htmlStyle=Pattern.compile("\\]*?<.*?\\/style\\>",Pattern.CASE_INSENSITIVE);
		//Pattern htmlOption=Pattern.compile("\\]*?<.*?\\/option\\>",Pattern.CASE_INSENSITIVE);
		Pattern htmlTag=Pattern.compile("\\<.*?\\>",Pattern.CASE_INSENSITIVE);
		
		//Pattern.matcher(String source) : ����ǥ���İ� ���ް��� ��
		//ó���ϱ� ���� Matcher �ν��Ͻ��� ��ȯ�ϴ� �޼ҵ�
		//Matcher.replaceAll(String replacement) : ����ǥ���İ� ���� 
		//������ ���ڿ��� ã�� ���ϴ� ���ڿ��� �����ϴ� �޼ҵ�
		//source=htmlScript.matcher(source).replaceAll("");//�±�����
		//source=htmlStyle.matcher(source).replaceAll("");
		//source=htmlOption.matcher(source).replaceAll("");
		source=htmlTag.matcher(source).replaceAll("");
		
		return source;
	}
	
	//���ڿ��� ���޹޾� ��ȣȭ ó���Ͽ� ��ȯ�ϴ� �޼ҵ�
	public static String encrypt(String source) {
		//��ȣȭ�� ���ڿ��� �����ϱ� ���� ����
		String password="";
		try {
			//MessageDigest : ��ȣȭ ó�� ����� �����ϴ� Ŭ����
			//MessageDigest.getInstance(String algorithm) : ��ȣȭ �˰�����
			//����� MessageDigest �ν��Ͻ��� ��ȯ�ϴ� �޼ҵ�
			// => NoSuchAlgorithmException �߻� - ����ó��
			//��ȣȭ �˰���(�ܹ���) : MD5, SHA-1, SHA-256(����), SHA-512 ��
			MessageDigest md=MessageDigest.getInstance("SHA-256");
			
			//MessageDigest.update(byte[] input) : MessageDigest �ν��Ͻ���
			//��ȣȭ ó���ϱ� ���� ���� byte �迭�� ���޹޾� �����ϴ� �޼ҵ�
			//String.getBytes() : ���ڿ��� byte �迭�� ��ȯ�Ͽ� ��ȯ�ϴ� �޼ҵ�
			md.update(source.getBytes());
			
			//MessageDigest.digest() : MessageDigest�ν��Ͻ��� �����
			//byte �迭�� ��ȣȭ �˰����� �̿��Ͽ� ��ȣȭ ó���ϰ� 
			//��ȯ�� byte �迭�� ��ȯ�ϴ� �޼ҵ� 
			byte[] digest=md.digest();
			
			//byte �迭�� ��Ұ��� 16���� ������ ���ڿ��� ��ȯ�Ͽ� ���ڿ� �߰�
			for(int i=0;i<digest.length;i++) {
				password+=Integer.toHexString(digest[i]&0xff);
			}
		} catch (NoSuchAlgorithmException e) {
			System.out.println("[����]�߸��� ��ȣȭ �˰����� ��� �Ͽ����ϴ�.");
		}
		return password;
	}
}

