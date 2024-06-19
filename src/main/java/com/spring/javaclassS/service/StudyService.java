package com.spring.javaclassS.service;

import java.util.ArrayList;

import com.spring.javaclassS.vo.UserVO;

public interface StudyService {

	public String[] getCityStringArray(String dodo);

	public ArrayList<String> getCityArrayList(String dodo);

	public String[] getUserNames();

	public UserVO getUserNameSearch(String name);


}
