package cn.soft.job.web.pojo.po;

import java.util.Date;

public class Message {


    private Integer id;

    private Integer parentId;
    private String context;
    private Integer userId;
    private Integer positionId;
    private Date CreateDate;
    private Date comCreateDate;
    private String comContext;
    private Integer status;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Integer getParentId() {
        return parentId;
    }

    public void setParentId(Integer parentId) {
        this.parentId = parentId;
    }

    public String getContext() {
        return context;
    }

    public void setContext(String context) {
        this.context = context;
    }

    public Integer getUserId() {
        return userId;
    }

    public void setUserId(Integer userId) {
        this.userId = userId;
    }

    public Integer getPositionId() {
        return positionId;
    }

    public void setPositionId(Integer positionId) {
        this.positionId = positionId;
    }

    public Date getCreateDate() {
        return CreateDate;
    }

    public void setCreateDate(Date createDate) {
        CreateDate = createDate;
    }

    public Integer getStatus() {
        return status;
    }

    public void setStatus(Integer status) {
        this.status = status;
    }

    public Date getComCreateDate() {
        return comCreateDate;
    }

    public void setComCreateDate(Date comCreateDate) {
        this.comCreateDate = comCreateDate;
    }

    public String getComcontext() {
        return comContext;
    }

    public void setComcontext(String comcontext) {
        this.comContext = comcontext;
    }

    @Override
    public String toString() {
        return "Message [id=" + id + ", parentId=" + parentId + ", context="
                + context + ", userId=" + userId + ", positionId=" + positionId
                + ", CreateDate=" + CreateDate + ", comCreateDate="
                + comCreateDate + ", comcontext=" + comContext + ", status="
                + status + "]";
    }


}
