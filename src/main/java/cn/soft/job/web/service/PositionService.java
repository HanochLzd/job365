package cn.soft.job.web.service;

import java.util.List;

import cn.soft.job.sys.pojo.po.User;
import cn.soft.job.web.pojo.po.Position;

public interface PositionService {

	String getPositionList(User user, int sEcho, int iDisplayStart, int iDisplayLength, String startDate,
                           String endDate, String companyName);

	Position getPositionById(int id);

	int updateByPrimaryKeySelective(Position position);

	int insert(Position position);

	int shenhe(int id);

	int start(int id);

	int stop(int id);

	int deleteByPrimaryKey(int id);

	int deleteBatch(String[] ids);

	List<Position> getAllPosition(int start, int limit);

	int getPositionCount();

	List<Position> getPositionByCate(int cate1, int cate2, int start, int limit);

	int getCountByCate(int cate1, int cate2);

}
