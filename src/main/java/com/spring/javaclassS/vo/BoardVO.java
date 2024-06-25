package com.spring.javaclassS.vo;

import lombok.Data;

@Data
public class BoardVO {
	private int idx;
	private String mid;
	private String nickName;
	private String title;
	private String content;
	private int readNum;
	private String hostIp;
	private String openSw;
	private String wDate;
	private int good;
	
	private int hour_diff; // 게시글 24시간 경과유무 체크변수
	private int date_diff; // 게시글 일자 경과유무 체크변수
	private String complaint;
	private int replyCnt; // 부모 게시글 댓글 수 변수

}
