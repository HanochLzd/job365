package cn.soft.job.web.pojo.po;

import java.util.Date;

public class News {
    private Long id;

    private Long createUserId;

    private String newsTitle;

    private Date pushDate;

    private Date createDate;

    private Date updateDate;

    private String newsStatus;

    private String remark;

    private String isShowTop;

    private String newsContent;

    private String imagePath;

    public String getImagePath() {
        return imagePath;
    }

    public void setImagePath(String imagePath) {
        this.imagePath = imagePath;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public Long getCreateUserId() {
        return createUserId;
    }

    public void setCreateUserId(Long createUserId) {
        this.createUserId = createUserId;
    }

    public String getNewsTitle() {
        return newsTitle;
    }

    public void setNewsTitle(String newsTitle) {
        this.newsTitle = newsTitle == null ? null : newsTitle.trim();
    }

    public Date getPushDate() {
        return pushDate;
    }

    public void setPushDate(Date pushDate) {
        this.pushDate = pushDate;
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

    public String getNewsStatus() {
        return newsStatus;
    }

    public void setNewsStatus(String newsStatus) {
        this.newsStatus = newsStatus == null ? null : newsStatus.trim();
    }

    public String getRemark() {
        return remark;
    }

    public void setRemark(String remark) {
        this.remark = remark == null ? null : remark.trim();
    }

    public String getIsShowTop() {
        return isShowTop;
    }

    public void setIsShowTop(String isShowTop) {
        this.isShowTop = isShowTop == null ? null : isShowTop.trim();
    }

    public String getNewsContent() {
        return newsContent;
    }

    public void setNewsContent(String newsContent) {
        this.newsContent = newsContent == null ? null : newsContent.trim();
    }


    @Override
    public String toString() {
        return "News [id=" + id + ", createUserId=" + createUserId + ", newsTitle=" + newsTitle + ", pushDate="
                + pushDate + ", createDate=" + createDate + ", updateDate=" + updateDate + ", newsStatus=" + newsStatus
                + ", remark=" + remark + ", isShowTop=" + isShowTop + ", newsContent=" + newsContent + ", imagePath="
                + imagePath + "]";
    }


}