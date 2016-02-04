<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>MEDIOLIO</title>
<link href="resources/css/common.css" rel="stylesheet" type="text/css"/>
<link href="resources/css/ui.css" rel="stylesheet" type="text/css"/>
<link href="resources/css/index.css" rel="stylesheet" type="text/css"/>
<link href="resources/css/modal.css" rel="stylesheet" type="text/css"/>
    
<link rel="stylesheet" href="resources/css/jquery.mCustomScrollbar.css" />
<link rel="stylesheet" href="resources/css/nice-select.css"/>
<link rel="stylesheet" href="resources/css/jquery-labelauty.css"/>

<script src="js/jquery-1.11.3.min.js"></script>
<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js"></script>
<script src="js/jquery.mCustomScrollbar.concat.min.js"></script>
<script src="js/jquery.nice-select.js"></script>
<script src="js/jquery-labelauty.js"></script>
    
<script src="js/ui.js"></script>
<script src="js/modal.js"></script>
<script src="js/index.js"></script>    
<script src="js/write.js"></script>   
</head>
<body>
<jsp:include page="./header.jsp"></jsp:include>
<jsp:include page="./aside.jsp"></jsp:include>
<!-- <div id="header">
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
        </div>//search_main
        <input class="btnStyle" id="btn_login" type="button" value="LOGIN" onClick="loginModalOpen()"/>
    </div>//headerWrap
    
    
</div>
    

<div id="aside">
    <div id="logoWrap"></div>
	<div class="asideWrap" id="userBox">
    	<p><a href="#">12LEEYURA</a></p>
        <ul>
        	<li id="myPf"><a href="#" class="indent">MyPortfolio</a></li>
            <li id="likePf"><a href="#" class="indent">Like</a></li>
            <li id="follow"><a href="#" class="indent">Follow</a></li>
            <li id="message"><a href="#" class="indent">Message</a></li>
        </ul>
    </div>//userBox
    <div id="uploadWrap">
    	<a id="uploadPf" onclick="location='addProjectForm'; return false;" href="#">UPLOAD PORTFOLIO</a>
    </div>//uploadWrap
    <div class="asideWrap" id="categoryTitle">
    	<p>CATEGORY</p>
    </div>//categoryTitle
    
    <div id="categoryWrap">
        <ul id="nav_category">
    		<li class="nav_group">
    			<div class="nav_title" id="ct_game"><span></span>GAME</div>
            	<ul class="nav_sub">
            		<li><a href="#">프로그래밍</a>
                    <li><a href="#">태그이름</a>
                    <li><a href="#">tag</a>
                    <li><a href="#">tag</a>
                    <li><a href="#">tag</a>
                    <li><a href="#">tag</a>
                    <li><a href="#">tag</a>
                    <li><a href="#">tag</a>
                    <li><a href="#">tag</a>
                    <li><a href="#">tag</a>
                    <li><a href="#">tag</a>
                    <li><a href="#">tag</a>
                    <li><a href="#">tag</a>
                    <li><a href="#">태그이름</a>
                </ul>
            </li>
            
            <li class="nav_group">
    			<div class="nav_title" id="ct_video"><span></span>VIDEO</div>
            	<ul class="nav_sub">
            		<li><a href="#">tag</a>
                    <li><a href="#">tag</a>
                    <li><a href="#">tag</a>
                    <li><a href="#">tag</a>
                    <li><a href="#">tag</a>
                    <li><a href="#">tag</a>
                    <li><a href="#">tag</a>
                </ul>
            </li>
            
            <li class="nav_group">
    			<div class="nav_title" id="ct_sound"><span></span>SOUND</div>
            	<ul class="nav_sub">
            		<li><a href="#">tag</a>
                    <li><a href="#">tag</a>
                </ul>
            </li>
            
            <li class="nav_group">
    			<div class="nav_title" id="ct_webApp"><span></span>WEB &amp; APP</div>
            	<ul class="nav_sub">
            		<li><a href="#">tag</a>
                </ul>
            </li>
            
            <li class="nav_group">
    			<div class="nav_title" id="ct_design"><span></span>DESIGN</div>
            	<ul class="nav_sub">
            		<li><a href="#">tag</a>
                    <li><a href="#">tag</a>
                    <li><a href="#">tag</a>
                </ul>
            </li>
            
            <li class="nav_group">
    			<div class="nav_title" id="ct_3d"><span></span>3D</div>
            	<ul class="nav_sub">
            		<li><a href="#">tag</a>
                    <li><a href="#">tag</a>
                </ul>
            </li>
    	</ul>//nav_category
	</div>//categoryWrap
