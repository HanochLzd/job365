package cn.soft.job.web.service.impl;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import cn.soft.job.common.utils.DateUtil;
import cn.soft.job.common.utils.JSONUtil;
import cn.soft.job.sys.pojo.po.User;
import cn.soft.job.web.mapper.UploadResumeMapper;
import cn.soft.job.web.pojo.po.UploadResume;
import cn.soft.job.web.service.UploadResumeService;

@Service("universityDocumentService")
public class UploadResumeServiceImpl implements UploadResumeService {

	public Logger log = Logger.getLogger(UploadResumeServiceImpl.class);

	@Autowired
	private UploadResumeMapper uploadResumeDao;

	public String getDocumentList(int sEcho, int iDisplayStart, int iDisplayLength, String startDate, String endDate,
			String resumeName) {
		Map<String, Object> paramsMap = new HashMap<String, Object>();
		paramsMap.put("start", iDisplayStart);
		paramsMap.put("limit", iDisplayLength);
		paramsMap.put("resumeName", resumeName);
		// 处理检索时间
		if (null != startDate && !"".equals(startDate)) {
			paramsMap.put("startDate",
					DateUtil.toDate(DateUtil.getBeginTimeOfDay(startDate), DateUtil.YYYY_MM_DD_HH_MM_SS));
		}
		if (null != endDate && !"".equals(endDate)) {
			paramsMap.put("endDate", DateUtil.toDate(DateUtil.getEndTimeOfDay(endDate), DateUtil.YYYY_MM_DD_HH_MM_SS));
		}
		List<UploadResume> docList = new ArrayList<UploadResume>();
		// 获取总的记录数
		int count = uploadResumeDao.getCount(paramsMap);
		if (count > 0) {
			docList = uploadResumeDao.getDocList(paramsMap);
		} else {
			docList = new ArrayList<UploadResume>();
		}
		return JSONUtil.getDataTableJson(docList, sEcho, count);
	}

	public int saveDocument(UploadResume document, String op) {
		document.setCreateDate(new Date());
		document.setUpdateDate(new Date());
		document.setDownloadNum(0);
		document.setStatus("1");
		return uploadResumeDao.insert(document);
	}

	public int delById(int id, User user, HttpServletRequest request) {
		return uploadResumeDao.delById(id);
	}

	public UploadResume download(int id) {
		// int number = uploadResumeDao.selectDownloadNum(id);
		UploadResume uploadResume = uploadResumeDao.selectById(id);
		int number = (int) uploadResume.getDownloadNum();
		number = number + 1;
		Map<String, Object> paramsMap = new HashMap<String, Object>();
		paramsMap.put("number", number);
		paramsMap.put("id", id);
		uploadResumeDao.download(paramsMap);
		return uploadResume;
	}

}