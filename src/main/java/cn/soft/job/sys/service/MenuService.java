package cn.soft.job.sys.service;

import cn.soft.job.sys.pojo.po.Menu;

import java.util.List;

/**
 * @author Hanoch
 * @version 1.0
 * @date 2018/9/10 14:23
 */
public interface MenuService {

    /**
     * 获取指定user下的所有父级菜单
     *
     * @param userid userid
     * @return list
     */
    List<Menu> getAllMenu(Long userid);

    /**
     * 获取某父级菜单下的所有子菜单
     *
     * @param userid userid
     * @param menuId menuId
     * @return list
     */
    List<Menu> getAllChlidMenu(Long userid, Integer menuId);

    /**
     * 查询所有菜单
     *
     * @return
     */
    List<Menu> getAllMenuList();

    List<Menu> getMenuListByMenuName(String menuName);

    int deleteByPrimiary(int id);

    int batchDeleteMenu(String ids);

    Menu findMenuById(int menuId);

    int updateMenuById(Menu menu);

    int findMenuByName(String menuName);

    int insert(Menu menu);

    List<Menu> getOwnMenuById(int id);

    int giveMenu(int id, String menuIds);
}
