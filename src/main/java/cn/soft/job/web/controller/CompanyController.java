package cn.soft.job.web.controller;

import cn.soft.job.common.utils.CommonUtil;
import cn.soft.job.common.utils.Constants;
import cn.soft.job.common.utils.DateUtil;
import cn.soft.job.sys.controller.base.BaseController;
import cn.soft.job.sys.pojo.po.Menu;
import cn.soft.job.sys.pojo.po.User;
import cn.soft.job.sys.service.MenuService;
import cn.soft.job.web.pojo.po.Company;
import cn.soft.job.web.pojo.vo.CompanyQueryVo;
import cn.soft.job.web.service.CompanyService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import java.text.ParseException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @author Hanoch
 * @version 1.0
 * @date 2018/9/15 15:52
 */
@Controller
@RequestMapping("/company")
public class CompanyController extends BaseController {

    @Autowired
    private CompanyService companyService;

    @Autowired
    private MenuService menuService;

    @RequestMapping("/index")
    public ModelAndView index() {

        ModelAndView model = new ModelAndView();
        model.setViewName("web/company/company_list");
        return model;
    }

    @RequestMapping("/addCompany")
    public ModelAndView addCompany() {
        ModelAndView model = new ModelAndView();
        model.addObject("op", Constants.OP_ADD);
        model.setViewName("web/company/company_add");

        return model;
    }

    @RequestMapping("/getCompanyListJson")
    public void getCompanyListJson(CompanyQueryVo companyQueryVo) {
        System.out.println(companyQueryVo);
        int sEcho = companyQueryVo.getsEcho();
        int iDisplayStart = companyQueryVo.getiDisplayStart();
        int iDisplayLength = companyQueryVo.getiDisplayLength();
        String startDate = companyQueryVo.getStartDate();
        String endDate = companyQueryVo.getEndDate();
        String companyName = companyQueryVo.getCompany().getCompanyName();
        out(companyService.getCompanyList(sEcho, iDisplayStart, iDisplayLength, startDate, endDate, companyName));
    }

    @RequestMapping("/saveCompany")
    public void saveCompany(Company company, String op) {
        //定义结果集合
        Map<String, Object> resultMap;
//        User user = (User) session.getAttribute(Constants.LONGIN_USER);
        //修改资讯信息
        if (Constants.OP_MODIFY.equals(op)) {
            //设置更新时间
            company.setUpdateDate(DateUtil.getSystemTime());
            int flag = companyService.updateByPrimaryKeySelective(company);
            // 若执行成功，记录成功操作日志
            if (Constants.RESULT_SUCCESS_FLAG.equals(String.valueOf(flag))) {
                //operLogService.addLog(request, logUser, "修改资讯信息", "修改资讯信息成功！",
                //flag, "修改");
            }
            // 若执行失败，记录失败操作日志
            else {
//	    			operLogService.addLog(request, logUser, "修改资讯信息", "修改资讯信息失败！",
//	    					flag, "修改");
            }
            //判断是否修改成功
            resultMap = CommonUtil.checkUpdate(flag);
        } else {                   //添加资讯信息
            //设置创建时间
            company.setCreateDate(DateUtil.getSystemTime());
            company.setUpdateDate(DateUtil.getSystemTime());
            company.setStatus("0");
            //执行添加资讯操作
            int flag;
            if (company.getCompanyDesc().isEmpty()) {
                flag = 0;
            } else {
                flag = companyService.insert(company);
            }
            // 若执行成功，记录成功操作日志
            if (Constants.RESULT_SUCCESS_FLAG.equals(String.valueOf(flag))) {
//	    			operLogService.addLog(request, logUser, "添加资讯信息", "添加资讯信息成功！",
//	    					flag, "添加");
            }
            // 若执行失败，记录失败操作日志
            else {
//	    			operLogService.addLog(request, logUser, "添加资讯信息", "添加资讯信息失败！",
//	    					flag, "添加");
            }
            //判断是否添加成功
            resultMap = CommonUtil.checkSave(flag);
        }
        //将返回结果输出至页面
        outJson(resultMap);
    }

