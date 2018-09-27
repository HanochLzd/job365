package cn.soft.job.web.controller;

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
import cn.soft.job.common.utils.DateUtil;
import cn.soft.job.sys.controller.base.BaseController;
import cn.soft.job.sys.pojo.po.User;
import cn.soft.job.web.pojo.po.Position;
import cn.soft.job.web.service.PositionService;

@Controller
@RequestMapping("/position")
public class PositionController extends BaseController {

	@Autowired
	private PositionService positionService;
	@Autowired
	private BaseService baseService;

	@RequestMapping("/index")
	public ModelAndView index() {
		ModelAndView model = new ModelAndView();
		model.setViewName("web/position/position_list");
		return model;
	}

	@RequestMapping("/indexApplay")
	public ModelAndView indexApplay() {
		ModelAndView model = new ModelAndView();
		model.setViewName("web/position_applay/position_list");
		return model;
	}

	@RequestMapping("/getPositionListJson")
	public void getPositionListJson(int sEcho, int iDisplayStart, int iDisplayLength, String startDate, String endDate,
			String positionName) {

		User user = (User) session.getAttribute(Constants.LONGIN_USER);
		session.setAttribute("user", user);
		out(positionService.getPositionList(user, sEcho, iDisplayStart, iDisplayLength, startDate, endDate,
				positionName));
	}

	@RequestMapping("/add")
	public ModelAndView add() {
		ModelAndView model = new ModelAndView();
		model.addObject("op", Constants.OP_ADD);
		List<Base> selectByCode = baseService.selectByCode("salary");
		model.addObject("baseList", selectByCode);
		model.setViewName("web/position/position_add");

		return model;
	}

	@RequestMapping("/edit")
	public ModelAndView edit(int id) {
		ModelAndView model = new ModelAndView();
		List<Base> selectByCode = baseService.selectByCode("salary");
		model.addObject("baseList", selectByCode);
		Position position = positionService.getPositionById(id);
		model.addObject("position", position);
		model.addObject("op", Constants.OP_MODIFY);
		model.setViewName("web/position/position_add");

		return model;
	}

	@RequestMapping("/save")
	public void save(Position position, String op) {
		System.out.println(position);
		// 定义结果集合
		Map<String, Object> resultMap;

		@SuppressWarnings("unused")
		User user = (User) session.getAttribute(Constants.LONGIN_USER);
		if (Constants.OP_MODIFY.equals(op)) {
			// 修改资讯信息
			// 设置更新时间
			position.setUpdateDate(DateUtil.getSystemTime());
			int flag = positionService.updateByPrimaryKeySelective(position);
			// 若执行成功，记录成功操作日志
			if (Constants.RESULT_SUCCESS_FLAG.equals(String.valueOf(flag))) {
				// operLogService.addLog(request, logUser, "修改资讯信息", "修改资讯信息成功！",
				// flag, "修改");
			}
			// 若执行失败，记录失败操作日志
			else {
				// operLogService.addLog(request, logUser, "修改资讯信息", "修改资讯信息失败！",
				// flag, "修改");
			}
			// 判断是否修改成功
			resultMap = CommonUtil.checkUpdate(flag);
		} else { // 添加资讯信息
			// 设置创建时间
			position.setCreateDate(DateUtil.getSystemTime());
			position.setUpdateDate(DateUtil.getSystemTime());

			// 设置
			position.setCompanyId(1);
			position.setStatus(0);
			// 执行添加资讯操作
			int flag;
			if (position.getPositionDesc().isEmpty()) {
				flag = 0;
			} else {
				flag = positionService.insert(position);
			}
			// 若执行成功，记录成功操作日志
			if (Constants.RESULT_SUCCESS_FLAG.equals(String.valueOf(flag))) {
				// operLogService.addLog(request, logUser, "添加资讯信息", "添加资讯信息成功！",
				// flag, "添加");
			}
			// 若执行失败，记录失败操作日志
			else {
				// operLogService.addLog(request, logUser, "添加资讯信息", "添加资讯信息失败！",
				// flag, "添加");
			}
			// 判断是否添加成功
			resultMap = CommonUtil.checkSave(flag);
		}
		// 将返回结果输出至页面
		outJson(resultMap);
	}

