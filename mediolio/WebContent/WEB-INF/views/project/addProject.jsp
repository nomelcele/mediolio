<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<style>
	ul{padding:0;}
	li{list-style-type: none;}
	img{max-width:500px;}

	fieldset{display:inline-block;}
	.mediaTagBox{display:none;}
	.textBox{display:none;}
	
	.changeTxtArea{background-color:#CECACA; height:30px; display:none; margin:auto; width:70%;}
	.txtAttr{float:left; text-align:center; width:33.3%;}
	
	.upBtn{}
	.downBtn{}
	.removeBtn{}
</style>
<script type="text/javascript" src="js/jquery-1.11.3.min.js"></script>
<script type="text/javascript" src="js/jscolor.min.js"></script>
<script type="text/javascript" src="js/jquery.form.js"></script>
<script>
	var order = 0;
	var txtId = 0;

	$(function(){
		$("#fileUpload").change(function(){
			// 파일 추가
			var ext = $(this).val().split('.').pop().toLowerCase(); // 파일의 확장자
			var file = $(this).prop("files")[0];
			blobURL = window.URL.createObjectURL(file);
			if($.inArray(ext,['gif','png','jpg','jpeg']) == -1){
				// doc, pdf, ppt 파일
				// 미리보기 영역에 뷰어 표시
				$("#viewerForm").ajaxForm({
					dataType: "text",
					url: "showViewer",
					success: function(jdata){
						order++;
						$(".writeBox").append("<div class='contentBox' data-sort="+order+">"
							+"<a href='#' onclick='moveUpElement(this); return false;' class='upBtn'>↑</a>"
							+"<a href='#' onclick='moveDownElement(this); return false;' class='downBtn'>↓</a>"
							+"<a href='#' onclick='removeElement(this); return false;' class='removeBtn'>X</a>"
							+"<iframe src='"+jdata+"' style='width:500px; height:500px;'/></div>");				
					}
				}).submit();
			} else {
				// 이미지 파일
				// 미리보기 영역에 이미지 표시
				order++;
				$(".writeBox").append("<div class='contentBox' data-sort="+order+">"
						+"<a href='#' onclick='moveUpElement(this); return false;' class='upBtn'>↑</a>"
						+"<a href='#' onclick='moveDownElement(this); return false;' class='downBtn'>↓</a>"
						+"<a href='#' onclick='removeElement(this); return false;' class='removeBtn'>X</a>"
						+"<img src='"+blobURL+"' style='display:block;'/></div>");				
			}
		});
		
		$("#tagBtn").click(function(){
			// 미디어 태그 추가
			$(".mediaTagBox").css("display","block");
		});
		
		$("#mediaTagAddBtn").click(function(){
			// 미디어 태그 표시(비디오 등)
			order++;
			$(".writeBox").append("<div class='contentBox' data-sort="+order+">"
					+"<a href='#' onclick='moveUpElement(this); return false;' class='upBtn'>↑</a>"
					+"<a href='#' onclick='moveDownElement(this); return false;' class='downBtn'>↓</a>"
					+"<a href='#' onclick='removeElement(this); return false;' class='removeBtn'>X</a>"
					+$("#mediaTagContent").val()+"</div>");
		});
		
		$("#textBtn").click(function(){
			// 텍스트 추가
			$(".textBox").css("display","block");
		});
		
		$("#textAddBtn").click(function(){
			// 텍스트 표시
			txtId++;
			
			order++;
			$(".writeBox").append("<div class='contentBox contentTextBox' data-sort="+order+">"
			+"<a href='#' onclick='moveUpElement(this); return false;' class='upBtn'>↑</a>"
			+"<a href='#' onclick='moveDownElement(this); return false;' class='downBtn'>↓</a>"
			+"<a href='#' onclick='removeElement(this); return false;' class='removeBtn'>X</a>"
			+"<div class='changeTxtArea'><ul><li class='txtAttr'>"
			+"<select class='txtSize' onchange='changeTxtSize(this)'><option selected>크기</option><option>10</option><option>11</option>"
			+"<option>12</option><option>13</option><option>14</option>"
			+"<option>15</option><option>16</option><option>17</option>"
			+"<option>18</option><option>19</option><option>20</option>"
			+"</select></li>"
			+"<li class='txtAttr'>"
			+"<button class=\"jscolor {valueElement:'chosen-value', onFineChange:'setTextColor(this,"+txtId+")'}\">Pick text color</button>"
			+"</li>"
			+"<li class='txtAttr'><select class='txtStyle' onchange='changeTxtStyle(this)'>"
			+"<option selected>스타일</option><option>bold</option><option>italic</option><option>underline</option>"
			+"</select></li></ul></div>"
			+"<div contenteditable='true' class='contentTxt' onfocusin='showTxtAttrArea(this)' id='txt"+txtId+"'>"
			+$("#textContent").val()
			+"</div></div>");
			// $(".jscolor").init();
			
		});
		
		$(".contentTxt").focusin(function(){
			// 텍스트에 포커스가 맞춰져 있을 경우 텍스트 속성 변경 창 표시
			$(this).closest(".contentTextBox").find(".changeTxtArea").css("display","block");
		});
		
// 		$(".contentTxt").focusout(function(){
// 			// 텍스트에 포커스가 맞춰져 있지 않을 경우 텍스트 속성 변경 창 표시
// 			$(this).closest(".contentTextBox").find(".changeTxtArea").css("display","none");
// 		});
		
		
		$(".txtSize").change(function(){
			// 텍스트 크기 변경
			$(this).closest(".contentTextBox").find(".contentTxt").css("font-size",$(this).val()+"px");
		});
		
		$(".txtStyle").change(function(){
			// 텍스트 스타일 변경
			var styleType = $(this).val();
			if(styleType == 'bold'){
				$(this).closest(".contentTextBox").find(".contentTxt").css("font-weight","bold");	
			}
			if(styleType == 'italic'){
				$(this).closest(".contentTextBox").find(".contentTxt").css("font-style","italic");
			}
			if(styleType == 'underline'){
				$(this).closest(".contentTextBox").find(".contentTxt").css("text-decoration","underline");	
			}
		});
	});
	
	function showTxtAttrArea(txtObj){
		// 텍스트에 포커스가 맞춰져 있을 경우 텍스트 속성 변경 창 표시
		var txt = txtObj;
		$(txt).closest(".contentTextBox").find(".changeTxtArea").css("display","block");
	}
	
	function changeTxtSize(sizeObj){
		// 텍스트 크기 변경
		var txtSize = sizeObj;
		$(txtSize).closest(".contentTextBox").find(".contentTxt").css("font-size",$(txtSize).val()+"px");
	}
	
	function setTextColor(picker,id) {
		// 텍스트 색상 변경
		// 안됩니다... 동적으로 추가한 애들 안 됨
		var txtId = "#txt"+id;
		console.log("텍스트 아이디: "+txtId);
		$(txtId).css("color","#"+picker.toString());
// 		document.getElementsByTagName('body')[0].style.color = '#' + picker.toString()
	}
	
	function changeTxtStyle(styleObj){
		// 텍스트 스타일 변경
		var txtStyle = styleObj;
		var styleType = $(txtStyle).val();
		if(styleType == 'bold'){
			$(txtStyle).closest(".contentTextBox").find(".contentTxt").css("font-weight","bold");	
		}
		if(styleType == 'italic'){
			$(txtStyle).closest(".contentTextBox").find(".contentTxt").css("font-style","italic");
		}
		if(styleType == 'underline'){
			$(txtStyle).closest(".contentTextBox").find(".contentTxt").css("text-decoration","underline");	
		}		
	}
	
	function moveUpElement(ele){
		// 엘리먼트 위로 이동
		var element = ele;
		var order = $(element).closest(".contentBox").attr("data-sort");
		$(element).closest(".contentBox").attr("data-sort",parseInt(order)-1);
		sortElements();
	}
	
	function moveDownElement(ele){
		// 엘리먼트 아래로 이동
		var element = ele;
		var order = $(element).closest(".contentBox").attr("data-sort");
		$(element).closest(".contentBox").attr("data-sort",parseInt(order)+1);
		sortElements();
	}
	
	function removeElement(ele){
		// 엘리먼트 삭제
		var element = ele;
		$(element).closest(".contentBox").remove();
	}
	
	function sortElements(){
		// 순서에 따라 엘리먼트 정렬
		var $wrapper = $('.writeBox');

		$wrapper.find('.contentBox').sort(function (a, b) {
		    return +a.getAttribute('data-sort') - +b.getAttribute('data-sort');
		})
		.appendTo($wrapper);
	}
</script>
</head>
<body>
	<fieldset>
		<legend>글쓰기</legend>
		<div style="width:500px;">
			<div>
				<select>
					<option selected>카테고리 선택</option>
					<option>게임</option>
					<option>영상</option>
					<option>사운드</option>
					<option>웹/모바일</option>
					<option>디자인</option>
				</select>
				<input type="text" placeholder="제목을 입력하세요.">
			</div>
			<div>
				<div>
					<form id="viewerForm" action="showViewer" method="post" enctype="multipart/form-data">
						<input type="file" id="fileUpload" name="projectFile">
					</form>
					<input type="button" id="tagBtn" value="embed">
					<input type="button" id="textBtn" value="텍스트">
				</div>
				<div class="mediaTagBox">
					<textarea id="mediaTagContent" placeholder="미디어 태그를 입력하세요."></textarea>
					<input type="button" id="mediaTagAddBtn" value="태그 추가">
				</div>
				<div class="textBox">
					<textarea id="textContent" placeholder="텍스트를 입력하세요."></textarea>
					<input type="button" id="textAddBtn" value="텍스트 추가">
				</div>				
				<div class="writeBox">
					<div class="contentBox contentTextBox" data-sort="2">
						<a href="#" onclick="moveUpElement(this); return false;" class="upBtn">↑</a>
						<a href="#" onclick="moveDownElement(this); return false;" class="downBtn">↓</a>
						<a href="#" onclick="removeElement(this); return false;" class="removeBtn">X</a>
						<div class="changeTxtArea">
							<ul>
								<li class="txtAttr">
									<select class="txtSize">
										<option selected>크기</option>
										<option>10</option>
										<option>11</option>
										<option>12</option>
										<option>13</option>
										<option>14</option>
										<option>15</option>
										<option>16</option>
										<option>17</option>
										<option>18</option>
										<option>19</option>
										<option>20</option>
									</select>
								</li>
								<li class="txtAttr">
									<button class="jscolor {valueElement:'chosen-value', onFineChange:'setTextColor(this,1)'}">
										Pick text color
									</button>
								</li>
								<li class="txtAttr">
									<select class="txtStyle">
										<option selected>스타일</option>
										<option>bold</option>
										<option>italic</option>
										<option>underline</option>
									</select>								
								</li>
							</ul>
						</div>
						<div contenteditable="true" class="contentTxt" id="txt1">첫번째</div>
					</div>
					<div class="contentBox contentTextBox" data-sort="1">
						<a href="#" onclick="moveUpElement(this); return false;" class="upBtn">↑</a>
						<a href="#" onclick="moveDownElement(this); return false;" class="downBtn">↓</a>
						<a href="#" onclick="removeElement(this); return false;" class="removeBtn">X</a>
						<div class="changeTxtArea">
							<ul>
								<li class="txtAttr">
									<select class="txtSize">
										<option selected>크기</option>
										<option>10</option>
										<option>11</option>
										<option>12</option>
										<option>13</option>
										<option>14</option>
										<option>15</option>
										<option>16</option>
										<option>17</option>
										<option>18</option>
										<option>19</option>
										<option>20</option>
									</select>
								</li>
								<li class="txtAttr">
									<button class="jscolor {valueElement:'chosen-value', onFineChange:'setTextColor(this,2)'}">
										Pick text color
									</button>
								</li>
								<li class="txtAttr">
									<select class="txtStyle">
										<option selected>스타일</option>
										<option>bold</option>
										<option>italic</option>
										<option>underline</option>
									</select>								
								</li>
							</ul>
						</div>
						<div contenteditable="true" class="contentTxt" id="txt2">두번째</div>
					</div>
				</div>
			</div>
			<div>
				<input type="text" placeholder="태그를 입력하세요.">
			</div>
		</div>
	</fieldset>
	<fieldset>
		<legend>카드 미리보기</legend>
		<div>
			<input type="button" value="대표 이미지 선택">
		</div>
	</fieldset>	
</body>
</html>