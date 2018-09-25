package cn.soft.job.web.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import cn.soft.job.web.pojo.po.News;

public interface NewsMapper {

	/**
	 * 根据主键ID删除单条新闻纪录
	 */
	public int deleteByPrimaryKey(Long id);

	/**
	 * 批量删除记录
	 * 
	 */
	public int deleteBatch(String[] ids);

	/**
	 * 新闻添加
	 */
	public int insert(News record);

	/**
	 * 根据主键ID获取单条新闻信息
	 */
	public News selectByPrimaryKey(Long id);

	/**
	 * 修改新闻
	 */
	public int updateByPrimaryKeySelective(News record);

	public int updateByPrimaryKey(News record);

	/**
	 * 获取新闻列表
	 */
	public List<News> getList(Map<String, Object> map);

	/**
	 * 获取总的新闻纪录数
	 */

	public int getCount(Map<String, Object> paramsMap);

	public int updateStatusByPrimiary(int id);

	public int xiajia(int id);

	public int shangjia(Map<String, Object> paramsMap);

	public News selectByPrimiary(int id);

	public int deleteByPrimiary(int id);

	public int getPagesCount();

	public List<News> getPageList(@Param("start") int start, @Param("limit") int limit);

}
