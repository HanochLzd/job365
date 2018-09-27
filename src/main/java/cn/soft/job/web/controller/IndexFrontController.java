package cn.soft.job.web.controller;

import cn.soft.job.common.utils.MD5Util;
import cn.soft.job.sys.controller.base.BaseController;
import cn.soft.job.sys.pojo.po.User;
import cn.soft.job.sys.service.RoleService;
import cn.soft.job.sys.service.UserService;
import cn.soft.job.web.pojo.po.Category;
import cn.soft.job.web.pojo.po.News;
import cn.soft.job.web.pojo.po.Position;
import cn.soft.job.web.service.CategoryService;
import cn.soft.job.web.service.NewsService;
import cn.soft.job.web.service.PositionService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.sql.Timestamp;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @author Hanoch
 */
@Controller
@RequestMapping("/index")
public class IndexFrontController extends BaseController {

    @Autowired
    private UserService userService;

    @Autowired
    private NewsService newsService;

    @Autowired
    private CategoryService categoryService;

    @Autowired
    private PositionService positionService;

    @Autowired
    private RoleService roleService;

    @RequestMapping("/main")
    public ModelAndView index(HttpServletRequest request, HttpServletResponse response) {
        ModelAndView model = new ModelAndView();
        List<Position> positionList = positionService.getAllPosition(0, 8);
        model.addObject("positionList", positionList);
        model.setViewName("front/index_1");
        return model;
    }

    @RequestMapping("/frontlogin")
    public void frontlogin(HttpServletRequest request, HttpServletResponse response) {
        Map<String, Object> resultMap = new HashMap<String, Object>();
        String uname = request.getParameter("username");
        String password = request.getParameter("password");

        System.out.println("uname:--->" + uname);
        User user = userService.selectByUserName(uname);

        if (user == null) {
            resultMap.put("status", false);
            resultMap.put("msg", "用户不存在！");
        } else {
            if (MD5Util.getMD5(password).equals(user.getUserPassword())) {
                resultMap.put("status", true);
                request.getSession().setAttribute("user", user);
            } else {
                resultMap.put("status", false);
                resultMap.put("msg", "密码错误！");
            }
        }
        outJson(resultMap);
    }

    @RequestMapping("/loginout")
    public void loginout(HttpServletRequest request, HttpServletResponse response) {
        Map<String, Object> resultMap = new HashMap<String, Object>();
        request.getSession().removeAttribute("user");
        resultMap.put("status", true);
        outJson(resultMap);
    }

    @RequestMapping("/toregister")
    public ModelAndView toregister(HttpServletRequest request, HttpServletResponse response) {
        ModelAndView mav = new ModelAndView();
        mav.setViewName("front/register");
        return mav;
    }

    @RequestMapping("/tonewsmain")
    public ModelAndView tonewsmain(HttpServletRequest request, HttpServletResponse response) {
        ModelAndView mav = new ModelAndView();
        String curpage = request.getParameter("curpage");
        if (curpage == null) {
            curpage = "1";
        }
        int totalpages = 1;
        try {
            Integer cp = Integer.parseInt(curpage);
            List<News> newslist = newsService.getPageList((cp - 1) * 5, 5);
            int newsconut = newsService.getPagesCount();
            if (newsconut % 5 == 0) {
                totalpages = newsconut / 5;
            } else {
                totalpages = newsconut / 5 + 1;
            }
            mav.addObject("totalpages", totalpages);
            mav.addObject("curpage", curpage);
            mav.addObject("newslist", newslist);
        } catch (Exception e) {
            e.printStackTrace();
        }
        mav.setViewName("front/news");
        return mav;
    }

    @RequestMapping("/tonewsdetail")
    public ModelAndView tonewsdetail(HttpServletRequest request, HttpServletResponse response) {
        ModelAndView mav = new ModelAndView();
        String id = request.getParameter("id");
        if (id == null) {
            id = "1";
        }
        try {
            Integer cp = Integer.parseInt(id);
            News news = newsService.selectByPrimiary(cp);
            mav.addObject("news", news);
        } catch (Exception e) {
            e.printStackTrace();
        }
        mav.setViewName("front/newsdetail");
        return mav;
    }

    @RequestMapping("/tojobmain")
    public ModelAndView tojobmain(HttpServletRequest request, HttpServletResponse response) {
        ModelAndView mav = new ModelAndView();
        String curpage = request.getParameter("curPage");
        List<Category> getcate1list = categoryService.getAllCategory(1);
        List<Category> getcate2list = categoryService.getAllCategory(2);
        if (curpage == null) {
            curpage = "1";
        }
        int totalpages = 0;
        try {
            int start = Integer.parseInt(curpage);
            List<Position> positionlist = positionService.getAllPosition((start - 1) * 12, 12);
            Integer count = positionService.getPositionCount();
            if (count % 12 == 0) {
                totalpages = count / 12;
            } else {
                totalpages = count / 12 + 1;
            }
            mav.addObject("totalpages", totalpages);
            mav.addObject("curpage", curpage);
            mav.addObject("positionlist", positionlist);
        } catch (Exception e) {
            e.printStackTrace();
        }

        mav.addObject("cate1list", getcate1list);
        mav.addObject("cate2list", getcate2list);
        mav.setViewName("front/jobmain");
        return mav;
    }

