package com.spring.javaclassS.dao;

import java.util.ArrayList;
import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.spring.javaclassS.vo.ChartVO;
import com.spring.javaclassS.vo.CrawlingVO;
import com.spring.javaclassS.vo.CrimeVO;
import com.spring.javaclassS.vo.GameVO;
import com.spring.javaclassS.vo.KakaoAddressVO;
import com.spring.javaclassS.vo.PetCafeVO;
import com.spring.javaclassS.vo.QrCodeVO;
import com.spring.javaclassS.vo.TransactionVO;
import com.spring.javaclassS.vo.UserVO;

public interface StudyDAO {

	public UserVO getUserMidSearch(@Param("mid") String mid);

	public ArrayList<UserVO> getUserMidList(@Param("mid") String mid);

	public void setSaveCrimeData(@Param("vo") CrimeVO vo);

	public int setdeleteCrimeDate(@Param("year") int year);

	public ArrayList<CrimeVO> getlistCrimeDate(@Param("year") int year);

	public ArrayList<CrimeVO> getPoliceCrimeDate(@Param("police") String police, @Param("year") int year);

	public ArrayList<CrimeVO> getYearPoliceCheck(@Param("police") String police, @Param("year") int year);

	public CrimeVO getAllCntVo(@Param("year") int year);

	public void setGame(@Param("vo") CrawlingVO vo);

	public KakaoAddressVO getKakaoAddressSearch(@Param("address") String address);

	public void setKakaoAddressInput(@Param("vo") KakaoAddressVO vo);

	public List<KakaoAddressVO> getKakaoAddressList();

	public int setKakaoAddressDelete(@Param("address") String address);

	public GameVO getGameIdx(@Param("gameIdx") int gameIdx);

	public void setGameUpdate(@Param("vo") GameVO vo, @Param("gameIdx") int gameIdx);

	public ArrayList<GameVO> getGameList();

	public void setPetCafe(@Param("vo") PetCafeVO vo);
	
	public int setCsvTableDelete(@Param("csvTable") String csvTable);

	public void setQrCodeCreate(@Param("vo") QrCodeVO vo);

	public QrCodeVO getQrCodeSearch(@Param("qrCode") String qrCode);

	public List<ChartVO> getRecentlyVisitCount(@Param("i") int i);

	public List<TransactionVO> getTranscationList();

	public int setTransactionUserInput(@Param("vo") TransactionVO vo);

	public List<TransactionVO> getTranscationList2();

	public void setTransactionUser1Input(@Param("vo") TransactionVO vo);

	public void setTransactionUser2Input(@Param("vo") TransactionVO vo);

	public void setTransactionUserTotalInput(@Param("vo") TransactionVO vo);


}