</div>//aside -->
    
<!--<div id="navigator"></div>-->
<div id="contentsWrap">
    
    
    
    <div class="cardWrap">
    	<div class="card_hd"></div>
    	<div class="card_img">
            <a href="#">
                <div>
                    <p>태그내용<br>태그내용태그내용태그내용태그내용<br>태그내용<br>태그내용<br>태그내용<br>태그내용<br>태그내용<br>태그내용<br>태그내용<br>태그내용<br></p>
                </div>
                <img src="resources/images/default.png"/>
            </a>
        </div><!--//card_img-->
    	<div class="card_bd">
        	<p class="card_title ellipsis"><a href="#">글제목입니다.글제목입니다.글제목입니다.</a></p>
            <p class="card_dscrpt"><a href="#">12이유라</a></p>
            <p class="card_tag">게임프로그래밍,게임사운드,게임프로그래밍,게임사운드,게임프로그래밍,게임사운드,</p>
        </div><!--//card_bd-->
        <div class="card_ct">
        	<p class="p_like"><span></span>12</p>
            <p class="p_view"><span></span>12</p>
        </div><!--//card_ct-->
    </div><!--//cardWrap-->
    
    
    <div class="cardWrap">
    	<div class="card_hd"></div>
    	<div class="card_img">
            <a href="#">
                <div>
                    <p>태그내용<br>태그내용태그내용태그내용태그내용<br>태그내용<br>태그내용<br>태그내용<br>태그내용<br>태그내용<br>태그내용<br>태그내용<br>태그내용<br></p>
                </div>
                <img src="resources/images/default.png"/>
            </a>
        </div><!--//card_img-->
    	<div class="card_bd">
        	<p class="card_title ellipsis"><a href="#">글제목입니다.글제목입니다.글제목입니다.</a></p>
            <p class="card_dscrpt"><a href="#">12이유라</a></p>
            <p class="card_tag">게임프로그래밍,게임사운드,게임프로그래밍,게임사운드,게임프로그래밍,게임사운드,</p>
        </div><!--//card_bd-->
        <div class="card_ct">
        	<p class="p_like"><span></span>12</p>
            <p class="p_view"><span></span>12</p>
        </div><!--//card_ct-->
    </div><!--//cardWrap-->
    
    
    <div class="cardWrap">
    	<div class="card_hd"></div>
    	<div class="card_img">
            <a href="#">
                <div>
                    <p>태그내용<br>태그내용태그내용태그내용태그내용<br>태그내용<br>태그내용<br>태그내용<br>태그내용<br>태그내용<br>태그내용<br>태그내용<br>태그내용<br></p>
                </div>
                <img src="resources/images/default.png"/>
            </a>
        </div><!--//card_img-->
    	<div class="card_bd">
        	<p class="card_title ellipsis"><a href="#">글제목입니다.글제목입니다.글제목입니다.</a></p>
            <p class="card_dscrpt"><a href="#">12이유라</a></p>
            <p class="card_tag">게임프로그래밍,게임사운드,게임프로그래밍,게임사운드,게임프로그래밍,게임사운드,</p>
        </div><!--//card_bd-->
        <div class="card_ct">
        	<p class="p_like"><span></span>12</p>
            <p class="p_view"><span></span>12</p>
        </div><!--//card_ct-->
    </div><!--//cardWrap-->
    
    
    <div class="cardWrap">
    	<div class="card_hd"></div>
    	<div class="card_img">
            <a href="#">
                <div>
                    <p>태그내용<br>태그내용태그내용태그내용태그내용<br>태그내용<br>태그내용<br>태그내용<br>태그내용<br>태그내용<br>태그내용<br>태그내용<br>태그내용<br></p>
                </div>
                <img src="resources/images/default.png"/>
            </a>
        </div><!--//card_img-->
    	<div class="card_bd">
        	<p class="card_title ellipsis"><a href="#">글제목입니다.글제목입니다.글제목입니다.</a></p>
            <p class="card_dscrpt"><a href="#">12이유라</a></p>
            <p class="card_tag">게임프로그래밍,게임사운드,게임프로그래밍,게임사운드,게임프로그래밍,게임사운드,</p>
        </div><!--//card_bd-->
        <div class="card_ct">
        	<p class="p_like"><span></span>12</p>
            <p class="p_view"><span></span>12</p>
        </div><!--//card_ct-->
    </div><!--//cardWrap-->
    
    
    <div class="cardWrap">
    	<div class="card_hd"></div>
    	<div class="card_img">
            <a href="#">
                <div>
                    <p>태그내용<br>태그내용태그내용태그내용태그내용<br>태그내용<br>태그내용<br>태그내용<br>태그내용<br>태그내용<br>태그내용<br>태그내용<br>태그내용<br></p>
                </div>
                <img src="resources/images/default.png"/>
            </a>
        </div><!--//card_img-->
    	<div class="card_bd">
        	<p class="card_title ellipsis"><a href="#">글제목입니다.글제목입니다.글제목입니다.</a></p>
            <p class="card_dscrpt"><a href="#">12이유라</a></p>
            <p class="card_tag">게임프로그래밍,게임사운드,게임프로그래밍,게임사운드,게임프로그래밍,게임사운드,</p>
        </div><!--//card_bd-->
        <div class="card_ct">
        	<p class="p_like"><span></span>12</p>
            <p class="p_view"><span></span>12</p>
        </div><!--//card_ct-->
    </div><!--//cardWrap-->
    
    
    <div class="cardWrap">
    	<div class="card_hd"></div>
    	<div class="card_img">
            <a href="#">
                <div>
                    <p>태그내용<br>태그내용태그내용태그내용태그내용<br>태그내용<br>태그내용<br>태그내용<br>태그내용<br>태그내용<br>태그내용<br>태그내용<br>태그내용<br></p>
                </div>
                <img src="resources/images/default.png"/>
            </a>
        </div><!--//card_img-->
    	<div class="card_bd">
        	<p class="card_title ellipsis"><a href="#">글제목입니다.글제목입니다.글제목입니다.</a></p>
            <p class="card_dscrpt"><a href="#">12이유라</a></p>
            <p class="card_tag">게임프로그래밍,게임사운드,게임프로그래밍,게임사운드,게임프로그래밍,게임사운드,</p>
        </div><!--//card_bd-->
        <div class="card_ct">
        	<p class="p_like"><span></span>12</p>
            <p class="p_view"><span></span>12</p>
        </div><!--//card_ct-->
    </div><!--//cardWrap-->
    
    
    <div class="cardWrap">
    	<div class="card_hd"></div>
    	<div class="card_img">
            <a href="#">
                <div>
                    <p>태그내용<br>태그내용태그내용태그내용태그내용<br>태그내용<br>태그내용<br>태그내용<br>태그내용<br>태그내용<br>태그내용<br>태그내용<br>태그내용<br></p>
                </div>
                <img src="resources/images/default.png"/>
            </a>
        </div><!--//card_img-->
    	<div class="card_bd">
        	<p class="card_title ellipsis"><a href="#">글제목입니다.글제목입니다.글제목입니다.</a></p>
            <p class="card_dscrpt"><a href="#">12이유라</a></p>
            <p class="card_tag">게임프로그래밍,게임사운드,게임프로그래밍,게임사운드,게임프로그래밍,게임사운드,</p>
        </div><!--//card_bd-->
        <div class="card_ct">
        	<p class="p_like"><span></span>12</p>
            <p class="p_view"><span></span>12</p>
        </div><!--//card_ct-->
    </div><!--//cardWrap-->
    
    
    
    
    
