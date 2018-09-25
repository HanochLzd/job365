package cn.soft.job.web.service;

import cn.soft.job.sys.pojo.po.User;
import cn.soft.job.web.pojo.po.Message;

public interface MessageService {

	String getMessageList(User user, int sEcho, int iDisplayStart, int iDisplayLength, String startDate, String endDate);

	public int saveMessage(Message message);

}
