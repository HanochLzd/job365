package cn.soft.job.sys.mapper;

import cn.soft.job.sys.pojo.po.Menu;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * @author Hanoch
 * @version 1.0
 * @date 2018/9/10 14:05
 */
public interface MenuMapper {

    /**
     * 根据userid查询所有菜单（父级菜单）
     *
     * @param userid userid
     * @return Menu
     */
    List<Menu> getAllMenu(Long userid);

    /**
     * 获取某父级菜单下的所有子菜单
     *
     * @param userid userid
     * @param menuId 父级菜单id
     * @return menuList
     */
    List<Menu> getAllChlidMenu(@Param("userId") Long userid, @Param("menuId") Integer menuId);

    List<Menu> getAllMenuList();

    List<Menu> selectByMenuName(@Param("menuName") String menuName);

    int deleteByPrimiary(int id);

    int batchDeleteMenu(String[] id);

    Menu findMenuById(int menuId);

    int updateMenuById(Menu menu);

    int findMenuByName(String menuName);

    int insert(Menu menu);

    List<Menu> getOwnMenuById(int id);

    void deleteMenuById(int id);

    int giveMenu(@Param("id") int id, @Param("list") List<Integer> list);
}
