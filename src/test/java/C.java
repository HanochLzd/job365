import org.junit.Test;

/**
 * @author Hanoch
 * @version 1.0
 * @date 2018/9/6 22:47
 */
public class C implements B {


    @Test
    public void test1(){
        C c = new C();
        System.out.println("["+c.queryList()+"]");
    }
}
