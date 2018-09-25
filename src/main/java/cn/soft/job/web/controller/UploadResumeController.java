package cn.soft.job.web.controller;

import java.io.File;
import java.io.IOException;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.net.URLDecoder;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.io.FileUtils;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import cn.soft.job.common.utils.CommonUtil;
import cn.soft.job.common.utils.Constants;
import cn.soft.job.common.utils.DateUtil;
import cn.soft.job.common.utils.ParamUtil;
import cn.soft.job.sys.controller.base.BaseController;
import cn.soft.job.sys.pojo.po.User;
import cn.soft.job.web.pojo.po.UploadResume;
import cn.soft.job.web.service.UploadResumeService;

/**
 * <p>
 * this is about:<code>DocumentController.java </code>
 * </P>
 * 
 *
 */
@Controller
@Scope("prototype")
@RequestMapping(value = "/uploadResume")
public class UploadResumeController extends BaseController {
	private static Logger logger = Logger.getLogger(UploadResumeController.class);
	/*
	 * @Autowired //private ISysOperLogService operLogService;
	 */ @Autowired
	private UploadResumeService uploadResumeService;

	// 页面初始化
	@RequestMapping(value = "/getList")
	public ModelAndView getList() {
		ModelAndView view = new ModelAndView();
		view.setViewName("web/upload_resume/upload_resume_list");
		return view;
	}

	/**
	 * 获取上传的列表
	 * 
	 * @param sEcho
	 * @param iDisplayStart
	 * @param iDisplayLength
	 * @param startDate
	 * @param endDate
	 * @param docName
	 * @throws ParseException
	 */
	@RequestMapping(value = "getDocumentListJson")
	public void getDocumentListJson(int sEcho, int iDisplayStart, int iDisplayLength, String startDate, String endDate,
			String resumeName) throws ParseException {
		System.out.println("uploadResumeService-->" + resumeName);
		out(uploadResumeService.getDocumentList(sEcho, iDisplayStart, iDisplayLength, startDate, endDate, resumeName));

	}

	/**
	 * 添加文档
	 */
	@RequestMapping("/addDoc")
	public ModelAndView addMovie() {
		ModelAndView view = new ModelAndView();
		// 创建视频对象
		UploadResume doc = new UploadResume();
		view.addObject("doc", doc);
		view.addObject("op", Constants.OP_ADD);
		view.setViewName("web/upload_resume/upload_resume_add");
		return view;
	}

	/**
	 * 保存文档
	 */
	@RequestMapping("/saveDoc")
	public void saveDoc(String docName, String docDesc, String op) {
		List<Map<String, Object>> fileList = new ArrayList<Map<String, Object>>();
		// 定义结果集合
		Map<String, Object> resultMap = new HashMap<String, Object>();
		MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) request;
		Iterator<String> fileNames = multipartRequest.getFileNames();
		UploadResume document = new UploadResume();
		User user = (User) session.getAttribute(Constants.LONGIN_USER);
		Map<String, Object> returnMap = new HashMap<String, Object>();

		int i = 0;
		while (fileNames.hasNext()) {

			String name = (String) fileNames.next();// 文件参数名称
			MultipartFile myfile = multipartRequest.getFile(name);
			if (myfile.isEmpty()) {
				returnMap.put("flag", 0);
				returnMap.put("flagMsg", "简历未上传");
				// return JSONUtil.getJson(returnMap);
			} else {

				String OriginalFileName = myfile.getOriginalFilename();
				String saveName = DateUtil.getSystemTime().getTime() + "" + i
						+ OriginalFileName.substring(OriginalFileName.lastIndexOf("."), OriginalFileName.length());

				String uploadPath = ParamUtil.upload_document_path;

				if (null == uploadPath || "".equals(uploadPath)) {
					// out(response, "请维护文件上传暂存路径");
					out("请维护文件上传暂存路径");
					logger.warn("请维护文件上传暂存路径");
					return;
				}

				// 日期作为相对路径
				SimpleDateFormat formatdate = new SimpleDateFormat("yyyy/MM/dd/");
				// 相对路径
				String relative_path = formatdate.format(new Date());
				// 服务器路径
				String server_path = session.getServletContext().getRealPath("/");
				// 真实路径
				String realPath = uploadPath + relative_path;

				File filePath = new File(server_path + realPath);
				if (!filePath.exists()) {
					filePath.mkdirs();
				}
				/* String houzuiming =saveName.substring(saveName.lastIndexOf(".")+1); */
				try {
					FileUtils.copyInputStreamToFile(myfile.getInputStream(),
							new File(filePath, myfile.getOriginalFilename()));
				} catch (IOException e) {
					e.printStackTrace();
					logger.error(e.getMessage(), e);
				}

				// 将属性封装到 fileDate
				Map<String, Object> fileData = new HashMap<String, Object>();
				fileData.put("fileSize", myfile.getSize());
				fileData.put("fileName", myfile.getOriginalFilename());
				fileData.put("saveName", saveName);
				fileData.put("savePath", realPath + "/" + saveName);
				document.setResumeUrl(realPath + "/" + myfile.getOriginalFilename());
				document.setResumeName(myfile.getOriginalFilename());
				logger.info("saveName:" + saveName);
				logger.info("savePath:" + realPath + "/" + myfile.getOriginalFilename());

				fileList.add(fileData);
			}

			i++;

		}

