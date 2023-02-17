package Chatt;

import java.io.IOException;
import java.util.Collections;
import java.util.HashSet;
import java.util.Set;

import jakarta.websocket.OnClose;
import jakarta.websocket.OnMessage;
import jakarta.websocket.OnOpen;
import jakarta.websocket.Session;
import jakarta.websocket.server.ServerEndpoint;

@ServerEndpoint("/chatting2")
public class WebSocketServer {
	
	private static Set<Session> clients =       //static은 초기화 한번만 가능, 모든 클래스가 접근하여 사용가능한 공통 변수가됨 (똑같은 데이터가 중복적으로 저장되지않는다)
			Collections.synchronizedSet( new HashSet<Session>());   //동시에 한개만 접속을 허용하겠다
			
	@OnOpen
	public void onOpen(Session s) {
		System.out.println("session open......");
		clients.add(s);
	}
	
	@OnClose
	public void onClose(Session s) { 
		System.out.println("session close....");
		clients.remove(s);
	}
	
	@OnMessage
	public void onMessage(String msg, Session s) throws IOException {
		System.out.println("message : " + msg);
		for(Session ss : clients) {
			ss.getBasicRemote().sendText(msg);
		}
	}
}
