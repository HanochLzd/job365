package cn.soft.job.web.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import cn.soft.job.web.pojo.po.Position;

public interface PositionMapper {

	int getCount(Map<String, Object> paramsMap);

	List<Position> getList(Map<String, Object> paramsMap);

	Position getPositionById(int id);

	int updateByPrimaryKeySelective(Position position);

	int insert(Position position);

	int shenhe(int id);

	int start(Map<String, Object> map);

	int stop(int id);

	int deleteByPrimaryKey(int id);

	int deleteBatch(String[] ids);

	List<Position> getAllPosition(@Param("start") int start, @Param("limit") int limit);

	List<Position> getPositionByCate(@Param("cate1") int cate1, @Param("cate2") int cate2, @Param("start") int start,
                                     @Param("limit") int limit);

	int getPositionCount();

	int getCountByCate(int cate1, int cate2);

}
