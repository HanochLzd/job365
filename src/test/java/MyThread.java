/**
 * @author Hanoch
 * @version 1.0
 * @date 2018/9/25 16:37
 */
public class MyThread extends Thread {

    @Override
    public void run() {
        super.run();
        for (int i = 0; i < 50000; i++) {
            System.out.println("i=" + (i + 1));
        }
    }
}
