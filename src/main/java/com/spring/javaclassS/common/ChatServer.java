package com.spring.javaclassS.common;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;

import javax.websocket.OnClose;
import javax.websocket.OnError;
import javax.websocket.OnMessage;
import javax.websocket.OnOpen;
import javax.websocket.Session;
import javax.websocket.server.ServerEndpoint;

@ServerEndpoint("/chatserver")
public class ChatServer {
	
	// 채팅서버에 접속한 클라이언트 목록들을 저장하기 위한 객체생성
	private static List<Session> userList = new ArrayList<Session>();
	
	// 채팅서버에 접속한 클라이언트 출력
	private void print(String msg) {
		System.out.printf("[%tT] %s\n", Calendar.getInstance(), msg);
	}
	
	// 채팅 서버에 최초 접속시 처음 수행
	@OnOpen
	public void handleOpen(Session session) {
		print("클라이언트 연결 : sessionID : " + session.getId());
		userList.add(session);  // user명으로 접속시 모든 user들은 세션으로 저장됨(세션 이름은 16진수이다)
	}
	
	// 클라이언트가 메세지 호출시 무조건 이곳을 통과한다 (wd.send())
	@OnMessage
	public void handleMessage(String msg, Session session) {	
		// 로그인시 msg : '1#유저명#메세지@색상코드
		// 대화시에는 msg: '2#유저명:메세지@색상
		int index = msg.indexOf("#", 2);	// 메세지와 색상을 찾는다
		String no = msg.substring(0, 1);	// 첫번째 번호(1:로그인 2:대화 3:종료)
		String user = msg.substring(2, index);	// 유저명을 찾는다
		
		String txt = msg.substring(index + 1);	// 메세지와 색상코드 가져온다
		
		// 만약에 로그인시 색상을 넣었다면 아래부분 처리
		if(txt.indexOf("@") != -1) {		
			txt = txt.substring(0, txt.lastIndexOf("@"));	
			String chatColor = msg.substring(msg.lastIndexOf("@")+1);	
			// 글자에 색상 입히기
			txt = " <font color=\""+chatColor+"\">"+txt+"</font>";	
		}
		
		// 처음 접속시에 처리 - 접속자를 제외한 다른 모든 접속자에게 지금 접속자의 유저명을 전송
		if (no.equals("1")) {  
			for (Session s : userList) {	
				if (s != session) { 
					try {	 
						s.getBasicRemote().sendText("1#" + user + "#");
					} catch (IOException e) {e.printStackTrace();}
				}
			}
		}
		
		// 대화중일때 처리되는 부분
		else if(no.equals("2")) {  
			for (Session s : userList) {
				if (s != session) { 
					try {
						s.getBasicRemote().sendText("2#" + user + ":" + txt);	
					} catch (IOException e) {e.printStackTrace();}
				}
			} 
		}
		
		// 종료시 처리되는 부분
		else if (no.equals("3")) { 
			for (Session s : userList) {
				if (s != session) { 
					try {
						s.getBasicRemote().sendText("3#" + user + "#");
					} catch (IOException e) {e.printStackTrace();}
				}
			}
			// 접속 종료버튼 클릭시 접속자의 세션을 제거
			userList.remove(session);	
		}
		
	}

	// 접속 종료시에 실행되는 메소드
	@OnClose
	public void handleClose(Session session) {
		System.out.println("Websocket Close");
		userList.remove(session);	
	}
	
	// 에러시에 실행되는 메소드
	@OnError
	public void handleError(Throwable t) {
		System.out.println("웹소켓 전송 에러입니다.");
	}
}