    @RequestMapping("/getpagejobdata")
    public void getpagejobdata(HttpServletRequest request, HttpServletResponse response) {
        Map<String, Object> resultMap = new HashMap<String, Object>();
        String curpage = request.getParameter("curpage");
        if (curpage == null) {
            curpage = "1";
        }
        int totalpages = 1;
        try {
            Integer cp = Integer.parseInt(curpage);
            List<Position> positionlist = positionService.getAllPosition((cp - 1) * 12, 12);
            Integer count = positionService.getPositionCount();
            if (count % 12 == 0) {
                totalpages = count / 12;
            } else {
                totalpages = count / 12 + 1;
            }
            resultMap.put("totalpages", totalpages);
            resultMap.put("curpage", curpage);
            resultMap.put("positionlist", positionlist);
            resultMap.put("status", true);
        } catch (Exception e) {
            e.printStackTrace();
        }
        outJson(resultMap);
    }

    @RequestMapping("/getpagedata")
    public void getpagedata(HttpServletRequest request, HttpServletResponse response) {
        Map<String, Object> resultMap = new HashMap<>(16);
        String curpage = request.getParameter("curpage");
        if (curpage == null) {
            curpage = "1";
        }
        int totalpages = 1;
        try {
            Integer cp = Integer.parseInt(curpage);
            List<News> newslist = newsService.getPageList((cp - 1) * 5, 5);
            int newsconut = newsService.getPagesCount();
            if (newsconut % 5 == 0) {
                totalpages = newsconut / 5;
            } else {
                totalpages = newsconut / 5 + 1;
            }
            resultMap.put("totalpages", totalpages);
            resultMap.put("curpage", curpage);
            resultMap.put("newslist", newslist);
            resultMap.put("status", true);
        } catch (Exception e) {
            e.printStackTrace();
        }
        outJson(resultMap);
    }

    @RequestMapping("/register")
    public void register(HttpServletRequest request, HttpServletResponse response) {
        Map<String, Object> resultMap = new HashMap<>(16);
        String username = request.getParameter("name");
        String pwd = request.getParameter("password");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String usertype = request.getParameter("usertype");
        User user = userService.selectByUserName(username);
        if (user != null) {
            resultMap.put("msg", "注册失败，该用户已经被注册过！");
            resultMap.put("status", false);
        } else {
            User u = new User();
            u.setEmail(email);
            u.setUserPassword(MD5Util.getMD5(pwd));
            u.setUserName(username);
            u.setUserStatus(1);
            u.setPhone(phone);
            Date date = new Date();
            u.setCreateDate(new Timestamp(date.getTime()));
            Integer userType = Integer.parseInt(usertype);
            u.setRemark(usertype);
            userService.insert(u);
            User user2 = userService.selectByUserName(username);
            System.out.println("user2的Id————————》" + user2.getId());
            try {

//				if(userType==1){//普通用户  3
//
//					roleService.giveOneRole(user2.getId(),3);
//				}else if(userType==2){//企业用户
//					roleService.giveOneRole(user2.getId(),2);
//				}
			/*try{
				Integer role = Integer.parseInt(usertype);*/
                //u.setRole(role);
            } catch (Exception e) {
                e.printStackTrace();
            }
            //userService.insert(u);
            resultMap.put("status", true);
        }
        outJson(resultMap);
    }

    @RequestMapping("/getdatebycate")
    public void getdatebycate(HttpServletRequest request, HttpServletResponse response) {
        Map<String, Object> resultMap = new HashMap<String, Object>();
        String curpage = request.getParameter("curpage");
        String cate1 = request.getParameter("cate1");
        String cate2 = request.getParameter("cate2");
        if (curpage == null) {
            curpage = "1";
        }
        int totalpages = 1;
        try {
            Integer cp = Integer.parseInt(curpage);
            Integer c1 = Integer.parseInt(cate1);
            Integer c2 = Integer.parseInt(cate2);
            List<Position> positionlist = positionService.getPositionByCate(c1, c2, (cp - 1) * 12, 12);
            Integer count = positionService.getCountByCate(c1, c2);
            if (count % 12 == 0) {
                totalpages = count / 12;
            } else {
                totalpages = count / 12 + 1;
            }
            resultMap.put("totalpages", totalpages);
            resultMap.put("curpage", curpage);
            resultMap.put("positionlist", positionlist);
            resultMap.put("status", true);
        } catch (Exception e) {
            e.printStackTrace();
        }
        outJson(resultMap);
    }

    @RequestMapping("/tojobdetail")
    public ModelAndView tojobdetail(HttpServletRequest request, HttpServletResponse response) {
        ModelAndView mav = new ModelAndView();
        mav.setViewName("front/jobdetail");
        return mav;
    }
}
