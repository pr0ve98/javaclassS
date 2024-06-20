package com.spring.javaclassS.service;

import java.util.ArrayList;

import com.spring.javaclassS.vo.CrimeVO;
import com.spring.javaclassS.vo.UserVO;

public interface StudyService {

	public String[] getCityStringArray(String dodo);

	public ArrayList<String> getCityArrayList(String dodo);

	public String[] getUserNames();

	public UserVO getUserNameSearch(String name);

	public UserVO getUserMidSearch(String mid);

	public ArrayList<UserVO> getUserMidList(String mid);

	public void setSaveCrimeData(CrimeVO vo);

	public int setdeleteCrimeDate(int year);

	public String getlistCrimeDate(int year);

	public String getPoliceCrimeDate(String police, int year);

	public String getYearPoliceCheck(String police, int year, String sort);

	public String getAllCntVo();


}
