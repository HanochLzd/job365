<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@include file="../../common/taglibs.jsp" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>图片上传</title>
    
    <script type="text/javascript">
	//样式
	$(function(){
		$('.skin-minimal input').iCheck({
			checkboxClass: 'icheckbox-blue',
			radioClass: 'iradio-blue',
			increaseArea: '20%'
		});
		var pid=${pid};
		var imageNum = ${imageNum};
		$list = $("#fileList");
		// 实例化
        var uploader = WebUploader.create({
            pick: {
                id: '#filePicker-2',
                label: '点击选择图片'
            },
            //参数
            formData: {
                uid: 123
            },
            //dnd: '#dndArea',
            //paste: '#uploader',
            swf: 'lib/webuploader/0.1.5/Uploader.swf',
            chunked: false,
            chunkSize: 512 * 1024,
            server: '<%=basePath%>moduleImage/imageUpload.do?pid='+pid,
          
            accept: {
                 title: 'Images',
                 extensions: 'gif,jpg,jpeg,bmp,png',
                 mimeTypes: 'image/*'
            },

            // 禁掉全局的拖拽功能。这样不会出现图片拖进页面的时候，把图片打开。
            disableGlobalDnd: true,
            fileNumLimit: imageNum,
            fileSizeLimit: 200 * 1024 * 1024,    // 200 M
            fileSingleSizeLimit: 50 * 1024 * 1024    // 50 M
        });
		
		
       uploader.on( 'fileQueued', function( file ) {
	   		var $li = $(
	   			'<div id="' + file.id + '" class="item">' +
	   				'<div class="pic-box"><img></div>'+
	   				//'<div class="info">' + file.name + '</div>' +
	   				//'<p class="state">等待上传...</p>'+
	   			'</div>'
	   		),
	   		$img = $li.find('img');
	   		$list.html($li);
	   		//$list.append( $li );
	   	
	   		// 创建缩略图
	   		// 如果为非图片文件，可以不用调用此方法。
	   		// thumbnailWidth x thumbnailHeight 为 100 x 100
	   		uploader.makeThumb( file, function( error, src ) {
	   			if ( error ) {
	   				$img.replaceWith('<span>不能预览</span>');
	   				return;
	   			}
	   	
	   			$img.attr( 'src', src );
	   		}, 300, 300 );
	   	});
		
       //开始上传
       $("#btn-star").on('click', function () {          
             uploader.upload();
       });
       
       //上传成功
       uploader.on( 'uploadSuccess', function(file,response) {   	 
    	  //$(response.fileList).each(function(){
    	  //	  alert(this.fileName+"-"+this.saveName+"-"+this.savePath);
    	  //});
    	  //父页面传值
    	  parent.set_img_url(response.fileList);
    	  //关闭当前页面
    	  layer_close();
       });
		
	});

	function setUploadFile(){
		var filepath=$("#filepath").val();
		//window.location.href="<%=basePath%>active/backActive.do?&pictureUrl="+filepath;
		//parent.$("#pictureUrl").val($("#filepath").val());
		parent.set_img_url($("#filepath").val());
	}
	
	function setUpdateFile(){
		var filepath=$("#filepath").val();
		parent.set_img_url($("#filepath").val());
		
		//var id=${id};
		//window.location.href='<%=basePath%>active/backActiveUpdate.do?&pictureUrl='+filepath+'&id='+id;
	}
	
	//图片上传
	
	
</script>
    
  </head>
  
  <body>

    <form  method="post" enctype="multipart/form-data">

		<div class="row cl">

			<div class="formControls col-xs-5 col-sm-6">
				<div class="uploader-list-container"> 
					<div class="queueList">
						<div id="dndArea" class="placeholder">
							<div id="filePicker-2"></div>
						</div>
					</div>					
				</div>
			</div>
		
			<label class="form-label col-xs-4 col-sm-2">缩略图：</label>
			<div class="formControls col-xs-5 col-sm-6">
				<div class="uploader-thum-container">
					<div id="fileList" class="uploader-list"></div>
<!-- 					<div id="filePicker">选择图片</div> -->
<!-- 					<button id="btn-star" class="btn btn-default btn-uploadstar radius ml-10">开始上传</button> -->
				</div>
			</div>
		</div>

	<input type="button" id="btn-star" class="btn btn-primary radius" value="开始上传"/>

	</form>
    
  </body>
</html>
