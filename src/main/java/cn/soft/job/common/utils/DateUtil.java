package cn.soft.job.common.utils;

import java.io.File;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.*;

public class DateUtil {
	
	/**
	 * 日期格式
	 */
	public static final String YYYY_MM = "yyyy-MM";

	/**
	 * 日期格式
	 */
	public static final String YYYY_MM_DD = "yyyy-MM-dd";
	
	/**
	 * 日期格式
	 */
	public static final String YYYY_MM_DD_HH_MM_SS = "yyyy-MM-dd HH:mm:ss";
	
	public static final String YYYY_MM_DD1 = "YYYY/MM/DD";
	
	/**
	 * 日期格式
	 */
	public static final String YYYY_MM_DD_HH_MM = "yyyy-MM-dd HH:mm";
	
	/**
	 * 日期格式
	 */
	public static final String YYYY_MM_DD_HH_MM_SSS = "yyyyMMddHHmmsss";
	
	/**
	 * 日期格式
	 */
	public static final String YYYYMM = "yyyyMM";

	/**
	 * 日期格式
	 */
	public static String YYYYMMDD = "yyyyMMdd";
	
	/**
	 * 日期格式： xxxx年xx月xx日
	 */
	public static final String DATE_FORMAT_EIGHTEEN = "yyyy年MM月dd日";

	/**
	 * 获取时间格式："yyyy/MM/dd"
	 * @param date
	 * @return
	 */
	public static Date toDate(String date){  	

		return toDate(date, YYYY_MM_DD1);
	}

	/**
	 * 将日期转化成特定格式："yyyy-MM-dd HH:mm:ss"
	 */
	public static Date toOneDate(Date date){
		String dateStr = toStr(date);
		System.out.println( toDate(dateStr,"yyyy-MM-dd HH:mm:ss")+"...");
		return toDate(dateStr,"yyyy-MM-dd HH:mm:ss");
	}
	
	/**
	 * ※日期的字符串格式转Date对象实例
	 * 
	 * @param date
	 *            字符串格式的日期
	 * @param pattern
	 *            日期格式
	 * @return 返回Date对象实例
	 */
	public static Date toDate(String date, String pattern) {
		Date date2;

		if (isEmpty(pattern)) {
			pattern = YYYY_MM_DD_HH_MM_SS;
		}
		try {
			if (date != null && !date.equals("")) {
				SimpleDateFormat sdf = new SimpleDateFormat(pattern);
				date2 = sdf.parse(date);
			} else {
				date2 = toLocalDate(new Date(), pattern);
			}
		} catch (Exception e) {
			e.printStackTrace();
			return new Date();
		}
		return date2;
	}

	/**
	 * 日期的字符串格式转Date对象实例
	 * @param date
	 * @return
	 */
	public static String toStr(Date date) {
		return toStr(date, YYYY_MM_DD_HH_MM_SS);
	}
	/**
	 * 日期的字符串格式转Date对象实例
	 * @param date
	 * @return yyyy-MM-DD
	 */
	public static String toMDS(Date date) {
		return toStr(date, YYYY_MM_DD);
	}

	/**
	 * 日期的字符串格式转Date对象实例
	 * @param date
	 * @param pattern
	 * @return
	 */
	public static String toStr(Date date, String pattern) {
		String date2 = "";

		if (isEmpty(pattern)) {
			pattern = YYYY_MM_DD_HH_MM_SS;
		}

		if (date != null && !date.equals("")) {
			SimpleDateFormat sdf = new SimpleDateFormat(pattern);
			date2 = sdf.format(date);
		}

		return date2;
	}

	//得到系统时间
	public  static Date getSystemTime() {
		Calendar now = Calendar.getInstance();
		return now.getTime();
	}

	//得到系统时间
	public  static Date getMinTime() {
		Calendar date = Calendar.getInstance();
		date.set(1997, 1, 1);
		return date.getTime();
	}

	public static String DateNow() {
		return toStr(getSystemTime(), YYYY_MM_DD_HH_MM_SS) ;
	}

