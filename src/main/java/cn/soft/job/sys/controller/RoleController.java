package cn.soft.job.sys.controller;

import cn.soft.job.common.pojo.po.ZTreeNode;
import cn.soft.job.common.utils.CommonUtil;
import cn.soft.job.common.utils.Constants;
import cn.soft.job.sys.controller.base.BaseController;
import cn.soft.job.sys.pojo.po.Menu;
import cn.soft.job.sys.pojo.po.Role;
import cn.soft.job.sys.service.MenuService;
import cn.soft.job.sys.service.RoleService;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import java.util.*;


/**
 * @author Hanoch
 * @version 1.0
 * @date 2018/9/12 9:53
 */
@Controller
@RequestMapping("/role")
public class RoleController extends BaseController {

    private Logger logger = Logger.getLogger(RoleController.class);

    @Autowired
    private RoleService roleService;

    @Autowired
    private MenuService menuService;

    @RequestMapping("/index")
    public String index() {
        List<Role> roleList = roleService.getAllRole();
        request.setAttribute("roleList", roleList);
        return "sys/role/role_list";
    }

    @RequestMapping("/addRole")
    public ModelAndView addRole() {

        ModelAndView model = new ModelAndView();
        model.addObject("op", Constants.OP_ADD);
        model.setViewName("sys/role/role_add");

        return model;

    }

    @RequestMapping("/editRole")
    public ModelAndView editRole(int roleId) {
        ModelAndView model = new ModelAndView();
        Role role = roleService.findRoleById(roleId);
        model.addObject("op", Constants.OP_MODIFY);
        model.addObject("role", role);
        model.setViewName("sys/role/role_add");
        return model;
    }

    /**
     * 添加（编辑角色）角色
     *
     * @param role role
     * @param op   op
     */
    @RequestMapping(value = "/saveRole", method = RequestMethod.POST)
    public void saveRole(Role role, String op) {
        logger.debug("执行添加...");
        Map<String, String> returnMsg = new HashMap<>(16);
        if (op.equals(Constants.OP_ADD)) {
            role.setCreateDate(new Date());
            role.setStatus(1);
            int status = roleService.addRole(role);
            if (status == 1) {
                returnMsg.put("message", "角色添加成功");
            } else {
                returnMsg.put("message", "角色添加失败");
            }
        } else {
            int count = roleService.updateRole(role);
            if (count <= 0) {
                returnMsg.put("message", "角色修改失败");

            } else {
                returnMsg.put("message", "角色修改成功");
            }
        }
        outJson(returnMsg);
    }

    @RequestMapping("/roleMenu")
    public ModelAndView roleMenu(int roleId) {
        ModelAndView model = new ModelAndView();
        Role role = roleService.findRoleById(roleId);

        model.addObject("role", role);
        model.setViewName("sys/role/role_menu");
        return model;
    }

    @ResponseBody
    @RequestMapping("/getMenuById")
    public List<ZTreeNode> getMenuById(int id) {

        List<ZTreeNode> treeNode = new ArrayList<>();
        List<Menu> allMenuList = menuService.getAllMenuList();
        List<Menu> ownMenuList = menuService.getOwnMenuById(id);
        for (Menu menu : allMenuList) {
            ZTreeNode zTreeNode = new ZTreeNode();
            zTreeNode.setId(menu.getId());
            zTreeNode.setpId(menu.getParentId());
            zTreeNode.setName(menu.getMenuName());
            zTreeNode.setOpen(true);
            if (ownMenuList.size() > 0) {
                for (Menu menu2 : ownMenuList) {
                    if (menu.getMenuName().equals(menu2.getMenuName())) {
                        zTreeNode.setChecked(true);
                    }
                }
            } else {
                zTreeNode.setChecked(false);
            }
            treeNode.add(zTreeNode);
        }
        return treeNode;
    }

    /**
     * 删除
     *
     * @param id 角色ID
     */
    @RequestMapping("/roledel")
    public void roledel(int id) {
        //定义结果集合
        Map<String, Object> resultMap;
        //执行删除操作
        int flag = roleService.deleteByPrimiary(id);
        //判断删除是否成功
        resultMap = CommonUtil.checkDel(flag);
        //输出返回结果至页面
        outJson(resultMap);
    }


    /**
     * 给角色授予菜单
     *
     * @param id      角色ID
     * @param menuIds 菜单ID集
     */
    @RequestMapping("/giveMenu")
    public void giveMenu(int id, String menuIds) {
        Map<String, Object> resultMap = new HashMap<>(2);
        int count = menuService.giveMenu(id, menuIds);
        if (count > 0) {
            resultMap.put(Constants.RESULT_CODE, Constants.RESULT_SUCCESS_FLAG);
            resultMap.put(Constants.RESULT_MSG, "授权成功");
        } else {
            resultMap.put(Constants.RESULT_CODE, Constants.RETURN_FAIL_FLAG);
            resultMap.put(Constants.RESULT_MSG, "授权失败");
        }
        outJson(resultMap);
    }

}