    /**
     * 修改资讯状态
     *
     * @param id 主键
     */
    @RequestMapping("/changeStatus")
    public void changeStatus(int id) {
        Map<String, Object> resultMap = new HashMap<>(2);
        //执行修改状态操作
        int flag = companyService.updateStatus(id);
        resultMap.put("msg", flag);
        //输出返回结果至页面
        outJson(resultMap);
    }


    /**
     * 跳转到编辑资讯页面
     *
     * @param id 主键
     * @return newsinfo_add.jsp
     */
    @RequestMapping("/modifyCompany")
    public ModelAndView modifyNewsinfo(int id) {
        ModelAndView view = new ModelAndView();
        //根据主键获得用户对象
        Company company = companyService.selectByPrimiary(id);

        view.addObject("company", company);
        view.addObject("op", Constants.OP_MODIFY);
        view.setViewName("web/company/company_add");
        return view;
    }

    /**
     * 删除单条
     */
    @RequestMapping(value="/delCompany")
    public void delNewsinfo(int id){
        //定义结果集合
        Map<String, Object> resultMap = new HashMap<String, Object>();

        //执行删除操作
        int flag = companyService.deleteByPrimaryKey(id);
        // 若执行成功，记录成功操作日志
        if (Constants.RESULT_SUCCESS_FLAG.equals(String.valueOf(flag))) {
//				operLogService.addLog(request, logUser, "删除资讯信息", "删除资讯信息成功！",
//						flag, "删除");
        }
        // 若执行失败，记录失败操作日志
        else {
//				operLogService.addLog(request, logUser, "删除资讯信息", "删除资讯信息失败！",
//						flag, "删除");
        }
        //判断删除是否成功
        resultMap = CommonUtil.checkDel(flag);
        //输出返回结果至页面
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
//	   		LoginUser logUser = (LoginUser) session
//	   				.getAttribute(Constants.LONGIN_USER);
        // 若入参不为空，执行删除并返回结果
        if (!CommonUtil.isNull(ids)) {
            delFlg = companyService.deleteBatch(ids);
            retMap = CommonUtil.checkDel(delFlg);
        }
        // 若入参为空，返回删除失败
        else {
            retMap.put(Constants.RESULT_CODE, Constants.RETURN_FAIL_FLAG);
            retMap.put(Constants.RESULT_MSG, Constants.DEL_FAIL_MSG);
        }
        // 若执行成功，记录成功操作日志
        if (!Constants.RESULT_SUCCESS_FLAG.equals(String.valueOf(delFlg))) {
//	   			operLogService.addLog(request, logUser, "资讯信息", "批量删除资讯信息成功！",
//	   					delFlg, "删除");
        }
        // 若执行失败，记录失败操作日志
        else {
//	   			operLogService.addLog(request, logUser, "资讯信息", "批量删除资讯信息失败！",
//	   					delFlg, "删除");
        }
        outJson(retMap);
    }


    @RequestMapping("/show")
    public ModelAndView show(){
        User user = (User) session.getAttribute(Constants.LONGIN_USER);

        ModelAndView model = new ModelAndView();

        //查找自己所有的权限
        //List<Menu> menuList = menuService.findUserMenuById(user.getId());
        //查找所具有的父权限
        //menuService.getAllMenu(user.getId());

        List<Menu> menuList = menuService.getAllMenu(user.getId());


        for (Menu menu : menuList) {

            List<Menu> menuChild = menuService.getAllChlidMenu(user.getId(),menu.getId());
            menu.setChildMenus(menuChild);

        }
        model.addObject("user", user);
        model.addObject("menuList", menuList);
        model.setViewName("../../index");
        return model;

    }

}