</div>

<!-- <div class="modal_bg"></div>
<div class="modal_bg2"></div>
    
<div class="modal" id="modal_login">
	<div class="modal_hd"></div> 
    <div class="modal_bd" id="modal_bd_login">
    	<div id="otherLoginWrap">
            <a id="link_facebook" href="#"></a>
            <span id="otherLogin">LOGIN WITH FACEBOOK</span>
        </div>
        
        <div class="login_inputWrap" id="inputWrap_id">
            <div class="login_smallBox"></div><input class="inputStyle2" type="text" placeholder="ID"/>
        </div>
        <div class="login_inputWrap" id="inputWrap_pw">
            <div class="login_smallBox"></div><input class="inputStyle2" type="password" placeholder="PASSWORD"/>
        </div>
        
        <input type="button" class="btnStyle2" id="btn_mdLogin" value="LOGIN"/>
        
        <p><a href="#">FIND PASSWORD</a></p>
        
        <hr>
        <input type="button" class="btnStyle2" id="btn_mdJoin" value="JOIN" onClick="joinModalOpen()"/>
    </div>//modal_bd
</div>//modal_login -->


<!-- <div class="modal" id="modal_join">
	<div class="modal_hd"></div> 
    <div class="modal_bd" id="modal_bd_login">
    	<div id="joinTitle">JOIN FORM</div>
        
        <div class="login_inputWrap" id="inputWrap_id">
            <div class="login_smallBox">
            </div><input class="inputStyle2" type="text" placeholder="ID"/>
        </div>
        <div class="login_inputWrap" id="inputWrap_pw">
            <div class="login_smallBox"></div>
            <input class="inputStyle2" type="password" placeholder="PASSWORD"/>
        </div>
        <div class="login_inputWrap" id="inputWrap_pw">
            <div class="login_smallBox"></div>
            <input class="inputStyle2" type="password" placeholder="PASSWORD"/>
        </div>
        <div class="login_inputWrap" id="inputWrap_name">
            <div class="login_smallBox"></div>
            <input class="inputStyle2" type="text" placeholder="NAME"/>
        </div>
        <div class="login_inputWrap join_inputWrap" id="inputWrap_gender">
            <div class="login_smallBox"></div>
            <div id="selectWrap_gender">
                <select class="inputStyle2 input_join" id="input_gender" >
                    <option value="male">MALE</option>
                    <option value="female">FEMALE</option>
                </select>
            </div>
        </div>
        <div class="login_inputWrap join_inputWrap" id="inputWrap_studNum">
            <div class="login_smallBox"></div><input class="inputStyle2 input_join" type="number" placeholder="STUDENT NUMBER"/>
        </div>
        
        <div class="login_inputWrap" id="inputWrap_bookmark" >
            <div class="login_smallBox"></div>
            <input class="inputStyle2" id="btn_addBookmark" type="button" value="LIKE" onClick="likeCategoryModalOpen()"/>
        </div>
        <input type="button" class="btnStyle2" id="btn_mdJoinForm" value="JOIN"/>
        
    </div>//modal_bd
