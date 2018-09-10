package cn.soft.job.common.utils;

public class Constants {

    public static final String FILE_NAME = "FILE_NAME";
    //当前登录用户
    public static final String LONGIN_USER = "LONGIN_USER";
    //当前门户登录用户
    public static final String PROTAL_LONGIN_USER = "PROTAL_LONGIN_USER";

    public static final String LONGIN_IP = "LONGIN_IP";//登录IP

    public static final String LONGIN_HOST = "LONGIN_HOST";//登录计算机名

    public static final String OP = "op";//操作标志

    public static final String OP_ADD = "add";//新增

    public static final String OP_MODIFY = "modify";//修改

    public static final String OP_INIT = "init";//初始化

    public static final String OP_FILTER = "filter";//过滤

    public static final String RESULT_CODE = "code";

    public static final String RESULT_MSG = "msg";

    public static final String RESULT_SUCCESS_FLAG = "1";//成功标志

    public static final String RETURN_FAIL_FLAG = "0";//失败标志

    public static final String RESULT_ERROR_FLAG = "-1";//出错标志

    public static final String RESULT_NODATA_FLAG = "2";//暂无数据标志

    public static final String RESULT_SUCCESS = "success";

    public static final String RETURN_FAIL = "fail";

    public static final String RESULT_ERROR = "error";

    public static final String RESULT_SUCCESS_MSG = "操作成功！";

    public static final String RESULT_ERROR_MSG = "操作出错！";

    public static final String RESULT_FAIL_MSG = "操作失败！";

    public static final String SAVEPASSWORD_SUCCESS_MSG = "保存成功！所修改的用户名/密码将于下次登录时起效！";

    public static final String SAVE_SUCCESS_MSG = "添加成功！";

    public static final String SAVE_ERROR_MSG = "添加出错！";

    public static final String SAVE_FAIL_MSG = "添加失败！";

    public static final String UPDATE_SUCCESS_MSG = "修改成功！";

    public static final String UPDATE_SUCCESS_MSG_PWD = "修改成功！将于下次登录时起效！";

    public static final String UPDATE_ERROR_MSG = "修改出错！";

    public static final String UPDATE_FAIL_MSG = "修改失败！";

    public static final String RELEASE_FAIL_MSG = "发布失败，请联系管理员！";

    public static final String RELEASE_SUCCESS_MSG = "发布成功,经管理员审核后将在门户系统展示！";

    public static final String DEL_SUCCESS_MSG = "删除成功！";

    public static final String DEL_ERROR_MSG = "删除出错！";

    public static final String DEL_FAIL_MSG = "删除失败！";

    public static final String REVIEW_FAIL_MSG = "审核失败！";

    public static final String REVIEW_SUCCESS_MSG = "审核成功！";

    public static final String RESULT_NODATA_MSG = "暂无数据！";

    public static final String LONGIN_ERROR = "登录失败";

    public static final String NO_PRIVILEGE = "权限不够";

    public static final String UPLOAD_SUCCESS_MSG = "上传成功！";

    public static final String UPLOAD_ERROR_MSG = "上传失败！文件格式不对！";

    public static final String UPLOAD_ERROR_MSG1 = "上传失败！服务器错！";

    public static final String TIME_DAY_FLAG = "DAY";

    public static final String TIME_WEEK_FLAG = "WEEK";

    public static final String TIME_MONTH_FLAG = "MONTH";

    public static final String DEFAULT_STATUS_ENABLE = "1";//默认状态为启用

    public static final String DEFAULT_STATUS_DISABLE = "0";//默认状态为禁用

    public static final String DEFAULT_REPORT_STATUS = "0"; //简报默认状态为0

    public static final String DEFAULT_ARCHIVE_STATUS = "1"; //档案默认状态为1

    public static final Integer PORTAL_PAGE_NUM = 10; //门户网站列表页每页显示记录数

    /**
     * 用户状态 1：正常 非1：禁用
     */
    public static final Integer USER_NORMAL_CODE = 1;


    /*
     * 列表每页记录数，默认每页20条。
     */
    public final static int PER_PAGE_SIZE = 10;

    //标签开始
    public static final String STARTTAG = "<font style='color:red;font-weight:bold;'>";
    //标签结束
    public static final String ENDTAG = "</font>";

    //创建换行符
    public static final String LINE_SEPARATOR = "\r\n";

    /**
     * HTable表名
     */
    public static final String HTABLE_NAME = "hbaseTest2";

    /**
     * hbase小表  计算
     */
    public static final String HTABLE_COUNT_NAME = "hbaseTestCount2";

    /**
     * 常量 OK
     */
    public static final String OK = "OK";

    /**
     * 常量数字
     */
    public static final String ZERO = "0";

    public static final String ONE = "1";

    public static final String TWO = "2";

    public static final String THREE = "3";

    public static final String FOUR = "4";

    public static final String FIVE = "5";

    public static final String SIX = "6";

    public static final String SEVEN = "7";

    public static final String EIGHT = "8";

    public static final String NINE = "9";

    public static final String REPORT_STRING = "为帮助关注者理清事实，探析网络舆情，对本监测期的传媒表现做一初步分析，我们借助安恒舆情云监测平台进行。"
            + "本分析报告整合主流媒体及门户网站的同质新闻作统计分析，务求完整、客观展现网络舆情的全貌。"
            + "传播分析系以网络舆情监测系统监测到的与关键词相关的新闻、论坛、博客、平面媒体和微博的内容为基础，参考转载率数据和媒体权重等数据，"
            + "描绘出舆情发展的传播影响顺序，分析得出舆情传播路径，以展示网络舆论的形成脉络。本分析报告非严格意义的抽样调查研究，"
            + "其意义在于为正式的科学研究给出初探性结论；本研究的数据面向文章、网民、媒体的意见倾向，相关的意见结论未必与行为主体的行为选择成完全对应关系；"
            + "本研究基于当前资料及数据，而非完善的历时性研究。";

}
