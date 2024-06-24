package com.spring.javaclassS.service;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;

import org.springframework.web.multipart.MultipartFile;

import com.spring.javaclassS.vo.MemberVO;

public interface MemberService {

	public MemberVO getMemberIdCheck(String mid);

	public MemberVO getMemberNickCheck(String nickName);

	public int setMemberJoinOk(MemberVO vo, MultipartFile fName);

	public void setMemberPasswordUpdate(String mid, String pwd);

	public void setMemberInforUpdate(MemberVO vo);

	public int setPwdChangeOk(String mid, String pwd);

	public int setMemberPhotoChange(String mid, MultipartFile fName, HttpServletRequest request);

	public ArrayList<MemberVO> getMemberList(int level);

	public int setMemberUpdate(MemberVO vo, MultipartFile fName, HttpServletRequest request);

}