	@RequestMapping("/shenhe")
	public void shenhe(int id) {
		Map<String, Object> resultMap = new HashMap<String, Object>();
		// 执行修改状态操作
		int flag = positionService.shenhe(id);
		resultMap.put("msg", flag);
		// 输出返回结果至页面
		outJson(resultMap);
	}

	/**
	 * 上架-----在页面显示
	 * 
	 * @param id
	 *            主键
	 */
	@RequestMapping("/start")
	public void start(int id) {
		Map<String, Object> resultMap = new HashMap<String, Object>();
		// 执行修改状态操作
		int flag = positionService.start(id);
		resultMap.put("msg", flag);
		// 输出返回结果至页面
		outJson(resultMap);
	}

	/**
	 * 下架-----不在页面显示
	 * 
	 * @param id
	 *            主键
	 */
	@RequestMapping("/stop")
	public void stop(int id) {
		Map<String, Object> resultMap = new HashMap<String, Object>();
		// 执行修改状态操作
		int flag = positionService.stop(id);
		resultMap.put("msg", flag);
		// 输出返回结果至页面
		outJson(resultMap);
	}

	/**
	 * 删除单条
	 */
	@RequestMapping(value = "/delPosition")
	public void delPosition(int id) {
		// 定义结果集合
		Map<String, Object> resultMap = new HashMap<String, Object>();

		// 执行删除操作
		int flag = positionService.deleteByPrimaryKey(id);
		// 若执行成功，记录成功操作日志
		if (Constants.RESULT_SUCCESS_FLAG.equals(String.valueOf(flag))) {
			// operLogService.addLog(request, logUser, "删除资讯信息", "删除资讯信息成功！",
			// flag, "删除");
		}
		// 若执行失败，记录失败操作日志
		else {
			// operLogService.addLog(request, logUser, "删除资讯信息", "删除资讯信息失败！",
			// flag, "删除");
		}
		// 判断删除是否成功
		resultMap = CommonUtil.checkDel(flag);
		// 输出返回结果至页面
		outJson(resultMap);
	}

	/**
	 * 批量删除
	 */
	@RequestMapping(value = "/delBatch")
	public void delBatch(String delIds) {
		// 分割要删除的id串，获取到所有要删除的记录id
		String[] ids = delIds.split(",");
		Map<String, Object> retMap = new HashMap<String, Object>();
		// 初始化删除操作执行结果
		int delFlg = 0;
		// 获取当前登录用户
		// LoginUser logUser = (LoginUser) session
		// .getAttribute(Constants.LONGIN_USER);
		// 若入参不为空，执行删除并返回结果
		if (!CommonUtil.isNull(ids)) {
			delFlg = positionService.deleteBatch(ids);
			retMap = CommonUtil.checkDel(delFlg);
		}
		// 若入参为空，返回删除失败
		else {
			retMap.put(Constants.RESULT_CODE, Constants.RETURN_FAIL_FLAG);
			retMap.put(Constants.RESULT_MSG, Constants.DEL_FAIL_MSG);
		}
		// 若执行成功，记录成功操作日志
		if (!Constants.RESULT_SUCCESS_FLAG.equals(String.valueOf(delFlg))) {
			// operLogService.addLog(request, logUser, "资讯信息", "批量删除资讯信息成功！",
			// delFlg, "删除");
		}
		// 若执行失败，记录失败操作日志
		else {
			// operLogService.addLog(request, logUser, "资讯信息", "批量删除资讯信息失败！",
			// delFlg, "删除");
		}
		outJson(retMap);
	}

}
