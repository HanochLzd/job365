package cn.soft.job.common.service;

import java.util.List;

import cn.soft.job.common.pojo.po.Base;

public interface BaseService {
	public List<Base> selectByCode(String baseCode);

}
