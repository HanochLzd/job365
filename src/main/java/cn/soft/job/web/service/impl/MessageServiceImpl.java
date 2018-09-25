package cn.soft.job.web.service.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import cn.soft.job.common.utils.DateUtil;
import cn.soft.job.common.utils.JSONUtil;
import cn.soft.job.sys.mapper.RoleMapper;
import cn.soft.job.sys.pojo.po.Role;
import cn.soft.job.sys.pojo.po.User;
import cn.soft.job.web.mapper.MessageMapper;
import cn.soft.job.web.pojo.po.Message;
import cn.soft.job.web.service.MessageService;

@Service
public class MessageServiceImpl implements MessageService {

	@Autowired
	private MessageMapper messageDao;

	@Autowired
	private RoleMapper roleDao;

	@Override
	public String getMessageList(User user, int sEcho, int iDisplayStart, int iDisplayLength, String startDate,
								 String endDate) {

		Role role = roleDao.getOwnRoleByUserId(user.getId()).get(0);

		Map<String, Object> paramsMap = new HashMap<>(16);
		paramsMap.put("start", iDisplayStart);
		paramsMap.put("limit", iDisplayLength);
		paramsMap.put("roleID", role.getId());
		paramsMap.put("userID", user.getId());
		// paramsMap.put("resumeName", resumeName);
		// 处理检索时间
		if (null != startDate && !"".equals(startDate)) {
			paramsMap.put("startDate",
					DateUtil.toDate(DateUtil.getBeginTimeOfDay(startDate), DateUtil.YYYY_MM_DD_HH_MM_SS));
		}
		if (null != endDate && !"".equals(endDate)) {
			paramsMap.put("endDate", DateUtil.toDate(DateUtil.getEndTimeOfDay(endDate), DateUtil.YYYY_MM_DD_HH_MM_SS));
		}
		List<Message> docList = new ArrayList<Message>();
		// 获取总的记录数
		int count = messageDao.getCount(paramsMap);
		if (count > 0) {
			docList = messageDao.getMessageList(paramsMap);
		} else {
			docList = new ArrayList<Message>();
		}
		return JSONUtil.getDataTableJson(docList, sEcho, count);
	}

	@Override
	public int saveMessage(Message message) {
		return messageDao.insert(message);
	}

}
