<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>

<link href="resources/css/common.css" rel="stylesheet" type="text/css"/>
<link href="resources/css/ui.css" rel="stylesheet" type="text/css"/>
<link href="resources/css/index.css" rel="stylesheet" type="text/css"/>
<link href="resources/css/modal.css" rel="stylesheet" type="text/css"/>
<link href="resources/css/note.css" rel="stylesheet" type="text/css"/>
<link href="resources/css/write.css" rel="stylesheet" type="text/css"/>

<link rel="stylesheet" href="resources/css/jquery.mCustomScrollbar.css" />
<link rel="stylesheet" href="resources/css/nice-select.css"/>
<link rel="stylesheet" href="resources/css/jquery-labelauty.css"/>

<script src="js/jQuery/jquery-1.11.3.min.js"></script>
<script src="js/jQuery/jquery.mCustomScrollbar.concat.min.js"></script>
<script src="js/jQuery/jquery.nice-select.js"></script>
<script src="js/jQuery/jquery-labelauty.js"></script>
<script src="js/jQuery/jquery.mousewheel.min.js"></script>
<script src="js/jQuery/jquery-confirm.js"></script>

<script src="js/ui.js"></script>
<script src="js/modal.js"></script>
<script src="js/index.js"></script>    
<script src="js/write.js"></script>   

<script src="js/header.js"></script>
<script src="js/login.js"></script>
<script src="js/join.js"></script>
<script src="js/history.js"></script>
<script src="js/search.js"></script> 
<script type="text/javascript">

</script>
<div id="header">
	<div id="headerWrap">
		<c:choose>
		<c:when test="${sessionScope.mev != null }">
			<div id="bellWrap">
	            <a id="bellIcon" href="#"></a>
	            <ul class="bubble" id="bubble_bell">
