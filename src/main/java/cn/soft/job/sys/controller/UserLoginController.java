package cn.soft.job.sys.controller;

import cn.soft.job.sys.controller.base.BaseController;
import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

/**
 * @author Hanoch
 * @version 1.0
 * @date 2018/9/8 15:32
 */
@Controller
@RequestMapping("/login")
public class UserLoginController extends BaseController {

    private static Logger logger = Logger.getLogger(UserLoginController.class);

    /**
     * 登录页面
     * TODO 为何这里的init不用加斜杠
     *
     * @return String
     */
    @RequestMapping("/init")
    public String init() {
        return "login/login";
    }

    @RequestMapping("/doRegister")
    public ModelAndView doregister() {
        logger.info("跳转到注册用户页面...");
        ModelAndView view = new ModelAndView();
        view.setViewName("login/register");
        return view;
    }
}
