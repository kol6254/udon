package com.kh.udon.common.websocket;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang.StringUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import com.kh.udon.member.model.vo.Member;

/**
 * 1. 텍스트 메세지 전용
 * 	  TextWebSocketHandler - handlerTextMessage
 * 2. 바이너리 메세지 전용
 * 	  BinaryWebSocketHandler - handleBinaryMessage
 *
 * 웹소켓 연결 시작하기 (jsp)
 * var webSocket = new WebSocket("ws://요청주소");
 * var sock = new SockJS("http://요청주소");
 *
 * 온라인 상태 일 경우에만 알림 보내기
 * 1. WS 연결은 전역에서 한다 (footer.jsp) - 어느 페이지에 있던 알림 받을 수 있도록
 * 2. Server에서는 로그인 사용자의 id 별 SocketSession 관리가 필요하다
 * 3. 댓글 작성 or 키워드 관련 상품 업데이트 or ... 면 Websocket에 알린다
 *
 */
@RequestMapping("/websocket")
public class WebSocketHandler extends TextWebSocketHandler{
	
	//세션 리스트 (현재 login 중인 정보를 모두 모아 놓는 곳)
	private List<WebSocketSession> sessions = new ArrayList<WebSocketSession>();
	private Map<String, WebSocketSession> userSessions = new HashMap<>(); 

	//웹소켓이 연결되면 호출되는 함수
	@Override
	public void afterConnectionEstablished(WebSocketSession session) throws Exception {
		System.out.printf("%s 연결 됨\n", session.getId());
		sessions.add(session);
		String senderId = getId(session);
		userSessions.put(senderId, session); //Map에 senderId 키값으로 session 담기
	}		

	//클라이언트가 서버로 메세지를 전송했을 때 실행 되는 메소드
	// WebSocketSession session : 전송 주체 정보가 담긴 세션
    // TextMessage message : 전송 받은 메세지 정보
	@Override
	protected void handleTextMessage(WebSocketSession session, 
									 TextMessage message) throws Exception {
		String senderId = getId(session);
		/*
		 * for(WebSocketSession sess : sessions) { //userId : 안녕하세요 sess.sendMessage(new
		 * TextMessage(senderId + " : " + message.getPayload())); }
		 */
		
		//protocol 
		//cmd(구분자), 댓글 작성자, 게시글 작성자, boardNo : (reply, user1, writer, 1234)
		//cmd(구분자), 발신자, 수신자, 게시글번호 : (reply, user1, writer, 1234)
		String msg = message.getPayload();
		//메세지가 있을 경우에만
		if(StringUtils.isNotEmpty(msg)) {
			String[] strs = msg.split(",");
			if(strs != null && strs.length == 4) {
				String cmd = strs[0];
				String sender = strs[1];
				String receiver = strs[2];
				String boardNo = strs[3];
				
				//현재 접속 중인 (로그인 중인) 사용자 중에 receiver가 있을때만 알림을 보낸다
				WebSocketSession receiverSession 
					= userSessions.get(receiver); 
				
				if("reply".equals(cmd) && receiverSession != null) {
					TextMessage tmpMsg = new TextMessage("[" + cmd + "]" + sender + "님이" + boardNo + "에 ㅇㅇ를 했습니다");
					receiverSession.sendMessage(tmpMsg);
				}
				else if("keyword".equals(cmd) && receiverSession != null) {
					TextMessage tmpMsg = new TextMessage("[" + cmd + "]" + sender + "님이" + boardNo + "에 ㅇㅇ를 했습니다");
					receiverSession.sendMessage(tmpMsg);
				}
			}
		}
		
		
	}
	
	//클라이언트와의 연결을 끊었을 때 실행되는 메소드
	// 웹소켓이 연결이 종료 = 세션 종료
	@Override
	public void afterConnectionClosed(WebSocketSession session, 
									  CloseStatus status) throws Exception {
		System.out.printf("%s 연결 끊김\n", session.getId());
	}
	
	
	//session에 저장된 userId 가져오기
	private String getId(WebSocketSession session) {
		//Map객체에 session에 담긴 값들을 가져오기
		Map<String, Object> httpSession = session.getAttributes();
		//login할때 세션에 담았던 사용자 정보 가져오기
		Member loginMember = (Member)httpSession.get("loginMember");
		
		//로그인 하지 않은 사용자라면 sessionId 리턴
		if(loginMember == null)
			return session.getId();
		//로그인 한 사용자라면 UserId 리턴
		else 
			return loginMember.getUserId();
	}
		
}