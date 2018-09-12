package cn.soft.job.sys.service.impl;

import cn.soft.job.sys.mapper.RoleMapper;
import cn.soft.job.sys.pojo.po.Role;
import cn.soft.job.sys.service.RoleService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * @author Hanoch
 * @version 1.0
 * @date 2018/9/12 9:54
 */
@Service
public class RoleServiceImpl implements RoleService {

    @Autowired
    private RoleMapper roleMapper;

    @Override
    public List<Role> getAllRole() {
        return roleMapper.getAllRole();
    }

    @Override
    public List<Role> getOwnRoleById(int userid) {
        return roleMapper.getOwnRoleByUserId(userid);
    }
}
