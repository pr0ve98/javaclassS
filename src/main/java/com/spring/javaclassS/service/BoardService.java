package com.spring.javaclassS.service;

import java.util.ArrayList;

import com.spring.javaclassS.vo.BoardVO;

public interface BoardService {

	public ArrayList<BoardVO> getBoardList(int startIndexNo, int pageSize);

	public int setBoardInput(BoardVO vo);

	public BoardVO getBoardContent(int idx);

	public void setReadNumPlus(int idx);

	public BoardVO getPreNextSearch(int idx, String flag);

}
