package cn.soft.job.sys.mapper;

import cn.soft.job.sys.pojo.po.User;
import cn.soft.job.sys.pojo.vo.UserQueryVo;

import java.util.List;
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

    int getCount(UserQueryVo userQueryVo);

    List<User> selectByExample(UserQueryVo userQueryVo);

    User selectByPrimiary(int id);

    int getUserNumber(Map<String, Object> paramsMap);

    int insert(User user);

    int deleteByPrimiary(int id);

    int updateUserStatus(int id);

    int batchDeleteUsers(String[] idArr);
}
