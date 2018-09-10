package cn.soft.job.sys.mapper;

import cn.soft.job.sys.pojo.po.User;

import java.util.Map;

/**
 * @author Hanoch
 * @version 1.0
 * @date 2018/9/10 9:20
 */
public interface UserMapper {

    User selectByUserName(String userName);


    int updatePwd(Map<String, Object> paramsMap);

    int updateByPrimaryKeySelective(User recoed);
}
