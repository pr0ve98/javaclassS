package com.spring.javaclassS.vo;

import lombok.Data;

@Data
public class CrimeVO {
	private int idx;
	private int year;
	private String police;
	private int murder;
	private int robbery;
	private int theft;
	private int violence;
	
	private int allCntCri;
	private int allCntMur;
	private int allCntRob;
	private int allCntThe;
	private int allCntVio;
}
