package cn.soft.job.common.utils;

public class ParamUtil {

	public static String upload_image_path = "";
	public static String upload_module_image_path="";
	
	public static String upload_movie_path = "";
	
	public static String upload_document_path="";
	
	public static String upload_file_path = "";

	public static String user_password = "";
	
	//报表logo路径
	public static String report_logo = "";

	public static String index_path = "";

	public static String sql_file_path = "";
	
	// 邮件smtp服务器
	public static String mail_smtp_host = "";
	// 发件人
	public static String mail_from = "";
	// 授权码
	public static String mail_pass = "";

	// 爬虫服务器
	public static String crawl_host = "";
	// 爬虫服务器端口
	public static String crawl_port = "";
	
	// Id
	public static int totalId = 1;

	static {

		PropertiesUtil propertiesUtil = PropertiesUtil
				.getInstance("/conf/confing.properties");

		if (propertiesUtil.getValueByKey("path.upload_image_path") != null) {
			upload_image_path = propertiesUtil
					.getValueByKey("path.upload_image_path");
		}
		if (propertiesUtil.getValueByKey("path.upload_movie_path") != null) {
			upload_movie_path = propertiesUtil
					.getValueByKey("path.upload_movie_path");
		}
		if (propertiesUtil.getValueByKey("path.upload_document_path") != null) {
			upload_document_path = propertiesUtil
					.getValueByKey("path.upload_document_path");
		}
		if (propertiesUtil.getValueByKey("path.upload_module_image_path") != null) {
			upload_module_image_path = propertiesUtil
					.getValueByKey("path.upload_module_image_path");
		}
		
		if (propertiesUtil.getValueByKey("path.upload_file_path") != null) {
			upload_file_path = propertiesUtil
					.getValueByKey("path.upload_file_path");
		}

		if (propertiesUtil.getValueByKey("index_path") != null) {
			index_path = propertiesUtil.getValueByKey("index_path");
		}

		// 默认用户密码
		if (propertiesUtil.getValueByKey("user.password") != null) {
			user_password = propertiesUtil.getValueByKey("user.password");
		}
		
		//报表logo路径
		if (propertiesUtil.getValueByKey("report.logo") != null) {
			report_logo = propertiesUtil.getValueByKey("report.logo");
		}

		if (propertiesUtil.getValueByKey("crawl.host") != null) {
			crawl_host = propertiesUtil.getValueByKey("crawl.host");
		}

		if (propertiesUtil.getValueByKey("crawl.port") != null) {
			crawl_port = propertiesUtil.getValueByKey("crawl.port");
		}

		if (propertiesUtil.getValueByKey("mail.smtp.host") != null) {
			mail_smtp_host = propertiesUtil.getValueByKey("mail.smtp.host");
		}

		if (propertiesUtil.getValueByKey("mail.from") != null) {
			mail_from = propertiesUtil.getValueByKey("mail.from");
		}

		if (propertiesUtil.getValueByKey("mail.pass") != null) {
			mail_pass = propertiesUtil.getValueByKey("mail.pass");
		}
		
		if (propertiesUtil.getValueByKey("path.sql_file_path") != null){
			sql_file_path = propertiesUtil.getValueByKey("path.sql_file_path");
		}
		
		if (propertiesUtil.getValueByKey("totalId") != null){
			totalId = Integer.valueOf(propertiesUtil.getValueByKey("totalId"));
		}

	}

}