	/**
	 * ※其他地区时间转成北京时间
	 * 
	 * @param date
	 *            日期实例对象
	 * @param pattern
	 *            日期格式
	 */
	public static Date toLocalDate(Date date, String pattern) {
		SimpleDateFormat sdf = new SimpleDateFormat(pattern);
		TimeZone zone = new SimpleTimeZone(28800000, "Asia/Shanghai");// +8区
		sdf.setTimeZone(zone);
		String sdate = sdf.format(date);

		SimpleDateFormat sdf2 = new SimpleDateFormat(pattern);
		try {
			return sdf2.parse(sdate);
		} catch (Exception e) {
			e.printStackTrace();
			return new Date();
		}
	}

	/**
	 * 获取年月日结构路径片段
	 * @return
	 */
	public static String getDatePath(){
		Calendar calendar = Calendar.getInstance();

		String path = "";
		int year = calendar.get(Calendar.YEAR);
		path = year+"";
		int month = calendar.get(Calendar.MONTH)+1;
		if(month<10)
			path = path+File.separator+"0"+month;
		else {
			path = year+File.separator+month;
		}
		int day = calendar.get(Calendar.DATE);
		if(day<10)
			return path+File.separator+"0"+day+File.separator;
		else {
			return path+File.separator+day+File.separator;
		}
	}

	/**
	 * 返回毫秒
	 * @param date
	 * @return
	 */
	public static long getMillis(Date date) {
		Calendar c = Calendar.getInstance();
		c.setTime(date);
		return c.getTimeInMillis();
	}

	private static boolean isEmpty(String str) {
		if (str != null && str.trim().length() > 0) {
			return false;
		}
		return true;
	}

	/**
	 * 获取某一天的开始时间 即 00:00:00 create by zhaoheng
	 * @return
	 */
	public static String getBeginTimeOfToday(){
		String nowTime = DateNow();
		String [] arr = nowTime.split(" ");
		StringBuffer sb = new StringBuffer(arr[0]);
		sb.append(" 00:00:00");
		String beginTimeOfToday = sb.toString();
		return beginTimeOfToday;
	}

	/**
	 * 获取本周一的开始时间 00:00:00 create by zhaoheng 2015-12-14 09:23
	 * @return
	 */
	public static String getMondayOfThisWeek() {
		return getMonday() + " " + "00:00:00";
	}

	/**
	 * 获取本周一的开始时间
	 * @return
	 */
	public static String getMonday() {
		//获得日历实例
		Calendar calender = Calendar.getInstance();
		//获得今天是周几 默认周日是1，周一是2，...周六是7
		int dayOfWeek = calender.get(Calendar.DAY_OF_WEEK);
		if ((dayOfWeek - 1) == 0){
			 dayOfWeek = 7;
		}else{
			dayOfWeek --;
		}
		//获得周一的日期
		calender.add(Calendar.DATE, -dayOfWeek + 1);
		//创建日期格式化
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		//格式化日期
		String monday = sdf.format(calender.getTime());
		//分割时间字符串
		String [] timeArr = monday.split(" ");
		String time = null;
		if(timeArr.length > 0 && null != timeArr){
			time = timeArr[0];
		}
		return time;
	}

	/**
	 * 获取本月1号开始时间 00:00:00
	 * @return
	 */
	public static String getMonthOfFisrtday() {
		return getMonthOfFisrt() + " " + "00:00:00";
	}

	/**
	 * 获取本月1号
	 * @return
	 */
	public static String getMonthOfFisrt() {
		//获得日历实例
		Calendar calender = Calendar.getInstance();
		calender.add(Calendar.MONTH, 0);
		calender.set(Calendar.DAY_OF_MONTH, 1);//设置1号为本月第一天

		//创建日期格式化
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		//格式化日期
		String monday = sdf.format(calender.getTime());
		//分割时间字符串
		String [] timeArr = monday.split(" ");
		String time = null;
		if(timeArr.length > 0 && null != timeArr){
			time = timeArr[0];
		}
		return time;
	}

	/**
	 * 获取某年的第一天的开始时间
	 */
	public static String getBeginTimeOfYear(){
		//获得日历实例
	    Calendar calender = Calendar.getInstance();
	    int year = calender.get(Calendar.YEAR);
		String time = year + "-01-01 00:00:00";
		return time;
	}

