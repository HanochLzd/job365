package cn.soft.job.sys.service.impl;

import cn.soft.job.common.utils.CommonUtil;
import cn.soft.job.common.utils.Constants;
import cn.soft.job.common.utils.MD5Util;
import cn.soft.job.sys.mapper.UserMapper;
import cn.soft.job.sys.pojo.po.User;
import cn.soft.job.sys.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.Map;

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

    @Override
    public Object savePwd(User user, String pwd1, String pwd2, String pwd3) {
        String MD5pwd1 = MD5Util.getMD5(pwd1);
        String MD5pwd2 = MD5Util.getMD5(pwd2);
        System.out.println(user.getUserPassword());
        System.out.println(MD5pwd1);
        System.out.println(MD5pwd2);
        Map<String, Object> resultMap = new HashMap<>(16);
        if (user.getUserPassword().equals(MD5pwd1)) {
            if (pwd2.equals(pwd3)) {
                if (!MD5pwd2.equals(MD5pwd1)) {
                    user.setUserPassword(MD5pwd2);
                    resultMap = CommonUtil.checkPwdUpdate(userMapper.updateByPrimaryKeySelective(user));
                } else {
                    //TODO 以下密码重复性验证 需放入前端JS验证  缓解服务器压力
                    resultMap.put(Constants.RESULT_CODE, Constants.RETURN_FAIL_FLAG);
                    resultMap.put(Constants.RESULT_MSG, "新密码与原始密码一致！修改失败...");
                }
            } else {
                resultMap.put(Constants.RESULT_CODE, Constants.RETURN_FAIL_FLAG);
                resultMap.put(Constants.RESULT_MSG, "两次输入的新密码不一致！修改失败...");
            }
        } else {
            resultMap.put(Constants.RESULT_CODE, Constants.RETURN_FAIL_FLAG);
            resultMap.put(Constants.RESULT_MSG, "原始密码输入错误！修改失败...");
        }
        return resultMap;
    }
}
