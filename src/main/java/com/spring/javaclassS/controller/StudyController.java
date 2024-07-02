package com.spring.javaclassS.controller;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.io.FileUtils;
import org.jsoup.Connection;
import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;
import org.openqa.selenium.By;
import org.openqa.selenium.OutputType;
import org.openqa.selenium.TakesScreenshot;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.chrome.ChromeDriver;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.FileSystemResource;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.spring.javaclassS.service.StudyService;
import com.spring.javaclassS.vo.CrawlingVO;
import com.spring.javaclassS.vo.CrimeVO;
import com.spring.javaclassS.vo.MailVO;
import com.spring.javaclassS.vo.UserVO;

@Controller
@RequestMapping("/study")
public class StudyController {
	
	@Autowired
	StudyService studyService;
	
	@Autowired
	JavaMailSender mailSender;
	
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
	
	@RequestMapping(value = "/mail/mailForm", method = RequestMethod.GET)
	public String mailFormGet() {
		return "study/mail/mailForm";
	}
	
	// 메일 전송하기
	@RequestMapping(value = "/mail/mailForm", method = RequestMethod.POST)
	public String mailFormPost(MailVO vo, HttpServletRequest request) throws MessagingException {
		String toMail = vo.getToMail();
		String title = vo.getTitle();
		String content = vo.getContent();
		
		// 메일 전송을 위한 객체: MimeMessage(), MimeMessageHelper()
		MimeMessage message = mailSender.createMimeMessage();
		MimeMessageHelper messageHelper = new MimeMessageHelper(message, true, "UTF-8");
		
		// 메일 보관함에 작성한 메세지들의 정보를 모두 저장시킨후 작업처리
		messageHelper.setTo(toMail); // 받는 사람 메일주소
		messageHelper.setSubject(title); // 메일 제목
		messageHelper.setText(content); // 메일 내용
		
		// 메세지 보관함의 내용(content)에, 발신자의 필요한 정보를 추가로 담아서 전송처리한다.
		content = content.replace("\n", "<br>");
		content += "<br><hr><h3>javaclass에서 보냅니다</h3><hr><br>";
		content += "<p><img src=\"cid:la.jpg\" width='500px'></p>";
		content += "<p>방문하기: <a href='http://49.142.157.251:9090/javaclassJ4/Main'>javaclass</a></p>";
		content += "<hr>";
		messageHelper.setText(content, true); // 기존거 무시하고 새로 갈기
		
		// 본문에 기재될 그림파일의 경로를 별도로 표시시켜준다. 그런 후 다시 보관함에 저장한다.
		//FileSystemResource file = new FileSystemResource("D:\\javaclass\\springframework\\works\\javaclassS\\src\\main\\webapp\\resources\\images\\la.jpg");
		
		// cid:에 넣을 그림 생성
		//request.getSession().getServletContext().getRealPath("/resources/images/la.jpg");
		FileSystemResource file = new FileSystemResource(request.getSession().getServletContext().getRealPath("/resources/images/la.jpg"));
		messageHelper.addInline("la.jpg", file);
		
		// 첨부파일 보내기
		file = new FileSystemResource(request.getSession().getServletContext().getRealPath("/resources/images/ny.jpg"));
		messageHelper.addAttachment("ny.jpg", file);
		file = new FileSystemResource(request.getSession().getServletContext().getRealPath("/resources/images/sanfran.zip"));
		messageHelper.addAttachment("sanfran.zip", file);
		
		// 메일 전송하기
		mailSender.send(message);
		
		return "redirect:/message/mailSendOk";
	}
	
	// 파일 업로드 연습폼 호출하기
	@RequestMapping(value = "/fileUpload/fileUpload", method = RequestMethod.GET)
	public String fileUploadGet(HttpServletRequest request, Model model) {
		String realPath = request.getSession().getServletContext().getRealPath("/resources/data/fileUpload");
		String[] files = new File(realPath).list();
		model.addAttribute("files", files);
		model.addAttribute("fileCount", files.length);
		return "study/fileUpload/fileUpload";
	}
	
	@RequestMapping(value = "/fileUpload/fileUpload", method = RequestMethod.POST)
	public String fileUploadPost(MultipartFile fName, String mid) {
		int res = studyService.fileUpload(fName, mid);
		if(res != 0) return "redirect:/message/fileUploadOk";
		else return "redirect:/message/fileUploadNo";
	}
	
	@ResponseBody
	@RequestMapping(value = "/fileUpload/fileDelete", method = RequestMethod.POST)
	public String fileDeletePost(HttpServletRequest request, String file) {
		String realPath = request.getSession().getServletContext().getRealPath("/resources/data/fileUpload/");
		File fName = new File(realPath + file);
		
		String res = "0";
		if(fName.exists()) {
			fName.delete();
			res = "1";
		}
		return res;
	}
	
