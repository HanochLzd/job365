import org.junit.Test;

import java.util.ArrayList;
import java.util.List;

/**
 * @author Hanoch
 * @version 1.0
 * @date 2018/9/6 14:40
 */
public class ATest extends Thread{

    @Test
    public void test() {
        long i = 2132343243242342321L;
        System.out.println('你');
        List lsit = new ArrayList();

        int[] a = new int[3];

        String b = "1234";
        String b2 = new String("4");
        String b3 = "123";
        String b5 = b3 + "4";
        String b4 = new String("123");


        System.out.println(b == b2);
        System.out.println(b == b3);
        System.out.println(b2 == b4);

        System.out.println(b == b5);

        char[] chars = new char[2];
        System.out.println(chars);

        throw new RuntimeException();
    }

    @Test
    public void test2() throws InterruptedException {
         ATest aTest = new ATest();
         aTest.start();
         Thread.sleep(1000);
         System.out.println(aTest.isAlive());
        Thread thread = new Thread(aTest);
    }

//    @Override
//    public void run() {
//        super.run();
//        try {
//            Thread.sleep(1000);
//        } catch (InterruptedException e) {
//            e.printStackTrace();
//        }
//    }
}
