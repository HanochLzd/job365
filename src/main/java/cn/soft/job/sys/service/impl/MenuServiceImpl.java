package cn.soft.job.sys.service.impl;

import cn.soft.job.sys.mapper.MenuMapper;
import cn.soft.job.sys.pojo.po.Menu;
import cn.soft.job.sys.service.MenuService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.lang.reflect.Array;
import java.util.*;

/**
 * @author Hanoch
 * @version 1.0
 * @date 2018/9/10 14:23
 */
@Service
public class MenuServiceImpl implements MenuService {

    @Autowired
    private MenuMapper menuMapper;

    @Override
    public List<Menu> getAllMenu(Long userid) {
        return menuMapper.getAllMenu(userid);
    }

    @Override
    public List<Menu> getAllChlidMenu(Long userid, Integer menuId) {
        return menuMapper.getAllChlidMenu(userid, menuId);
    }

    @Override
    public List<Menu> getAllMenuList() {
        return menuMapper.getAllMenuList();
    }

    @Override
    public List<Menu> getMenuListByMenuName(String menuName) {
        return menuMapper.selectByMenuName(menuName);
    }

    @Override
    public int deleteByPrimiary(int id) {
        return menuMapper.deleteByPrimiary(id);
    }

    @Override
    public int batchDeleteMenu(String ids) {
        String[] id = ids.split(",");
        return menuMapper.batchDeleteMenu(id);
    }

    @Override
    public Menu findMenuById(int menuId) {
        return menuMapper.findMenuById(menuId);
    }

    @Override
    public int updateMenuById(Menu menu) {
        return menuMapper.updateMenuById(menu);
    }

    @Override
    public int findMenuByName(String menuName) {
        return menuMapper.findMenuByName(menuName);
    }

    @Override
    public int insert(Menu menu) {
        return menuMapper.insert(menu);
    }

    @Override
    public List<Menu> getOwnMenuById(int id) {
        return menuMapper.getOwnMenuById(id);
    }

    @Override
    public int giveMenu(int id, String menuIds) {
        menuMapper.deleteMenuById(id);
        String[] roleIdArray = menuIds.split(",");
        List<Integer> list = new ArrayList<Integer>();
        for (int i = 0; i < roleIdArray.length; i++) {
            if (i < roleIdArray.length - 1) {
                Integer.parseInt(roleIdArray[i + 1]);
                list.add(Integer.parseInt(roleIdArray[i + 1]));
            }
        }
        int count = menuMapper.giveMenu(id, list);
        return count;
    }
}