</div>//modal_join

    
<div class="modal modal_dCategory" id="modal_likeCategory">
    <div class="modal_hd modal_hd_dCategory">CATEGORY
        <input class="btnStyle btn_category" id="btn_likeCategory" type="button" value="REGIST"/>
    </div>
    <div class="modal_bd modal_bd_dCategory">
        <ul>
            <li>
                <input type="checkbox" data-labelauty="게임프로그래밍"/>
                <label class="label_category">게임프로그래밍게임프로그래밍게임프로그래밍</label>
            </li>
            <li>
                <input type="checkbox" data-labelauty="게임프로그래밍"/>
                <label class="label_category">게임프로그래밍</label>
            </li>
            <li>
                <input type="checkbox" data-labelauty="게임프로그래밍"/>
                <label class="label_category">게임프로그래밍</label>
            </li>
            <li>
                <input type="checkbox" data-labelauty="게임프로그래밍"/>
                <label class="label_category">게임프로그래밍</label>
            </li>
            <li>
                <input type="checkbox" data-labelauty="게임프로그래밍"/>
                <label class="label_category">게임프로그래밍</label>
            </li>
            <li>
                <input type="checkbox" data-labelauty="게임프로그래밍"/>
                <label class="label_category">게임프로그래밍</label>
            </li>
            <li>
                <input type="checkbox" data-labelauty="게임프로그래밍"/>
                <label class="label_category">게임프로그래밍</label>
            </li>
            <li>
                <input type="checkbox" data-labelauty="게임프로그래밍"/>
                <label class="label_category">게임프로그래밍ul 1끝</label>
            </li>
        </ul>
        <ul>
            <li>
                <input type="checkbox" data-labelauty="게임프로그래밍"/>
                <label class="label_category">게임프로그래밍</label>
            </li>
            <li>
                <input type="checkbox" data-labelauty="게임프로그래밍"/>
                <label class="label_category">게임프로그래밍</label>
            </li>
            <li>
                <input type="checkbox" data-labelauty="게임프로그래밍"/>
                <label class="label_category">게임프로그래밍</label>
            </li>
            <li>
                <input type="checkbox" data-labelauty="게임프로그래밍"/>
                <label class="label_category">게임프로그래밍</label>
            </li>
            <li>
                <input type="checkbox" data-labelauty="게임프로그래밍"/>
                <label class="label_category">게임프로그래밍</label>
            </li>
            <li>
                <input type="checkbox" data-labelauty="게임프로그래밍"/>
                <label class="label_category">게임프로그래밍</label>
            </li>
            <li>
                <input type="checkbox" data-labelauty="게임프로그래밍"/>
                <label class="label_category">게임프로그래밍</label>
            </li>
            <li>
                <input type="checkbox" data-labelauty="게임프로그래밍"/>
                <label class="label_category">게임프로그래밍</label>
            </li>
            <li>
                <input type="checkbox" data-labelauty="게임프로그래밍"/>
                <label class="label_category">게임프로그래밍</label>
            </li>
            <li>
                <input type="checkbox" data-labelauty="게임프로그래밍"/>
                <label class="label_category">게임프로그래밍ul2 끝</label>
            </li>
        </ul>
        <ul>
            <li>
                <input type="checkbox" data-labelauty="게임프로그래밍"/>
                <label class="label_category">게임프로그래밍</label>
            </li>
            <li>
                <input type="checkbox" data-labelauty="게임프로그래밍"/>
                <label class="label_category">게임프로그래밍</label>
            </li>
            <li>
                <input type="checkbox" data-labelauty="게임프로그래밍"/>
                <label class="label_category">게임프로그래밍</label>
            </li>
            <li>
                <input type="checkbox" data-labelauty="게임프로그래밍"/>
                <label class="label_category">게임프로그래밍</label>
            </li>
            <li>
                <input type="checkbox" data-labelauty="게임프로그래밍"/>
                <label class="label_category">게임프로그래밍</label>
            </li>
            <li>
                <input type="checkbox" data-labelauty="게임프로그래밍"/>
                <label class="label_category">게임프로그래밍</label>
            </li>
            <li>
                <input type="checkbox" data-labelauty="게임프로그래밍"/>
                <label class="label_category">게임프로그래밍</label>
            </li>
            <li>
                <input type="checkbox" data-labelauty="게임프로그래밍"/>
                <label class="label_category">게임프로그래밍</label>
            </li>
            <li>
                <input type="checkbox" data-labelauty="게임프로그래밍"/>
                <label class="label_category">게임프로그래밍</label>
            </li>
            <li>
                <input type="checkbox" data-labelauty="게임프로그래밍"/>
                <label class="label_category">게임프로그래밍</label>
            </li>
            <li>
                <input type="checkbox" data-labelauty="게임프로그래밍"/>
                <label class="label_category">게임프로그래밍</label>
            </li>
            <li>
                <input type="checkbox" data-labelauty="게임프로그래밍"/>
                <label class="label_category">게임프로그래밍ul3끝</label>
            </li>
        </ul>
        
        
    </div>//modal_bd_likeCategory
</div>//_modal_likeCategory -->
</body>
</html>