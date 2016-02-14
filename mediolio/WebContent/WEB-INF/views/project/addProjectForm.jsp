<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>MEDIOLIO</title>
<link href="resources/css/write.css" rel="stylesheet" type="text/css"/>
<link rel="stylesheet" media="screen" type="text/css" href="resources/css/colorpicker.css" />
<link href="resources/css/jquery.Jcrop.css" rel="stylesheet" type="text/css" />
<link href="resources/css/crop.css" rel="stylesheet" type="text/css"/>

<script type="text/javascript" src="js/jquery.Jcrop.js"></script>
<script type="text/javascript" src="js/colorpicker.js"></script>
<script type="text/javascript" src="js/jscolor.js"></script>
<script type="text/javascript" src="js/jquery.form.js"></script>
<script type="text/javascript" src="js/crop.js"></script> 
</head>
<body>
<div id="modalBox"></div>
<form id="addProjectForm" action="addProject" method="post" enctype="multipart/form-data"></form>
<div id="contentsWrap">
    <div class="cardWindow">
        <div class="cardWindow_hd">UPLOAD PORTFOLIO</div>
        <div id="write_hd">
            <div id="write_category">
                <select id="selectedCategory">
                	<option>카테고리</option>
                    <option value="1">게임</option>
                    <option value="2">영상</option>
                    <option value="3">3D</option>
                    <option value="4">디자인</option>
                    <option value="5">웹 & 앱</option>
                    <option value="6">컴퓨터 그래픽스</option>
                    <option value="7">사운드</option>
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
                			<input type="file" class="contentFile" id="file0" name="contents[0]"/> 
                			파일 업로드
                		</a>
<!--                 		<input type="hidden" id="orderArr" name="orderArr"> -->
<!--                 		<input type="hidden" id="p_title" name="p_title"> -->
<!--                 		<input type="hidden" id="cate_id" name="cate_id"> -->
<!--                 		<input type="hidden" id="hashtags" name="hashtags"> -->
<!--                 		<input type="hidden" id="p_coverImg" name="p_coverImg"> -->
<!--                 		<input type="hidden" id="sc_id" name="sc_id"> -->
                	</form>
                </li>
                <li><a id="btn_addMedia" href="#" onclick="writeEmbedModalOpen()">미디어 추가</a></li>
                <li><a id="btn_addText" href="#">텍스트 추가</a></li>
            </ul>
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
        	<a href="#"><img src="resources/images/default.png"><!-- 미리보기이미지 들어오는곳 --></a>
        </div><!--//card_img-->
    	<div class="card_bd">
        	<p class="card_title ellipsis"><a href="#"></a></p>
            <p class="card_dscrpt"><a href="#">${sessionScope.mev.m_studentID} ${sessionScope.mev.m_nickname}</a></p>
            <p class="card_tag"></p>
        </div><!--//card_bd-->
        <div class="card_ct">
        	<p class="p_like"><span></span>12</p>
            <p class="p_view"><span></span>12</p>
        </div><!--//card_ct-->
    </div><!--//cardWrap-->
    
    
    <input type="submit" id="submit_portfolio" value="SUBMIT"/>
</div><!--//contentsWrap-->
        
    
    
    
<div class="modal_bg"></div>


    
<div class="modal modal_dCategory" id="modal_writeDCategory">
    <div class="modal_hd modal_hd_dCategory">CATEGORY
        <input class="btnStyle btn_category" id="btn_writeDCategory" type="button" value="REGIST"/>
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
        <input class="btnStyle btn_category" id="btn_writeEmbed" type="button" value="REGIST"/>
    </div>
    <div class="modal_bd modal_bd_dCategory" id="modal_bd_writeEmbed">
        <textarea placeholder="태그를 입력하세요."></textarea>
        
    </div><!--//modal_bd_writeEmbed -->
</div><!--//modal_writeEmbed-->
</div>
</body>
</html>
