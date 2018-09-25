package cn.soft.job.web.controller;

import java.text.ParseException;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import cn.soft.job.common.pojo.po.Base;
import cn.soft.job.common.service.BaseService;
import cn.soft.job.common.utils.CommonUtil;
import cn.soft.job.common.utils.Constants;
import cn.soft.job.sys.controller.base.BaseController;
import cn.soft.job.sys.pojo.po.User;
import cn.soft.job.web.pojo.po.Message;
import cn.soft.job.web.pojo.po.Position;
import cn.soft.job.web.service.MessageService;
import cn.soft.job.web.service.PositionService;

@Controller
@RequestMapping("/message")
public class MessageController extends BaseController {

	@Autowired
	private MessageService messageService;
	@Autowired
	private PositionService positionService;
	@Autowired
	private BaseService baseService;

	@RequestMapping("/index")
	public ModelAndView index() {

		ModelAndView model = new ModelAndView();
		model.setViewName("web/message/message_search");
		return model;
	}

	/**
	 * 获取视频列表
	 * 
	 * @param sEcho
	 * @param iDisplayStart
	 * @param iDisplayLength
	 * @param startDate
	 * @param endDate
	 * @param docName
	 * @throws ParseException
	 */
	@RequestMapping(value = "getMessageListJson")
	public void getDocumentListJson(int sEcho, int iDisplayStart, int iDisplayLength, String startDate, String endDate)
			throws ParseException {
		// System.out.println("uploadResumeService-->"+resumeName);
		User user = (User) session.getAttribute(Constants.LONGIN_USER);
		out(messageService.getMessageList(user, sEcho, iDisplayStart, iDisplayLength, startDate, endDate));

	}

	@RequestMapping("/createMessage")
	public ModelAndView createMessage(int id) {
		ModelAndView model = new ModelAndView();
		List<Base> selectByCode = baseService.selectByCode("salary");
		model.addObject("baseList", selectByCode);
		Position position = positionService.getPositionById(id);
		model.addObject("position", position);
		model.addObject("op", Constants.OP_MODIFY);
		model.setViewName("web/position_applay/position_message");

		return model;
	}

	/**
	 * 保存留言信息
	 * 
	 */
	@RequestMapping("/saveMessage")
	public void saveMessage(Position position, String op) {
		Map<String, Object> resultMap = new HashMap<String, Object>();
		// System.out.println("op--+++:"+op);

		position.getPositionDesc();
		@SuppressWarnings("unused")
		long id = position.getId();
		User user = (User) session.getAttribute(Constants.LONGIN_USER);
		System.out.println("op--+++:" + user.getUserName());

		Message message = new Message();

		message.setUserId(user.getId().intValue());
		message.setComCreateDate(new Date());
		position.getPositionRequire();
		// message.setComcontext(position.getPositionRequire());
		message.setComcontext(position.getPositionDesc());
		message.setPositionId(new Integer((int) position.getId()));
		message.setStatus(1);

		message.setParentId(user.getId().intValue());
		message.setContext("mnjuu");
		message.setCreateDate(new Date());

		int flag = messageService.saveMessage(message);
		resultMap = CommonUtil.checkSave(flag);
		outJson(resultMap);
	}

}
