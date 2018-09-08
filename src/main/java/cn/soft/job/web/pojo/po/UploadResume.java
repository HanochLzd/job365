package cn.soft.job.web.pojo.po;

import java.util.Date;

public class UploadResume {

    private long id;
    private long createUserId;
    private String resumeName;
    private String resumeDesc;
    private String status;
    private String resumeUrl;
    private Date createDate;
    private Date updateDate;
    private long downloadNum;


    public long getId() {
        return id;
    }

    public void setId(long id) {
        this.id = id;
    }

    public long getCreateUserId() {
        return createUserId;
    }

    public void setCreateUserId(long createUserId) {
        this.createUserId = createUserId;
    }

    public String getResumeName() {
        return resumeName;
    }

    public void setResumeName(String resumeName) {
        this.resumeName = resumeName;
    }

    public String getResumeDesc() {
        return resumeDesc;
    }

    public void setResumeDesc(String resumeDesc) {
        this.resumeDesc = resumeDesc;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getResumeUrl() {
        return resumeUrl;
    }

    public void setResumeUrl(String resumeUrl) {
        this.resumeUrl = resumeUrl;
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

    public long getDownloadNum() {
        return downloadNum;
    }

    public void setDownloadNum(long downloadNum) {
        this.downloadNum = downloadNum;
    }

    public UploadResume() {
        super();
    }

    public UploadResume(long id, long createUserId, String resumeName,
                        String resumeDesc, String status, String resumeUrl,
                        Date createDate, Date updateDate, long downloadNum) {
        super();
        this.id = id;
        this.createUserId = createUserId;
        this.resumeName = resumeName;
        this.resumeDesc = resumeDesc;
        this.status = status;
        this.resumeUrl = resumeUrl;
        this.createDate = createDate;
        this.updateDate = updateDate;
        this.downloadNum = downloadNum;
    }


}
