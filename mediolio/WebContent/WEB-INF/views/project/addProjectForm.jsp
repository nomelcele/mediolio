<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>MEDIOLIO</title>

<link href="resources/css/write.css" rel="stylesheet" type="text/css"/>
<link href="resources/css/write2.css" rel="stylesheet" type="text/css"/>
<link rel="stylesheet" media="screen" type="text/css" href="resources/css/colorpicker.css" />
<link href="resources/css/jquery.Jcrop.css" rel="stylesheet" type="text/css" />
<link href="resources/css/crop.css" rel="stylesheet" type="text/css"/>

<script type="text/javascript" src="js/jQuery/jquery.Jcrop.js"></script>
<script type="text/javascript" src="js/jQuery/colorpicker.js"></script>
<script type="text/javascript" src="js/jQuery/jscolor.js"></script>
<script type="text/javascript" src="js/jQuery/jquery.form.js"></script>
<script type="text/javascript" src="js/crop.js"></script> 
</head>
<body>
<form id="addProjectForm" action="addProject" method="post">
<!--  		<input type="hidden" id="orderArr" name="orderArr"> -->
 		<input type="hidden" id="p_title" name="p_title">
 		<input type="hidden" id="cate_id" name="cate_id">
 		<input type="hidden" id="hashtags" name="hashtags">
 		<input type="hidden" id="p_coverImgName" name="p_coverImg">
 		<input type="hidden" id="sc_id" name="sc_id">
</form>
<div id="contentsWrap">
	<div class="writeWrap clear">
	<!-- 탭 -->
	        <h1 class="pageTitle"><a id="projTab1" href="#">1. 글 내용 작성</a><span class="pageTitleNext"><a id="projTab2" href="#">2. 프로젝트 정보 작성</a></span></h1>
    	<!-- 탭 -->
	    <div class="cardWindow" id="contentArea">
	        <div class="cardWindow_hd">1단계 : 글 내용 작성</div>
	        <div id="write_hd">
	            <div id="write_category">
	                <select id="selectedCategory">
	                	<option value="0">카테고리</option>
	                    <option value="1">게임</option>
	                    <option value="2">웹 & 앱</option>
	                    <option value="3">영상 & 사운드</option>
	                    <option value="4">3D</option>
	                    <option value="5">디자인</option>
	                    <option value="6">기타</option>
	                </select>
	            </div><!--//write_category-->
	            <div id="write_dCategory">
						<a href="#" onclick="writeDCategoryModalOpen()">세부 카테고리 선택..</a>
					</div>
	        </div><!--//write_hd-->
	        
	        <div id="write_title">
	            <input class="input_in" id="projectTitle" type="text" placeholder="글 제목을 입력하세요."/>
	        </div><!--//write_title-->
	        
	        <div id="write_bd">
	            <a href="#" class="btn_circle" id="btn_addWrite"></a>
	            <ul class="bubble" id="bubble_addWrite">
	                <li>
	                	<form id="viewerForm" action="showViewer" method="post" enctype="multipart/form-data">
	                		<a id="btn_addFile" href="#">
	                			<input type="file" class="contentFile" id="file0" name="contents"/> 
	                			파일 업로드
	                		</a>
	                	</form>
	                </li>
	                <li><a id="btn_addMedia" href="#" onclick="writeEmbedModalOpen()">미디어 추가</a></li>
	                <li><a id="btn_addText" href="#">텍스트 추가</a></li>
	            </ul>
	            <!--  url: 파일 주소(서버에 올려진 주소) -->
	<!--             <iframe src="http://docs.google.com/viewer?url=http://infolab.stanford.edu/pub/papers/google.pdf&embedded=true" style="width:600px; height:500px;" frameborder="0"></iframe> -->
	 
	 
	 <!--
	            <div class="write_textarea" contenteditable>
	                
	            </div>
	            
	
	            <ul class="text_toolBoxes" id="text_toolBox">
	                <li id="text_size">
	                    <select id="select_fontSize">
	                        <option>10px</option>
	                        <option>11px</option>
	                    </select>
	                </li>
	                <li id="text_color"><a href="#"></a></li>
	                <li id="text_bold"><a href="#"></a></li>
	                <li id="text_italic"><a href="#"></a></li>
	                <li id="text_under"><a href="#"></a></li>
	            </ul>
	            
	            <ul class="text_toolBoxes" id="content_toolBox">
	                <li id="text_up"><a href="#"></a></li>
	                <li id="text_down"><a href="#"></a></li>
	                <li id="text_delete"><a href="#"></a></li>
	            </ul>
	
	            <a href="#" class="text_position" id="btn_textUp"></a>
	            <a href="#" class="text_position" id="btn_textDown"></a>
	-->
	<!--             <div id="main" contenteditable="true"> -->
	        </div><!--//write_bd-->
	        
	
	        <div id="write_ft">
	            <div id="write_tagTitle">#</div>
	            <div id="write_tag">
	            	<div id="write_tagBox">
	            		<div id="write_tagTxt"></div>
	            		<div class="write_tagArea">
		            		<input id="write_tagInput" class="input_in" type="text" placeholder="태그를 입력하세요."/>
		            		<div class="autoCompleteBox"><ul id="autoCompleteArea"></ul></div>
		            	</div>
	            	</div>
	            </div>
	        </div>
	    </div><!--//cardWindow-->
    
	    <div class="cardWrap">
	    	<div class="card_hd"></div>
	    	<div class="card_img">
		    	<form method="post" id="coverImg_form" enctype="multipart/form-data">
					<input type="file" id="cover_img" name="coverImg" onchange="fileValidation()" onclick="emptyValue()">
				 	<input type="hidden" id="preview_url" name="preview_url">
				 	<input type="hidden" id="preview_x" name="x" value=""/>
					<input type="hidden" id="preview_y"name="y" value=""/>
					<input type="hidden" id="preview_w"name="w" value=""/>
					<input type="hidden" id="preview_h"name="h" value=""/>
				</form>
				<input type="hidden" id="p_coverImg" name="p_coverImg">
	        	<a href="#">
	        		<img src="resources/images/default_upload.png"><!-- 미리보기이미지 들어오는곳 -->
	        		<span id="text_uploadCover">UPLOAD IMAGE</span>
	        	</a>
	        	
	        </div><!--//card_img-->
	    	<div class="card_bd">
	        	<p class="card_title ellipsis"><a href="#"></a></p>
	            <p class="card_dscrpt"><a href="#">${sessionScope.mev.m_studentID} ${sessionScope.mev.m_name}</a></p>
	            <p class="card_tag"></p>
	        </div><!--//card_bd-->
	        <div class="card_ct">
	        	<p class="p_like"><span></span>0</p>
	            <p class="p_view"><span></span>0</p>
	        </div><!--//card_ct-->
	    </div><!--//cardWrap-->
