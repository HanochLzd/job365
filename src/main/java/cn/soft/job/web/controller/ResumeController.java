package cn.soft.job.web.controller;

import java.util.HashMap;
import java.util.Map;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import cn.soft.job.common.utils.CommonUtil;
import cn.soft.job.common.utils.Constants;
import cn.soft.job.sys.controller.base.BaseController;
import cn.soft.job.web.pojo.po.Resume;
import cn.soft.job.web.service.ResumeService;


@Controller
@RequestMapping("/resume")
public class ResumeController extends BaseController {

    private Logger logger = Logger.getLogger(ResumeController.class);

    @Autowired
    private ResumeService resumeService;

    @RequestMapping("/index")
    public ModelAndView resumeList() {
        ModelAndView view = new ModelAndView();
        view.setViewName("web/resume/resume_list");
        return view;
    }

    @RequestMapping("/createResume")
    public ModelAndView createResume() {
        ModelAndView view = new ModelAndView();
        view.setViewName("web/resume/resume_create");
        return view;
    }

    /**
     * 获取简历列表 一、分页 分页的基本思想是根据datatable的页码及每页显示的行数，将数据从数据库分段提出，然后再填充到表格中，以达到分页的效果。
     * 这里需要用到datatable插件的几个属性：
     * "sEcho"：这个属性需要原封不动地传回给datatable，具体的作用我也不清楚，但是根据它值的变化情况来看，好像是一个操作次数的计数（
     * 之前我一直把它当做是pageindex来用，结果发现，不论我在datatable中是翻下一页还是翻上一页，它一直在增加。）
     * "iDisplayStart"：这个属性，根据字面意思理解，就是每段数据开始的行数，比如第一页的数据就是从0开始计，那么它就是0，每页显示的行数是10，
     * 那么第二页的第一行的iDisplayStart就是10。 "iDisplayLength"：这个属性就是每页显示的行数。
     * 然后是数据库操作，只需要从数据库查询其中一段数据，然后输出出来，转成JSON格式，让datatable插件获取。
     *
     * @param sEcho
     * @param iDisplayStart
     * @param iDisplayLength
     * @param resumeName
     * @param resumePosition
     * @param resumeWorkplace
     */
    @RequestMapping("/getResumeList")
    public void getResumeList(int sEcho, int iDisplayStart, int iDisplayLength, String resumeName,
                              String resumePosition, String resumeWorkplace) {
        System.out.println("终于进来了！" + resumeName + "---" + resumePosition + "---" + resumeWorkplace);
        String data = resumeService.getResumeList(sEcho, iDisplayStart, iDisplayLength, resumeName, resumePosition,
                resumeWorkplace);
        System.out.println("data:" + data);
        // 返回数据至页面
        out(data);
    }

    /**
     * 添加简历
     *
     * @return
     */
    @RequestMapping("/addResume")
    public ModelAndView addResume() {
        ModelAndView view = new ModelAndView();
        Resume resume = new Resume();
        view.addObject("resume", resume);

        view.addObject("op", Constants.OP_ADD);
        view.setViewName("web/resume/resume_add");
        return view;
    }

    /**
     * 保存简历信息
     */
    @RequestMapping("/saveResume")
    public void saveResume(Resume resume, String op) {
        logger.info("保存用户信息...");
        // System.out.println("op:"+resume.getResumeName() +
        // resume.getResumeSex()+resume.getResumeEmail());
        // 定义结果集合
        Map<String, Object> resultMap = new HashMap<String, Object>();
        // 获取用户数量
        int count = resumeService.getCountNumber(resume, op);
        System.out.println("count的数量:" + count);
        if (Constants.OP_MODIFY.equals(op)) {
            // 修改用户信息
            // 设置修改时间

            // user.setUpdateDate(DateUtil.getSystemTime());
            // 执行修改用户信息操作
            int flag = resumeService.updateByPrimaryKeySelective(resume);
            // 判断是否修改成功
            resultMap = CommonUtil.checkUpdate(flag);
        } else {

            // 添加用户信息
            if (count <= 0) {
                // 设置创建时间和修改时间
                // user.setCreateDate(DateUtil.getSystemTime());
                // user.setUpdateDate(DateUtil.getSystemTime());
                // 设置用户状态，默认为1
                String resumeStatus = "1";
                resume.setResumeStatus(resumeStatus);
                // 执行添加用户操作
                int flag = resumeService.insert(resume);
                // 判断是否添加成功
                resultMap = CommonUtil.checkSave(flag);
            } else {
                // 用户名已经存在
                resultMap.put(Constants.RESULT_CODE, Constants.RETURN_FAIL_FLAG);
                resultMap.put(Constants.RESULT_MSG, "用户名已存在！！！");
            }
        }

        // 将返回结果输出至页面
        outJson(resultMap);
    }

