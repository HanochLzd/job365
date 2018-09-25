package cn.soft.job.web.controller;

import java.text.ParseException;
import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import cn.soft.job.common.utils.CommonUtil;
import cn.soft.job.common.utils.Constants;
import cn.soft.job.common.utils.DateUtil;
import cn.soft.job.sys.controller.base.BaseController;
import cn.soft.job.sys.pojo.po.User;
import cn.soft.job.web.pojo.po.News;
import cn.soft.job.web.service.NewsService;

/**
 * 新闻
 */

@Controller
@Scope("prototype")
@RequestMapping(value = "/news")
public class NewsController extends BaseController {

	@Autowired
	private NewsService newsService;

	/**
	 * 初始化页面
	 * 
	 * @return
	 */
	@RequestMapping(value = "/index")
	public ModelAndView init() {
		ModelAndView view = new ModelAndView();
		view.setViewName("web/news/news_list");
		return view;
	}

	@RequestMapping(value = "getNewsListJson")
	public void getNewsListJson(int sEcho, int iDisplayStart, int iDisplayLength, String startDate, String endDate,
			String newsTitle) throws ParseException {

		User user = (User) session.getAttribute(Constants.LONGIN_USER);
		session.setAttribute("user", user);
		out(newsService.getNewsList(user, sEcho, iDisplayStart, iDisplayLength, startDate, endDate, newsTitle));

	}

	/**
	 * 添加资讯
	 */
	@RequestMapping("/addNews")
	public ModelAndView addNews() {
		ModelAndView view = new ModelAndView();
		// 创建用户对象
		News news = new News();
		// 获得部门列表

		view.addObject("news", news);
		view.addObject("op", Constants.OP_ADD);
		view.setViewName("web/news/news_add");
		return view;
	}

	/**
	 * 保存资讯信息
	 */
	@RequestMapping("/saveNews")
	public void saveNews(News news, String op) {
		// 定义结果集合
		Map<String, Object> resultMap = new HashMap<String, Object>();

		User user = (User) session.getAttribute(Constants.LONGIN_USER);
		if (Constants.OP_MODIFY.equals(op)) { // 修改资讯信息
			// 设置更新时间
			news.setUpdateDate(DateUtil.getSystemTime());
			int flag = newsService.updateByPrimaryKeySelective(news);
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
			news.setCreateDate(DateUtil.getSystemTime());
			news.setUpdateDate(DateUtil.getSystemTime());
			news.setPushDate(DateUtil.getSystemTime());
			news.setCreateUserId(user.getId());
			news.setNewsStatus("0");
			news.setIsShowTop("0");
			// 执行添加资讯操作
			int flag;
			if (news.getNewsContent().isEmpty()) {
				flag = 0;
			} else {
				flag = newsService.insert(news);
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

	/**
	 * 修改资讯状态
	 * 
	 * @param id
	 *            主键
	 */
	@RequestMapping("/changeStatus")
	public void changeStatus(int id) {
		Map<String, Object> resultMap = new HashMap<String, Object>();
		// 执行修改状态操作
		int flag = newsService.updateStatus(id);
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
	@RequestMapping("/shangjia")
	public void shangjia(int id) {
		Map<String, Object> resultMap = new HashMap<String, Object>();
		// 执行修改状态操作
		int flag = newsService.shangjia(id);
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
	@RequestMapping("/xiajia")
	public void xiajia(int id) {
		Map<String, Object> resultMap = new HashMap<String, Object>();
		// 执行修改状态操作
		int flag = newsService.xiajia(id);
		resultMap.put("msg", flag);
		// 输出返回结果至页面
		outJson(resultMap);
	}

	/**
	 * 跳转到编辑资讯页面
	 * 
	 * @param id
	 *            主键
	 * @return newsinfo_add.jsp
	 */
	@RequestMapping("/modifyNews")
	public ModelAndView modifyNewsinfo(int id) {
		ModelAndView view = new ModelAndView();
		// 根据主键获得用户对象
		News news = newsService.selectByPrimiary(id);
		// 获得校友分会列表

		view.addObject("news", news);
		view.addObject("op", Constants.OP_MODIFY);
		view.setViewName("web/news/news_add");
		return view;
	}

	/**
	 * 删除单条
	 */
	@RequestMapping(value = "/delNews")
	public void delNewsinfo(int id) {
		// 定义结果集合
		Map<String, Object> resultMap = new HashMap<String, Object>();

		// 执行删除操作
		int flag = newsService.deleteByPrimaryKey(id);
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
			delFlg = newsService.deleteBatch(ids);
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

	/**
	 * 预览资讯信息
	 */
	@RequestMapping(value = "/newsShow")
	public ModelAndView newsinfoShow(int id) {
		ModelAndView view = new ModelAndView();
		News news = new News();
		if (id != 0 && id > 0) {
			news = newsService.selectByPrimiary(id);
			view.addObject("news", news);
		}
		view.setViewName("web/news/news_show");
		return view;

	}

}