	@ResponseBody
	@RequestMapping(value = "/fileUpload/fileDeleteAll", method = RequestMethod.POST)
	public String fileDeleteAllPost(HttpServletRequest request, String file) {
		String realPath = request.getSession().getServletContext().getRealPath("/resources/data/fileUpload/");
		
		String res = "0";
		File targetFolder = new File(realPath);
		if(!targetFolder.exists()) return res;
		
		File[] files = targetFolder.listFiles();
		
		if(files.length != 0) {
			for(File f : files) {
				if(!f.isDirectory()) f.delete();
			}
			res = "1";
		}
		return res;
	}
	
	@RequestMapping(value = "/fileUpload/multiFile", method = RequestMethod.GET)
	public String multiFileGet() {
		return "study/fileUpload/multiFile";
	}
	
	@RequestMapping(value = "/fileUpload/multiFile", method = RequestMethod.POST)
	public String multiFilePost(MultipartHttpServletRequest mFile) {
		
		int res = studyService.multiFileUpload(mFile);
		
		if(res != 0) return "redirect:/message/multiFileUploadOk";
		else return "redirect:/message/multiFileUploadNo";
	}
	
	@RequestMapping(value = "/fileUpload/multiFile2", method = RequestMethod.GET)
	public String multiFile2Get() {
		return "study/fileUpload/multiFile2";
	}
	
	@RequestMapping(value = "/fileUpload/multiFile2", method = RequestMethod.POST)
	public String multiFile2Post(MultipartHttpServletRequest mFile, HttpServletRequest request, String imgNames) {
		//String[] imgNames = request.getParameter("imgNames").split("/");
		
		int res = studyService.multiFileUpload(mFile);
		
		if(res != 0) return "redirect:/message/multiFileUploadOk";
		else return "redirect:/message/multiFileUploadNo";
	}
	
	@RequestMapping(value = "/crawling/jsoup", method = RequestMethod.GET)
	public String jsoupGet() {
		return "study/crawling/jsoup";
	}
	
	/*
	 * @ResponseBody
	 * 
	 * @RequestMapping(value = "/crawling/jsoup", method = RequestMethod.POST,
	 * produces = "application/text; charset=utf8") public String jsoupPost(String
	 * url, String selector) throws IOException { Connection conn =
	 * Jsoup.connect(url);
	 * 
	 * Document document = conn.get(); //System.out.println(document);
	 * 
	 * Elements selects = document.select(selector); //System.out.println(selects);
	 * //System.out.println(selects.text());
	 * 
	 * String str = ""; int i = 0; for(Element select : selects) { i++;
	 * //System.out.println(i + ": " + select); System.out.println(i + ": " +
	 * select.text()); str += i + ". " + select; }
	 * 
	 * return str; }
	 */
	
	// 네이버 뉴스
	@ResponseBody
	@RequestMapping(value = "/crawling/jsoup", method = RequestMethod.POST)
	public ArrayList<String> jsoupPost(String url, String selector) throws IOException {
		Connection conn = Jsoup.connect(url);
		
		Document document = conn.get();
		//System.out.println(document);
		
		Elements selects = document.select(selector);
		//System.out.println(selects);
		//System.out.println(selects.text());
		
		ArrayList<String> vos = new ArrayList<String>();
		int i = 0;
		for(Element select : selects) {
			i++;
			System.out.println(i + ": " + select);
			//System.out.println(i + ": " + select.text());
			vos.add(i + ". " + select.html().replace("data-onshow-src","src"));
		}
		
		return vos;
	}
	
	// 네이버 뉴스 표
	@ResponseBody
	@RequestMapping(value = "/crawling/jsoup2", method = RequestMethod.POST)
	public ArrayList<CrawlingVO> jsoup2Post() throws IOException {
		Connection conn = Jsoup.connect("https://news.naver.com/");
		
		Document document = conn.get();
		
		Elements selects = null;
		
		ArrayList<String> titleVos = new ArrayList<String>();
		selects = document.select("div.cjs_t");
		for(Element select : selects) {
			titleVos.add(select.html());
		}
		
		ArrayList<String> imageVos = new ArrayList<String>();
		selects = document.select("div.cjs_news_mw");
		for(Element select : selects) {
			imageVos.add(select.html().replace("data-onshow-src","src"));
		}
		
		ArrayList<String> broadcastVos = new ArrayList<String>();
		selects = document.select("h4.channel");
		for(Element select : selects) {
			broadcastVos.add(select.html());
		}
		
		ArrayList<CrawlingVO> vos = new ArrayList<CrawlingVO>();
		CrawlingVO vo = null;
		for(int i=0; i<titleVos.size(); i++) {
			vo = new CrawlingVO();
			vo.setItem1(titleVos.get(i));
			vo.setItem2(imageVos.get(i));
			vo.setItem3(broadcastVos.get(i));
			vos.add(vo);
		}
		
		return vos;
	}
	