    /**
     * 跳转到修改简历页面
     *
     * @param id
     *            主键
     * @return user_add.jsp
     */
    /*
     * @RequestMapping("/modifyResume") public ModelAndView modifySysResume(int id){
     * logger.info("跳转到新增用户页面..."); ModelAndView view = new ModelAndView();
     * //根据主键获得用户对象 User user = resumeService.selectByPrimiary(id);
     *
     *
     *
     * view.addObject("user", user); view.addObject("op", Constants.OP_MODIFY);
     * view.setViewName("sys/user/user_add"); return view; }
     */

    /**
     * 修改简历状态，启用或者禁用
     *
     * @param id 主键，用户编号
     */
    @RequestMapping("/modifyResumeStatus")
    public void modifyResumeStatus(int id) {
        System.out.println("id:;:::" + id);
        logger.info("根据主键修改用户状态...");
        Map<String, Object> resultMap = new HashMap<String, Object>();
        // 执行修改状态操作
        int flag = resumeService.updateResumeStatus(id);
        resultMap.put("msg", flag);
        // 输出返回结果至页面
        outJson(resultMap);
    }

    /**
     * 根据主键删除简历信息
     *
     * @param id 主键，用户编号
     */
    @RequestMapping("/delResume")
    public void delResume(int id) {
        logger.info("根据主键删除用户信息...");
        // 定义结果集合
        Map<String, Object> resultMap = new HashMap<String, Object>();
        // 执行删除操作
        int flag = resumeService.deleteByPrimiary(id);
        // 判断删除是否成功
        resultMap = CommonUtil.checkDel(flag);
        // 输出返回结果至页面
        outJson(resultMap);
    }

    /**
     * 批量删除简历信息
     *
     * @param ids 主键字符串
     */
    @RequestMapping("/batchDeleteResume")
    public void batchDeleteResume(String ids) {
        logger.info("批量删除用户信息...");
        // 定义结果集合
        Map<String, Object> resultMap = new HashMap<String, Object>();
        // 执行批量删除操作
        int flag = resumeService.batchDeleteResume(ids);
        // 判断是否删除成功
        resultMap = CommonUtil.checkDel(flag);
        // 输出返回结果至页面
        outJson(resultMap);
    }

    /**
     * 跳转到修改用户页面
     *
     * @param id 主键
     * @return user_add.jsp
     */
    @RequestMapping("/modifyResume")
    public ModelAndView modifyResume(int id) {
        logger.info("跳转到新增用户页面...");
        ModelAndView view = new ModelAndView();
        // 根据主键获得用户对象
        Resume resume = resumeService.selectByPrimiary(id);
        view.addObject("resume", resume);
        view.addObject("op", Constants.OP_MODIFY);
        view.setViewName("web/resume/resume_add");
        return view;
    }

    /*
     * @RequestMapping("/exportResume") public ModelAndView exportResume(String
     * startDate,String endDate,String resumeName,HttpServletResponse response){
     *
     * resumeService.getExportList(startDate, endDate, resumeName, response);
     *
     * ModelAndView view = new ModelAndView(); //根据主键获得用户对象 Resume resume =
     * resumeService.selectByPrimiary(id); view.addObject("resume", resume);
     * view.addObject("op", Constants.OP_MODIFY);
     * view.setViewName("web/resume/resume_add"); return view; }
     */

}
