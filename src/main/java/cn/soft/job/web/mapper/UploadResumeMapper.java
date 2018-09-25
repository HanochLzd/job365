package cn.soft.job.web.mapper;

import java.util.List;
import java.util.Map;

import cn.soft.job.web.pojo.po.UploadResume;

public interface UploadResumeMapper {

	/*
	 * 计数
	 */
	public int getCount(Map<String, Object> paramsMap);

	/*
	 * 
	 * /* 获取列表数据
	 */
	public List<UploadResume> getDocList(Map<String, Object> paramsMap);

	/**
	 * 保存简历信息
	 */
	public int insert(UploadResume document);

	/**
	 * 删除一条简历信息
	 * 
	 * @param id
	 * @return
	 */
	public int delById(int id);

	/**
	 * 根据Id选择下载的简历
	 * 
	 * @param id
	 * @return
	 */
	public int selectDownloadNum(int id);

	/**
	 * 下载的简历数
	 * 
	 * @param paramsMap
	 * @return
	 */
	public int download(Map<String, Object> paramsMap);

	/**
	 * 根据Id获取简历信息
	 */
	public UploadResume selectById(int id);
}
