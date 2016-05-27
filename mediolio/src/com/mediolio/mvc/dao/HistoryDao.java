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

/* *****
 * ***** 모하람 작성
 * *****
 * */
@Repository
public class HistoryDao {
	@Autowired
	private SqlSessionTemplate st;
	
	public List<HistoryVO> historyList(Map<String, Object> map){
		// 유저의 히스토리 리스트 불러오기
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
		// 선택한 히스토리의 브랜치 불러오기
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
		// 히스토리에 새로운 브랜치를 추가했을 경우, 그 당시의 시간 등록
		// => 메인과 마이페이지에서 제일 최근에 업데이트 된 히스토리를 보여주기 위해서
		st.update("ht.updateLastEdit", ht_id);
	}
	
	public List<ClassVO> autocompleteClass(String cl_name){
		// 히스토리 추가 폼에서 관련 과목 입력 시, 사용자가 입력한 글자(cl_name)가 포함된 과목의 이름을 모두 리턴
		return st.selectList("ht.autocompleteClass", cl_name);
	}
	
	public void changeHtPublic(HistoryVO htvo){
		// 히스토리 공개 상태(공개/비공개) 변경
		st.update("ht.changeHtPublic", htvo);
	}
}
