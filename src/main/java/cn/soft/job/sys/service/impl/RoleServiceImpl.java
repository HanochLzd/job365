package cn.soft.job.sys.service.impl;

import cn.soft.job.sys.mapper.RoleMapper;
import cn.soft.job.sys.pojo.po.Role;
import cn.soft.job.sys.service.RoleService;
import org.apache.log4j.Logger;
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

    private Logger logger = Logger.getLogger(RoleServiceImpl.class);

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

    @Override
    public Role findRoleById(int roleId) {
        return roleMapper.findRoleById(roleId);
    }

    @Override
    public int addRole(Role role) {
        return roleMapper.addRole(role);
    }

    @Override
    public int updateRole(Role role) {
        return roleMapper.updateRole(role);
    }

    @Override
    public int deleteByPrimiary(int id) {
        try {
            roleMapper.deleteRoleMenuByRoleId(id);
        } catch (Exception e) {
            logger.debug("role_menu表关联删除失败！");
        }
        return roleMapper.deleteByPrimiary(id);
    }
}
