package com.spring.javaclassS.service;

import java.io.File;
import java.util.ArrayList;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.spring.javaclassS.common.JavaclassProvide;
import com.spring.javaclassS.dao.MemberDAO;
import com.spring.javaclassS.vo.MemberVO;

@Service
public class MemberServiceImpl implements MemberService {
	@Autowired
	MemberDAO memberDAO;
	
	@Autowired
	JavaclassProvide javaclassProvide;

	@Override
	public MemberVO getMemberIdCheck(String mid) {
		return memberDAO.getMemberIdCheck(mid);
	}

	@Override
	public MemberVO getMemberNickCheck(String nickName) {
		return memberDAO.getMemberNickCheck(nickName);
	}

	@Override
	public int setMemberJoinOk(MemberVO vo, MultipartFile fName) {
		// 사진처리
		// 파일 이름 중복처리를 위해 UUID객체 활용
		UUID uid = UUID.randomUUID();
		String oFileName = fName.getOriginalFilename();
		String sFileName = vo.getMid() + "_" + uid.toString().substring(0,8) + "_" + oFileName;
		if(oFileName.equals("")) {
			vo.setPhoto("noimage.jpg");
		}
		// 서버에 파일 올리기
		else {
			try {
				javaclassProvide.writeFile(fName, sFileName, "member");
			}
			catch (Exception e) {
				e.printStackTrace();
			}
			vo.setPhoto(sFileName);
		}
	
		return memberDAO.setMemberJoinOk(vo);
	}

	@Override
	public void setMemberPasswordUpdate(String mid, String pwd) {
		memberDAO.setMemberPasswordUpdate(mid, pwd);
	}

	@Override
	public void setMemberInforUpdate(MemberVO vo) {
		memberDAO.setMemberInforUpdate(vo);
	}

	@Override
	public int setPwdChangeOk(String mid, String pwd) {
		return memberDAO.setPwdChangeOk(mid, pwd);
	}

	@Override
	public int setMemberPhotoChange(String mid, MultipartFile fName, HttpServletRequest request) {
		UUID uid = UUID.randomUUID();
		String oFileName = fName.getOriginalFilename();
		String sFileName = mid + "_" + uid.toString().substring(0,8) + "_" + oFileName;
		
		MemberVO vo = memberDAO.getMemberIdCheck(mid);
		
		// 서버에 파일 올리기
		try {
			javaclassProvide.writeFile(fName, sFileName, "member");
			if(!vo.getPhoto().equals("noimage.jpg")) {
				String realPath = request.getSession().getServletContext().getRealPath("/resources/data/member/");
				File fileName = new File(realPath + vo.getPhoto());
				if(fileName.exists()) fileName.delete();
			}
		}
		catch (Exception e) {
			e.printStackTrace();
		}
		
		return memberDAO.setMemberPhotoChange(mid, sFileName);
	}

	@Override
	public ArrayList<MemberVO> getMemberList(int level) {
		return memberDAO.getMemberList(level);
	}

	@Override
	public int setMemberUpdate(MemberVO vo, MultipartFile fName, HttpServletRequest request) {
		UUID uid = UUID.randomUUID();
		String oFileName = fName.getOriginalFilename();
		String sFileName = vo.getMid() + "_" + uid.toString().substring(0,8) + "_" + oFileName;
		if(!oFileName.equals("")) {
			try {
				javaclassProvide.writeFile(fName, sFileName, "member");
				if(!vo.getPhoto().equals("noimage.jpg")) {
					String realPath = request.getSession().getServletContext().getRealPath("/resources/data/member/");
					File fileName = new File(realPath + vo.getPhoto());
					if(fileName.exists()) fileName.delete();
				}
			}
			catch (Exception e) {
				e.printStackTrace();
			}
		}
		return memberDAO.setMemberUpdate(vo, sFileName, oFileName);
	}

	@Override
	public int setMemberDelete(String mid) {
		return memberDAO.setMemberDelete(mid);
	}
}
