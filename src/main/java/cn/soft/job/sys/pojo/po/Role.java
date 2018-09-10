package cn.soft.job.sys.pojo.po;

import java.util.Date;

public class Role {
    private Integer id;
    private String roleName;
    private String roleDesc;
    private Date createDate;
    private Integer status;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getRoleName() {
        return roleName;
    }

    public void setRoleName(String roleName) {
        this.roleName = roleName;
    }

    public String getRoleDesc() {
        return roleDesc;
    }

    public void setRoleDesc(String roleDesc) {
        this.roleDesc = roleDesc;
    }

    public Date getCreateDate() {
        return createDate;
    }

    public void setCreateDate(Date createDate) {
        this.createDate = createDate;
    }

    public Integer getStatus() {
        return status;
    }

    public void setStatus(Integer status) {
        this.status = status;
    }

    public Role(Integer id, String roleName, String roleDesc, Date createDate,
                Integer status) {
        this.id = id;
        this.roleName = roleName;
        this.roleDesc = roleDesc;
        this.createDate = createDate;
        this.status = status;
    }

    @Override
    public String toString() {
        return "Role [id=" + id + ", roleName=" + roleName + ", roleDesc="
                + roleDesc + ", createDate=" + createDate + ", status="
                + status + "]";
    }


}