		document.setResumeDesc(docDesc);
		// System.out.println("logUser.getId()"+user.getId());
		document.setCreateUserId(user.getId());

		int flag = uploadResumeService.saveDocument(document, op);
		// 判断是否添加成功
		resultMap = CommonUtil.checkSave(flag);
		// 将返回结果输出至页面
		outJson(resultMap);
	}

	@SuppressWarnings("deprecation")
	@RequestMapping("/downloadTemplate")
	public void downloadTemplate(HttpServletRequest request, HttpServletResponse response) throws IOException {
		String fileName = request.getParameter("fileName");
		fileName = URLDecoder.decode(fileName);
		fileName = new String(fileName.getBytes(), "iso-8859-1");
		String filePath = "/back/templateFile/" + fileName;
		File file = new File(request.getSession().getServletContext().getRealPath("/") + filePath);
		if (file.exists()) {
			OutputStream os = response.getOutputStream();
			try {
				response.reset();
				response.setHeader("Content-Disposition", "attachment;filename=\"" + fileName + "\"");
				response.setContentType("application/octet-stream;charset=utf-8");
				os.write(FileUtils.readFileToByteArray(file));
				os.flush();
			} finally {
				if (os != null) {
					os.close();
				}
			}
		} else {
			response.setContentType("text/html;charset=utf-8");
			PrintWriter out = response.getWriter();
			out.print("<script>");
			out.print("alert('该文件不存在，请联系管理员!');window.close();");
			out.print("</script>");
			out.close();
		}
	}

	/**
	 * 
	 * 下载文档一次，文档下载次数加一
	 * 
	 * @param id
	 * @throws IOException
	 */
	@SuppressWarnings("unused")
	@RequestMapping("download")
	public ModelAndView download(HttpServletRequest request, HttpServletResponse response, int id) throws IOException {
		UploadResume uploadResume = uploadResumeService.download(id);

		/*
		 * String resumeName = uploadResume.getResumeName(); //相对路径 String relative_path
		 * = uploadResume.getResumeUrl(); //服务器路径 String server_path =
		 * session.getServletContext().getRealPath("/"); //图片真实路径 String realPath =
		 * server_path+relative_path;
		 * 
		 * File filePath = new File(realPath); System.out.println("真实文件路径::"+filePath);
		 * 
		 * FileDownLoadController fileDownLoad = new FileDownLoadController();
		 * fileDownLoad.download(filePath, resumeName, response);
		 */

		ModelAndView view = new ModelAndView();
		view.setViewName("web/upload_resume/upload_resume_list");
		return view;
	}

	/**
	 * 删除信息
	 */
	@SuppressWarnings("unused")
	@RequestMapping("delDocument")
	public void delDocument(int id) {
		// 定义结果集合
		Map<String, Object> resultMap = new HashMap<String, Object>();
		User user = (User) session.getAttribute(Constants.LONGIN_USER);
		// 执行删除操作
		int flag = uploadResumeService.delById(id, new User(), request);
		// 判断删除是否成功
		resultMap = CommonUtil.checkDel(flag);
		// 输出返回结果至页面
		outJson(resultMap);
	}
}
