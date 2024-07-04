package com.spring.javaclassS.service;

import java.io.FileOutputStream;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.spring.javaclassS.common.JavaclassProvide;
import com.spring.javaclassS.dao.StudyDAO;
import com.spring.javaclassS.dao.UserDAO;
import com.spring.javaclassS.vo.CrawlingVO;
import com.spring.javaclassS.vo.CrimeVO;
import com.spring.javaclassS.vo.GameVO;
import com.spring.javaclassS.vo.KakaoAddressVO;
import com.spring.javaclassS.vo.UserVO;

@Service
public class StudyServiceImpl implements StudyService {
	
	@Autowired
	UserDAO userDAO;
	@Autowired
	StudyDAO studyDAO;
	@Autowired
	JavaclassProvide javaclassProvide;

	@Override
	public String[] getCityStringArray(String dodo) {
		String[] strArray = new String[100];
		
		if(dodo.equals("서울")) {
			strArray[0] = "강남구";
			strArray[1] = "강북구";
			strArray[2] = "강서구";
			strArray[3] = "강동구";
			strArray[4] = "서초구";
			strArray[5] = "관악구";
			strArray[6] = "종로구";
			strArray[7] = "영등포구";
			strArray[8] = "마포구";
			strArray[9] = "동대문구";
		}
		else if(dodo.equals("경기")) {
			strArray[0] = "수원시";
			strArray[1] = "안양시";
			strArray[2] = "안성시";
			strArray[3] = "평택시";
			strArray[4] = "시흥시";
			strArray[5] = "용인시";
			strArray[6] = "성남시";
			strArray[7] = "광명시";
			strArray[8] = "김포시";
			strArray[9] = "안산시";
		}
		else if(dodo.equals("충북")) {
			strArray[0] = "청주시";
			strArray[1] = "충주시";
			strArray[2] = "제천시";
			strArray[3] = "단양군";
			strArray[4] = "음성군";
			strArray[5] = "진천군";
			strArray[6] = "괴산군";
			strArray[7] = "증평군";
			strArray[8] = "옥천군";
			strArray[9] = "영동군";
		}
		else if(dodo.equals("충남")) {
			strArray[0] = "천안시";
			strArray[1] = "아산시";
			strArray[2] = "논산시";
			strArray[3] = "공주시";
			strArray[4] = "당진시";
			strArray[5] = "서산시";
			strArray[6] = "홍성군";
			strArray[7] = "청양군";
			strArray[8] = "계룡시";
			strArray[9] = "예산군";
		}
		
		
		
		return strArray;
	}

	@Override
	public ArrayList<String> getCityArrayList(String dodo) {
		ArrayList<String> vos = new ArrayList<String>();
		
		if(dodo.equals("서울")) {
			vos.add("강남구");
			vos.add("강북구");
			vos.add("강서구");
			vos.add("강동구");
			vos.add("서초구");
			vos.add("관악구");
			vos.add("종로구");
			vos.add("영등포구");
			vos.add("마포구");
			vos.add("동대문구");
		}
		else if(dodo.equals("경기")) {
			vos.add("수원시");
			vos.add("안양시");
			vos.add("안성시");
			vos.add("평택시");
			vos.add("시흥시");
			vos.add("용인시");
			vos.add("성남시");
			vos.add("광명시");
			vos.add("김포시");
			vos.add("안산시");
		}
		else if(dodo.equals("충북")) {
			vos.add("청주시");
			vos.add("충주시");
			vos.add("제천시");
			vos.add("단양군");
			vos.add("음성군");
			vos.add("진천군");
			vos.add("괴산군");
			vos.add("증평군");
			vos.add("옥천군");
			vos.add("영동군");
		}
		else if(dodo.equals("충남")) {
			vos.add("천안시");
			vos.add("아산시");
			vos.add("논산시");
			vos.add("공주시");
			vos.add("당진시");
			vos.add("서산시");
			vos.add("홍성군");
			vos.add("청양군");
			vos.add("계룡시");
			vos.add("예산군");
		}
		
		return vos;
	}

	@Override
	public String[] getUserNames() {
		String[] userNames = new String[100];
		List<UserVO> vos = userDAO.getUserList();
		int cnt = 0;
		for(UserVO vo : vos) {
			userNames[cnt] = vo.getName();
			cnt++;
		}
		return userNames;
	}

	@Override
	public UserVO getUserNameSearch(String name) {
		return userDAO.getUserNameSearch(name);
	}

	@Override
	public UserVO getUserMidSearch(String mid) {
		return studyDAO.getUserMidSearch(mid);
	}

