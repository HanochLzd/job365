package cn.soft.job.sys.controller.base;

import cn.soft.job.common.utils.JSONUtil;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.ModelAttribute;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Date;
import java.text.SimpleDateFormat;

/**
 * @author Hanoch
 * @version 1.0
 * @date 2018/9/8 14:48
 */
public class BaseController {

    protected HttpServletResponse response;
    protected HttpServletRequest request;
    protected HttpSession session;

    /**
     * 操作描述
     */
    protected String operDescription = "";


    /**
     * 日期格式化
     *
     * @param binder binder
     */
    @InitBinder
    public void initBinder(WebDataBinder binder) {
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm");
        dateFormat.setLenient(false);
        binder.registerCustomEditor(Date.class, new CustomDateEditor(dateFormat, true));
    }

    /**
     * 放置在方法上面：表示请求该类的每个Action前都会首先执行它，你可以将一些准备数据的操作放置在该方法里面
     *
     * @param response  response
     * @param request request
     */
    @ModelAttribute
    public void setReqAndResp(HttpServletResponse response, HttpServletRequest request) {
        this.response = response;
        this.request = request;
        this.session = request.getSession();
    }

    /**
     * 输出
     * @param value value
     */
    protected void out(String value) {
        PrintWriter out = null;
        try {
            response.setContentType("text/html;charset=UTF-8");
            out = response.getWriter();
            out.println(value);
        } catch (IOException e) {
            e.printStackTrace();
        } finally {
            if (out != null) {
                out.flush();
                out.close();
            }
        }
    }

    /**
     * 输出json格式
     * @param obj obj
     */
    protected void outJson(Object obj) {
        out(JSONUtil.getJson(obj));
    }

}
