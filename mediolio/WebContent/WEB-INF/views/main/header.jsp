<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script src="js/login.js"></script>
<script src="js/join.js"></script>
</head>
<body>
<div id="header">
	<div id="headerWrap">
        <div class="inputStyle" id="search_main">
        	<div id="selectWrap_main">
                <select id="select_main">
                    <option value="title">TITLE</option>
                    <option value="id">ID</option>
                    <option value="tag">TAG</option>
                </select>
           </div>
            <input class="input_in" id="text_main" type="text"/>
            <input class="btn_search" type="button" />
        </div><!--//search_main-->
        <input class="btnStyle" id="btn_login" type="button" value="LOGIN" onClick="loginModalOpen()"/>
    </div><!--//headerWrap-->   
</div>

<div class="modal_bg"></div>
<div class="modal_bg2"></div>
    
<div class="modal" id="modal_login">
	<div class="modal_hd"></div> 
    <div class="modal_bd" id="modal_bd_login">
		<div id="otherLoginWrap">
            <!-- <a id="link_facebook" href="#"></a>
            <span id="otherLogin">LOGIN WITH FACEBOOK</span> -->
        </div>
        
        <div class="login_inputWrap" id="inputWrap_id">
            <div class="login_smallBox"></div><input class="inputStyle2" name="m_mail" type="text" placeholder = "EMAIL" onfocus="this.placeholder = ''" onblur="this.placeholder = 'EMAIL'" id = "mail"/>
        </div>
        <div class="login_inputWrap" id="inputWrap_pw">
            <div class="login_smallBox"></div><input class="inputStyle2" name="m_pw" type="password" placeholder = "PASSWORD" onfocus="this.placeholder = ''" onblur="this.placeholder = 'PASSWORD'" id = "pw"/>
        </div>
        
        <input type="button" class="btnStyle2" id="btn_mdLogin" value="LOGIN"/>
        
        <p><a href="#">FIND PASSWORD</a></p>
        
        <hr>
        <input type="button" class="btnStyle2" id="btn_mdJoin" value="JOIN" onClick="joinModalOpen()"/>
    </div><!--//modal_bd -->
</div><!--//modal_login-->


<div class="modal" id="modal_join">
	<div class="modal_hd"></div> 
    <div class="modal_bd" id="modal_bd_login">
    	<div id="joinTitle">JOIN FORM</div>
        <form action = "" method="post" name="sendForm">
        	<div class="login_inputWrap" id="inputWrap_id">
            	<div class="login_smallBox"></div>
            	<input class="inputStyle2" id = "id" name="mail" type="text" placeholder = "ID (EMAIL)" onfocus="this.placeholder = ''" onblur="this.placeholder = 'ID (EMAIL)'"/>
            	<input type="hidden" id="m_mail" name="m_mail" value="">
        	</div>
	        <div class="login_inputWrap" id="inputWrap_pw">
    	        <div class="login_smallBox"></div>
    	        <input class="inputStyle2" id = "jpw" type="password" name="pw" placeholder = "PASSWORD" onfocus="this.placeholder = ''" onblur="this.placeholder = 'PASSWORD'"/>
    	    </div>
       		<div class="login_inputWrap" id="inputWrap_pw">
            	<div class="login_smallBox"></div>
            	<input class="inputStyle2" id = "jpw_correct" type="password" name="pw_correct" placeholder = "PASSWORD CORRECT" onfocus="this.placeholder = ''" onblur="this.placeholder = 'PASSWORD CORRECT'"/>
        	</div>
        	<input type="hidden" id="m_pw" name="m_pw" value="">
        	<div class="login_inputWrap" id="inputWrap_name">
            	<div class="login_smallBox"></div>
            	<input class="inputStyle2" type="text"  name="m_nickname" id = "m_nickname" maxlength="14" placeholder = "NICKNAME" onfocus="this.placeholder = ''" onblur="this.placeholder = 'NICKNAME'"/>
        	</div>
        	<div class="login_inputWrap join_inputWrap" id="inputWrap_gender">
            	<div class="login_smallBox"></div>
            	<div id="selectWrap_gender">
                	<select class="inputStyle2 input_join" id="input_gender" name="m_gender">
                		<!-- <option value="" disabled selected style="display: none;">GENDER</option> -->
                    	<option value="male">MALE</option>
                    	<option value="female">FEMALE</option>
                	</select>
            	</div>
        	</div>
        	<div class="login_inputWrap join_inputWrap" id="inputWrap_studNum">
            	<div class="login_smallBox"></div>
            	<input class="inputStyle2 input_join" type = "text" name="m_studentID" maxlength="2" id = "m_studentID" placeholder = "STUDENT NUMBER" onfocus="this.placeholder = ''" onblur="this.placeholder = 'STUDENT NUMBER'"/>
        	</div>
        
        	<div class="login_inputWrap" id="inputWrap_bookmark" >
           		<div class="login_smallBox"></div>
            	<input class="inputStyle2" id="btn_addBookmark" type="button" value="LIKE" onClick="likeCategoryModalOpen()"/>
        	</div>
        	<input type="hidden" name="m_interestingPart" id="m_interestingPart" value="">
        </form>
        <input type="button" class="btnStyle2" id="btn_mdJoinForm" value="JOIN"/>
        
    </div><!--//modal_bd -->