	/**

	/**
	 * 获取本月有多少天
	 * @return
	 */
	public static int getMonthLastDay() {
		//获得日历实例
		Calendar calender = Calendar.getInstance();
		calender.set(Calendar.DATE, 1);////设置1号为本月第一天
		calender.roll(Calendar.DATE, -1);

		return calender.get(Calendar.DATE);
	}


	/**
	 * 获取今天是几号
	 * @return
	 */
	public static int getCurrentDayOfMonth() {
		Calendar calender = Calendar.getInstance();
		return calender.get(Calendar.DAY_OF_MONTH);
	}

	/**
	 * 指定日期加一天
	 * @return
	 */
	public static String addOneDay(String startDate) {
		Date date = DateUtil.toDate(startDate, DateUtil.YYYY_MM_DD_HH_MM_SS);
		Calendar calender = Calendar.getInstance();
		calender.setTime(date);
		calender.add(Calendar.DATE, 1);
		return DateUtil.toStr(calender.getTime(), DateUtil.YYYY_MM_DD_HH_MM_SS);
	}

	/**
	 * 获取某天开始时间 00:00:00
	 * @param day
	 * @return
	 */
	public static String getBeginTimeOfDay(String day) {
		String time = "";
	    time = day + " " + "00:00:00";
		return time;
	}

	/**
	 * 获取某天结束时间 23:59:59
	 * @param day
	 * @return
	 */
	public static String getEndTimeOfDay(String day) {
		String time = "";
	    time = day + " " + "23:59:59";
		return time;
	}


	 // 获得当前日期与本周一相差的天数     下面几个类似的方法created by zjk
    public static int getMondayPlus() {
        Calendar cd = Calendar.getInstance();
        // 获得今天是一周的第几天，星期日是第一天，星期二是第二天......
        int dayOfWeek = cd.get(Calendar.DAY_OF_WEEK);
        if (dayOfWeek == 1) {
            return -6;
        } else {
            return 2 - dayOfWeek;
        }
    }

    // 获得当前周- 周一的日期
	public static String getCurrentMonday() {
        int mondayPlus = getMondayPlus();
        GregorianCalendar currentDate = new GregorianCalendar();
        currentDate.add(GregorianCalendar.DATE, mondayPlus);
        Date monday = currentDate.getTime();
        DateFormat df = DateFormat.getDateInstance();
        String preMonday = df.format(monday);
        return preMonday;
    }

    // 获得当前周- 周日  的日期
	public static String getPreviousSunday() {
        int mondayPlus = getMondayPlus();
        GregorianCalendar currentDate = new GregorianCalendar();
        currentDate.add(GregorianCalendar.DATE, mondayPlus +6);
        Date monday = currentDate.getTime();
       DateFormat df = DateFormat.getDateInstance();
        String preMonday = df.format(monday);
        return preMonday;
    }


	  // 获得周一的日期 月份和日都是两位数   shiqianqian
		public static String getMondayOfWeek() {
	        int mondayPlus = getMondayPlus();
	        GregorianCalendar currentDate = new GregorianCalendar();
	        currentDate.add(GregorianCalendar.DATE, mondayPlus);
	        Date monday = currentDate.getTime();
	       // DateFormat df = DateFormat.getDateInstance();
	        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyyMMdd");
	        String preMonday = dateFormat.format(monday);
	        return preMonday;
	    }

	    // 获得周日  的日期 月份和日都是两位数  shiqianqian
		public static String getSundayOfWeek() {
	        int mondayPlus = getMondayPlus();
	        GregorianCalendar currentDate = new GregorianCalendar();
	        currentDate.add(GregorianCalendar.DATE, mondayPlus +6);
	        Date monday = currentDate.getTime();
	        //DateFormat df = DateFormat.getDateInstance();
	        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyyMMdd");
	        String preMonday = dateFormat.format(monday);
	        return preMonday;
	    }



		 private static SimpleDateFormat format = new SimpleDateFormat("yyyyMMdd");

