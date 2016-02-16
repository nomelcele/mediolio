<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<link href="resources/css/userPage.css" rel="stylesheet" type="text/css"/>    
<script src="js/userPage.js"></script> 

<div id="contentsWrap">
       <div class="cardWrap" id="userInfoWrap">
	<div id="userInfoWrap_hd">
        <span>12LEEYURA</span>
        <div id="btnWrap_userInfo">
            <a class="btn_userInfo" id="btn_addFriend" href="#" data-click-state="0"></a>
            <a class="btn_userInfo" id="btn_userNote" href="#" onclick="noteModalOpen()"></a>
        </div>
    </div> 
    <div id="userInfoWrap_bd">
        <div class="box_userInfo" id="userIntro">
            <div class="title_userInfo">INTRODUCE</div>
            <div class="content_userInfo">

               안녕하세요. 자기소개입니다. <br/>
               Lorem ipsum dolor sit amet, consectetur adipisicing elit. Quisquam cumque a doloribus, explicabo obcaecati! Ex deleniti consequatur corrupti necessitatibus, dignissimos iste id asperiores cumque laboriosam nobis quisquam quia adipisci, vel.
               Lorem ipsum dolor sit amet, consectetur adipisicing elit. Nam repudiandae non voluptas. Natus distinctio pariatur dolore, nam, libero dignissimos reprehenderit aliquam doloribus. Expedita ducimus nihil voluptatum commodi earum rem consectetur!<br/>
               Lorem ipsum dolor sit amet, consectetur adipisicing elit. Nam pariatur voluptas totam quasi, dignissimos fugiat, vel illo culpa fugit porro sapiente nesciunt saepe ullam minima earum amet numquam aliquam adipisci.

            </div>
        </div><!--//modal_bd_content -->
        <div class="box_userInfo" id="userFavorite">
            <div class="title_userInfo">FAVORITE</div>
            <div class="content_userInfo">게임프로그래밍</div>
        </div>
        <div class="box_userInfo gallery" id="userProject">
            <a class="gallery_arrows gallery_left"  href="#"></a>
            <a class="gallery_arrows gallery_right" id="gallery_right" href="#"></a>
            <div class="title_userInfo">PROJECT</div>
            <div class="content_userInfo">
                <ul>

                    <li>
                        <a href="#"><img src="resources/images/default.png" width="70" height="70"/></a>
                        <p class="userProject_category"><span>GAME</span><span> / </span><span>게임프로그래밍</span></p>
                        <p class="userProject_title">프로젝트 이름입니다. 프로젝트 이름입니다. 프로젝트 이름입니다.</p>
                        <p class="userProject_tag">#태그 #태그</p>
                    </li>
                    
                    <li>
                        <a href="#"><img src="resources/images/default.png" width="70" height="70"/></a>
                        <p class="userProject_category"><span>GAME</span><span> / </span><span>게임프로그래밍</span></p>
                        <p class="userProject_title">프로젝트 이름입니다.</p>
                        <p class="userProject_tag">#태그 #태그</p>
                    </li>
                   
                    <li>
                        <a href="#"><img src="resources/images/default.png" width="70" height="70"/></a>
                        <p class="userProject_category"><span>GAME</span><span> / </span><span>게임프로그래밍</span></p>
                        <p class="userProject_title">프로젝트 이름입니다.</p>
                        <p class="userProject_tag">#태그 #태그</p>
                    </li>
                    
                    <li>
                        <a href="#"><img src="resources/images/default.png" width="70" height="70"/></a>
                        <p class="userProject_category"><span>GAME</span><span> / </span><span>게임프로그래밍</span></p>
                        <p class="userProject_title">프로젝트 이름입니다.</p>
                        <p class="userProject_tag">#태그 #태그</p>
                    </li>
                   
                    
                </ul>
            </div>
        </div><!--//userProject-->
        
        <div class="box_userInfo gallery" id="userLike">
            <a class="gallery_arrows gallery_left"  href="#"></a>
            <a class="gallery_arrows gallery_right" id="gallery_right" href="#"></a>
            <div class="title_userInfo">LIKE</div>
            <div class="content_userInfo">
                <ul>

                    <li>
                        <a href="#"><img src="resources/images/default.png" width="70" height="70"/></a>
                        <p class="userProject_category"><span>GAME</span><span> / </span><span>게임프로그래밍</span></p>
                        <p class="userProject_title">프로젝트 이름입니다. 프로젝트 이름입니다. 프로젝트 이름입니다.</p>
                        <p class="userProject_tag">#태그 #태그</p>
                    </li>
                    
                    <li>
                        <a href="#"><img src="resources/images/default.png" width="70" height="70"/></a>
                        <p class="userProject_category"><span>GAME</span><span> / </span><span>게임프로그래밍</span></p>
                        <p class="userProject_title">프로젝트 이름입니다.</p>
                        <p class="userProject_tag">#태그 #태그</p>
                    </li>
                    
                    <li>
                        <a href="#"><img src="resources/images/default.png" width="70" height="70"/></a>
                        <p class="userProject_category"><span>GAME</span><span> / </span><span>게임프로그래밍</span></p>
                        <p class="userProject_title">프로젝트 이름입니다.</p>
                        <p class="userProject_tag">#태그 #태그</p>
                    </li>
                    
                    <li>
                        <a href="#"><img src="resources/images/default.png" width="70" height="70"/></a>
                        <p class="userProject_category"><span>GAME</span><span> / </span><span>게임프로그래밍</span></p>
                        <p class="userProject_title">프로젝트 이름입니다.</p>
                        <p class="userProject_tag">#태그 #태그</p>
                    </li>
                    
                    <li>
                        <a href="#"><img src="resources/images/default.png" width="70" height="70"/></a>
                        <p class="userProject_category"><span>GAME</span><span> / </span><span>게임프로그래밍</span></p>
                        <p class="userProject_title">프로젝트 이름입니다.</p>
                        <p class="userProject_tag">#태그 #태그</p>
                    </li>
                    
                    <li>
                        <a href="#"><img src="resources/images/default.png" width="70" height="70"/></a>
                        <p class="userProject_category"><span>GAME</span><span> / </span><span>게임프로그래밍</span></p>
                        <p class="userProject_title">프로젝트 이름입니다.</p>
                        <p class="userProject_tag">#태그 #태그</p>
                    </li>

                    
                </ul>
            </div>
        </div><!--//userLike-->
    </div>
    
</div><!--//modal_content_userInfo-->
</div>