<!--  	                <li><a href="#">알림 3아주아주아주아주아주아주아주아주긴알람입니당 긴알람이에요 긴알람긴알람리람ㅇㄴ리ㅏㅁ넝리ㅏㅁㄴㅇ러ㅣㅏㅁㄴㄹㅇ</a></li>
	                <li><a href="#">알림 1</a></li>
	                <li><a href="#">알림 2</a></li>
	                <li><a href="#">알림 3</a></li>
	                <li><a href="#">알림 1</a></li>
	                <li><a href="#">알림 2</a></li> -->
	            </ul>
	            <span id="bubbleAfter"></span>
	            <input type="hidden" id="hidden_m_id" value="${sessionScope.mev.m_id}"><!-- 로그인한 사람 m_id -->
	        </div><!--//bellWrap-->
		</c:when>
		</c:choose>
        <div class="inputStyle" id="search_main">
        	<div id="selectWrap_main">
                <select id="select_main" onchange="selectChanged();">
                    <option value="member">학우 검색</option>
                    <option value="title">글제목 검색</option>
                    <option value="tag">태그 검색</option>
                    <option value="subject">과목 검색</option>
                </select>
           </div><!--//selectWrap -->
            <input class="input_in" id="text_main" type="text"/>
            <div class="searchAutoCompleteBox"><ul id="searchAutoCompleteArea"></ul></div>
            <input class="btn_search indent" type="button" />
        </div><!--//search_main-->
        <a class="btn_close"></a>
        
       <!--  <input class="btnStyle" id="btn_login" type="button" value="LOGIN" onClick="loginModalOpen()"/> -->
    	<c:choose> 
			<c:when test="${sessionScope.mev == null }">
				<input class="btnStyle" id="btn_login" type="button" value="LOGIN" onClick="loginModalOpen()"/>
			</c:when>
			<c:otherwise>
				<input class="btnStyle" id="btn_logout" type="button" value="LOGOUT"/>
			</c:otherwise>
		</c:choose>
    </div><!--//headerWrap-->
    <div class="searchTermWrap teamSearchWrap">
        <div class="clear" id="category_select">
            <span>분야 선택</span>
            <div class="team_category">
            	<input type="button" value="전체" class="btnStyle2 btn_555" id="teamCategory_total">
                <input type="button" value="게임" class="btnStyle2 btn_555" id="teamCategory_game">
                <input type="button" value="웹 & 앱" class="btnStyle2 btn_555" id="teamCategory_webApp">
                <input type="button" value="디자인" class="btnStyle2 btn_555" id="teamCategory_design">
                <input type="button" value="영상 & 사운드" class="btnStyle2 btn_555" id="teamCategory_video">
                <input type="button" value="3D" class="btnStyle2 btn_555" id="teamCategory_3d">
                <input type="button" value="기타" class="btnStyle2 btn_555" id="teamCategory_etc">
            </div>
        </div>
        <div class="clear" id="skill_select">
            <span>보유 기술</span>
            <div style="float: left; width:700px;">
            <div class="team_techWrap techWrap_language">
	         	<div>
	             	<input type="radio" name="skills" value="1"><label>C</label>
	         	</div>
	            <div>
	            	<input type="radio" name="skills" value="2"><label>C#</label>
	        	</div>
	        	<div>
	            	<input type="radio" name="skills" value="3"><label>C++</label>
	         	</div>	        	
	         	<div>
	            	<input type="radio" name="skills" value="10"><label>JAVA</label>
	         	</div>
	        	<div>
	            	<input type="radio" name="skills" value="15"><label>Android</label>
	        	</div>
	        	<div>
	            	<input type="radio" name="skills" value="16"><label>iOS</label>
	        	</div>
            </div><!--//team_techWrap -->
            <div class="team_techWrap techWrap_game">
	         	<div>
	             	<input type="radio" name="skills" value="4"><label>Unity</label>
	         	</div>
	            <div>
	            	<input type="radio" name="skills" value="5"><label>COCOS-2D</label>
	        	</div>
	        	<div>
	            	<input type="radio" name="skills" value="6"><label>게임샐러드</label>
	         	</div>
	        	<div>
	            	<input type="radio" name="skills" value="7"><label>언리얼엔진</label>
	        	</div>
	        	<div>
	            	<input type="radio" name="skills" value="8"><label>DirectX</label>
	        	</div>
	        	<div>
	            	<input type="radio" name="skills" value="9"><label>OpenGL</label>
	        	</div>
            </div><!--//team_techWrap -->
            
            <div class="team_techWrap techWrap_webApp">
                <div>
                    <input type="radio" name="skills" value="11"><label>javascript</label>
                </div>
                <div>
                    <input type="radio" name="skills" value="12"><label>phthon</label>
                </div>
                <div>
                    <input type="radio" name="skills" value="13"><label>PHP</label>
                </div>
                <div>
                    <input type="radio" name="skills" value="14"><label>JSP</label>
                </div>
                <div>
                    <input type="radio" name="skills" value="35"><label>node.js</label>
                </div>
            </div><!--//team_techWrap -->
            
            <div class="team_techWrap techWrap_design">
                <div>
                    <input type="radio" name="skills" value="29"><label>포토샵</label>
                </div>
                <div>
                    <input type="radio" name="skills" value="30"><label>일러스트레이터</label>
                </div>
                <div>
                    <input type="radio" name="skills" value="31"><label>인디자인</label>
                </div>

            </div><!--//team_techWrap -->
            
            <div class="team_techWrap techWrap_video">
                <div>
                    <input type="radio" name="skills" value="25"><label>촬영</label>
                </div>
                <div>
                    <input type="radio" name="skills" value="22"><label>프리미어</label>
                </div>
                <div>
                    <input type="radio" name="skills" value="23"><label>에프터이펙트</label>
                </div>
                <div>
                    <input type="radio" name="skills" value="24"><label>NUKE</label>
                </div>                
                <div>
                    <input type="radio" name="skills" value="26"><label>PROTOOLS</label>
                </div>
            </div><!--//team_techWrap -->
            
            <div class="team_techWrap techWrap_3d">
                <div>
                    <input type="radio" name="skills" value="27"><label>MAYA</label>
                </div>
                <div>
                    <input type="radio" name="skills" value="28"><label>3DMAX</label>
                </div>
            </div><!--//team_techWrap -->
            
            <div class="team_techWrap techWrap_etc">
                <div>
                    <input type="radio" name="skills" value="32"><label>R</label>
                </div>
                <div>
                    <input type="radio" name="skills" value="33"><label>하둡</label>
                </div>
                <div>
                    <input type="radio" name="skills" value="34"><label>루비</label>
                </div>
                <div>
                    <input type="radio" name="skills" value="17"><label>MySQL</label>
                </div>
                <div>
                    <input type="radio" name="skills" value="18"><label>Oracle</label>
                </div>                
                <div>
                    <input type="radio" name="skills" value="19"><label>MSSQL</label>
                </div>
                <div>
                    <input type="radio" name="skills" value="20"><label>아두이노</label>
                </div>
                <div>
                    <input type="radio" name="skills" value="21"><label>라즈베리파이</label>
                </div>
            </div><!--//team_techWrap -->
            </div>
        </div>
    </div><!--//searchTermWrap-->   
