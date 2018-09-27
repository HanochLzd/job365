package cn.soft.job.common.interceptor;

import cn.soft.job.common.utils.CommonUtil;
import cn.soft.job.common.utils.Constants;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * @author Hanoch
 * @version 1.0
 * @date 2018/9/27 15:31
 */
public class PortalReleaseInterceptor implements HandlerInterceptor {
    /**
     * 允许通过的url请求
     */
    private String[] allowUrls;

    public String[] getAllowUrls() {
        return allowUrls;
    }

    public void setAllowUrls(String[] allowUrls) {
        this.allowUrls = allowUrls;
    }

    @Override
    public void afterCompletion(HttpServletRequest arg0,
                                HttpServletResponse arg1, Object arg2, Exception arg3)
            throws Exception {
        // TODO Auto-generated method stub

    }

    @Override
    public void postHandle(HttpServletRequest arg0, HttpServletResponse arg1,
                           Object arg2, ModelAndView arg3) throws Exception {
        // TODO Auto-generated method stub

    }

    @Override
    public boolean preHandle(HttpServletRequest arg0, HttpServletResponse arg1,
                             Object arg2) throws Exception {
        // TODO Auto-generated method stub
        String requstUrl = arg0.getRequestURI();
        if (!CommonUtil.isNull(allowUrls)) {
            for (String url : allowUrls) {
                if (requstUrl.contains(url)) {
                    return true;
                }
            }
        }

        Object portalLoginUser = arg0.getSession().getAttribute(Constants.PROTAL_LONGIN_USER);
        if (CommonUtil.isNull(portalLoginUser)) {
            arg1.sendRedirect(arg0.getContextPath() + "/ptlLogin/toLogin.do");
        } else {
            return true;
        }
        return false;
    }
}
