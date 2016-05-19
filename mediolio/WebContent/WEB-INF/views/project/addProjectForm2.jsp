<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>MIDIOLIO</title>
<link href="resources/css/write.css" rel="stylesheet" type="text/css"/>
<link href="resources/css/write2.css" rel="stylesheet" type="text/css"/>
</head>
<body>
<div id="contentsWrap">
	<div class="writeWrap clear">
	<form method="post">
	    <div class="cardWindow cardWindow_write2">
            <div class="cardWindow_hd">2단계 : 프로젝트 정보 작성</div>
            <div class="writeLineWrap">
                <div class="writeLine_1">작업 이름</div>
                <div class="writeLine_2">
                    <input class="writeLine_text" type="text" name="p_prjname" placeholder="예) 미디어학과 포트폴리오 공유 사이트-미디올리오">
                </div>
            </div><!--//writeLineWrap-->
            <div class="writeLineWrap">
                <div class="writeLine_1">작업 기간</div>
                <div class="writeLine_2">
                    <span class="dateSpan">시작 : </span>
                    <div class="twoCell">
                        <input class="writeLine_text" type="date" name="p_workfrom">
                    </div>
                    <span class="dateSpan">종료 : </span>
                    <div class="twoCell">
                        <input class="writeLine_text" type="date" name="p_workto">
                    </div>
                </div>
            </div><!--//writeLineWrap-->
            <div class="writeLineWrap">
                <div class="writeLine_1">관련 과목</div>
                <div class="writeLine_2">
                	<input class="writeLine_text project_related_class" type="text">
<!--                     <a href="#"  onclick="subjectModalOpen()">과목 선택..</a> -->
					<div class="autoCompleteBox classBox autoClass"><ul class="autoCompleteArea autoClassArea"></ul></div>
                </div>
            </div><!--//writeLineWrap-->
            <div class="writeLineWrap clear">
                <div class="writeLine_1 writeLine_1Long">팀원 소개</div>
                <div class="writeLine_2 writeLine_2Long clear" id="teamMateGroup">
                    <div class="write_teamMateWrap">
                        <div class="threeCell shortCell">
                            <input class="writeLine_text teamMateName" type="text" placeholder="이름">
                            <div class="autoCompleteBox classBox autoMember"><ul class="autoCompleteArea autoMemberArea"></ul></div>
                        </div>
                        <div class="threeCell shortCell">
                            <input class="writeLine_text" type="text" placeholder="역할">
                        </div>
                        <div class="threeCell">
                            <input class="writeLine_text" type="text" placeholder="소개">
                        </div>
                    </div>
                    
                    <input type="button" value="+" id="btn_addTeamMate">
                </div>
            </div><!--//writeLineWrap-->
            <div class="writeLineWrap writeLongLineWrap clear">
                <div class="writeLine_1 writeLine_1Long">작업 개요</div>
                <div class="writeLine_2 writeLine_2Long">
                    <textarea class="writeLine_textarea" type="text" placeholder="작업 내용을 입력해주세요."></textarea>
                </div>
            </div><!--//writeLineWrap-->
        </div><!--//cardWindow-->
        
        <input type="button" class="write_submit" id="submit_step1" value="글 내용 작성"/>
        <input type="button" class="write_submit" id="submit_portfolio" value="작성 완료"/>
    </form>
    </div> <!-- writeWrap -->
</div> <!-- contentsWrap -->        



</body>
</html>