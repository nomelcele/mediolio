/**
 * 
 */

$(function(){
	$("#addHistoryBtn").click(function(){
		// 히스토리 추가
		$("#addHistoryForm").submit();
	});
});

function deleteHistory(ht_id){
	// 히스토리 삭제
	if(!confirm("히스토리를 삭제하시겠습니까?")){
		return;
	} else {
		
	}
}