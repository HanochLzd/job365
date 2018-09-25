package cn.soft.job.web.service.impl;

import java.io.OutputStream;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFCellStyle;
import org.apache.poi.hssf.usermodel.HSSFFont;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.hssf.util.HSSFColor;
import org.apache.poi.ss.util.CellRangeAddress;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import cn.soft.job.common.utils.CommonUtil;
import cn.soft.job.common.utils.DateUtil;
import cn.soft.job.common.utils.JSONUtil;
import cn.soft.job.web.mapper.ResumeMapper;
import cn.soft.job.web.pojo.po.Resume;
import cn.soft.job.web.service.ResumeService;

@Service("resumeService")
public class ResumeServiceImpl implements ResumeService {

	private Logger logger = Logger.getLogger(ResumeServiceImpl.class);

	@Autowired
	private ResumeMapper resumeDao;

	public String getResumeList(int sEcho, int start, int limit, String resumeName, String resumePosition,
			String resumeWorkplace) {
		// System.out.println("resumeName的值："+resumeName);
		// TODO Auto-generated method stub
		// 定义参数集合
		Map<String, Object> paramsMap = new HashMap<String, Object>();
		// 获取分页参数
		// PageUtil pageUtil = CommonUtil.getPage(page, pagesize);
		// 将分页参数和简历编号封装入参数集合
		paramsMap.put("start", start);
		paramsMap.put("limit", limit);
		paramsMap.put("resumeName", resumeName);
		paramsMap.put("resumePosition", resumePosition);
		paramsMap.put("resumeWorkplace", resumeWorkplace);
		// System.out.println("----->"+paramsMap.get("resumeName"));
		// paramsMap.put("resumeId", resumeId);
		List<Resume> resumeList = null;
		// 获取用户数量
		int count = getCount(paramsMap);
		if (count <= 0) {
			resumeList = new ArrayList<Resume>();
		} else {
			// 获取分页内容
			// System.out.println("resumeList");
			resumeList = resumeDao.getList(paramsMap);
			System.out.println("resumeList的size:" + resumeList.size());
			if (null == resumeList || resumeList.isEmpty()) {
				resumeList = new ArrayList<Resume>();
			}
		}
		return JSONUtil.getDataTableJson(resumeList, sEcho, count);
	}

	private int getCount(Map<String, Object> paramsMap) {
		// TODO Auto-generated method stub
		int count = resumeDao.getCount(paramsMap);
		System.out.println("count的值：" + count);
		// return resumeDao.getCount(paramsMap);
		return count;
	}

	public int deleteByPrimiary(int id) {
		// TODO Auto-generated method stub
		return resumeDao.deleteByPrimiary(id);
	}

	public int batchDeleteResume(String ids) {
		// TODO Auto-generated method stub
		logger.info("批量删除用户信息...");
		String[] idArr = ids.split(",");
		return resumeDao.batchDeleteResume(idArr);
	}

	public int updateResumeStatus(int id) {
		// TODO Auto-generated method stub
		System.out.println("id:;updateResumeStatus----" + id);
		return resumeDao.updateResumeStatus(id);
	}

	public int getCountNumber(Resume resume, String op) {
		// TODO Auto-generated method stub
		logger.info("获取用户数量 ...");
		// 定义参数集合
		Map<String, Object> paramsMap = new HashMap<String, Object>();
		// 将用户编号、用户名和操作类型封装入参数集合
		paramsMap.put("id", resume.getId());
		paramsMap.put("resumeName", resume.getResumeName());
		paramsMap.put("op", op);
		return resumeDao.getCountNumber(paramsMap);
	}

	public int updateByPrimaryKeySelective(Resume resume) {
		// TODO Auto-generated method stub
		logger.info("根据主键有选择的更新用户简历信息...");
		return resumeDao.updateByPrimaryKeySelective(resume);
	}

	public int insert(Resume resume) {
		// TODO Auto-generated method stub
		return resumeDao.insert(resume);
	}

