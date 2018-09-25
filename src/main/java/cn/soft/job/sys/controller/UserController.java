package cn.soft.job.sys.controller;

import cn.soft.job.common.pojo.po.ZTreeNode;
import cn.soft.job.common.utils.CommonUtil;
import cn.soft.job.common.utils.Constants;
import cn.soft.job.common.utils.DateUtil;
import cn.soft.job.common.utils.MD5Util;
import cn.soft.job.sys.controller.base.BaseController;
import cn.soft.job.sys.pojo.po.Role;
import cn.soft.job.sys.pojo.po.User;
import cn.soft.job.sys.pojo.vo.UserQueryVo;
import cn.soft.job.sys.service.RoleService;
import cn.soft.job.sys.service.UserService;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @author Hanoch
 * @version 1.0
 * @date 2018/9/11 9:25
 */
@Controller
@RequestMapping("/user")
public class UserController extends BaseController {

    private Logger logger = Logger.getLogger(UserController.class);

    @Autowired
    private UserService userService;

    @Autowired
    private RoleService roleService;

    @RequestMapping("/index")
    public String userIndex() {
        return "sys/user/user_list";
    }

    /**
     * 显示所有用户列表
     *
     * @param userQueryVo userQueryVo
     */
    @RequestMapping("/getUserList")
    public void getUserList(UserQueryVo userQueryVo) {
        System.out.println(userQueryVo.getsEcho() + "--" + userQueryVo.getiDisplayStart() + "--" + userQueryVo.getiDisplayStart());
        String userJsonData = userService.getUserList(userQueryVo);
        out(userJsonData);
    }

    /**
     * 跳转到新增用户页面
     *
     * @return user_add.jsp
     */
    @RequestMapping("/addUser")
    public ModelAndView addSysUser() {
        logger.info("跳转到新增用户页面...");
        ModelAndView view = new ModelAndView();
        User user = new User();
        view.addObject("user", user);
        view.addObject("op", Constants.OP_ADD);
        view.setViewName("sys/user/user_add");
        return view;
    }


    /**
     * 跳转到修改用户页面
     *
     * @param id 主键
     * @return user_add.jsp
     */
    @RequestMapping("/modifyUser")
    public ModelAndView modifySysUser(int id) {
        logger.info("跳转到编辑用户页面...");
        ModelAndView view = new ModelAndView();
        //根据主键获得用户对象
        User user = userService.selectByPrimiary(id);
        view.addObject("user", user);
        view.addObject("op", Constants.OP_MODIFY);
        view.setViewName("sys/user/user_add");
        return view;
    }


    /**
     * 保存用户信息
     *
     * @param user 系统用户对象
     * @param op   op
     */
    @RequestMapping("/saveUser")
    public void saveUser(User user, String op) {
        logger.info("保存用户信息...");
        //定义结果集合
        Map<String, Object> resultMap = new HashMap<>(16);
        //获取用户数量
        int count = userService.getUserNumber(user, op);
        //修改用户信息
        if (Constants.OP_MODIFY.equals(op)) {
            //设置修改时间
            user.setUpdateDate(DateUtil.getSystemTime());
            //执行修改用户信息操作
            int flag = userService.updateByPrimaryKeySelective(user);
            //判断是否修改成功
            resultMap = CommonUtil.checkUpdate(flag);
        } else {
            //添加用户信息
            if (count <= 0) {
                //设置创建时间和修改时间
                user.setCreateDate(DateUtil.getSystemTime());
                user.setUpdateDate(DateUtil.getSystemTime());
                //设置用户状态，默认为1
                user.setUserStatus(1);
                //设置用户密码，默认为1
                user.setUserPassword(MD5Util.getMD5("1"));
                //执行添加用户操作
                int flag = userService.insert(user);
                //判断是否添加成功
                resultMap = CommonUtil.checkSave(flag);
            } else {
                //用户名已经存在
                resultMap.put(Constants.RESULT_CODE, Constants.RETURN_FAIL_FLAG);
                resultMap.put(Constants.RESULT_MSG, "用户名已存在");
            }
        }
        System.out.println(resultMap);
        outJson(resultMap);
    }