	@Override
	public ArrayList<UserVO> getUserMidList(String mid) {
		return studyDAO.getUserMidList(mid);
	}

	@Override
	public void setSaveCrimeData(CrimeVO vo) {
		studyDAO.setSaveCrimeData(vo);
	}
	
	@Override
	public int setdeleteCrimeDate(int year) {
		int res = studyDAO.setdeleteCrimeDate(year);
		return res;
	}
	
	@Override
	public String getlistCrimeDate(int year) {
		ArrayList<CrimeVO> vos = studyDAO.getlistCrimeDate(year);
		String str = "<table class='table table-bordered table-hover text-center'>"
				+ "<tr class='table-info'><th colspan='5' style='font-size:24pt'>"+year+"년도 강력범죄 자료</th></tr>"
				+ "<tr class='table-secondary'><th>경찰서</th><th>살인</th><th>강도</th><th>절도</th><th>폭력</th></tr>";
			if(vos.size() == 0) str += "<tr><td colspan='5'>해당 년도의 자료가 없습니다.</td></tr>";
			else {
				for(CrimeVO v : vos){
					str += "<tr><td>" + v.getPolice() + "</td>"
					+ "<td>" + v.getMurder() + "건</td>"
					+ "<td>" + v.getRobbery() + "건</td>"
					+ "<td>" + v.getTheft() + "건</td>"
					+ "<td>" + v.getViolence() + "건</td></tr>";
				}
			}
			str += "</table>";
		return str;
	}

	@Override
	public String getPoliceCrimeDate(String police, int year) {
		ArrayList<CrimeVO> vos = studyDAO.getPoliceCrimeDate(police, year);
		String str = "<table class='table table-bordered table-hover text-center'>"
				+ "<tr class='table-info'><th colspan='5' style='font-size:24pt'>"+year+"년도 "+police+"지역 강력범죄 자료</th></tr>"
				+ "<tr class='table-secondary'><th>경찰서</th><th>살인</th><th>강도</th><th>절도</th><th>폭력</th></tr>";
			if(vos.size() == 0) str += "<tr><td colspan='5'>해당 년도의 자료가 없습니다.</td></tr>";
			else {
				for(CrimeVO v : vos){
					str += "<tr><td>" + v.getPolice() + "</td>"
					+ "<td>" + v.getMurder() + "건</td>"
					+ "<td>" + v.getRobbery() + "건</td>"
					+ "<td>" + v.getTheft() + "건</td>"
					+ "<td>" + v.getViolence() + "건</td></tr>";
				}
			}
			str += "</table>";
		return str;
	}

	@Override
	public String getYearPoliceCheck(String police, int year, String sort) {
		 ArrayList<CrimeVO> vos = new ArrayList<CrimeVO>();
		if(sort.equals("a")) vos = studyDAO.getPoliceCrimeDate(police, year);
		else vos = studyDAO.getYearPoliceCheck(police, year);
			String str = "<table class='table table-bordered table-hover text-center'>"
					+ "<tr class='table-info'><th colspan='5' style='font-size:24pt'>"+year+"년도 "+police+"지역 강력범죄 자료</th></tr>"
					+ "<tr class='table-secondary'><th>경찰서</th><th>살인</th><th>강도</th><th>절도</th><th>폭력</th></tr>";
				if(vos.size() == 0) str += "<tr><td colspan='5'>해당 년도의 자료가 없습니다.</td></tr>";
				else {
					for(CrimeVO v : vos){
						str += "<tr><td>" + v.getPolice() + "</td>"
						+ "<td>" + v.getMurder() + "건</td>"
						+ "<td>" + v.getRobbery() + "건</td>"
						+ "<td>" + v.getTheft() + "건</td>"
						+ "<td>" + v.getViolence() + "건</td></tr>";
					}
				}
				str += "</table>";
			return str;
	}

	@Override
	public String getAllCntVo() {
		String str = "<table class='table table-bordered table-hover text-center'>"
			+ "<tr class='table-info'><th colspan='6' style='font-size:24pt'>년도별 강력범죄 건수</th></tr>"
			+ "<tr class='table-secondary'><th>년도</th><th>총 건수</th><th>살인</th><th>강도</th><th>절도</th><th>폭력</th></tr>";
		for(int i=2015; i<=2022; i++){
			CrimeVO vo = studyDAO.getAllCntVo(i);
			if(vo.getAllCntCri() == 0) str += "<tr><td colspan='6'>해당 년도의 자료가 없습니다.</td></tr>";
			else str += "<tr><td>" + i + "년도</td>"
				+ "<td>" + vo.getAllCntCri() + "건</td>"
				+ "<td>" + vo.getAllCntMur() + "건</td>"
				+ "<td>" + vo.getAllCntRob() + "건</td>"
				+ "<td>" + vo.getAllCntThe() + "건</td>"
				+ "<td>" + vo.getAllCntVio() + "건</td></tr>";
		}
		str += "</table>";
		return str;
	}

