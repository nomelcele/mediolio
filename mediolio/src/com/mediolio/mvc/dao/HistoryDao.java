package com.mediolio.mvc.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.mediolio.vo.BranchVO;
import com.mediolio.vo.ClassVO;
import com.mediolio.vo.HistoryVO;

@Repository
public class HistoryDao {
	@Autowired
	private SqlSessionTemplate st;
	
	public List<HistoryVO> historyList(Map<String, Object> map){
		// 히스토리 리스트 불러오기
		return st.selectList("ht.historyList", map);
	}
	
	public void addHistory(HistoryVO htvo){
		// 새로운 히스토리 추가
		st.insert("ht.addHistory", htvo);
	}
	
	public void deleteHistory(int ht_id){
		// 히스토리 삭제
		st.delete("ht.deleteHistory", ht_id);
	}
	
	public List<BranchVO> branchList(Map<String, Object> map){
		// 히스토리의 브랜치 불러오기
		System.out.println("브랜치 확인할 히스토리 번호: "+map.get("ht_id"));
		System.out.println(map.get("type"));
		return st.selectList("ht.branchList", map);
	}
	
	public void addBranch(BranchVO brvo){
		// 히스토리에 브랜치 추가
		st.insert("ht.addBranch", brvo);
	}
	
	public void deleteBranch(int br_id){
		// 브랜치 삭제
		st.delete("ht.deleteBranch", br_id);
	}
	
	public void updateLastEdit(int ht_id){
		// 히스토리 편집 날짜 업데이트
		st.update("ht.updateLastEdit", ht_id);
	}
	
	public List<ClassVO> autocompleteClass(String cl_name){
		// 관련 과목 입력 시 자동 완성
		return st.selectList("ht.autocompleteClass", cl_name);
	}
	
	public void changeHtPublic(HistoryVO htvo){
		// 히스토리 공개 상태 변경
		st.update("ht.changeHtPublic", htvo);
	}
}
