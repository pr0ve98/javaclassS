package com.spring.javaclassS.service;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.spring.javaclassS.vo.CrawlingVO;
import com.spring.javaclassS.vo.CrimeVO;
import com.spring.javaclassS.vo.GameVO;
import com.spring.javaclassS.vo.KakaoAddressVO;
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

	public int fileUpload(MultipartFile fName, String mid);

	public int multiFileUpload(MultipartHttpServletRequest mFile);

	public Map<String, Integer> analyzer(String content);

	public void setGame(CrawlingVO vo);

	public KakaoAddressVO getKakaoAddressSearch(String address);

	public void setKakaoAddressInput(KakaoAddressVO vo);

	public List<KakaoAddressVO> getKakaoAddressList();

	public int setKakaoAddressDelete(String address);

	public GameVO getGameIdx(int gameIdx);

	public void setGameUpdate(GameVO vo, int gameIdx);

	public ArrayList<GameVO> getGameList();

}
