package com.spring.javaclassS.service;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.spring.javaclassS.vo.ChartVO;
import com.spring.javaclassS.vo.CrawlingVO;
import com.spring.javaclassS.vo.CrimeVO;
import com.spring.javaclassS.vo.GameVO;
import com.spring.javaclassS.vo.KakaoAddressVO;
import com.spring.javaclassS.vo.QrCodeVO;
import com.spring.javaclassS.vo.TransactionVO;
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

	public String fileCsvToMysql(MultipartFile fName);

	public int setCsvTableDelete(String csvTable);
	
	public String setQrCodeCreate(String realPath);

	public String setQrCodeCreate1(String realPath, QrCodeVO vo);

	public String setQrCodeCreate2(String realPath, QrCodeVO vo);

	public String setQrCodeCreate3(String realPath, QrCodeVO vo);

	public String setQrCodeCreate4(String realPath, QrCodeVO vo);

	public QrCodeVO getQrCodeSearch(String qrCode);

	public String setThumbnailCreate(MultipartFile file);

	public List<ChartVO> getRecentlyVisitCount(int i);

	public List<TransactionVO> getTranscationList();

	public int setTransactionUserInput(TransactionVO vo);

	public List<TransactionVO> getTranscationList2();

	public void setTransactionUser1Input(TransactionVO vo);

	public void setTransactionUser2Input(TransactionVO vo);

	public void setTransactionUserTotalInput(TransactionVO vo);
}
