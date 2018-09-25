package cn.soft.job.sys.pojo.po;

import java.io.Serializable;
import java.util.List;

/**
 * @author Hanoch
 */
public class Menu implements Serializable {

    private Integer id;

    private String menuName;

    private String menuUrl;

    private Integer parentId;

    private Integer menuType;

    private String menuDesc;

    private String menuIcon;

    private Integer menuStatus;

    private List<Menu> childMenus;

    public Menu() {
    }

    public Menu(Integer id, String menuName, String menuUrl, Integer parentId, Integer menuType, String menuDesc, String menuIcon, Integer menuStatus, List<Menu> childMenus) {
        this.id = id;
        this.menuName = menuName;
        this.menuUrl = menuUrl;
        this.parentId = parentId;
        this.menuType = menuType;
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
        this.menuName = menuName;
    }

    public String getMenuUrl() {
        return menuUrl;
    }

    public void setMenuUrl(String menuUrl) {
        this.menuUrl = menuUrl;
    }

    public Integer getParentId() {
        return parentId;
    }

    public void setParentId(Integer parentId) {
        this.parentId = parentId;
    }

    public Integer getMenuType() {
        return menuType;
    }

    public void setMenuType(Integer menuType) {
        this.menuType = menuType;
    }

    public String getMenuDesc() {
        return menuDesc;
    }

    public void setMenuDesc(String menuDesc) {
        this.menuDesc = menuDesc;
    }

    public String getMenuIcon() {
        return menuIcon;
    }

    public void setMenuIcon(String menuIcon) {
        this.menuIcon = menuIcon;
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
                ", parentId=" + parentId +
                ", menuType=" + menuType +
                ", menuDesc='" + menuDesc + '\'' +
                ", menuIcon='" + menuIcon + '\'' +
                ", menuStatus=" + menuStatus +
                ", childMenus=" + childMenus +
                '}';
    }

}