	// 다음 연예뉴스
	@ResponseBody
	@RequestMapping(value = "/crawling/jsoup3", method = RequestMethod.POST)
	public ArrayList<CrawlingVO> jsoup3Post() throws IOException {
		Connection conn = Jsoup.connect("https://entertain.daum.net/");
		
		Document document = conn.get();
		
		Elements selects = null;
		
		ArrayList<String> titleVos = new ArrayList<String>();
		selects = document.select("strong.tit_thumb");
		for(Element select : selects) {
			titleVos.add(select.html());
		}
		
		ArrayList<String> imageVos = new ArrayList<String>();
		selects = document.select("a.link_thumb");
		for(Element select : selects) {
			imageVos.add(select.html().replace("width=\"108\" height=\"72\"","width=\"264\" height=\"148\""));
		}
		
		ArrayList<String> broadcastVos = new ArrayList<String>();
		selects = document.select("span.info_thumb");
		for(Element select : selects) {
			broadcastVos.add(select.html());
		}
		
		ArrayList<CrawlingVO> vos = new ArrayList<CrawlingVO>();
		CrawlingVO vo = null;
		for(int i=0; i<broadcastVos.size(); i++) {
			vo = new CrawlingVO();
			vo.setItem1(titleVos.get(i));
			vo.setItem2(imageVos.get(i));
			vo.setItem3(broadcastVos.get(i));
			vos.add(vo);
		}
		
		return vos;
	}
	
	// 네이버 검색해 검색처리
	@ResponseBody
	@RequestMapping(value = "/crawling/jsoup4", method = RequestMethod.POST)
	public ArrayList<String> jsoup4Post(String search, String searchSelector) throws IOException {
		Connection conn = Jsoup.connect(search);
		
		Document document = conn.get();
		
		Elements selects = document.select(searchSelector);
		
		ArrayList<String> vos = new ArrayList<String>();
		
		int i = 0;
		for(Element select : selects) {
			i++;
			System.out.println(i + ": " + select.html());
			vos.add(i + ": " + select.html().replace("data-lazy", ""));
		}
		
		return vos;
	}
	
	// selenium
	@RequestMapping(value = "/crawling/selenium", method = RequestMethod.GET)
	public String seleniumGet() {
		return "study/crawling/selenium";
	}
	