    /**
     * 修改用户状态，启用或者禁用
     *
     * @param id 主键，用户编号
     */
    @RequestMapping("/modifyUserStatus")
    public void modifyUserStatus(int id) {
        logger.info("根据主键修改用户状态...");
        Map<String, Object> resultMap = new HashMap<>(16);
        //执行修改状态操作
        //获取当前用户
        User user = (User) session.getAttribute(Constants.LONGIN_USER);
        int flag = -1;
        if (user.getId() != id) {
            flag = userService.updateUserStatus(id);
        }
        resultMap.put("msg", flag);
        //输出返回结果至页面
        outJson(resultMap);
    }


    /**
     * 根据主键删除用户信息
     *
     * @param id 主键，用户编号
     */
    @RequestMapping("/delUser")
    public void delUser(int id) {
        logger.info("根据主键删除用户信息...");
        //定义结果集合
        Map<String, Object> resultMap;
        //执行删除操作
        int flag = userService.deleteByPrimiary(id);
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
    @RequestMapping("/batchDeleteUser")
    public void batchDeleteSysUser(String ids) {
        logger.info("批量删除用户信息...");
        //定义结果集合
        Map<String, Object> resultMap;
        //执行批量删除操作
        int flag = userService.batchDeleteUsers(ids);
        //判断是否删除成功
        resultMap = CommonUtil.checkDel(flag);
        //输出返回结果至页面
        outJson(resultMap);
    }

    /**
     * 用户赋予角色
     *
     * @param userId 用户id
     * @return
     */
    @RequestMapping("/userRole")
    public ModelAndView userRole(@RequestParam("id") int userId) {
        logger.info("跳转到赋角色页面...");
        ModelAndView view = new ModelAndView();
        //根据主键获得用户对象
        User user = userService.selectByPrimiary(userId);
        view.addObject("user", user);
        view.addObject("op", Constants.OP_MODIFY);
        view.setViewName("sys/user/user_role");
        return view;
    }

    /**
     * 显示当前用户的角色树
     *
     * @param userid userid
     * @return
     */
    @ResponseBody
    @RequestMapping("/getRoleById")
    public List<ZTreeNode> getRoleById(@RequestParam("userid") int userid) {
        logger.debug("初始化角色树...");
        List<ZTreeNode> roleTreeList = new ArrayList<>();
        List<Role> roleList = roleService.getAllRole();
        List<Role> roleOwn = roleService.getOwnRoleById(userid);
        for (Role role : roleList) {
            ZTreeNode zTreeNode = new ZTreeNode();
            zTreeNode.setId(role.getId());
            zTreeNode.setpId(0);
            zTreeNode.setName(role.getRoleName());
            zTreeNode.setOpen(false);
            zTreeNode.setNocheck(false);
            if (roleOwn != null && roleOwn.size() > 0) {
                for (Role role2 : roleOwn) {
                    if (role2.getRoleName().equals(role.getRoleName()) && role2.getId() == role.getId()) {
                        zTreeNode.setChecked(true);
                    }
                }
            } else {
                zTreeNode.setChecked(false);
            }
            roleTreeList.add(zTreeNode);
        }
        System.out.println(roleTreeList);
        return roleTreeList;
    }

    @RequestMapping("/giveRole")
    public void giveRole(int id, String roleIds) {
        logger.info("保存用户信息...");
        //定义结果集合
        Map<String, Object> resultMap = new HashMap<>(16);
        //获取用户数量
        //根据主键获得用户对象
        int count = userService.giveRole(id, roleIds);

        if (count > 0) {
            resultMap.put(Constants.RESULT_CODE, Constants.RESULT_SUCCESS_FLAG);
            resultMap.put(Constants.RESULT_MSG, "授权成功");
        } else {
            resultMap.put(Constants.RESULT_CODE, Constants.RETURN_FAIL_FLAG);
            resultMap.put(Constants.RESULT_MSG, "授权失败！");
        }
        outJson(resultMap);

    }
}
