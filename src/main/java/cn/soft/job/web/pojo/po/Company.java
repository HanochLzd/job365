package cn.soft.job.web.pojo.po;

import java.util.Date;

public class Company {

    private Integer id;
    private String companyName;
    private Integer userId;
    private String email;
    private String address;
    private Integer type;
    private String companyDesc;
    private String status;
    private String phone;
    private Date createDate;
    private Date updateDate;
    private Date companyCreateDate;
    private String companyPerson;

    private String companyLogo;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getCompanyName() {
        return companyName;
    }

    public void setCompanyName(String companyName) {
        this.companyName = companyName;
    }

    public Integer getUserId() {
        return userId;
    }

    public void setUserId(Integer userId) {
        this.userId = userId;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public Integer getType() {
        return type;
    }

    public void setType(Integer type) {
        this.type = type;
    }

    public String getCompanyDesc() {
        return companyDesc;
    }

    public void setCompanyDesc(String companyDesc) {
        this.companyDesc = companyDesc;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
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

    public Date getCompanyCreateDate() {
        return companyCreateDate;
    }

    public void setCompanyCreateDate(Date companyCreateDate) {
        this.companyCreateDate = companyCreateDate;
    }

    public String getCompanyPerson() {
        return companyPerson;
    }

    public void setCompanyPerson(String companyPerson) {
        this.companyPerson = companyPerson;
    }

    public String getCompanyLogo() {
        return companyLogo;
    }

    public void setCompanyLogo(String companyLogo) {
        this.companyLogo = companyLogo;
    }

    public Company() {
        super();
        // TODO Auto-generated constructor stub
    }

    @Override
    public String toString() {
        return "Company [id=" + id + ", companyName=" + companyName + ", userId=" + userId + ", email=" + email
                + ", address=" + address + ", type=" + type + ", companyDesc=" + companyDesc + ", status=" + status
                + ", phone=" + phone + ", createDate=" + createDate + ", updateDate=" + updateDate
                + ", companyCreateDate=" + companyCreateDate + ", companyPerson=" + companyPerson + ", companyLogo="
                + companyLogo + "]";
    }


}
