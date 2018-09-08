package cn.soft.job.web.pojo.po;

import java.util.Date;

public class Position {

    private long id;
    private String positionName;
    private String positionSalary;
    private String positionAddress;
    private String positionDesc;
    private String positionRequire;
    private Integer companyId;
    private String positionPhone;
    private Date createDate;
    private Date updateDate;
    private Integer status;
    private Integer category1;
    private Integer category2;

    public long getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getPositionName() {
        return positionName;
    }

    public void setPositionName(String positionName) {
        this.positionName = positionName;
    }

    public String getPositionSalary() {
        return positionSalary;
    }

    public void setPositionSalary(String positionSalary) {
        this.positionSalary = positionSalary;
    }

    public String getPositionAddress() {
        return positionAddress;
    }

    public void setPositionAddress(String positionAddress) {
        this.positionAddress = positionAddress;
    }

    public String getPositionDesc() {
        return positionDesc;
    }

    public void setPositionDesc(String positionDesc) {
        this.positionDesc = positionDesc;
    }

    public String getPositionRequire() {
        return positionRequire;
    }

    public void setPositionRequire(String positionRequire) {
        this.positionRequire = positionRequire;
    }

    public String getPositionPhone() {
        return positionPhone;
    }

    public Integer getCompanyId() {
        return companyId;
    }

    public void setCompanyId(Integer companyId) {
        this.companyId = companyId;
    }

    public void setPositionPhone(String positionPhone) {
        this.positionPhone = positionPhone;
    }

    public Integer getStatus() {
        return status;
    }

    public void setStatus(Integer status) {
        this.status = status;
    }

    public Date getCreateDate() {
        return createDate;
    }

    public void setCreateDate(Date createDate) {
        this.createDate = createDate;
    }

    public Date getUpdateDate() {
        return updateDate;
    }

    public void setUpdateDate(Date updateDate) {
        this.updateDate = updateDate;
    }

    public Integer getCategory1() {
        return category1;
    }

    public void setCategory1(Integer category1) {
        this.category1 = category1;
    }

    public Integer getCategory2() {
        return category2;
    }

    public void setCategory2(Integer category2) {
        this.category2 = category2;
    }

    public Position() {
        super();
        // TODO Auto-generated constructor stub
    }

    @Override
    public String toString() {
        return "Position [id=" + id + ", positionName=" + positionName
                + ", positionSalary=" + positionSalary + ", positionAddress="
                + positionAddress + ", positionDesc=" + positionDesc
                + ", positionRequire=" + positionRequire + ", companyId="
                + companyId + ", positionPhone=" + positionPhone
                + ", status=" + status + ",createDate=" + createDate + ",updateDate=" + updateDate + ",category1=" + category1 + ",category2=" + category2 + "]";
    }


}
