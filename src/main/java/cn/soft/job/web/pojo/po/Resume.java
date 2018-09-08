package cn.soft.job.web.pojo.po;

import java.util.Date;

public class Resume {
    //主键 用户编号
    private int id;
    //简历ID
    private int resumeId;
    //投简历人姓名
    private String resumeName;
    //投简历人性别
    private int resumeSex;
    //投简历人出生日期
    private Date resumeBirth;
    //投简历人联系方式
    private String resumePhone;
    //投简历人电子邮件
    private String resumeEmail;
    //投简历人状态：是否在职
    private String resumeStatus;
    //投简历人居住地
    private String resumeAddress;
    //投简历人期望工资
    private String resumeSalary;
    //投简历人期望工作地点
    private String resumeWorkplace;
    //投简历人期望工作职位
    private String resumePosition;
    //投简历人工作经验
    private String resumeExperience;
    //简历其他
    private String resumeOthers;

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getResumeId() {
        return resumeId;
    }

    public void setResumeId(int resumeId) {
        this.resumeId = resumeId;
    }

    public String getResumeName() {
        return resumeName;
    }

    public void setResumeName(String resumeName) {
        this.resumeName = resumeName;
    }

    public int getResumeSex() {
        return resumeSex;
    }

    public void setResumeSex(int resumeSex) {
        this.resumeSex = resumeSex;
    }

    public Date getResumeBirth() {
        return resumeBirth;
    }

    public void setResumeBirth(Date resumeBirth) {
        this.resumeBirth = resumeBirth;
    }

    public String getResumePhone() {
        return resumePhone;
    }

    public void setResumePhone(String resumePhone) {
        this.resumePhone = resumePhone;
    }

    public String getResumeEmail() {
        return resumeEmail;
    }

    public void setResumeEmail(String resumeEmail) {
        this.resumeEmail = resumeEmail;
    }

    public String getResumeStatus() {
        return resumeStatus;
    }

    public void setResumeStatus(String resumeStatus) {
        this.resumeStatus = resumeStatus;
    }

    public String getResumeAddress() {
        return resumeAddress;
    }

    public void setResumeAddress(String resumeAddress) {
        this.resumeAddress = resumeAddress;
    }

    public String getResumeSalary() {
        return resumeSalary;
    }

    public void setResumeSalary(String resumeSalary) {
        this.resumeSalary = resumeSalary;
    }

    public String getResumeWorkplace() {
        return resumeWorkplace;
    }

    public void setResumeWorkplace(String resumeWorkplace) {
        this.resumeWorkplace = resumeWorkplace;
    }

    public String getResumePosition() {
        return resumePosition;
    }

    public void setResumePosition(String resumePosition) {
        this.resumePosition = resumePosition;
    }

    public String getResumeExperience() {
        return resumeExperience;
    }

    public void setResumeExperience(String resumeExperience) {
        this.resumeExperience = resumeExperience;
    }

    public String getResumeOthers() {
        return resumeOthers;
    }

    public void setResumeOthers(String resumeOthers) {
        this.resumeOthers = resumeOthers;
    }

    @Override
    public String toString() {
        return "resume []";
    }

    public Resume(int id, int resumeId, String resumeName, int resumeSex,
                  Date resumeBirth, String resumePhone, String resumeEmail,
                  String resumeStatus, String resumeAddress, String resumeSalary,
                  String resumeWorkplace, String resumePosition,
                  String resumeExperience, String resumeOthers) {
        super();
        this.id = id;
        this.resumeId = resumeId;
        this.resumeName = resumeName;
        this.resumeSex = resumeSex;
        this.resumeBirth = resumeBirth;
        this.resumePhone = resumePhone;
        this.resumeEmail = resumeEmail;
        this.resumeStatus = resumeStatus;
        this.resumeAddress = resumeAddress;
        this.resumeSalary = resumeSalary;
        this.resumeWorkplace = resumeWorkplace;
        this.resumePosition = resumePosition;
        this.resumeExperience = resumeExperience;
        this.resumeOthers = resumeOthers;
    }

    public Resume() {
        super();
    }


}
