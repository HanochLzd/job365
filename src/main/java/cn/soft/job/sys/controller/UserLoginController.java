package cn.soft.job.sys.controller;

import cn.soft.job.common.utils.CommonUtil;
import cn.soft.job.common.utils.Constants;
import cn.soft.job.common.utils.DateUtil;
import cn.soft.job.common.utils.MD5Util;
import cn.soft.job.sys.controller.base.BaseController;
import cn.soft.job.sys.mapper.RoleMapper;
import cn.soft.job.sys.pojo.po.Menu;
import cn.soft.job.sys.pojo.po.Role;
import cn.soft.job.sys.pojo.po.User;
import cn.soft.job.sys.service.MenuService;
import cn.soft.job.sys.service.RoleService;
import cn.soft.job.sys.service.UserService;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.regex.Pattern;

/**
 * @author Hanoch
 * @version 1.0
 * @date 2018/9/8 15:32
 */
@Controller
@RequestMapping("/login")
public class UserLoginController extends BaseController {

    private static Logger logger = Logger.getLogger(UserLoginController.class);

    @Autowired
    private UserService userService;

    @Autowired
    private MenuService menuService;

    @Autowired
    private RoleService roleService;

    @RequestMapping("/doRegister")
    public ModelAndView doregister() {
        logger.info("跳转到注册用户页面...");
        ModelAndView view = new ModelAndView();
        view.setViewName("login/register");
        return view;
    }


    @RequestMapping("/doLogin")
    public void doLogin(String userName, String password) {
        logger.info("处理用户登录请求...");
        //定义结果集合
        Map<String, Object> resultMap = new HashMap<>(16);

        //判断用户名密码、是否为空
        if (CommonUtil.isNull(userName) || CommonUtil.isNull(password)) {
            resultMap.put(Constants.RESULT_CODE, Constants.RETURN_FAIL_FLAG);
            //TODO 此处消息类型需要统一封装（统一管理->推荐使用全局异常管理）
            resultMap.put(Constants.RESULT_MSG, "用户名或密码不能为空！");
        } else {
            //根据用户名获取对象
            User user = userService.selectByUserName(userName);
            if (!CommonUtil.isNull(user)) {
                //判断密码是否正确
                if (MD5Util.getMD5(password).equals(user.getUserPassword())) {
                    if (!user.getUserStatus().equals(Constants.USER_NORMAL_CODE)) {
                        resultMap.put(Constants.RESULT_CODE, Constants.RETURN_FAIL_FLAG);
                        resultMap.put(Constants.RESULT_MSG, "该账户已被禁用，请联系管理员！");
                        logger.info(userName + "：该账户已被禁用，请联系管理员！，时间：" + DateUtil.getSystemTime());
                    } else {
                        resultMap.put(Constants.RESULT_CODE, Constants.RESULT_SUCCESS_FLAG);
                        resultMap.put(Constants.RESULT_MSG, "登录成功!");
                        session.setAttribute(Constants.LONGIN_USER, user);
                        logger.info(userName + "：登录成功，时间：" + DateUtil.getSystemTime());
                    }
                } else {
                    resultMap.put(Constants.RESULT_CODE, Constants.RETURN_FAIL_FLAG);
                    resultMap.put(Constants.RESULT_MSG, "密码错误!");
                    logger.info(userName + "：密码错误，时间：" + DateUtil.getSystemTime());
                }
            } else {
                resultMap.put(Constants.RESULT_CODE, Constants.RETURN_FAIL_FLAG);
                resultMap.put(Constants.RESULT_MSG, "当前用户不存在!");
                logger.info(userName + "：当前用户不存在，时间：" + DateUtil.getSystemTime());
            }
        }
        outJson(resultMap);
    }

