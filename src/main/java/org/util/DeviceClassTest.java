package org.util;

import org.dao.DeviceDao;

import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import java.text.DecimalFormat;
import java.text.NumberFormat;

/*public class DeviceClassTest {

    static ApplicationContext context = new ClassPathXmlApplicationContext("spring.xml");
    static DeviceDao d = (DeviceDao) context.getBean("myDeviceDao");

    public static void main(String[] args) {
        Runnable instance1 = new RunnableTest();
        //用Thread类来创建目标线程，并start()启动线程
        Thread c1 = new Thread(instance1, "1");
        Thread c2 = new Thread(instance1, "2");
        Thread c3 = new Thread(instance1, "3");
        Thread c4 = new Thread(instance1, "4");
        Thread c5 = new Thread(instance1, "5");
        Thread c6 = new Thread(instance1, "6");
        c1.start();
        c2.start();
        c3.start();
        c4.start();
        c5.start();
        c6.start();

    }

    public static class RunnableTest implements Runnable {
        /**
         * run()方法同样是线程执行体
         */
       /* @Override
        public void run() {
            insertDevice(d, new Integer(Thread.currentThread().getName()));

        }
    }

    public static void insertDevice(DeviceDao deviceDao, int deviceClassId){
        int i;
        long startTime = System.currentTimeMillis();
        for (i = 1 + (deviceClassId - 1)* 100000; i <= (deviceClassId - 1)* 100000 + 100000; i++){
            int price = (int)(Math.random()* 500 + 500 * deviceClassId);
            String deviceName = "device" + i;
            deviceDao.addDevice(i, deviceClassId, deviceName, String.valueOf(price));
        }
        double time = System.currentTimeMillis() - startTime;
        NumberFormat numberFormat = new DecimalFormat("0.000"); //数字格式化类，输出小数点后3位
        System.out.println("Thread" + deviceClassId + "->" + numberFormat.format(time / 1000) + "s");
    }
}*/
