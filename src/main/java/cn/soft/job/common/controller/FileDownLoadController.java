package cn.soft.job.common.controller;

import javax.servlet.http.HttpServletResponse;
import java.io.*;


public class FileDownLoadController {
	
	public HttpServletResponse download(File path, String  filename, HttpServletResponse response) {
        try {
            // path是指欲下载的文件的路径。
           // File file = new File(path);
            // 取得文件名。
            //String filename = file.getName();
            // 取得文件的后缀名。
            String ext = filename.substring(filename.lastIndexOf(".") + 1).toUpperCase();

            // 以流的形式下载文件。
            InputStream fis = new BufferedInputStream(new FileInputStream(path));
            byte[] buffer = new byte[fis.available()];
            fis.read(buffer);
            fis.close();
            // 清空response
            response.reset();
            // 设置response的Header
            response.addHeader("Content-Disposition", "attachment;filename=" + new String(filename.getBytes()));
            response.addHeader("Content-Length", "" + path.length());
            OutputStream toClient = new BufferedOutputStream(response.getOutputStream());
            response.setContentType("application/octet-stream");
            toClient.write(buffer);
          
            toClient.flush();
            toClient.close();
        } catch (IOException ex) {
            ex.printStackTrace();
        }
        return null;
	}
	 
}
