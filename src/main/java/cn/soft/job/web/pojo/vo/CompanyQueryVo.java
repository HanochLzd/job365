package cn.soft.job.web.pojo.vo;

import cn.soft.job.web.pojo.po.Company;

/**
 * 公司搜索条件结果集
 *
 * @author Hanoch
 * @version 1.0
 * @date 2018/9/15 19:32
 */
public class CompanyQueryVo{

    private Company company;

    private int sEcho;

    private int iDisplayStart;

    private int iDisplayLength;

    private String startDate;

    private String endDate;

    public Company getCompany() {
        return company;
    }

    public void setCompany(Company company) {
        this.company = company;
    }

    public int getsEcho() {
        return sEcho;
    }

    public void setsEcho(int sEcho) {
        this.sEcho = sEcho;
    }

    public int getiDisplayStart() {
        return iDisplayStart;
    }

    public void setiDisplayStart(int iDisplayStart) {
        this.iDisplayStart = iDisplayStart;
    }

    public String getStartDate() {
        return startDate;
    }

    public void setStartDate(String startDate) {
        this.startDate = startDate;
    }

    public String getEndDate() {
        return endDate;
    }

    public void setEndDate(String endDate) {
        this.endDate = endDate;
    }

    public int getiDisplayLength() {
        return iDisplayLength;
    }

    public void setiDisplayLength(int iDisplayLength) {
        this.iDisplayLength = iDisplayLength;
    }

    @Override
    public String toString() {
        return "CompanyQueryVo{" +
                "company=" + company +
                ", sEcho=" + sEcho +
                ", iDisplayStart=" + iDisplayStart +
                ", iDisplayLength=" + iDisplayLength +
                ", startDate='" + startDate + '\'' +
                ", endDate='" + endDate + '\'' +
                '}';
    }
}
