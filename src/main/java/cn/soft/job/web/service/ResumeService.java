package cn.soft.job.web.service;

import javax.servlet.http.HttpServletResponse;

import cn.soft.job.web.pojo.po.Resume;

public interface ResumeService {
	/**
	 * 获取用户简历列表
	 * 
	 * @param sEcho
	 * @param iDisplayStart
	 * @param iDisplayLength
	 * @param searchResume
	 * @param resumeWorkplace
	 * @param resumePosition
	 * @return
	 */

	public String getResumeList(int sEcho, int iDisplayStart, int iDisplayLength, String searchResume,
                                String resumePosition, String resumeWorkplace);

	/**
	 * 批量删除简历信息
	 * 
	 * @param ids
	 * @return
	 */
	public int batchDeleteResume(String ids);

	/**
	 * 根据Id删除简历信息
	 * 
	 * @param id
	 * @return
	 */
	public int deleteByPrimiary(int id);

	/**
	 * 修改简历状态
	 * 
	 * @param id
	 * @return
	 */
	public int updateResumeStatus(int id);

	/**
	 * 获得简历总数量
	 * 
	 * @param resume
	 * @param op
	 * @return
	 */
	public int getCountNumber(Resume resume, String op);

	/**
	 * 根据Id修改简历信息
	 * 
	 * @param resume
	 * @return
	 */
	public int updateByPrimaryKeySelective(Resume resume);

	/**
	 * 添加 简历信息
	 * 
	 * @param resume
	 * @return
	 */
	public int insert(Resume resume);

	/**
	 * 根据Id查找用户
	 * 
	 * @param id
	 * @return
	 */
	public Resume selectByPrimiary(int id);

//	/**
//	 * 获取导出列表
//	 *
//	 * @param startDate
//	 * @param endDate
//	 * @param resumeName
//	 */
//	public void getExportList(String startDate, String endDate, String resumeName, HttpServletResponse response);

}
