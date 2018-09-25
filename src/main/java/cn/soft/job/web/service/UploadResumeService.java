package cn.soft.job.web.service;

import javax.servlet.http.HttpServletRequest;

import cn.soft.job.sys.pojo.po.User;
import cn.soft.job.web.pojo.po.UploadResume;

public interface UploadResumeService {
	// 查询文档列表
	public String getDocumentList(int sEcho, int iDisplayStart, int iDisplayLength, String startDate, String endDate,
                                  String docName);

	// 保存上传文档信息
	public int saveDocument(UploadResume document, String op);

	// 删除单条文档信息
	public int delById(int id, User user, HttpServletRequest request);

	// 下载文档
	public UploadResume download(int id);
}
