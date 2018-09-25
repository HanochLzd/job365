package cn.soft.job.sys.controller;

import cn.soft.job.common.pojo.po.ZTreeNode;
import cn.soft.job.common.utils.CommonUtil;
import cn.soft.job.common.utils.Constants;
import cn.soft.job.sys.controller.base.BaseController;
import cn.soft.job.sys.pojo.po.Menu;
import cn.soft.job.sys.service.MenuService;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @author Hanoch
 * @version 1.0
 * @date 2018/9/12 20:03
 */
@Controller
@RequestMapping("/menu")
public class MenuController extends BaseController {

    private Logger logger = Logger.getLogger(MenuController.class);

    @Autowired
    private MenuService menuService;


    @RequestMapping("/index")
    public ModelAndView index() {
        logger.debug("初始化菜单列表...");
        ModelAndView model = new ModelAndView();
        model.setViewName("sys/menu/menu_list");

        List<Menu> menuList = menuService.getAllMenuList();
        model.addObject("menuList", menuList);
        return model;
    }

    /**
     * 查询菜单
     *
     * @param menuName menuName
     */
    @RequestMapping("/query")
    public ModelAndView queryMenu(String menuName) {
        ModelAndView modelAndView = new ModelAndView();
        List<Menu> menuList = menuService.getMenuListByMenuName(menuName);
        modelAndView.addObject("menuList", menuList);
        modelAndView.addObject("menuName", menuName.trim());
        modelAndView.setViewName("sys/menu/menu_list");
        return modelAndView;
    }


    @RequestMapping("/addMenu")
    public ModelAndView addMenu() {
        ModelAndView modelAndView = new ModelAndView();
        modelAndView.addObject("op", Constants.OP_ADD);
        modelAndView.setViewName("sys/menu/menu_add");
        return modelAndView;

    }


    @RequestMapping(value = "/saveMenu", method = {RequestMethod.POST, RequestMethod.GET})
    public void saveMenu(Menu menu, String op) {

        Map<String, Object> map = new HashMap<>(16);
        if (Constants.OP_MODIFY.equals(op)) {
            int flag = menuService.updateMenuById(menu);
            if (flag == 1) {
                map.put(Constants.RESULT_CODE, Constants.RESULT_SUCCESS_FLAG);
                map.put(Constants.RESULT_MSG, "修改成功");
            }
        } else {
            int count = menuService.findMenuByName(menu.getMenuName());
            if (count <= 0) {
                menu.setMenuStatus(1);
                int flag = menuService.insert(menu);

                if (flag == 1) {
                    map = CommonUtil.checkSave(flag);
                } else {
                    map.put(Constants.RESULT_CODE, Constants.RETURN_FAIL_FLAG);
                    map.put(Constants.RESULT_MSG, "添加失败");
                }
            } else {
                map.put(Constants.RESULT_CODE, Constants.RETURN_FAIL_FLAG);
                map.put(Constants.RESULT_MSG, "权限已存在");
            }
        }
        //将返回结果输出至页面
        outJson(map);

    }


    @RequestMapping("/editMenu")
    public ModelAndView editMenu(int menuId) {
        Menu menu = menuService.findMenuById(menuId);
        ModelAndView model = new ModelAndView();
        model.addObject("menu", menu);
        model.addObject("op", Constants.OP_MODIFY);
        model.setViewName("sys/menu/menu_add");
        return model;

    }


    @RequestMapping("/delMenu")
    public void delMenu(int id) {
        //定义结果集合
        Map<String, Object> resultMap;
        //执行删除操作
        int flag = menuService.deleteByPrimiary(id);
        //判断删除是否成功
        resultMap = CommonUtil.checkDel(flag);
        //输出返回结果至页面
        outJson(resultMap);


    }

    /**
     * 批量删除用户信息
     *
     * @param ids 主键字符串
     */
    @RequestMapping("/batchDeleteMenu")
    public void batchDeleteMenu(String ids) {
        logger.info("批量删除权限信息...");
        //定义结果集合
        Map<String, Object> resultMap;
        //执行批量删除操作
        int flag = menuService.batchDeleteMenu(ids);
        //判断是否删除成功
        resultMap = CommonUtil.checkDel(flag);
        //输出返回结果至页面
        outJson(resultMap);
    }
}
