package cn.soft.job.web.mapper;

import java.util.List;
import java.util.Map;

import cn.soft.job.web.pojo.po.Resume;

public interface ResumeMapper {

	/**
	 * 获取简历列表，分页，分部门
	 * 
	 * @param paramsMap
	 * 
	 * @param sEcho
	 * @param strat
	 *            起始值
	 * @param limit
	 *            页的大小
	 * @param deptId
	 *            部门编号
	 * @return
	 */
	public List<Resume> getResumeList(Map<String, Object> paramsMap);

	/**
	 * 获取所有列表
	 * 
	 * @param paramsMap
	 * @return
	 */
	public List<Resume> getList(Map<String, Object> paramsMap);

	/**
	 * 总记录数
	 * 
	 * @param paramsMap
	 * @return
	 */
	public int getCount(Map<String, Object> paramsMap);

	/**
	 * 批量删除
	 * 
	 * @param idArr
	 * @return
	 */
	public int batchDeleteResume(String[] idArr);

	/**
	 * 根据Id删除简历信息
	 * 
	 * @param id
	 * @return
	 */
	public int deleteByPrimiary(int id);

	/**
	 * 修改简历状态，启用或者禁用
	 * 
	 * @param id
	 * @return
	 */
	public int updateResumeStatus(int id);

	/**
	 * 根据主键修改简历信息
	 * 
	 * @param resume
	 * @return
	 */
	public int updateByPrimaryKeySelective(Resume resume);

	/**
	 * 添加用户信息
	 * 
	 * @param resume
	 * @return
	 */
	public int insert(Resume resume);

	/**
	 * 添加当前用户的数量
	 * 
	 * @param paramsMap
	 * @return
	 */
	public int getCountNumber(Map<String, Object> paramsMap);

	/**
	 * 根据Id查找简历信息
	 * 
	 * @param id
	 * @return
	 */
	public Resume selectByPrimiary(int id);

}