<!--     	<input type="button" class="write_submit" id="submit_step2" value="프로젝트 정보 작성" onclick="location='gotoStep2'"/> -->
    
		
		
		<!-- 2단계 (S) -->
		
	    <div class="cardWindow cardWindow_write2" id="projInfoArea">
	    <form method="post">
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
             </form>
            
        </div><!--//cardWindow-->
        
        <div id="projBtnArea">
<!--          <input type="button" class="write_submit" id="submit_step1" value="글 내용 작성"/> -->
        <input type="button" class="write_submit" id="submit_portfolio" value="작성 완료"/>
        </div>
   
		<!-- 2단계 (E) -->
    </div> <!-- writeWrap -->
    
</div> <!-- contentsWrap -->        
    
    
    
<div class="modal_bg"></div>


    
<div class="modal modal_dCategory" id="modal_writeDCategory">
    <div class="modal_hd modal_hd_dCategory">CATEGORY
        <input class="btnStyle btn_category" id="btn_writeDCategory" type="button" value="REGISTER"/>
    </div>
    <div class="modal_bd modal_bd_dCategory" id="modal_bd_writeDCategory">
        <ul>
<!--             <li> -->
<!--                 <input type="checkbox" data-labelauty="게임프로그래밍"/> -->
<!--                 <label class="label_category">게임프로그래밍</label> -->
<!--             </li> -->
<!--             <li> -->
<!--                 <input type="checkbox" data-labelauty="게임프로그래밍"/> -->
<!--                 <label class="label_category">게임프로그래밍</label> -->
<!--             </li> -->
        </ul>
        
        
    </div><!--//modal_bd_writeDCategory -->
</div><!--//modal_writeDCategory-->

    
    
<div class="modal modal_dCategory" id="modal_writeEmbed">
    <div class="modal_hd modal_hd_dCategory">EMBED TAG
        <input class="btnStyle btn_category" id="btn_writeEmbed" type="button" value="REGISTER"/>
    </div>
    <div class="modal_bd modal_bd_dCategory" id="modal_bd_writeEmbed">
        <textarea placeholder="태그를 입력하세요."></textarea>
        
    </div><!--//modal_bd_writeEmbed -->
</div><!--//modal_writeEmbed-->
</div>
</body>
</html>