</div><!-- //header -->


<div id="modalBox"></div>
<div id="modalBox2"></div>


<div class="modal_bg">
	<div class="loading_wrap"><img class="project_loading" src="resources/images/project_loading.gif"></div>
    <div class="modal_scroll">
		<div class="modal" id="modal_login">
		    <div class="modal_bd" id="modal_bd_login">
				<!--<div id="otherLoginWrap">
		             <a id="link_facebook" href="#"></a>
		            <span id="otherLogin">LOGIN WITH FACEBOOK</span> 
		        </div>-->
		        
		        <div class="login_inputWrap inputWrap_id">
		            <div class="login_smallBox"></div><input class="inputStyle2" name="m_mail" type="text" placeholder = "아이디" onfocus="this.placeholder = ''" onblur="this.placeholder = 'EMAIL'" id = "mail"/>
		        </div>
		        <div class="login_inputWrap inputWrap_pw">
		            <div class="login_smallBox"></div><input class="inputStyle2" name="m_pw" type="password" placeholder = "비밀번호" onfocus="this.placeholder = ''" onblur="this.placeholder = 'PASSWORD'" id = "pw"/>
		        </div>
		        
		        <input type="button" class="btnStyle2" id="btn_mdLogin" value="LOGIN"/>
		        
		        <p><a href="#" onclick="pwModalOpen()">FIND PASSWORD</a></p>
		        
		        <hr>
		        <input type="button" class="btnStyle2" id="btn_mdJoin" value="JOIN" onClick="joinModalOpen()"/>
		    </div><!--//modal_bd -->
		</div><!--//modal_login-->
		
		
		<div class="modal" id="modal_join">
		    <div class="modal_bd" id="modal_bd_join">
		    	<div id="joinTitle">JOIN FORM</div>
		        <form action = "" method="post" name="sendForm">
		        	<div class="login_inputWrap inputWrap_id">
		            	<div class="login_smallBox"></div>
		            	<input class="inputStyle2" id = "id" name="mail" type="text" placeholder = "아이디" onfocus="this.placeholder = ''" onblur="this.placeholder = '아이디'"/>
		        	</div>
		        	<input type="hidden" id="m_mail" name="m_mail" value="">
			        <div class="login_inputWrap inputWrap_pw">
		    	        <div class="login_smallBox"></div>
		    	        <input class="inputStyle2" id = "jpw" type="password" name="pw" placeholder = "비밀번호" onfocus="this.placeholder = ''" onblur="this.placeholder = '비밀번호'"/>
		    	    </div>
		       		<div class="login_inputWrap inputWrap_pw">
		            	<div class="login_smallBox"></div>
		            	<input class="inputStyle2" id = "jpw_correct" type="password" name="pw_correct" placeholder = "비밀번호 확인" onfocus="this.placeholder = ''" onblur="this.placeholder = '비밀번호 확인'"/>
		        	</div>
		        	<input type="hidden" id="m_pw" name="m_pw" value="">
		        	<div class="login_inputWrap" id="inputWrap_name">
		            	<div class="login_smallBox"></div>
		            	<input class="inputStyle2" type="text"  name="m_name" id = "m_nickname" maxlength="14" placeholder = "이름" onfocus="this.placeholder = ''" onblur="this.placeholder = '이름'"/>
		        	</div>
		        	
		        	<div class="login_inputWrap">
			        	<div class="login_inputWrap join_inputWrap" id="inputWrap_gender">
			            	<div class="login_smallBox"></div>
			            	<div id="selectWrap_gender">
			                	<select class="inputStyle2 input_join" id="input_gender" name="m_gender">
			                		<!-- <option value="" disabled selected style="display: none;">GENDER</option> -->
			                    	<option value="male">남자</option>
			                    	<option value="female">여자</option>
			                	</select>
			            	</div>
			        	</div>
			        	<div class="login_inputWrap join_inputWrap" id="inputWrap_studNum">
			            	<div class="login_smallBox"></div>
			            	<input class="inputStyle2 input_join" type = "text" name="m_studentID" maxlength="9" id = "m_studentID" placeholder = "학번" onfocus="this.placeholder = ''" onblur="this.placeholder = '학번'"/>
			        	</div>
		        	</div>
		        	<div class="login_inputWrap" id="inputWrap_bookmark" >
		           		<div class="login_smallBox"></div>
		            	<input class="inputStyle2" id="btn_addBookmark" type="button" value="관심분야 (필수 2개)" onClick="likeCategoryModalOpen()"/>
		        	</div>
		        	
		        	<div class="login_inputWrap" id="inputWrap_tool" >
		                <div class="login_smallBox"></div>
		                <input class="inputStyle2" id="btn_addTool" type="button" value="보유 기술" onClick="toolModalOpen()"/>
		            </div>
		        	<input type="hidden" name="m_interesting1" id="m_interesting1" value="">
		        	<input type="hidden" name="m_interesting2" id="m_interesting2" value="">
		        </form>
		        <input type="button" class="btnStyle2" id="btn_mdJoinForm" value="JOIN"/>
		        
		    </div><!--//modal_bd -->
		</div><!--//modal_join-->
	</div><!--//modal_scroll-->
