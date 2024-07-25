package com.spring.javaclassS.common;

import java.text.SimpleDateFormat;
import java.util.Date;

import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.FileSystemResource;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;

/*
 	- cron 사용 예
 	매달 10일 14시에 실행: cron = "0 0 14 10 * ?"
 	매달 10일, 20일 14시에 실행: cron = "0 0 14 10,20 * ?"
 	매달 마지막날 23시에 실행: cron = "0 0 23 L * ?'
 	매일 9시 00분~9시 55분, 18시00분~18시55분에 5분 간격으로 실행: cron = "0 0/5 9,18 * * *"
 	매일 9시 00분~18시00분에 5분 간격으로 실행: cron = "0 0/5 9-18 * * *"
 	매년 7월달내 월~금 10시 30분에 실행: cron = "0 30 10 ? 7 1-5"
 	매달 마지막 토요일 10시 30분에 실행: cron = "0 30 10 ? * 6L"
 */

//@Component
//@Service
public class JavaclassScheduler {
	
	@Autowired
	JavaMailSender mailSender;
	
	// 정해진 시간에 자동으로 실행 (cron = 초 분 시 일 월 요일) 기본값으로 *을 입력시켜준다
	//@Scheduled(cron = "0/10 * * * * *") // 10초에 한번씩 자동 실행
	//@Scheduled(cron = "10 * * * * *") // 10초에 한번씩 자동 실행
	public void scheduleRun1() {
		Date today = new Date();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String strToday = sdf.format(today);
		System.out.println("10초마다 한번씩 메세지가 출력됩니다." + strToday);
	}
	
	//@Scheduled(cron = "0 0/1 * * * *") // 1분에 한번씩 자동 실행
	public void scheduleRun2() {
		Date today = new Date();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String strToday = sdf.format(today);
		System.out.println("1분마다 한번씩 메세지가 출력됩니다." + strToday);
	}
	
	//@Scheduled(cron = "5 * * * * *") // 5초에 한번씩 자동 실행
	public void scheduleRun3() {
		Date today = new Date();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String strToday = sdf.format(today);
		System.out.println("5초에 한번씩 메세지가 출력됩니다." + strToday);
	}
	
	//@Scheduled(cron = "0 14 10 * * *") // 매일 10시 14분에 한번씩 자동 실행
	public void scheduleRun4() {
		Date today = new Date();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String strToday = sdf.format(today);
		System.out.println("매일 10시 14분에 한번씩 메세지가 출력됩니다." + strToday);
	}
	
	//@Scheduled(cron = "0 45 10 * * *") // 매일 10시 45분에 한번씩 자동 실행
	public void scheduleRun5() throws MessagingException {
		Date today = new Date();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String strToday = sdf.format(today);
		System.out.println("매일 10시 23분에 메일을 전송합니다." + strToday);
		
		String email = "mq5abe@naver.com";
		String title = "신제품 안내 메일";
		String content = "여름 신상품 안내메일입니다.";
		
		//HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.currentRequestAttributes()).getRequest();
		
		// 메일 전송을 위한 객체: MimeMessage(), MimeMessageHelper()
		MimeMessage message = mailSender.createMimeMessage();
		MimeMessageHelper messageHelper = new MimeMessageHelper(message, true, "UTF-8");
		
		// 메일 보관함에 작성한 메세지들의 정보를 모두 저장시킨후 작업처리
		messageHelper.setTo(email); // 받는 사람 메일주소
		messageHelper.setSubject(title); // 메일 제목
		messageHelper.setText(content); // 메일 내용
		
		// 메세지 보관함의 내용(content)에, 발신자의 필요한 정보를 추가로 담아서 전송처리한다.
		content = content.replace("\n", "<br>");
		content += "<br><hr><h3>신상품: 수영복/튜브/물총/물안경</h3><hr><br>";
		content += "<p><img src=\"cid:la.jpg\" width='500px'></p>";
		content += "<p>방문하기: <a href='http://49.142.157.251:9090/javaclassJ4/Main'>javaclass</a></p>";
		content += "<hr>";
		messageHelper.setText(content, true); // 기존거 무시하고 새로 갈기
		
		//FileSystemResource file = new FileSystemResource(request.getSession().getServletContext().getRealPath("/resources/images/la.jpg"));
		FileSystemResource file = new FileSystemResource("D:\\javaclass\\springframework\\works\\javaclassS\\src\\main\\webapp\\resources\\images\\la.jpg");
		messageHelper.addInline("la.jpg", file);
		
		// 메일 전송하기
		mailSender.send(message);
	}
	
}
