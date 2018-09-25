package cn.soft.job.web.mapper;

import java.util.List;
import java.util.Map;

import cn.soft.job.web.pojo.po.Message;

public interface MessageMapper {

	int getCount(Map<String, Object> paramsMap);

	List<Message> getMessageList(Map<String, Object> paramsMap);

	int insert(Message message);

}
