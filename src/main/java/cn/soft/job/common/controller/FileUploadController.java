package cn.soft.job.common.controller;

import cn.soft.job.common.utils.Base64Util;
import cn.soft.job.common.utils.DateUtil;
import cn.soft.job.common.utils.ParamUtil;
import cn.soft.job.sys.controller.base.BaseController;
import org.apache.commons.io.FileUtils;
import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.text.SimpleDateFormat;
import java.util.*;


@Controller
@RequestMapping(value="/common/upload")
public class FileUploadController extends BaseController {
	private final static Logger logger = Logger.getLogger(FileUploadController.class);
	
	
	@RequestMapping(value="/doUploadImage", method= RequestMethod.POST)
	public void uploadImage(HttpServletRequest request, HttpServletResponse response){  

		List<Map<String,Object>> fileList = new ArrayList<Map<String,Object>>();

		MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) request;
		Iterator<String> fileNames = multipartRequest.getFileNames();

		int i = 1;
		while (fileNames.hasNext()) {

			String name = (String) fileNames.next();//文件参数名称
			MultipartFile myfile = multipartRequest.getFile(name);
			if(myfile.isEmpty()){  
				logger.info("文件未上传");  
			}else{  

				String saveName = DateUtil.getSystemTime().getTime()+""+i+ ".jpg";
				//SysDictMain sysDictMain = DictUtil.getMainByCode("fileuploadtemp_path");
				//String uploadPath = BaseUtil.getValueFromProperties("path.upload_image_path");
				String uploadPath = ParamUtil.upload_image_path;

				if (null == uploadPath || "".equals(uploadPath)) {
					//out(response, "请维护文件上传暂存路径");
					out("请维护文件上传暂存路径");
					logger.warn("请维护文件上传暂存路径");
					return;
				}

				//日期作为相对路径
				SimpleDateFormat formatdate=new SimpleDateFormat("yyyy/MM/dd/");		
				String relative_path = formatdate.format(new Date());
				String realPath = uploadPath+relative_path;

				File filePath = new File(realPath);
				if (!filePath.exists()) {
					filePath.mkdirs();
				}

				try {

					FileUtils.copyInputStreamToFile(myfile.getInputStream(), new File(realPath, saveName));
				} catch (IOException e) {
					e.printStackTrace();
					logger.error(e.getMessage(), e);
				}  

				Map<String,Object> fileData = new HashMap<>(16);
				fileData.put("fileSize", myfile.getSize());
				fileData.put("fileName", "logo"+i+".jpg");
				fileData.put("saveName", saveName);
				fileData.put("fileOrd", i);

				try {
					fileData.put("savePath", Base64Util.encodeBytesInAndroid(realPath+"/"+saveName));
				} catch (UnsupportedEncodingException e) {
					e.printStackTrace();
					logger.error(e.getMessage(), e);
				}
				fileList.add(fileData);
			}  
			i++;
		}
		Map<String,Object> dataMap = new HashMap<>();
		dataMap.put("success", true);
		dataMap.put("dataList", fileList);

		//响应客户端
		//out(response, JSONUtil.getJson(dataMap));
		outJson(dataMap);
	}


	/**
	 * 图片上传初始化
	 * @return
	 */
//	@RequestMapping(value="/imageUploadInit")
//	public ModelAndView imageUploadInit(){
//		ModelAndView view=new ModelAndView();
//		view.setViewName("common/image_upload");
//		//允许上传图片数量
//		String  imageNum = request.getParameter("imageNum");
//		view.addObject("imageNum", imageNum);
//		return view;
//	}
	
	
	
	/**
	 * 图片上传初始化
	 * @return
	 */
	@RequestMapping(value="/imageUploadInit")
	public ModelAndView imageUploadInit(int pid){
		ModelAndView view=new ModelAndView();
		view.addObject("pid",pid);
		view.setViewName("common/image_upload");
		//允许上传图片数量
		String  imageNum = request.getParameter("imageNum");
		view.addObject("imageNum", imageNum);
		return view;
	}


	/**
	 * 图片上传
	 * @param request
	 * @param response
	 */
	@RequestMapping(value="/imageUpload")
	public void imageUpload(){
		List<Map<String,Object>> fileList = new ArrayList<Map<String,Object>>();
		MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) request;
		Iterator<String> fileNames = multipartRequest.getFileNames();

		Map<String, Object> returnMap = new HashMap<String,Object>();

		int i = 0;
		while (fileNames.hasNext()) {

			String name = (String) fileNames.next();//文件参数名称
			MultipartFile myfile = multipartRequest.getFile(name);
			if(myfile.isEmpty()){  
				returnMap.put("flag", 0);
				returnMap.put("flagMsg", "文件未上传");
				//return JSONUtil.getJson(returnMap);
			}else{  

				String OriginalFileName = myfile.getOriginalFilename();
				String saveName = DateUtil.getSystemTime().getTime() +""+i+OriginalFileName.substring(OriginalFileName.lastIndexOf("."), OriginalFileName.length());

				String uploadPath = ParamUtil.upload_image_path;

				if (null == uploadPath || "".equals(uploadPath)) {
					//out(response, "请维护文件上传暂存路径");
					out("请维护文件上传暂存路径");
					logger.warn("请维护文件上传暂存路径");
					return;
				}

				//日期作为相对路径
				SimpleDateFormat formatdate=new SimpleDateFormat("yyyy/MM/dd/");
				//相对路径
				String relative_path = formatdate.format(new Date());
				//服务器路径
				String server_path = session.getServletContext().getRealPath("/");
				//图片真实路径
				String realPath = uploadPath+relative_path;


				File filePath = new File(server_path+realPath);
				if (!filePath.exists()) {
					filePath.mkdirs();
				}

				try {

					FileUtils.copyInputStreamToFile(myfile.getInputStream(), new File(filePath, saveName));
				} catch (IOException e) {
					e.printStackTrace();
					logger.error(e.getMessage(), e);
				}
				//将图片属性封装到 fileDate
				Map<String,Object> fileData = new HashMap<>(16);
				fileData.put("fileSize", myfile.getSize());
				fileData.put("fileName", myfile.getOriginalFilename());
				fileData.put("saveName", saveName);
				fileData.put("savePath", realPath+"/"+saveName);

				logger.info("saveName:"+saveName);
				logger.info("savePath:"+realPath+"/"+saveName);

				fileList.add(fileData);
			}
			i++;
		}
		returnMap.put("flag", 1);
		returnMap.put("flagMsg", "文件上传成功！");
		returnMap.put("fileList", fileList);

		outJson(returnMap);
	}

}
