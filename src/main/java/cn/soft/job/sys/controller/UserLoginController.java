package cn.soft.job.sys.controller;

import cn.soft.job.common.utils.CommonUtil;
import cn.soft.job.common.utils.Constants;
import cn.soft.job.common.utils.DateUtil;
import cn.soft.job.common.utils.MD5Util;
import cn.soft.job.sys.controller.base.BaseController;
import cn.soft.job.sys.pojo.po.User;
import cn.soft.job.sys.service.UserService;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.Map;

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

    @RequestMapping("/main/index")
    public ModelAndView index(HttpSession session) {
        ModelAndView modelAndView = new ModelAndView();
        return modelAndView;
    }

}