	@Override
	public int fileUpload(MultipartFile fName, String mid) {
		int res = 0;
		
		// 파일 이름 중복처리를 위해 UUID객체 활용
		UUID uid = UUID.randomUUID();
		String oFileName = fName.getOriginalFilename();
		String sFileName = mid + "_" + uid.toString().substring(0,8) + "_" + oFileName;
		
		// 서버에 파일 올리기
		try {
			wirteFile(fName, sFileName);
			res = 1;
			
		}
		catch (Exception e) {
			e.printStackTrace();
		}
		
		return res;
	}

	private void wirteFile(MultipartFile fName, String sFileName) throws IOException {
		HttpServletRequest request = ((ServletRequestAttributes)RequestContextHolder.currentRequestAttributes()).getRequest();
		String realPath = request.getSession().getServletContext().getRealPath("/resources/data/fileUpload/");
		
		FileOutputStream fos = new FileOutputStream(realPath + sFileName);
		
		//fos.write(fName.getBytes()); 용량이 크면 문제가 생길 수 있음
		if(fName.getBytes().length != -1) {
			fos.write(fName.getBytes());
		}
		fos.flush();
		fos.close();
	}

	@Override
	public int multiFileUpload(MultipartHttpServletRequest mFile) {
		int res = 0;
		
		try {
			List<MultipartFile> fileList = mFile.getFiles("fName");
			String oFileNames = "";
			String sFileNames = "";
			int fileSizes = 0;
			
			for(MultipartFile file : fileList) {
				//System.out.println("원본파일:" +file.getOriginalFilename());
				String oFileName = file.getOriginalFilename();
				String sFileName = javaclassProvide.saveFileName(oFileName);
				
				javaclassProvide.writeFile(file, sFileName, "fileUpload");
				
				oFileNames += oFileName + "/";
				sFileNames += sFileName + "/";
				fileSizes += file.getSize();
			}
			oFileNames = oFileNames.substring(0, oFileNames.length()-1);
			sFileNames = sFileNames.substring(0, sFileNames.length()-1);
			
			System.out.println("원본파일: "+oFileNames);
			System.out.println("저장파일: "+sFileNames);
			System.out.println("총사이즈: "+fileSizes);
			
			
			res = 1;
		} catch (IOException e) {e.printStackTrace();}
			
		return res;
	}

	@Override
	public Map<String, Integer> analyzer(String content) {
		int wordFrequenciesToReturn = 10; // 빈도수
		int minWordLength = 2; // 최소 단어글자수
		
		Map<String, Integer> frequencyMap = new HashMap<String, Integer>();
		
		String[] words = content.split("\\s+"); // 스페이스바 최소 1개이상
		
		for(String word : words) {
			if(word.length() >= minWordLength) {
				word = word.toLowerCase();
				frequencyMap.put(word, frequencyMap.getOrDefault(word, 0) + 1);
			}
		}
		
	   return frequencyMap.entrySet().stream()
		          .sorted((e1, e2) -> e2.getValue().compareTo(e1.getValue()))
		          .limit(wordFrequenciesToReturn)
		          .collect(HashMap::new, (m, e) -> m.put(e.getKey(), e.getValue()), HashMap::putAll);
	}

	@Override
	public void setGame(CrawlingVO vo) {
		studyDAO.setGame(vo);
	}

	@Override
	public KakaoAddressVO getKakaoAddressSearch(String address) {
		return studyDAO.getKakaoAddressSearch(address);
	}

	@Override
	public void setKakaoAddressInput(KakaoAddressVO vo) {
		studyDAO.setKakaoAddressInput(vo);
	}

	@Override
	public List<KakaoAddressVO> getKakaoAddressList() {
		return studyDAO.getKakaoAddressList();
	}

	@Override
	public int setKakaoAddressDelete(String address) {
		return studyDAO.setKakaoAddressDelete(address);
	}

	@Override
	public GameVO getGameIdx(int gameIdx) {
		return studyDAO.getGameIdx(gameIdx);
	}
	
	@Override
	public void setGameUpdate(GameVO vo, int gameIdx) {
		studyDAO.setGameUpdate(vo, gameIdx);
	}

	@Override
	public ArrayList<GameVO> getGameList() {
		return studyDAO.getGameList();
	}

}
