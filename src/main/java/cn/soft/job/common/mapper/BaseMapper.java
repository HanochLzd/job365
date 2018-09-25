package cn.soft.job.common.mapper;

import java.util.List;

import cn.soft.job.common.pojo.po.Base;

/**
 * @author Hanoch
 */
public interface BaseMapper {

	List<Base> selectByCode(String baseCode);

}