		    // 获得当前月--开始日期   shiqianqian
		public static String getStartOfMonth() {
			Calendar calendar = Calendar.getInstance();
			 try {
			         calendar.setTime(format.parse(DateUtil.toStr(new Date(), "yyyyMMdd")));
			         calendar.set(Calendar.DAY_OF_MONTH, calendar.getActualMinimum(Calendar.DAY_OF_MONTH));
			         return format.format(calendar.getTime());
			       } catch (ParseException e) {
			       e.printStackTrace();
			      }
			     return null;
		    }

		    // 获得当前月--结束日期  shiqianqian
		public static String getEndOfMonth(){
		   Calendar calendar = Calendar.getInstance();
		         try{
		            calendar.setTime(format.parse(DateUtil.toStr(new Date(), "yyyyMMdd")));
		            calendar.set(Calendar.DAY_OF_MONTH, calendar.getActualMaximum(Calendar.DAY_OF_MONTH));
		            return format.format(calendar.getTime());
		         }  catch (ParseException e) {
		             e.printStackTrace();
		         }
		         return null;
		    }

    private static SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");

    // 获得当前月--开始日期
    public static String getMinMonthDate() {
	     Calendar calendar = Calendar.getInstance();
	     try {
	         calendar.setTime(dateFormat.parse(DateUtil.toStr(new Date())));
	         calendar.set(Calendar.DAY_OF_MONTH, calendar.getActualMinimum(Calendar.DAY_OF_MONTH));
	         return dateFormat.format(calendar.getTime());
	       } catch (ParseException e) {
	       e.printStackTrace();
	      }
	     return null;
    }

    // 获得当前月--结束日期
    public static String getMaxMonthDate(){
         Calendar calendar = Calendar.getInstance();
         try{
            calendar.setTime(dateFormat.parse(DateUtil.toStr(new Date())));
            calendar.set(Calendar.DAY_OF_MONTH, calendar.getActualMaximum(Calendar.DAY_OF_MONTH));
            return dateFormat.format(calendar.getTime());
         }  catch (ParseException e) {
             e.printStackTrace();
         }
         return null;
    }

    // 获得当前年--开始日期
    public static String getMinYearDate() {
         Calendar calendar = Calendar.getInstance();
         try{
             calendar.setTime(dateFormat.parse(DateUtil.toStr(new Date())));
             calendar.set(Calendar.DAY_OF_YEAR, calendar.getActualMinimum(Calendar.DAY_OF_YEAR));
             return dateFormat.format(calendar.getTime());
           } catch (ParseException e) {
             e.printStackTrace();
          }
         return null;
    }

    // 获得当前年--结束日期
    public static String getMaxYearDate() {
         Calendar calendar = Calendar.getInstance();
         try{
             calendar.setTime(dateFormat.parse(DateUtil.toStr(new Date())));
             calendar.set(Calendar.DAY_OF_YEAR, calendar.getActualMaximum(Calendar.DAY_OF_YEAR));
             return dateFormat.format(calendar.getTime());
           } catch (ParseException e) {
             e.printStackTrace();
          }
         return null;
    }
    
    public static int getMin(String sendTime){
		//获得当前时间now  int类型 四位数字
		String date = DateUtil.toStr(new Date(), DateUtil.YYYY_MM_DD_HH_MM);
		String[] dateString = date.substring(11, 16).split(":");
		int now = Integer.valueOf(dateString[0]+dateString[1]);
		String[] timeString = sendTime.split(":");
		int time = Integer.valueOf(timeString[0]+timeString[1]);
		if(now>=time){
			return 1;
		}else{
			return -1;
		}
	}
	
	 // 获得当前日期与指定周几相差的天数    
    public static int getWeek(String sendTime) {
        Calendar cd = Calendar.getInstance();
        String[] time = sendTime.split(":");
        int week = Integer.valueOf(time[0]);
        // 获得今天是星期几，星期天为星期7
        int dayOfWeek = cd.get(Calendar.DAY_OF_WEEK)-1;
        if(week==dayOfWeek){
        	String weekTime = time[1]+":"+time[2]; 
        	return getMin(weekTime);
        }else{
        	return -1;
        }
    } 
    