	public Resume selectByPrimiary(int id) {
		// TODO Auto-generated method stub
		return resumeDao.selectByPrimiary(id);
	}

//	public void getExportList(String startTime, String endTime, String resumeName, HttpServletResponse response) {
//		// TODO Auto-generated method stub
//		Map<String, Object> paramsMap = new HashMap<String, Object>();
//		// 创建一个webbook，对应一个Excel文件，创建格式，规定文件名
//		HSSFWorkbook wb = new HSSFWorkbook();
//		// 设置样式
//		HSSFCellStyle alignCenter = wb.createCellStyle();
//		// 创建列
//		HSSFCell cell = null;
//
//		// 创建居中格式
//		alignCenter.setAlignment(HSSFCellStyle.ALIGN_CENTER);
//		alignCenter.setFillBackgroundColor(HSSFColor.LIGHT_GREEN.index);
//
//		// 创建左对齐格式
//		HSSFCellStyle alignLeft = wb.createCellStyle();
//		alignLeft.setAlignment(HSSFCellStyle.ALIGN_LEFT);
//
//		// 初始化文件名和单元格对象
//		String fileName = "签到信息列表.xls";
//
//		// 在webbook中添加一个sheet,对应Excel文件中的sheet，也就是左下角便签的名称
//		HSSFSheet sheet = wb.createSheet("签到信息列表");
//		// 生成一个字体
//		HSSFFont font = wb.createFont();
//		// 字体颜色
//		font.setColor(HSSFColor.BLACK.index);
//		// 字体增粗
//		font.setFontHeightInPoints((short) 14);
//		font.setBoldweight(HSSFFont.BOLDWEIGHT_NORMAL);
//		// 把字体应用到当前的样式
//		alignCenter.setFont(font);
//		// 获取导出的开始时间
//		Date startDate = DateUtil.toDate(DateUtil.getBeginTimeOfDay(startTime), DateUtil.YYYY_MM_DD_HH_MM_SS);
//		System.out.println(startDate);
//		// 获取导出的结束时间
//		Date endDate = DateUtil.toDate(DateUtil.getEndTimeOfDay(endTime), DateUtil.YYYY_MM_DD_HH_MM_SS);
//		// 获取导出开始时间与导出结束时间相差天数
//		int totalDays = DateUtil.findDates(startDate, endDate).size();
//
//		// 设置列宽
//		sheet.setColumnWidth(0, 5000);
//		for (int i = 1; i <= totalDays; i++) {
//			sheet.setColumnWidth(i, 5000);
//		}
//		sheet.setColumnWidth(totalDays, 3000);
//		sheet.setColumnWidth(totalDays + 1, 3000);
//
//		// 在sheet中添加表头第0行
//		HSSFRow row = sheet.createRow((int) 0);
//		// 在sheet中添加表头第1行
//		HSSFRow row1 = sheet.createRow((int) 1);
//
//		// 获取需要导出的数据
//		paramsMap.put("startDate", startDate);
//		paramsMap.put("endDate", endDate);
//		List<Map<String, Object>> signs = new ArrayList<Map<String, Object>>();
//		try {
//			// signs = signInfoDao.getListToExport(paramsMap);
//			logger.info("exportSignInfoList:" + "flag:成功！");
//		} catch (Exception ex) {
//			logger.info("exportSignInfoList:" + "flag:失败！" + ",reason:数据库连接失败");
//		}
//
//		// 创建表头单元格
//		CommonUtil.setResponseHeader(response, fileName);
//		cell = setTh(cell, "用户姓名", row, 0, alignCenter);
//		cell = setTh(cell, "签到时间统计", row, 1, alignCenter);
//
//		// 封装表头日期
//		List<String> thDates = new ArrayList<String>();
//
//		// 获取导出时间段内的日期，并分割出日期字符串中的mm-dd放入list中
//		List<Date> days = new ArrayList<Date>();
//		days = DateUtil.findDates(startDate, endDate);
//		for (int i = 0, j = 1; i < totalDays; i++, j++) {
//			cell = setTh(cell, DateUtil.toStr(days.get(i)).substring(5, 10), row1, j, alignCenter);
//			// 将表头日期封装到list里面
//			thDates.add(DateUtil.toStr(days.get(i)).substring(5, 10));
//		}
//		cell = setTh(cell, "迟到次数", row, totalDays, alignCenter);
//		cell = setTh(cell, "缺勤次数", row, totalDays + 1, alignCenter);
//
//		/**
//		 * 合并单元格 CellRangeAddress(int firstRow,int lastRow,int firstCol,int lastCol)
//		 */
//		sheet.addMergedRegion(new CellRangeAddress(0, 1, 0, 0));
//		sheet.addMergedRegion(new CellRangeAddress(0, 0, 1, (totalDays - 1)));
//		sheet.addMergedRegion(new CellRangeAddress(0, 1, totalDays, totalDays));
//		sheet.addMergedRegion(new CellRangeAddress(0, 1, (totalDays + 1), (totalDays + 1)));
//
//		// 用set存放realName
//		Set<Object> set = new HashSet<Object>();
//		for (Map<String, Object> map : signs) {
//			set.add(map.get("realName"));
//		}
//
//		// 定义行号
//		int rowNum = 1;
//		// 循环输出信息，以行为单位
//		for (Object realNameObj : set) {
//			row = sheet.createRow((int) rowNum + 1);
//			cell = setTd(cell, realNameObj.toString(), row, 0, alignCenter);
//			for (Map<String, Object> map : signs) {
//				if (realNameObj.equals(map.get("realName")) || realNameObj == map.get("realName")) {
//					if (!CommonUtil.isNull(map.get("signInTime"))) {
//						for (int column = 0; column < totalDays; column++) {
//							String topTime = DateUtil.toStr(days.get(column)).substring(0, 10);
//							if (topTime.equals(map.get("signInTime").toString().substring(0, 10))) {
//								cell = setTd(cell,
//										DateUtil.toStr(DateUtil.toDate(map.get("signInTime") + "",
//												DateUtil.YYYY_MM_DD_HH_MM_SS)).substring(11, 19),
//										row, column + 1, alignCenter);
//							}
//						}
//					}
//				}
//			}
//			// 迟到次数
//			paramsMap.put("realName", realNameObj.toString());
//			// cell = setTd(cell, Integer.toString(signInfoDao.getLateNum(paramsMap)), row,
//			// totalDays, alignCenter);
//			// 缺勤次数,由于缺勤次数无法统计出来，故将该列置空
//			cell = setTd(cell, "", row, totalDays + 1, alignCenter);
//			rowNum++;
//		}
//
//		// 将文件存到指定位置
//		try {
//			OutputStream os = response.getOutputStream();
//			wb.write(os);
//			os.flush();
//			os.close();
//			wb.close();
//		} catch (Exception e) {
//			e.printStackTrace();
//		}
//	}

	// 创建表体单元格，并设置值，循环所有行

	/**
	 * 设置表头单元
	 * 
	 * @param cell
	 * @param val
	 * @param row
	 * @param index
	 * @param style
	 * @return
	 */
	private HSSFCell setTh(HSSFCell cell, String val, HSSFRow row, int index, HSSFCellStyle style) {
		cell = row.createCell(index);
		cell.setCellValue(val);
		cell.setCellStyle(style);
		return cell;
	}

	/**
	 * 设置表体单元格
	 * 
	 * @param cell
	 * @param val
	 * @param row
	 * @param index
	 * @param style
	 * @return
	 */
	private HSSFCell setTd(HSSFCell cell, String val, HSSFRow row, int index, HSSFCellStyle style) {
		cell = row.createCell(index);
		if (!CommonUtil.isNull(val)) {
			cell.setCellValue(val);
		} else {
			cell.setCellValue("");
		}
		cell.setCellStyle(style);
		return cell;
	}

}
