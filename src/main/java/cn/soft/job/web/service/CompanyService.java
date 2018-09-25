package cn.soft.job.web.service;

import cn.soft.job.web.pojo.po.Company;

import java.util.List;

/**
 * @author Hanoch
 * @version 1.0
 * @date 2018/9/15 15:54
 */
public interface CompanyService {

    List<Company> getAllCompany();

    String getCompanyList(int sEcho, int iDisplayStart, int iDisplayLength, String startDate, String endDate,
                          String newsTitle);

    int updateByPrimaryKeySelective(Company company);

    int insert(Company company);

    Company selectByPrimiary(int id);

    int deleteByPrimaryKey(int id);

    int deleteBatch(String[] ids);

    int updateStatus(int id);
}
