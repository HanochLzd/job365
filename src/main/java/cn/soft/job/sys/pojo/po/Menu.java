package cn.soft.job.sys.pojo.po;

import java.util.List;

public class Menu {
    private Integer id;

    private String menuName;

    private String menuUrl;

    private Integer parentid;

    private Integer menutype;

    private String menuDesc;

    private String menuIcon;

    private Integer menuStatus;

    private List<Menu> childMenus;

    public Menu() {
    }

    public Menu(Integer id, String menuName, String menuUrl, Integer parentid, Integer menutype,
                String menuDesc, String menuIcon, Integer menuStatus, List<Menu> childMenus) {
        this.id = id;
        this.menuName = menuName;
        this.menuUrl = menuUrl;
        this.parentid = parentid;
        this.menutype = menutype;
        this.menuDesc = menuDesc;
        this.menuIcon = menuIcon;
        this.menuStatus = menuStatus;
        this.childMenus = childMenus;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getMenuName() {
        return menuName;
    }

    public void setMenuName(String menuName) {
        this.menuName = menuName == null ? null : menuName.trim();
    }

    public String getMenuUrl() {
        return menuUrl;
    }

    public void setMenuUrl(String menuUrl) {
        this.menuUrl = menuUrl == null ? null : menuUrl.trim();
    }

    public Integer getParentid() {
        return parentid;
    }

    public void setParentid(Integer parentid) {
        this.parentid = parentid;
    }

    public Integer getMenutype() {
        return menutype;
    }

    public void setMenutype(Integer menutype) {
        this.menutype = menutype;
    }

    public String getMenuDesc() {
        return menuDesc;
    }

    public void setMenuDesc(String menuDesc) {
        this.menuDesc = menuDesc == null ? null : menuDesc.trim();
    }

    public String getMenuIcon() {
        return menuIcon;
    }

    public void setMenuIcon(String menuIcon) {
        this.menuIcon = menuIcon == null ? null : menuIcon.trim();
    }

    public Integer getMenuStatus() {
        return menuStatus;
    }

    public void setMenuStatus(Integer menuStatus) {
        this.menuStatus = menuStatus;
    }

    public List<Menu> getChildMenus() {
        return childMenus;
    }

    public void setChildMenus(List<Menu> childMenus) {
        this.childMenus = childMenus;
    }

    @Override
    public String toString() {
        return "Menu{" +
                "id=" + id +
                ", menuName='" + menuName + '\'' +
                ", menuUrl='" + menuUrl + '\'' +
                ", parentid=" + parentid +
                ", menutype=" + menutype +
                ", menuDesc='" + menuDesc + '\'' +
                ", menuIcon='" + menuIcon + '\'' +
                ", menuStatus=" + menuStatus +
                ", childMenus=" + childMenus +
                '}';
    }
}