  //获得当前的日期并且返回与sendTime的比较值
    public static int getDay(String sendTime){
    	String[] time = sendTime.split(":");
        int month = Integer.valueOf(time[0]);
    	Date date = new Date();
    	int day = Integer.valueOf(date.toString().substring(8, 10));
    	if(month==day){
        	String monthTime = time[1]+":"+time[2]; 
        	return getMin(monthTime);
        }else{
        	return -1;
        }
    }

	
    //判断当前日期是星期几  shiqianqian
    
    public static int dayForWeek(String pTime) throws Exception {  
		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");  
		 Calendar c = Calendar.getInstance();  
		 c.setTime(format.parse(pTime));  
		 int dayForWeek = 0;  
		 if(c.get(Calendar.DAY_OF_WEEK) == 1){  
		  dayForWeek = 7;  
		 }else{  
		  dayForWeek = c.get(Calendar.DAY_OF_WEEK) - 1;  
		 }  
		 return dayForWeek;  
		} 
    
    
    //输入年，月，判断当前月份有多少天
    
    public static int getFirstDayOfMonth(int year,int month)
    {
    	
    	Calendar calendar=Calendar.getInstance();
    	calendar.set(Calendar.YEAR, year);
    	calendar.set(Calendar.MONTH, month-1);
    	int dayCount=calendar.getActualMaximum(calendar.DATE);
    	return dayCount;
    	
    }
    
    /**
	 * 返回今天结束时间
	 */
	public static String getEndTimeDay(String time){
		return toStr(new Date(),YYYY_MM_DD)+" "+"23:59:59";
	}
	/**
	 * 返回本周/月结束时间
	 */
	public static String getEndTimeWeekAndMonth(String time){
		String[] timeSplit = time.split(":");
		return toStr(new Date(),YYYY_MM_DD)+" "+timeSplit[1]+":"+timeSplit[2]+":00";
 	}
	
	//shiqianqian   任意时间段的天数
	 public static List<Date> findDates(Date dBegin, Date dEnd) {  
	        List lDate = new ArrayList();  
	        lDate.add(dBegin);  
	        Calendar calBegin = Calendar.getInstance();  
	        // 使用给定的 Date 设置此 Calendar 的时间    
	        calBegin.setTime(dBegin);  
	        Calendar calEnd = Calendar.getInstance();  
	        // 使用给定的 Date 设置此 Calendar 的时间    
	        calEnd.setTime(dEnd);  
	        // 测试此日期是否在指定日期之后    
	        while (dEnd.after(calBegin.getTime())) {  
	            // 根据日历的规则，为给定的日历字段添加或减去指定的时间量    
	            calBegin.add(Calendar.DAY_OF_MONTH, 1);  
	            lDate.add(calBegin.getTime());  
	        }  
	        return lDate;  
	    }  
	 
	//查询系统当前时间,返回格式yymmdd  shiqianqian
	public static String getToday()
	{
		 Date d = new Date();  
	     SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");  
	     String dateNowStr = sdf.format(d); 
		 return dateNowStr;
	}
	//得到系统前一天  shiqianqian
	public static String getBeforeToday()
	{    
		 SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");  
		
		 Calendar calendar=Calendar.getInstance();
		
		 calendar.add(Calendar.DATE, -1);
		
		 String yesterday=sdf.format(calendar.getTime());
		return yesterday;
		 
		
	}
	
	/**
	 * 
	 * @param time yyyy-MM-dd
	 * @return Date yyyy-MM-dd hh:mm:ss
	 */
	public static Date startToDate(String time){
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		Date date = null;
		try {
			String start = getBeginTimeOfDay(time);
			date = sdf.parse(start);
		} catch (ParseException e1) {
			e1.printStackTrace();
		}
		return date;
	}
	
	public static Date endToDate(String time){
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		Date date = null;
		try {
			String end = getEndTimeOfDay(time);
			date = sdf.parse(end);
		} catch (ParseException e1) {
			e1.printStackTrace();
		}
		return date;
	}
	
	public static String translate(String time){
		String[] times = time.split("-");
		String finalTime = "";
		for(String time1 : times){
			finalTime = finalTime+time1.trim();
		}
		return finalTime;
	}
}
