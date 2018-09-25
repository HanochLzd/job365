package cn.soft.job.web.mapper;

import cn.soft.job.web.pojo.po.Company;

import java.util.List;
import java.util.Map;

/**
 * @author Hanoch
 * @version 1.0
 * @date 2018/9/15 15:55
 */
public interface CompanyMapper {

    List<Company> getAllCompany();

    int getCount(Map<String, Object> paramsMap);

    List<Company> getList(Map<String, Object> paramsMap);

    int insert(Company company);

    int updateByPrimaryKeySelective(Company company);

    int deleteByPrimiary(int id);

    int deleteBatch(String[] ids);

    int updateStatusByPrimiary(int id);

    Company selectByPrimiary(int id);
}