    /**
     * 注册
     *
     * @param userName userName
     * @param password password
     * @param checkPwd checkPwd
     * @param usertype usertype
     */
    @RequestMapping("/register")
    public void register(String userName, String password, String checkPwd, String usertype) {
        logger.info("处理用户注册请求...");
        System.out.println("uType:" + usertype);
        Map<String, Object> resultMap = new HashMap<>(16);
        //判断用户名和密码是否为空
        User user = new User();
        user.setRealName(userName);
        user.setUserName(userName);
        user.setUserPassword(password);
        user.setUserStatus(1);

        //String regexUserName = "/^[a-zA-Z\u4e00-\u9fa5][a-zA-Z0-9_\u4E00-\u9FA5]{5,15}$/";
        // 昵称格式：限16个字符，支持中英文、数字、减号或下划线
        String regexUserName = "^[\\u4e00-\\u9fa5_a-zA-Z0-9-]{3,16}$";
        boolean matchesUserName = Pattern.matches(regexUserName, userName);
        System.out.println(matchesUserName);
        // 6-20 位，字母、数字、字符
        String regexPassword = "^([A-Z]|[a-z]|[0-9]|[`~!@#$%^&*()+=|{}':;',\\\\[\\\\].<>/?~！@#￥%……&*（）——+|{}【】‘；：”“’。，、？]){6,20}$";
        boolean matchesPassword = Pattern.matches(regexPassword, checkPwd);


        System.out.println(matchesPassword);
        if (CommonUtil.isNull(userName) || CommonUtil.isNull(password)) {
            resultMap.put("msg", "用户名或密码不能为空!");
            resultMap.put("status", false);
        } else {
            if (!matchesUserName) {
                resultMap.put("msg", "用户名格式错误!");
                resultMap.put("status", false);

            } else {
                if (!matchesPassword) {
                    resultMap.put("msg", "密码格式错误!");
                    resultMap.put("status", false);
                } else {
                    if (!password.equals(checkPwd)) {
                        resultMap.put("msg", "两密码不一致！");
                        resultMap.put("status", false);
                    } else {
                        String MD5pwd = MD5Util.getMD5(password);
                        user.setUserPassword(MD5pwd);
                        userService.insert(user);

                        User user2 = userService.selectByUserName(userName);
                        Integer userType = Integer.parseInt(usertype);
                        System.out.println("user2的Id————————》" + user2.getId());
                        try {
                            //普通用户  3
                            if (userType == 1) {
                                roleService.giveOneRole(user2.getId(), 3);
                            } else if (userType == 2) {
                                //企业用户
                                roleService.giveOneRole(user2.getId(), 2);
                            }
                        } catch (Exception e) {
                            e.printStackTrace();
                        }
                        resultMap.put("msg", "注册成功!");
                        resultMap.put("status", true);
                    }
                }
            }
        }
        outJson(resultMap);

    }

    /**
     * 菜单管理（不同的角色显示不同的菜单）
     *
     * @param session session
     * @return ModelAndView
     */
    @RequestMapping("/main/index")
    public ModelAndView index(HttpSession session) {
        ModelAndView modelAndView = new ModelAndView();
        User user = (User) session.getAttribute(Constants.LONGIN_USER);
        List<Menu> menuList = menuService.getAllMenu(user.getId());
        for (Menu menu : menuList) {
            List<Menu> menuChild = menuService.getAllChlidMenu(user.getId(), menu.getId());
            menu.setChildMenus(menuChild);
        }
        Role ownRole = roleService.getOwnRoleById(user.getId()).get(0);
        session.setAttribute(Constants.LONGIN_USER, user);
        session.setAttribute(Constants.LONGIN_USER_ROLE, ownRole.getRoleName());
        modelAndView.addObject("menuList", menuList);
        modelAndView.setViewName("main/index");
        return modelAndView;
    }

    /**
     * 修改密码
     */
    @RequestMapping("/changePassword")
    public String changePassword() {
        logger.info("修改密码操作...");
        return "login/changePassword";
    }

    /**
     * 保存修改密码
     * pwd1 原始密码
     * pwd2  pwd3 输入的新密码
     */
    @RequestMapping("/savePwd")
    public void savePwd(String pwd1, String pwd2, String pwd3) {
        logger.info("保存修改后的密码...");
        User user = (User) session.getAttribute(Constants.LONGIN_USER);
        System.out.println("密码：" + user.getUserPassword() + "-" + pwd1 + "-" + pwd2);
        //输出返回结果至页面
        outJson(userService.savePwd(user, pwd1, pwd2, pwd3));
    }

    /**
     * 欢迎页
     *
     * @return
     */
    @RequestMapping("/welcome")
    public String welcome() {
        return "main/desktop";
    }

    @RequestMapping("/exit")
    public String exit() {
        session.removeAttribute(Constants.LONGIN_USER);
        return "redirect:/";
    }

}
