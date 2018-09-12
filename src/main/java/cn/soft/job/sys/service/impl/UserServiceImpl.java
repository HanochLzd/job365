package cn.soft.job.sys.service.impl;

import cn.soft.job.common.utils.CommonUtil;
import cn.soft.job.common.utils.Constants;
import cn.soft.job.common.utils.JSONUtil;
import cn.soft.job.common.utils.MD5Util;
import cn.soft.job.sys.mapper.RoleMapper;
import cn.soft.job.sys.mapper.UserMapper;
import cn.soft.job.sys.pojo.po.User;
import cn.soft.job.sys.pojo.vo.UserQueryVo;
import cn.soft.job.sys.service.UserService;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.*;

/**
 * @author Hanoch
 * @version 1.0
 * @date 2018/9/10 9:37
 */
@Service
public class UserServiceImpl implements UserService {

    private Logger logger = Logger.getLogger(UserServiceImpl.class);

    @Autowired
    private UserMapper userMapper;

    @Autowired
    private RoleMapper roleMapper;

    @Override
    public User selectByUserName(String userName) {
        return userMapper.selectByUserName(userName);
    }

    @Override
    @Transactional(rollbackFor = RuntimeException.class)
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
                    user.setUpdateDate(new Date());
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

    @Override
    public String getUserList(UserQueryVo userQueryVo) {
        List<User> userList;
        //获取用户数量
        int count = getCount(userQueryVo);
        if (count <= 0) {
            userList = new ArrayList<>();
        } else {
            //获取分页内容
            userList = userMapper.selectByExample(userQueryVo);
        }
        return JSONUtil.getDataTableJson(userList, userQueryVo.getsEcho(), count);
    }

    @Override
    public User selectByPrimiary(int id) {
        return userMapper.selectByPrimiary(id);
    }

    @Override
    @Transactional(rollbackFor = RuntimeException.class)
    public int updateByPrimaryKeySelective(User user) {
        return userMapper.updateByPrimaryKeySelective(user);
    }

    @Override
    public int getUserNumber(User user, String op) {

        logger.info("获取用户数量 ...");
        //定义参数集合
        Map<String, Object> paramsMap = new HashMap<>(16);
        //将用户编号、用户名和操作类型封装入参数集合
        paramsMap.put("id", user.getId());
        paramsMap.put("userName", user.getUserName());
        paramsMap.put("op", op);
        return userMapper.getUserNumber(paramsMap);

    }

    @Override
    @Transactional(rollbackFor = RuntimeException.class)
    public int insert(User user) {
        return userMapper.insert(user);
    }

    @Override
    @Transactional(rollbackFor = RuntimeException.class)
    public int deleteByPrimiary(int id) {
        roleMapper.deleteRoleById(id);
        return userMapper.deleteByPrimiary(id);
    }

    @Override
    @Transactional(rollbackFor = RuntimeException.class)
    public int updateUserStatus(int id) {
        return userMapper.updateUserStatus(id);
    }

    @Override
    @Transactional(rollbackFor = RuntimeException.class)
    public int batchDeleteUsers(String ids) {
        logger.info("批量删除用户信息...");
        String[] idArr = ids.split(",");
        for (String id : idArr) {
            roleMapper.deleteRoleById(Integer.parseInt(id));
        }
        return userMapper.batchDeleteUsers(idArr);
    }

    @Override
    @Transactional(rollbackFor = RuntimeException.class)
    public int giveRole(int id, String roleIds) {
        roleMapper.deleteRoleById(id);
        String[] roleIdArray = roleIds.split(",");
        List<Integer> list = new ArrayList<>();
        for (int i = 0; i < roleIdArray.length; i++) {
            if (i < roleIdArray.length - 1) {
                list.add(Integer.parseInt(roleIdArray[i + 1]));
            }
        }
        System.out.println(id);
        System.out.println(list);
        return roleMapper.giveRole(id, list);
    }

    private int getCount(UserQueryVo userQueryVo) {
        logger.info("获取用户数量...");
        return userMapper.getCount(userQueryVo);
    }
}
