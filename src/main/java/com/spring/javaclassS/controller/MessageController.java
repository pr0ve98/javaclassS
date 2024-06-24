package com.spring.javaclassS.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class MessageController {
	
	@RequestMapping(value = "/message/{msgFlag}", method = RequestMethod.GET)
	public String getMessage(Model model,
			@PathVariable String msgFlag,
			@RequestParam(name="mid", defaultValue = "", required = false) String mid
			) {
		
		if(msgFlag.equals("userDeleteOk")) {
			model.addAttribute("msg", "회원 자료가 삭제 되었습니다.");
			model.addAttribute("url", "/user/userList");
		}
		else if(msgFlag.equals("userDeleteNo")) {
			model.addAttribute("msg", "회원 자료가 삭제 실패~~");
			model.addAttribute("url", "/user/userList");
		}
		else if(msgFlag.equals("userInputOk")) {
			model.addAttribute("msg", "회원 자료가 등록되었습니다.");
			model.addAttribute("url", "/user/userList");
		}
		else if(msgFlag.equals("userInputNo")) {
			model.addAttribute("msg", "회원 자료 등록 실패~~");
			model.addAttribute("url", "/user/userList");
		}
		else if(msgFlag.equals("userUpdateOk")) {
			model.addAttribute("msg", "회원 정보를 수정하였습니다.");
			model.addAttribute("url", "/user/userList");
		}
		else if(msgFlag.equals("userUpdateNo")) {
			model.addAttribute("msg", "회원 정보 실패~~");
			model.addAttribute("url", "/user/userList");
		}
		else if(msgFlag.equals("dbtestDeleteOk")) {
			model.addAttribute("msg", "회원 삭제 완료!");
			model.addAttribute("url", "/dbtest/dbtestList");
		}
		else if(msgFlag.equals("dbtestDeleteNo")) {
			model.addAttribute("msg", "회원 삭제 실패~~");
			model.addAttribute("url", "/dbtest/dbtestList");
		}
		else if(msgFlag.equals("dbtestInputOk")) {
			model.addAttribute("msg", "회원 등록 완료!");
			model.addAttribute("url", "/dbtest/dbtestList");
		}
		else if(msgFlag.equals("dbtestInputNo")) {
			model.addAttribute("msg", "회원 등록 실패~~");
			model.addAttribute("url", "/dbtest/dbtestList");
		}
		else if(msgFlag.equals("dbtestUpdateOk")) {
			model.addAttribute("msg", "회원 수정 완료!");
			model.addAttribute("url", "/dbtest/dbtestList");
		}
		else if(msgFlag.equals("dbtestUpdateNo")) {
			model.addAttribute("msg", "회원 수정 실패~~");
			model.addAttribute("url", "/dbtest/dbtestList");
		}
		else if(msgFlag.equals("mailSendOk")) {
			model.addAttribute("msg", "메일 전송 완료!");
			model.addAttribute("url", "/study/mail/mailForm");
		}
		else if(msgFlag.equals("guestInputOk")) {
			model.addAttribute("msg", "방명록 등록 완료!");
			model.addAttribute("url", "/guest/guestList");
		}
		else if(msgFlag.equals("guestInputNo")) {
			model.addAttribute("msg", "방명록 등록 실패~~");
			model.addAttribute("url", "/guest/guestList");
		}
		else if(msgFlag.equals("idCheckNo")) {
			model.addAttribute("msg", "이미 사용중인 아이디입니다!");
			model.addAttribute("url", "/member/memberJoin");
		}
		else if(msgFlag.equals("nickCheckNo")) {
			model.addAttribute("msg", "이미 사용중인 닉네임입니다!");
			model.addAttribute("url", "/member/memberJoin");
		}
		else if(msgFlag.equals("memberJoinOk")) {
			model.addAttribute("msg", "회원가입 완료~");
			model.addAttribute("url", "/member/memberLogin");
		}
		else if(msgFlag.equals("memberJoinNo")) {
			model.addAttribute("msg", "회원가입 실패...");
			model.addAttribute("url", "/member/memberJoin");
		}
		else if(msgFlag.equals("memberLoginOk")) {
			model.addAttribute("msg", mid+"님 로그인 되었습니다!");
			model.addAttribute("url", "/member/memberMain");
		}
		else if(msgFlag.equals("memberLoginNo")) {
			model.addAttribute("msg", "로그인 실패...");
			model.addAttribute("url", "/member/memberLogin");
		}
		else if(msgFlag.equals("memberLogout")) {
			model.addAttribute("msg", mid+"님 로그아웃 되었습니다!");
			model.addAttribute("url", "/member/memberLogin");
		}
		else if(msgFlag.equals("fileUploadOk")) {
			model.addAttribute("msg","파일이 업로드 되었습니다!");
			model.addAttribute("url", "/study/fileUpload/fileUpload");
		}
		else if(msgFlag.equals("fileUploadNo")) {
			model.addAttribute("msg","파일 업로드 실패~");
			model.addAttribute("url", "/study/fileUpload/fileUpload");
		}
		else if(msgFlag.equals("memberUpdateOk")) {
			model.addAttribute("msg","정보 수정 완료!");
			model.addAttribute("url", "/member/memberMain");
		}
		else if(msgFlag.equals("memberUpdateNo")) {
			model.addAttribute("msg","정보 수정 실패~");
			model.addAttribute("url", "/member/memberPwdCheck/i");
		}
		

		
		return "include/message";
	}
}
