<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<link href="resources/css/projectView.css" rel="stylesheet" type="text/css"/>
<script type="text/javascript" src="js/projectView.js"></script>

<div id="contentsWrap">
	<div class="cardWrap clear" id="modal_content">
        <div class="projectViewBox clear" id="projectViewBox_left">
            <div class="modal_hd" id="modal_hd_content">
                <p id="content_categoryWrap">
                    <span>GAME</span>
                    <span> > </span>
                    <span>게임프로그래밍</span>
                </p>
                <h2>글제목입니다.글제목입니다.</h2>
                <h3 id="content_userId"><a href="#">12LEEYURA</a></h3>
                <h3 id="content_date">2016.02.10</h3>
                <h3 id="content_hits"><span>0</span> views</h3>

                <a href="#" id="contentHeart">
                    <img src="resources/images/heartBefore.png" alt="LikeIt"/>
                </a>
                <span id="heartNum">10</span>
            </div> 
            <div class="modal_bd" id="modal_bd_content">
                <div id="content_imgWrap"></div>
                <div id="content_tagWrap">
                    <p>연관 태그</p>
                    <span>#겜프</span>
                    <span>#게임디자인</span>

                </div>
            </div><!--//modal_bd_content -->
            <hr>
            <div class="modal_ft" id="modal_ft_content">

                <div class="replyContentWrap">
                    <p>
                        <a href="#">12LEEYURA</a>
                        <a href="#" id="btn_deleteReply">X</a>
                        <span>2016-02-12 12:00:00</span>
                    </p>
                    <div class="replyContent">
                         안녕하세요. 댓글입니다. 안녕하세요. 댓글입니다. 안녕하세요. 댓글입니다. 안녕하세요. 댓글입니다. 안녕하세요. 댓글입니다. 안녕하세요. 댓글입니다. 안녕하세요. 댓글입니다. 안녕하세요. 댓글입니다. 안녕하세요. 댓글입니다. 안녕하세요. 댓글입니다. 안녕하세요. 댓글입니다. 안녕하세요. 댓글입니다. 안녕하세요. 댓글입니다. 안녕하세요. 댓글입니다. 안녕하세요. 댓글입니다. 안녕하세요. 댓글입니다. 안녕하세요. 댓글입니다. 안녕하세요. 댓글입니다. 
                    </div>
                </div><!--//replyContentWrap-->

                <div class="replyContentWrap">
                    <p>
                        <a href="#">12USER</a>
                        <span>2016-02-12 12:00:00</span>
                    </p>
                    <div class="replyContent">
                         안녕하세요. 댓글입니다.  
                    </div>
                </div><!--//replyContentWrap-->

                <div id="writeReplyWrap">
                    <textarea placeholder="댓글 내용을 입력하세요."></textarea>
                    <input type="button" value="입력"/>
                </div>
            </div>
        </div><!--projectViewBox_left-->
		
		<div class="projectViewBox clear" id="projectViewBox_right">
		    <div class="writerWrap">
		        <h1><a onclick="userPop(event)" class="btn_userPop" href="#">12이유라</a></h1>
		        <h2>자기소개입니다. 자기소개입니다. 자기소개입니다. 자기소개입니다. 자기소개입니다. 자기소개입니다. 자기소개입니다.</h2>
		        <div class="lineWrap clear">
                    <span>관심 분야</span>
                    <h3>게임프로그래밍, 게임디자인, 디자인</h3>
                </div>
                <div class="lineWrap clear">
                    <span>보유 기술</span>
                    <h3>JAVA, JAVASCRIPT, Photoshop, Illustrator</h3>
                </div>
                <h4>관련 히스토리</h4>
                <h5><a href="#">JUICY 반응형 웹사이트</a></h4>
		    </div>
		    
		    <div class="projectWrap">
		        <h1>작업 정보</h1>
		        <div class="lineWrap clear">
                    <span>작업 이름</span>
                    <h3>JUICY 반응형 웹사이트</h3>
                </div>
                <div class="lineWrap clear">
                    <span>작업 기간</span>
                    <h3>2016.01.01 ~ 2016.01.01</h3>
                </div>
                <div class="lineWrap clear">
                    <span>관련 과목</span>
                    <h3>웹앱프로그래밍</h3>
                </div>
                
                <hr>
                
                <h1>팀원 정보</h1>
                <div class="projectTeamWrap clear">
                    <h2><a onclick="userPop(event)" class="btn_userPop" href="#">12이유라</a></h2>
                    <h3>디자인</h3>
                    <h4>UI기획 및 디자인, 웹표준 마크업, CSSddddddd</h4>
                </div>
                <div class="projectTeamWrap clear">
                    <h2><a onclick="userPop(event)" class="btn_userPop" href="#">12이유라</a></h2>
                    <h3>디자인</h3>
                    <h4>UI기획 및 디자인, 퍼블리싱</h4>
                </div>
                <div class="projectTeamWrap clear">
                    <h2><a onclick="userPop(event)" class="btn_userPop" href="#">12이유라</a></h2>
                    <h3>디자인</h3>
                    <h4>UI기획 및 디자인, 퍼블리싱</h4>
                </div>
		    </div>
		</div><!--//projectViewBox_right-->
		
	</div><!--//modal_content-->
	<ul class="userPopWrap">
	    <li><a href="#">유저페이지</a></li>
	    <li><a href="#">쪽지 보내기</a></li>
	    <li><a href="#">유저 히스토리</a></li>
	</ul><!-- userPopWrap -->
	
	
	
	
</div>