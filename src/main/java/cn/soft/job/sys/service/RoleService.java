package cn.soft.job.sys.service;

import cn.soft.job.sys.pojo.po.Role;

import java.util.List;

/**
 * @author Hanoch
 * @version 1.0
 * @date 2018/9/12 9:54
 */
public interface RoleService {

    List<Role> getAllRole();

    List<Role> getOwnRoleById(int userid);

}
