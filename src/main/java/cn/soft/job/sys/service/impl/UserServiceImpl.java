package cn.soft.job.sys.service.impl;

import cn.soft.job.sys.mapper.UserMapper;
import cn.soft.job.sys.pojo.po.User;
import cn.soft.job.sys.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 * @author Hanoch
 * @version 1.0
 * @date 2018/9/10 9:37
 */
@Service
public class UserServiceImpl implements UserService {

    @Autowired
    private UserMapper userMapper;

    @Override
    public User selectByUserName(String userName) {
        return userMapper.selectByUserName(userName);
    }
}
