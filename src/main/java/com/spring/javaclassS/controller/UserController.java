package com.spring.javaclassS.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.spring.javaclassS.service.UserService;
import com.spring.javaclassS.vo.UserVO;

@Controller
@RequestMapping("/user")
public class UserController {

	@Autowired
	UserService userService;
	
	// user 리스트
	@RequestMapping(value = "/userList", method = RequestMethod.GET)
	public String getUserList(Model model) {
		
		List<UserVO> vos = userService.getUserList();
		
		model.addAttribute("vos", vos);
		
		return "user/userList";
	}
	
	// user 1건 삭제처리
	@RequestMapping(value = "/userDelete", method = RequestMethod.GET)
	public String getUserDelete(int idx) {
		
		int res = userService.setUserDelete(idx);
		if(res != 0) return "redirect:/message/userDeleteOk";
		else return "redirect:/message/userDeleteNo";
	}
	
	// user 1건 추가
	@RequestMapping(value = "/userInputOk", method = RequestMethod.POST)
	public String getUserInputOk(UserVO vo) {
		int res = userService.setUserInputOk(vo);
		if(res != 0) return "redirect:/message/userInputOk";
		else return "redirect:/message/userInputNo";
	}
}
