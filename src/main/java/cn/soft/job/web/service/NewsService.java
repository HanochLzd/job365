package cn.soft.job.web.service;

import java.util.List;

import cn.soft.job.sys.pojo.po.User;
import cn.soft.job.web.pojo.po.News;

public interface NewsService {

	/**
	 * 根据部门id删除新闻
	 * 
	 * @param id
	 * @return
	 */
	public int deleteByPrimaryKey(Long id);

	/**
	 * 插入新闻
	 * 
	 * @param record
	 * @return
	 */
	public int insert(News record);

	/**
	 * 更新新闻
	 * 
	 * @param record
	 * @return
	 */
	public int updateByPrimaryKey(News record);

	/**
	 * 根据id查询新闻
	 * 
	 * @param id
	 * @return
	 */
	public News selectByPrimaryKey(Long id);

	public String getNewsList(User user, int sEcho, int iDisplayStart, int iDisplayLength, String startDate,
                              String endDate, String newsTitle);

	public int updateByPrimaryKeySelective(News news);

	public int updateStatus(int id);

	public int shangjia(int id);

	public int xiajia(int id);

	public News selectByPrimiary(int id);

	public int deleteBatch(String[] ids);

	public int deleteByPrimaryKey(int id);

	public List<News> getPageList(int start, int limit);

	public int getPagesCount();

}
