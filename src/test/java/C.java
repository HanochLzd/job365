import cn.soft.job.sys.pojo.po.User;
import org.junit.Test;

/**
 * @author Hanoch
 * @version 1.0
 * @date 2018/9/6 22:47
 */
public class C implements B {

    private String username;

//    public void test1() {
//        C c = new C();
//        System.out.println("[" + c.queryList() + "]");
//    }


    public String get() {
        return "";
    }

    public void get(int i) {
    }

    public void find(Object o) {
        System.out.println("Object");
    }

    public void find(String string) {
        System.out.println("String");
    }

    public C() {
    }

    public C(String username) {
        this.username = username;
    }
}
