package com.spring.javaclassS.dao;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Param;

import com.spring.javaclassS.vo.BoardVO;

public interface BoardDAO {

	public ArrayList<BoardVO> getBoardList(@Param("startIndexNo") int startIndexNo, @Param("pageSize") int pageSize);

	public int setBoardInput(@Param("vo") BoardVO vo);

	public BoardVO getBoardContent(@Param("idx") int idx);

	public int getTotRecCnt();

	public void setReadNumPlus(@Param("idx") int idx);

	public BoardVO getPreNextSearch(@Param("idx") int idx, @Param("flag") String flag);

}
