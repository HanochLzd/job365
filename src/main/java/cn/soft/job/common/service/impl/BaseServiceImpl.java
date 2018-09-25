package cn.soft.job.common.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import cn.soft.job.common.mapper.BaseMapper;
import cn.soft.job.common.pojo.po.Base;
import cn.soft.job.common.service.BaseService;

@Service
public class BaseServiceImpl implements BaseService {

	@Autowired
	private BaseMapper baseDao;

	public List<Base> selectByCode(String baseCode) {
		return baseDao.selectByCode(baseCode);

	}

}
