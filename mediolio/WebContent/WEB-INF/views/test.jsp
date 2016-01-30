<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<style type="text/css">
.container { width: 500px; clear: both;}
.container input {width: 100%;clear: both;}
#wrapper {margin: 0 auto; width: 400px;}
#wrapper2 {margin: 0 auto; width: 200px;}
</style>
<script type="text/javascript" src="js/jquery-1.11.3.min.js"></script>
<script type="text/javascript" src="js/jquery.Jcrop.js"></script>
<link rel="stylesheet" href="resources/css/jquery.Jcrop.css" type="text/css" />
<script type="text/javascript">

var preview_url='';

function show_cropModal(url){
	console.log("function:", url);
	$.ajax({
		type: "POST",
		url: "imgCrop_modal",
		data: {
			url : url
		},
		async:false,
		success: function(result){
			$("#modalBox").html(result);
			location.href="#crop";
		}
	});
}

function readUrl(input){
	console.log("readUrl");
	//var result='';
    var reader= new FileReader();
    reader.onload = function (e) {
    	preview_url = e.target.result;	
   } 
	reader.readAsDataURL(input.files[0]);
}

$(function (){
	$('#representative_img').change(function(){
		$.ajax({
			url:readUrl(this),
			async:false,
			success:function(){
				show_cropModal(preview_url);
			}
		});
	});
});


</script>
</head>
<body>
<div id="modalBox"></div>
<input type="file" id="representative_img" name="p_coverImg">

</body>
</html>