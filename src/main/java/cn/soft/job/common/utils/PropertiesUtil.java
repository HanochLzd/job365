package cn.soft.job.common.utils;

import java.io.IOException;
import java.io.InputStream;
import java.util.*;
import java.util.Map.Entry;


public class PropertiesUtil {
	
	private String filepath = "/conf/config.properties";

	private static Properties properties = new Properties();

	private static Map<String,String> valMap = new HashMap<String,String>();

	private static Set<Entry<Object, Object>> valSet = null;

	private static PropertiesUtil mPropertiesUtil= null;

	private PropertiesUtil(String filepath) throws IOException {
		this.filepath = filepath;
		this.parseProp();
	}

	/**
	 * 实现静态获取
	 * @return
	 * @throws IOException
	 */
	public static PropertiesUtil getInstance(String filepath){
		try {
			mPropertiesUtil = new PropertiesUtil(filepath);
		} catch (IOException e) {
		
			e.printStackTrace();
		}

		return mPropertiesUtil;
	}

	/**
	 * 加载配置文件
	 * @return
	 * @throws IOException
	 */
	private Set<Entry<Object, Object>> parseProp() throws IOException{

		InputStream is=this.getClass().getResourceAsStream(filepath);

		properties.load(is);
		valSet = properties.entrySet();
		is.close();

		initMap();

		return valSet;
	}

	private void initMap(){
		Iterator<Entry<Object,Object>> it = valSet.iterator();

		while(it.hasNext()){
			Entry<Object, Object> entry = it.next();
			String key = entry.getKey()+"";
			String value = entry.getValue()+"";
			
			valMap.put(key, value);
		}
	}

	public String getValueByKey(String key){

		return properties.getProperty(key);
	}

	public Map<String,String> getMap() {

		return valMap;
	}

	/**
	 * 解析key对应的value值，不同值之间使用分号分割
	 * @param key
	 * @return
	 * @update：2014年7月31日 下午1:02:04
	 */
	public Map<String,String> analysisValue(String key){
		Map<String,String> map = new HashMap<String, String>();

		String value = getValueByKey(key);
		if(value!=null && !value.equals("")){
			String[] ss = value.split(";");
			if(ss!=null && ss.length>0){
				for(String s:ss){
					map.put(s, s);
				}
			}
		}

		return map;
	}

}