</div><!--//modal_bg-->
		    
<div class="modal_bg2">
	<div class="modal modal_dCategory" id="modal_likeCategory">
	    <div class="modal_hd modal_hd_dCategory">관심분야
	        <input class="btnStyle btn_category" id="btn_likeCategory" type="button" value="등록"/>
	    </div>
	    <div class="modal_bd modal_bd_dCategory">
	        <ul>
	            <li>
	                <input type="checkbox" name='check' data-labelauty="게임" value="1"/>
	                <label class="label_category">게임</label>
	            </li>
	            <li>
	                <input type="checkbox" name='check' data-labelauty="웹&앱" value="2"/>
	                <label class="label_category">웹&앱</label>
	            </li>
	        </ul>
	        <ul>
	            <li>
	                <input type="checkbox" name='check' data-labelauty="영상&사운드" value="3"/>
	                <label class="label_category">영상</label>
	            </li>
	            <li>
	                <input type="checkbox" name='check' data-labelauty="3D" value="4"/>
	                <label class="label_category">3D</label>
	            </li>
	        </ul>
	        <ul>
	            <li>
	                <input type="checkbox" name='check' data-labelauty="디자인" value="5"/>
	                <label class="label_category">디자인</label>
	            </li>
	        </ul>
	    </div><!--//modal_bd_likeCategory -->
	</div><!--//_modal_likeCategory-->
	
	<div class="modal modal_dCategory" id="modal_tool">
        <div class="modal_hd modal_hd_dCategory">보유 기술
            <input class="btnStyle btn_category" id="btn_tool" type="button" value="등록"/>
        </div>
        <div class="modal_bd modal_bd_dCategory">
            <ul>
                <li>
                    <input type="checkbox" name='skill' data-labelauty="C" value="1"/>
                    <label class="label_category">C</label>
                </li>
                <li>
                    <input type="checkbox" name='skill' data-labelauty="C#" value="2"/>
                    <label class="label_category">C#</label>
                </li>
                <li>
                    <input type="checkbox" name='skill' data-labelauty="C++" value="3"/>
                    <label class="label_category">C++</label>
                </li>
                <li>
                    <input type="checkbox" name='skill' data-labelauty="Unity" value="4"/>
                    <label class="label_category">Unity</label>
                </li>
                <li>
                    <input type="checkbox" name='skill' data-labelauty="COCOS-2D" value="5"/>
                    <label class="label_category">COCOS-2D</label>
                </li>
                <li>
                    <input type="checkbox" name='skill' data-labelauty="게임샐러드" value="6"/>
                    <label class="label_category">게임샐러드</label>
                </li>
                <li>
                    <input type="checkbox" name='skill' data-labelauty="언리얼엔진4" value="7"/>
                    <label class="label_category">언리얼엔진4</label>
                </li>
                <li>
                    <input type="checkbox" name='skill' data-labelauty="DirectX" value="8"/>
                    <label class="label_category">DirectX</label>
                </li>
                <li>
                    <input type="checkbox" name='skill' data-labelauty="OpenGL" value="9"/>
                    <label class="label_category">OpenGL</label>
                </li>
                <li>
                    <input type="checkbox" name='skill' data-labelauty="JAVA" value="10"/>
                    <label class="label_category">JAVA</label>
                </li>
                <li>
                    <input type="checkbox" name='skill' data-labelauty="Javascript" value="11"/>
                    <label class="label_category">Javascript</label>
                </li>
                <li>
                    <input type="checkbox" name='skill' data-labelauty="Python" value="12"/>
                    <label class="label_category">Python</label>
                </li>
                <li>
                    <input type="checkbox" name='skill' data-labelauty="PHP" value="13"/>
                    <label class="label_category">PHP</label>
                </li>
                <li>
                    <input type="checkbox" name='skill' data-labelauty="JSP" value="14"/>
                    <label class="label_category">JSP</label>
                </li>
                <li>
                    <input type="checkbox" name='skill' data-labelauty="Android" value="15"/>
                    <label class="label_category">Android</label>
                </li>
                <li>
                    <input type="checkbox" name='skill' data-labelauty="IOS" value="16"/>
                    <label class="label_category">IOS</label>
                </li>
                <li>
                    <input type="checkbox" name='skill' data-labelauty="MySQL" value="17"/>
                    <label class="label_category">MySQL</label>
                </li>
                <li>
                    <input type="checkbox" name='skill' data-labelauty="Oracle" value="18"/>
                    <label class="label_category">Oracle</label>
                </li>
                <li>
                    <input type="checkbox" name='skill' data-labelauty="MS-SQL" value="19"/>
                    <label class="label_category">MS-SQL</label>
                </li>
                <li>
                    <input type="checkbox" name='skill' data-labelauty="아두이노" value="20"/>
                    <label class="label_category">아두이노</label>
                </li>
                <li>
                    <input type="checkbox" name='skill' data-labelauty="라즈베리파이" value="21"/>
                    <label class="label_category">라즈베리파이</label>
                </li>
                <li>
                    <input type="checkbox" name='skill' data-labelauty="premiere" value="22"/>
                    <label class="label_category">premiere</label>
                </li>
                <li>
                    <input type="checkbox" name='skill' data-labelauty="After Effect" value="23"/>
                    <label class="label_category">After Effect</label>
                </li>
                <li>
                    <input type="checkbox" name='skill' data-labelauty="NUKE" value="24"/>
                    <label class="label_category">NUKE</label>
                </li>
                <li>
                    <input type="checkbox" name='skill' data-labelauty="촬영" value="25"/>
                    <label class="label_category">촬영</label>
                </li>
                <li>
                    <input type="checkbox" name='skill' data-labelauty="PROTOOLS" value="26"/>
                    <label class="label_category">PROTOOLS</label>
                </li>
                <li>
                    <input type="checkbox" name='skill' data-labelauty="MAYA" value="27"/>
                    <label class="label_category">MAYA</label>
                </li>
                <li>
                    <input type="checkbox" name='skill' data-labelauty="3DMAX" value="28"/>
                    <label class="label_category">3DMAX</label>
                </li>
                <li>
                    <input type="checkbox" name='skill' data-labelauty="포토샵" value="29"/>
                    <label class="label_category">포토샵</label>
                </li>
                <li>
                    <input type="checkbox" name='skill' data-labelauty="일러스트레이터" value="30"/>
                    <label class="label_category">일러스트레이터</label>
                </li>
                <li>
                    <input type="checkbox" name='skill' data-labelauty="인디자인" value="31"/>
                    <label class="label_category">인디자인</label>
                </li>
            </ul>


        </div><!--//modal_bd_tool -->
    </div><!--//_modal_tool-->
	
	<div class="modal" id="modal_findPw">
	    <div class="modal_hd" id="modal_findPw_hd">FIND PASSWORD</div> 
	    <div class="modal_bd" id="modal_findPw_bd">
	        <div class="login_inputWrap" id="textWrap_findPw">
	            <input class="inputStyle2" type="text" placeholder="E-MAIL" id="fpw_email" onfocus="this.placeholder = ''" onblur="this.placeholder = 'E-MAIL'"/>
	            <input type="button" value="send" class="btnStyle2" id="btn_pwSend"/>
	        </div>
	    </div>
	    
	</div><!-- //modal_findPw -->
</div><!-- //modal_bg2 -->