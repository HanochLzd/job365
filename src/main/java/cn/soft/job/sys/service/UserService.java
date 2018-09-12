package cn.soft.job.sys.service;

import cn.soft.job.sys.pojo.po.User;
import cn.soft.job.sys.pojo.vo.UserQueryVo;

/**
 * @author Hanoch
 * @version 1.0
 * @date 2018/9/10 9:36
 */
public interface UserService {

    /**
     * 根据username查询用户
     * TODO 需要将Controller的判断转移至service层进行处理（符合单一职责原则）
     *
     * @param userName userName
     * @return User
     */
    User selectByUserName(String userName);

    Object savePwd(User user, String pwd1, String pwd2, String pwd3);

    /**
     * 查询所有用户信息
     *
     * @param userQueryVo 组合条件
     * @return JSON String
     */
    String getUserList(UserQueryVo userQueryVo);

    User selectByPrimiary(int id);

    int updateByPrimaryKeySelective(User user);

    int getUserNumber(User user, String op);

    int insert(User user);


    int deleteByPrimiary(int id);

    int updateUserStatus(int id);

    int batchDeleteUsers(String ids);

    /**
     * 给用户授权
     *
     * @param id      用户id
     * @param roleIds 角色id
     * @return int
     */
    int giveRole(int id, String roleIds);
}
