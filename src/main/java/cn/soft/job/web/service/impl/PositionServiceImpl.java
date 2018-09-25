package cn.soft.job.web.service.impl;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import cn.soft.job.common.utils.DateUtil;
import cn.soft.job.common.utils.JSONUtil;
import cn.soft.job.sys.mapper.RoleMapper;
import cn.soft.job.sys.pojo.po.Role;
import cn.soft.job.sys.pojo.po.User;
import cn.soft.job.web.mapper.PositionMapper;
import cn.soft.job.web.pojo.po.Position;
import cn.soft.job.web.service.PositionService;

@Service
public class PositionServiceImpl implements PositionService {

	@Resource
	private PositionMapper positionDao;
	
	@Autowired
	private RoleMapper roleDao;

	public String getPositionList(User user, int sEcho, int iDisplayStart, int iDisplayLength, String startDate,
			String endDate, String positionName) {
		// TODO Auto-generated method stub

		Role role = roleDao.getOwnRoleByUserId(user.getId()).get(0);
		
		Map<String, Object> paramsMap = new HashMap<String, Object>();
		List<Position> positionList = new ArrayList<Position>();
		paramsMap.put("start", iDisplayStart);
		paramsMap.put("limit", iDisplayLength);
		paramsMap.put("positionName", positionName);
		paramsMap.put("roleID", role.getId());
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
		int count = positionDao.getCount(paramsMap);
		if (count <= 0) {
			positionList = new ArrayList<Position>();
		} else {
			positionList = positionDao.getList(paramsMap);
		}
		return JSONUtil.getDataTableJson(positionList, sEcho, count);

	}

	public Position getPositionById(int id) {
		// TODO Auto-generated method stub
		return positionDao.getPositionById(id);
	}

	public int updateByPrimaryKeySelective(Position position) {
		// TODO Auto-generated method stub
		return positionDao.updateByPrimaryKeySelective(position);
	}

	public int insert(Position position) {
		// TODO Auto-generated method stub
		return positionDao.insert(position);
	}

	public int shenhe(int id) {
		// TODO Auto-generated method stub
		return positionDao.shenhe(id);
	}

	public int start(int id) {
		// TODO Auto-generated method stub
		Map<String, Object> map = new HashMap<String, Object>();
		Date date = new Date();
		map.put("date", date);
		map.put("id", id);
		return positionDao.start(map);
	}

	public int stop(int id) {
		// TODO Auto-generated method stub
		return positionDao.stop(id);
	}

	public int deleteByPrimaryKey(int id) {
		// TODO Auto-generated method stub
		return positionDao.deleteByPrimaryKey(id);
	}

	public int deleteBatch(String[] ids) {
		// TODO Auto-generated method stub
		return positionDao.deleteBatch(ids);
	}

	public List<Position> getAllPosition(int start, int limit) {
		// TODO Auto-generated method stub
		return positionDao.getAllPosition(start, limit);
	}

	public int getPositionCount() {
		// TODO Auto-generated method stub
		return positionDao.getPositionCount();
	}

	public List<Position> getPositionByCate(int cate1, int cate2, int start, int limit) {
		// TODO Auto-generated method stub
		return positionDao.getPositionByCate(cate1, cate2, start, limit);
	}

	public int getCountByCate(int cate1, int cate2) {
		// TODO Auto-generated method stub
		return positionDao.getCountByCate(cate1, cate2);
	}

}
