package cn.soft.job.common.service;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import cn.soft.job.common.pojo.po.FileDownMode;

public interface FileDownService {

	public FileDownMode getFileInfo(HttpServletRequest request, String id);

	public String upload(HttpServletRequest request, HttpServletResponse response);

}
