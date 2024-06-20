package com.spring.javaclassS.controller;

import java.util.ArrayList;
import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.spring.javaclassS.service.StudyService;
import com.spring.javaclassS.vo.CrimeVO;
import com.spring.javaclassS.vo.UserVO;

@Controller
@RequestMapping("/study")
public class StudyController {
	
	@Autowired
	StudyService studyService;
	
	@RequestMapping(value = "/ajax/ajaxForm", method = RequestMethod.GET)
	public String ajaxFormGet() {
		return "study/ajax/ajaxForm";
	}
	
	@ResponseBody
	@RequestMapping(value = "/ajax/ajaxTest1", method = RequestMethod.POST)
	public String ajaxTest1Post(int idx) {
		System.out.println(idx);
		/* return "study/ajax/ajaxForm"; */
		return idx+"";
	}
	
	@ResponseBody
	@RequestMapping(value = "/ajax/ajaxTest2", method = RequestMethod.POST, produces = "application/text; charset=utf8")
	public String ajaxTest2Post(String str) {
		System.out.println(str);
		/* return "study/ajax/ajaxForm"; */
		return str+"";
	}
	
	@RequestMapping(value = "/ajax/ajaxTest3_1", method = RequestMethod.GET)
	public String ajaxTest3_1Get() {
		return "study/ajax/ajaxTest3_1";
	}
	
	@ResponseBody
	@RequestMapping(value = "/ajax/ajaxTest3_1", method = RequestMethod.POST)
	public String[] ajaxTest3_1Post(String dodo) {
//		String[] strArray = new String[100];
//		strArray = studyService.getCityStringArray();
//		return strArray;
		return studyService.getCityStringArray(dodo);
	}
	
	@RequestMapping(value = "/ajax/ajaxTest3_2", method = RequestMethod.GET)
	public String ajaxTest3_2Get() {
		return "study/ajax/ajaxTest3_2";
	}
	
	@ResponseBody
	@RequestMapping(value = "/ajax/ajaxTest3_2", method = RequestMethod.POST)
	public ArrayList<String> ajaxTest3_2Post(String dodo) {
		return studyService.getCityArrayList(dodo);
	}
	
	@RequestMapping(value = "/ajax/ajaxTest3_3", method = RequestMethod.GET)
	public String ajaxTest3_3Get() {
		return "study/ajax/ajaxTest3_3";
	}
	
	@ResponseBody
	@RequestMapping(value = "/ajax/ajaxTest3_3", method = RequestMethod.POST)
	public HashMap<Object, Object> ajaxTest3_3Post(String dodo) {
		ArrayList<String> vos = studyService.getCityArrayList(dodo);
		
		HashMap<Object, Object> map = new HashMap<Object, Object>();
		map.put("city", vos);
		
		return map;
	}
	
	@RequestMapping(value = "/ajax/ajaxTest4", method = RequestMethod.GET)
	public String ajaxTest4Get(Model model) {
		String[] names = studyService.getUserNames();
		model.addAttribute("names", names);
		return "study/ajax/ajaxTest4";
	}
	
	@ResponseBody
	@RequestMapping(value = "/ajax/ajaxTest4", method = RequestMethod.POST, produces = "application/text; charset=utf8")
	public String ajaxTest4Post(String name) {
		UserVO vo = studyService.getUserNameSearch(name);
		String str = "선택하신 회원 "+name+"의 정보는 아이디-"+vo.getMid()+", 나이-"+vo.getAge()+", 주소-"+vo.getAddress()+"입니다.";
		return str;
	}
	
	@ResponseBody
	@RequestMapping(value = "/ajax/ajaxTest5-1", method = RequestMethod.POST)
	public UserVO ajaxTest5_1Post(String mid) {
		return studyService.getUserMidSearch(mid);
	}
	
	@ResponseBody
	@RequestMapping(value = "/ajax/ajaxTest5-2", method = RequestMethod.POST)
	public ArrayList<UserVO> ajaxTest5_2Post(String mid) {
		return studyService.getUserMidList(mid);
	}
	
	@RequestMapping(value = "/restapi/restapi", method = RequestMethod.GET)
	public String restapiGet() {
		return "study/restapi/restapi";
	}
	
	@RequestMapping(value = "/restapi/restapiTest1/{message}", method = RequestMethod.GET)
	public String restapiTest1Get(@PathVariable String message) {
		System.out.println(message);
		return "message: "+message;
	}
	
	@RequestMapping(value = "/restapi/restapiTest4", method = RequestMethod.GET)
	public String restapiTest4Get(Model model) {
		String allCntStr = studyService.getAllCntVo();
		model.addAttribute("allCntStr", allCntStr);
		return "study/restapi/restapiTest4";
	}
	
	@ResponseBody
	@RequestMapping(value = "/restapi/saveCrimeData", method = RequestMethod.POST)
	public void saveCrimeDataPost(CrimeVO vo) {
		studyService.setSaveCrimeData(vo);
	}
	
	@ResponseBody
	@RequestMapping(value = "/restapi/deleteCrimeDate", method = RequestMethod.POST)
	public int deleteCrimeDatePost(int year) {
		return studyService.setdeleteCrimeDate(year);
	}
	
	@ResponseBody
	@RequestMapping(value = "/restapi/listCrimeDate", method = RequestMethod.POST, produces = "application/text; charset=utf8")
	public String listCrimeDatePost(int year) {
		return studyService.getlistCrimeDate(year);
	}
	
	@ResponseBody
	@RequestMapping(value = "/restapi/policeCrimeDate", method = RequestMethod.POST, produces = "application/text; charset=utf8")
	public String policeCrimeDatePost(String police, int year) {
		return studyService.getPoliceCrimeDate(police, year);
	}
	
	@ResponseBody
	@RequestMapping(value = "/restapi/yearPoliceCheck", method = RequestMethod.POST, produces = "application/text; charset=utf8")
	public String yearPoliceCheckPost(String police, int year, String sort) {
		return studyService.getYearPoliceCheck(police, year, sort);
	}
}
