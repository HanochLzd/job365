package cn.soft.job.sys.pojo.vo;

import cn.soft.job.sys.pojo.po.User;

/**
 * User条件结果集
 *
 * @author Hanoch
 * @version 1.0
 * @date 2018/9/11 9:39
 */
public class UserQueryVo {

    private User user;

    /**
     * 点击数的计数器，不是页码
     */
    private int sEcho;

    /**
     * 每页起始数
     */
    private int iDisplayStart;


    /**
     * 这个属性就是每页显示的行数
     */
    private int iDisplayLength;

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public int getsEcho() {
        return sEcho;
    }

    public void setsEcho(int sEcho) {
        this.sEcho = sEcho;
    }

    public int getiDisplayStart() {
        return iDisplayStart;
    }

    public void setiDisplayStart(int iDisplayStart) {
        this.iDisplayStart = iDisplayStart;
    }

    public int getiDisplayLength() {
        return iDisplayLength;
    }

    public void setiDisplayLength(int iDisplayLength) {
        this.iDisplayLength = iDisplayLength;
    }

    @Override
    public String toString() {
        return "UserQueryVo{" +
                "user=" + user +
                ", sEcho=" + sEcho +
                ", iDisplayStart=" + iDisplayStart +
                ", iDisplayLength=" + iDisplayLength +
                '}';
    }
}
