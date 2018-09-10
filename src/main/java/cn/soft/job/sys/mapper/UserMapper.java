package cn.soft.job.sys.mapper;

import cn.soft.job.sys.pojo.po.User;

/**
 * @author Hanoch
 * @version 1.0
 * @date 2018/9/10 9:20
 */
public interface UserMapper {

    User selectByUserName(String userName);


}
