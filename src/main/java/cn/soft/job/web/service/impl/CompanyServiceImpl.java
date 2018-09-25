package cn.soft.job.web.service.impl;

import cn.soft.job.common.utils.DateUtil;
import cn.soft.job.common.utils.JSONUtil;
import cn.soft.job.web.mapper.CompanyMapper;
import cn.soft.job.web.pojo.po.Company;
import cn.soft.job.web.service.CompanyService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @author Hanoch
 * @version 1.0
 * @date 2018/9/15 15:54
 */
@Service
public class CompanyServiceImpl implements CompanyService {

    @Autowired
    private CompanyMapper companyMapper;

    @Override
    public List<Company> getAllCompany() {
        // TODO Auto-generated method stub
        return companyMapper.getAllCompany();
    }

    @Override
    public String getCompanyList(int sEcho, int iDisplayStart, int iDisplayLength, String startDate, String endDate,
                                 String name) {
        // TODO Auto-generated method stub
        Map<String , Object> paramsMap = new HashMap<>();
        List<Company> companyList ;
        paramsMap.put("start", iDisplayStart);
        paramsMap.put("limit", iDisplayLength);
        paramsMap.put("name", name);

        //处理检索时间
        if(null != startDate && !"".equals(startDate)){
            paramsMap.put("startDate", DateUtil.toDate(DateUtil.getBeginTimeOfDay(startDate), DateUtil.YYYY_MM_DD_HH_MM_SS));
        }
        if(null != endDate && !"".equals(endDate)){
            paramsMap.put("endDate",DateUtil.toDate(DateUtil.getEndTimeOfDay(endDate), DateUtil.YYYY_MM_DD_HH_MM_SS));
        }
        //获取总 的记录数
        int count = companyMapper.getCount(paramsMap);
        if(count<=0){
            companyList = new ArrayList<>();
        }else{
            companyList = companyMapper.getList(paramsMap);
        }
        return JSONUtil.getDataTableJson(companyList, sEcho, count);
    }

    @Override
    public int updateByPrimaryKeySelective(Company company) {
        // TODO Auto-generated method stub
        return  companyMapper.updateByPrimaryKeySelective(company);
    }

    @Override
    public int insert(Company company) {
        // TODO Auto-generated method stub
        return companyMapper.insert(company);
    }

    @Override
    public Company selectByPrimiary(int id) {
        // TODO Auto-generated method stub
        return companyMapper.selectByPrimiary(id);
    }

    @Override
    public int deleteByPrimaryKey(int id) {
        // TODO Auto-generated method stub
        return companyMapper.deleteByPrimiary(id);
    }

    @Override
    public int deleteBatch(String[] ids) {
        // TODO Auto-generated method stub
        return companyMapper.deleteBatch(ids);
    }

    @Override
    public int updateStatus(int id) {
        // TODO Auto-generated method stub
        return companyMapper.updateStatusByPrimiary(id);
    }
}