	// selenium 크롤링 - CGV 상영작
	@ResponseBody
	@RequestMapping(value = "/crawling/selenium", method = RequestMethod.POST)
	public List<HashMap<String, Object>> seleniumPost(HttpServletRequest request) {
		List<HashMap<String, Object>> vos = new ArrayList<HashMap<String,Object>>();
		
		try {
			String realPath = request.getSession().getServletContext().getRealPath("/resources/crawling/");
			System.setProperty("webdriver.chrome.driver", realPath + "chromedriver.exe");
			
			WebDriver driver = new ChromeDriver();
			driver.get("http://www.cgv.co.kr/movies/");
			
			// 현재 상영작만 보기
			WebElement btnMore = driver.findElement(By.id("chk_nowshow"));
			btnMore.click();
			
			// 더보기 버튼 클릭
			btnMore = driver.findElement(By.className("btn-more-fontbold"));
			btnMore.click();
			
			// 화면이 더 열리는 동안 시간을 지연시켜준다
			try {Thread.sleep(2000);} catch (Exception e) {}
			
			// 낱개의 vos객체를 HashMap에 등록후 List로 처리해서 프론트로 넘겨준다
			List<WebElement> elements = driver.findElements(By.cssSelector("div.sect-movie-chart ol li"));
			for(WebElement element : elements) {
				HashMap<String, Object> map = new HashMap<String, Object>();
				String image = "<img src='"+element.findElement(By.tagName("img")).getAttribute("src")+"' width='200px' />";
				String link = element.findElement(By.tagName("a")).getAttribute("href");
				String title = "<a href='"+link+"' target='_blank'>"+element.findElement(By.className("title")).getText()+"</a>";
				String percent = element.findElement(By.className("percent")).getText();
				
				map.put("image", image);
				map.put("link", link);
				map.put("title", title);
				map.put("percent", percent);
				vos.add(map);
			}
			driver.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		System.out.println(vos);
		return vos;
	}
	
	// selenium 크롤링 - SRT 열차 조회
	@ResponseBody
	@RequestMapping(value = "/crawling/train", method = RequestMethod.POST)
	public List<HashMap<String, Object>> trainPost(HttpServletRequest request, String stationStart, String stationStop) {
		List<HashMap<String, Object>> array = new ArrayList<HashMap<String,Object>>();
		try {
			String realPath = request.getSession().getServletContext().getRealPath("/resources/crawling/");
			System.setProperty("webdriver.chrome.driver", realPath + "chromedriver.exe");
			
			WebDriver driver = new ChromeDriver();
			driver.get("http://srtplay.com/train/schedule");
			
			WebElement btnMore = driver.findElement(By.xpath("//*[@id=\"station-start\"]/span"));
			btnMore.click();
			try { Thread.sleep(2000);} catch (InterruptedException e) {}
			
			// 출발지
		    btnMore = driver.findElement(By.xpath("//*[@id=\"station-pos-input\"]"));
		    btnMore.sendKeys(stationStart);
		    btnMore = driver.findElement(By.xpath("//*[@id=\"stationListArea\"]/li/label/div/div[2]"));
		    btnMore.click();
		    btnMore = driver.findElement(By.xpath("//*[@id=\"stationDiv\"]/div/div[3]/div/button"));
		    btnMore.click();
		    try { Thread.sleep(2000);} catch (InterruptedException e) {}
		    
		    // 도착지
			btnMore = driver.findElement(By.xpath("//*[@id=\"station-arrive\"]/span"));
			btnMore.click();
			try { Thread.sleep(2000);} catch (InterruptedException e) {}
			btnMore = driver.findElement(By.id("station-pos-input"));
			  
			btnMore.sendKeys(stationStop);
			btnMore = driver.findElement(By.xpath("//*[@id=\"stationListArea\"]/li/label/div/div[2]"));
			btnMore.click();
			btnMore = driver.findElement(By.xpath("//*[@id=\"stationDiv\"]/div/div[3]/div/button"));
			btnMore.click();
			try { Thread.sleep(2000);} catch (InterruptedException e) {}
			
			// 최종 조회
		    btnMore = driver.findElement(By.xpath("//*[@id=\"sr-train-schedule-btn\"]/div/button"));
		    btnMore.click();
		    try { Thread.sleep(2000);} catch (InterruptedException e) {}
		    
		    // 정보 담기
		    List<WebElement> timeElements = driver.findElements(By.cssSelector(".table-body ul.time-list li"));
	 			
		    HashMap<String, Object> map = null;
		    
			for(WebElement element : timeElements){
				map = new HashMap<String, Object>();
				String train=element.findElement(By.className("train")).getText();
				String start=element.findElement(By.className("start")).getText();
				String arrive=element.findElement(By.className("arrive")).getText();
				String time=element.findElement(By.className("time")).getText();
				String price=element.findElement(By.className("price")).getText();
				map.put("train", train);
				map.put("start", start);
				map.put("arrive", arrive);
				map.put("time", time);
				map.put("price", price);
				array.add(map);
			}
			
		    // 요금조회하기 버튼을 클릭한다.(처리 안됨 - 스크린샷으로 대체)
		    btnMore = driver.findElement(By.xpath("//*[@id=\"scheduleDiv\"]/div[2]/div/ul/li[1]/div/div[5]/button"));
		    //System.out.println("요금 조회버튼클릭");
		    btnMore.click();
		    try { Thread.sleep(2000);} catch (InterruptedException e) {}
		    
		    // 지정경로에 브라우저 화면 스크린샷 저장처리
	  		realPath = request.getSession().getServletContext().getRealPath("/resources/data/ckeditor/");
	        File scrFile = ((TakesScreenshot) driver).getScreenshotAs(OutputType.FILE);
	        FileUtils.copyFile(scrFile, new File(realPath + "screenshot.png"));
			
	        driver.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return array;
	}
	
	@RequestMapping(value = "/crawling/test", method = RequestMethod.GET)
	public String testGet() {
		return "study/crawling/test";
	}
	
	@ResponseBody
	@RequestMapping(value = "/crawling/test", method = RequestMethod.POST)
	public List<HashMap<String, Object>> testPost(HttpServletRequest request) {
		List<HashMap<String, Object>> vos = new ArrayList<HashMap<String,Object>>();
		
		try {
			String realPath = request.getSession().getServletContext().getRealPath("/resources/crawling/");
			System.setProperty("webdriver.chrome.driver", realPath + "chromedriver.exe");
			
			WebDriver driver = new ChromeDriver();
			driver.get("https://search.naver.com/search.naver?where=nexearch&sm=top_sly.hst&fbm=0&acr=1&ie=utf8&query=%EA%B2%8C%EC%9E%84");
			
			
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		return vos;
	}
}
