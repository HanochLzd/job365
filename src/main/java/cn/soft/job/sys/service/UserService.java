package cn.soft.job.sys.service;

import cn.soft.job.sys.pojo.po.User;

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
}
