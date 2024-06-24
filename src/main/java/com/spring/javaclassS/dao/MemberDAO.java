package com.spring.javaclassS.dao;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Param;

import com.spring.javaclassS.vo.MemberVO;

public interface MemberDAO {

	public MemberVO getMemberIdCheck(@Param("mid") String mid);

	public MemberVO getMemberNickCheck(@Param("nickName") String nickName);

	public int setMemberJoinOk(@Param("vo") MemberVO vo);

	public void setMemberPasswordUpdate(@Param("mid") String mid, @Param("pwd") String pwd);

	public void setMemberInforUpdate(@Param("vo") MemberVO vo);

	public int setPwdChangeOk(@Param("mid") String mid, @Param("pwd") String pwd);

	public int setMemberPhotoChange(@Param("mid") String mid, @Param("photo") String photo);

	public ArrayList<MemberVO> getMemberList(@Param("level") int level);

	public int setMemberUpdate(@Param("vo") MemberVO vo, @Param("photo") String photo, @Param("oFileName") String oFileName);

}
