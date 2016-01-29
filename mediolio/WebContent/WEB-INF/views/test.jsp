<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
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
$(function () {
    $('#actualImage').Jcrop({
     setSelect: [0, 0, 268, 180],
     addClass: 'custom',
     bgColor: 'yellow',
     bgOpacity: .8,
     //sideHandles: true
     allowResize: false,
     allowSelect: false,
     onSelect: storeCoords
 });
    
});

function storeCoords(c) {

 jQuery('#X1').val(c.x);
 jQuery('#Y1').val(c.y); 
 jQuery('#X2').val(c.x2);
 jQuery('#Y2').val(c.y2); 
 jQuery('#W').val(c.w);
 jQuery('#H').val(c.h);
}

function cropPicture(){
    $.ajax({
        url: "cropPhoto.htm",
        type: "POST", 
        data :{
            x : $('input#X1').val(),
            y : $('input#Y1').val(),
            x2 : $('input#X2').val(),
            y2 : $('input#Y2').val(), 
            w : $('input#W').val(),
            h : $('input#H').val(),
            imageName : $('input#imageName').val()
        },
        success: function (data) { 
            window.location = 'photo.htm';
         }
}
</script>
</head>
<body>
<div class="container">
<div class="row">
<div class="span12">
<div class="jc-demo-box">

  <img src="test.jpg" id="target" />

  <div id="preview-pane">
    <div class="preview-container">
      <img src="../test.jpg" class="jcrop-preview" alt="Preview" />
    </div>
  </div>

<div class="clearfix"></div>

</div>
</div>
</div>
</div>

</body>
</html>