</div><!--//modal_join-->


    
<div class="modal modal_dCategory" id="modal_likeCategory">
    <div class="modal_hd modal_hd_dCategory">CATEGORY
        <input class="btnStyle btn_category" id="btn_likeCategory" type="button" value="REGIST"/>
    </div>
    <div class="modal_bd modal_bd_dCategory">
        <ul>
            <li>
                <input type="checkbox" name='check' data-labelauty="게임 기획" value="1"/>
                <label class="label_category">게임 기획</label>
            </li>
            <li>
                <input type="checkbox" name='check' data-labelauty="게임 개발" value="2"/>
                <label class="label_category">게임 개발</label>
            </li>
            <li>
                <input type="checkbox" name='check' data-labelauty="웹&앱 기획" value="9"/>
                <label class="label_category">웹&앱 기획</label>
            </li>
            <li>
                <input type="checkbox" name='check' data-labelauty="웹&앱 개발" value="10"/>
                <label class="label_category">웹&앱 개발</label>
            </li>
        </ul>
        <ul>
            <li>
                <input type="checkbox" name='check' data-labelauty="영상 시나리오" value="3"/>
                <label class="label_category">영상 시나리오</label>
            </li>
            <li>
                <input type="checkbox" name='check' data-labelauty="영상 연출" value="4"/>
                <label class="label_category">영상 연출</label>
            </li>
            <li>
                <input type="checkbox" name='check' data-labelauty="영상 촬영" value="5"/>
                <label class="label_category">영상 촬영</label>
            </li>
            <li>
                <input type="checkbox" name='check' data-labelauty="영상 OAP" value="6"/>
                <label class="label_category">영상 OAP</label>
            </li>
            <li>
                <input type="checkbox" name='check' data-labelauty="3D 모델링" value="7"/>
                <label class="label_category">3D 모델링</label>
            </li>
            <li>
                <input type="checkbox" name='check' data-labelauty="3D 애니메이션" value="8"/>
                <label class="label_category">3D 애니메이션</label>
            </li>
        </ul>
        <ul>
            <li>
                <input type="checkbox" name='check' data-labelauty="디자인" value="11"/>
                <label class="label_category">디자인</label>
            </li>
            <li>
                <input type="checkbox" name='check' data-labelauty="컴퓨터 그래픽스" value="12"/>
                <label class="label_category">컴퓨터 그래픽스</label>
            </li>
            <li>
                <input type="checkbox" name='check' data-labelauty="사운드" value="13"/>
                <label class="label_category">사운드</label>
            </li>
        </ul>
        
        
    </div><!--//modal_bd_likeCategory -->
</div><!--//_modal_likeCategory-->
</body>
</html>