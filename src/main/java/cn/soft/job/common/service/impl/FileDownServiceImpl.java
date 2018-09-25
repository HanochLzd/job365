package cn.soft.job.common.service.impl;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import cn.soft.job.common.pojo.po.FileDownMode;
import cn.soft.job.common.service.FileDownService;
import cn.soft.job.common.utils.DateUtil;
import cn.soft.job.common.utils.FileUtil;
import cn.soft.job.common.utils.JSONUtil;
import cn.soft.job.common.utils.ParamUtil;

@Service(value = "fileDownService")
public class FileDownServiceImpl implements FileDownService {

    @Override
    public FileDownMode getFileInfo(HttpServletRequest request, String id) {
        return null;
    }

    @Override
    public String upload(HttpServletRequest request, HttpServletResponse response) {
        List<Map<String, Object>> fileList = new ArrayList<Map<String, Object>>();

        MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) request;
        Iterator<String> fileNames = multipartRequest.getFileNames();

        Map<String, Object> returnMap = new HashMap<String, Object>();

        int i = 0;

        while (fileNames.hasNext()) {

            String name = (String) fileNames.next();// 文件参数名称
            MultipartFile myfile = multipartRequest.getFile(name);
            if (myfile.isEmpty()) {
                returnMap.put("flag", 0);//
                returnMap.put("flagMsg", "文件未上传");
                return JSONUtil.getJson(returnMap);
            } else {

                String OriginalFileName = myfile.getOriginalFilename();
                String saveName = DateUtil.getSystemTime().getTime() + "" + i
                        + OriginalFileName.substring(OriginalFileName.lastIndexOf("."), OriginalFileName.length());

                // 如果用的是Tomcat服务器，则文件会上传到\\%TOMCAT_HOME%\\webapps\\YourWebProject\\WEB-INF\\upload\\文件夹中
                // String uploadPath =
                // BaseUtil.getValueFromProperties("path.upload_image_path");
                String uploadPath = ParamUtil.upload_file_path;

                if (null == uploadPath || "".equals(uploadPath)) {
                    // out(response, "请维护文件上传暂存路径!");
                    returnMap.put("flag", 0);//
                    returnMap.put("flagMsg", "请维护文件上传暂存路径!");
                    return JSONUtil.getJson(returnMap);
                }
                FileUtil.mkdir(uploadPath);
                // 日期作为相对路径
                SimpleDateFormat formatdate = new SimpleDateFormat("yyyy/MM/dd/");
                String relative_path = formatdate.format(new Date());
                String realPath = uploadPath + relative_path;

                File filePath = new File(realPath);
                if (!filePath.exists()) {
                    filePath.mkdirs();
                }

                try {

                    FileUtil.copyInputStreamToFile(myfile.getInputStream(), new File(realPath, saveName));
                } catch (IOException e) {
                    e.printStackTrace();
                    // logger.error(e.getMessage(), e);
                }

                Map<String, Object> fileData = new HashMap<String, Object>();
                fileData.put("fileSize", myfile.getSize());
                fileData.put("fileName", myfile.getOriginalFilename());
                fileData.put("saveName", saveName);
                fileData.put("savePath", realPath + "/" + saveName);
                // try {
                // //fileData.put("savePath",
                // Base64Util.encodeBytesInAndroid(realPath+"/"+saveName));
                //
                // } catch (UnsupportedEncodingException e) {
                // e.printStackTrace();
                // //logger.error(e.getMessage(), e);
                // }
                fileList.add(fileData);
            }

            i++;
        }

        return JSONUtil.getJson(fileList);
    }

}
