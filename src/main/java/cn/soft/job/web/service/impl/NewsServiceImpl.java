package cn.soft.job.web.service.impl;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import cn.soft.job.common.utils.DateUtil;
import cn.soft.job.common.utils.JSONUtil;
import cn.soft.job.sys.pojo.po.User;
import cn.soft.job.web.mapper.NewsMapper;
import cn.soft.job.web.pojo.po.News;
import cn.soft.job.web.service.NewsService;

@Service
public class NewsServiceImpl implements NewsService {

	@SuppressWarnings("unused")
	private Logger log = Logger.getLogger(NewsServiceImpl.class);

	@Autowired
	private NewsMapper newsDao;

	public int deleteByPrimaryKey(Long id) {
		// TODO Auto-generated method stub
		return 0;
	}

	public int insert(News record) {
		// TODO Auto-generated method stub
		return newsDao.insert(record);
	}

	public int updateByPrimaryKey(News record) {
		// TODO Auto-generated method stub
		return 0;
	}

	public News selectByPrimaryKey(Long id) {
		// TODO Auto-generated method stub
		return null;
	}

	public String getNewsList(User user, int sEcho, int iDisplayStart, int iDisplayLength, String startDate,
			String endDate, String newsTitle) {
		// TODO Auto-generated method stub

		Map<String, Object> paramsMap = new HashMap<String, Object>();
		List<News> newsList = new ArrayList<News>();
		paramsMap.put("start", iDisplayStart);
		paramsMap.put("limit", iDisplayLength);
		paramsMap.put("newsTitle", newsTitle);
		paramsMap.put("userID", user.getId());

		// 处理检索时间
		if (null != startDate && !"".equals(startDate)) {
			paramsMap.put("startDate",
					DateUtil.toDate(DateUtil.getBeginTimeOfDay(startDate), DateUtil.YYYY_MM_DD_HH_MM_SS));
		}
		if (null != endDate && !"".equals(endDate)) {
			paramsMap.put("endDate", DateUtil.toDate(DateUtil.getEndTimeOfDay(endDate), DateUtil.YYYY_MM_DD_HH_MM_SS));
		}
		// 获取总 的记录数
		int count = newsDao.getCount(paramsMap);
		if (count <= 0) {
			newsList = new ArrayList<News>();
		} else {
			newsList = newsDao.getList(paramsMap);
		}
		return JSONUtil.getDataTableJson(newsList, sEcho, count);

	}

	public int updateByPrimaryKeySelective(News news) {
		// TODO Auto-generated method stub
		return newsDao.updateByPrimaryKeySelective(news);
	}

	public int updateStatus(int id) {
		// TODO Auto-generated method stub
		return newsDao.updateStatusByPrimiary(id);
	}

	public int shangjia(int id) {
		// TODO Auto-generated method stub
		Map<String, Object> paramsMap = new HashMap<String, Object>();
		Date date = new Date();
		paramsMap.put("date", date);
		paramsMap.put("id", id);
		return newsDao.shangjia(paramsMap);
	}

	public int xiajia(int id) {
		// TODO Auto-generated method stub
		return newsDao.xiajia(id);
	}

	public News selectByPrimiary(int id) {
		// TODO Auto-generated method stub
		return newsDao.selectByPrimiary(id);
	}

	public int deleteBatch(String[] ids) {
		// TODO Auto-generated method stub
		return newsDao.deleteBatch(ids);
	}

	public int deleteByPrimaryKey(int id) {
		// TODO Auto-generated method stub
		return newsDao.deleteByPrimiary(id);
	}

	public List<News> getPageList(int start, int limit) {
		// TODO Auto-generated method stub
		return newsDao.getPageList(start, limit);
	}

	public int getPagesCount() {
		// TODO Auto-generated method stub
		return newsDao.getPagesCount();
	}

}
