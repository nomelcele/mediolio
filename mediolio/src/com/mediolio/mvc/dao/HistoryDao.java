package com.mediolio.mvc.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.mediolio.vo.HistoryVO;

@Repository
public class HistoryDao {
	@Autowired
	private SqlSessionTemplate st;
	
	public List<HistoryVO> historyList(int m_id){
		// 히스토리 리스트 불러오기
		return st.selectList("ht.historyList", m_id);
	}
	
	public void addHistory(HistoryVO htvo){
		// 새로운 히스토리 추가
		st.insert("ht.addHistory", htvo);
	}
	
	public void deleteHistory(int ht_id){
		// 히스토리 삭제
		st.delete("ht.deleteHistory", ht_id);
	}
}
