package cn.soft.job.sys.service.impl;

import cn.soft.job.sys.mapper.MenuMapper;
import cn.soft.job.sys.pojo.po.Menu;
import cn.soft.job.sys.service.MenuService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

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
}
