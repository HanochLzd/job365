package cn.soft.job.common.pojo.po;

import java.io.Serializable;

/**
 * @author XXX
 */
public class ZTreeNode implements Serializable {

    private static final long serialVersionUID = -766759489880382042L;

    private Integer id;
    private Integer pId;
    private String name;
    /**
     * 是否默认打开
     */
    private boolean open;
    /**
     * 是否可以选
     */
    private boolean nocheck;
    /**
     * 是否默认选上
     */
    private boolean checked;
    /**
     * 是否是父节点
     */
    private Boolean isParent;

    public Boolean getIsParent() {
        return isParent;
    }

    public void setIsParent(Boolean isParent) {
        this.isParent = isParent;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Integer getpId() {
        return pId;
    }

    public void setpId(Integer pId) {
        this.pId = pId;
    }

    public static long getSerialversionuid() {
        return serialVersionUID;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public boolean isOpen() {
        return open;
    }

    public void setOpen(boolean open) {
        this.open = open;
    }

    public boolean isChecked() {
        return checked;
    }

    public void setChecked(boolean checked) {
        this.checked = checked;
    }

    public boolean isNocheck() {
        return nocheck;
    }

    public void setNocheck(boolean nocheck) {
        this.nocheck = nocheck;
    }

    @Override
    public String toString() {
        return "ZTreeNode [id=" + id + ", pId=" + pId + ", name=" + name + ", open=" + open + ", nocheck=" + nocheck
                + ", checked=" + checked + ", isParent=" + isParent + "]";
    }

}