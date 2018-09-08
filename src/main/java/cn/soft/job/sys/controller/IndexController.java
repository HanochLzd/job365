package cn.soft.job.sys.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

/**
 * @author Hanoch
 * @version 1.0
 * @date 2018/9/8 16:10
 */
@Controller
public class IndexController {

    /**
     * 主页
     *
     * @return
     */
    @RequestMapping("/")
    public String index() {
        return "/login/login";
    }
}
