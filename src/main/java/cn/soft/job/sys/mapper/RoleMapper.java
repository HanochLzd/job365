package cn.soft.job.sys.mapper;

import cn.soft.job.sys.pojo.po.Role;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * @author Hanoch
 * @version 1.0
 * @date 2018/9/10 14:03
 */
public interface RoleMapper {

    List<Role> getAllRole();

    List<Role> getOwnRoleByUserId(long userid);

    void deleteRoleById(int id);

    int giveRole(@Param("id") int id, @Param("list") List<Integer> list);

    Role findRoleById(int roleId);

    int addRole(Role role);

    int updateRole(Role role);

    int deleteByPrimiary(int id);

    int deleteRoleMenuByRoleId(int id);
}
