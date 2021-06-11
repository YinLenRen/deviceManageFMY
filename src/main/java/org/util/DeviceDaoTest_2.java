package org.util;

import org.dao.DeviceDao;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import java.text.DecimalFormat;
import java.text.NumberFormat;
import java.util.Scanner;

/*public class DeviceDaoTest_2 {
    public static void insertDevice(DeviceDao deviceDao, int deviceClassId){
        int i;
        long startTime = System.currentTimeMillis();
        for(i = 1 + (deviceClassId - 1)* 100000; i <= (deviceClassId - 1)* 100000 + 100000; i++){
            int price = (int)(Math.random()* 500 + 500 * deviceClassId);
            String deviceName = "device" + i;
            deviceDao.addDevice(i, deviceClassId, deviceName, String.valueOf(price));
        }
        double time = (System.currentTimeMillis() - startTime);
        NumberFormat numberFormat = new DecimalFormat("0.000");
        System.out.println("deviceClassId为" + deviceClassId + "的设备完成10万条数据插入的时间为："
                + numberFormat.format(time / 1000) + "s");
    }

    public static void main(String[] args){
        ApplicationContext ctx = new ClassPathXmlApplicationContext("spring.xml");
        DeviceDao d = (DeviceDao)ctx.getBean("myDeviceDao");
        System.out.print("插入数据请输入1， 查询数据请输入2");
        Scanner in = new Scanner(System.in);
        int ans = in.nextInt();
        while(true){
            if(ans == 1){
                for(int i = 1; i <= 6; i++){
                    insertDevice(d, i);
                }
                break;
            }
            else if(ans == 2){
                double startTime01 = System.currentTimeMillis();
                d.findDeviceByFuzzyWay1("学习", "device", String.valueOf(1500), String.valueOf(2000));
                double endTime01 = System.currentTimeMillis();
                NumberFormat numberFormat1 = new DecimalFormat("0.000");
                System.out.println("分类查询方法1（先根据Device筛选）的查询时间为：" + numberFormat1.format((endTime01 - startTime01)/ 1000 )+ "s");

                double startTime02 = System.currentTimeMillis();
                d.findDeviceByFuzzyWay2("学习", "device", String.valueOf(1500), String.valueOf(2000));
                double endTime02 = System.currentTimeMillis();
                NumberFormat numberFormat2 = new DecimalFormat("0.000");
                System.out.println("分类查询方法2（先根据Deviceclass筛选）的查询时间为：" + numberFormat2.format((endTime02 - startTime02)/ 1000 )+ "s");

                double startTime03 = System.currentTimeMillis();
                d.findDeviceByFuzzyWay3("学习", "device", String.valueOf(1500), String.valueOf(2000));
                double endTime03 = System.currentTimeMillis();
                NumberFormat numberFormat3 = new DecimalFormat("0.000");
                System.out.println("分类查询方法3（根据SQL IN查询）的查询时间为：" + numberFormat3.format((endTime03 - startTime03)/ 1000 )+ "s");

                double startTime04 = System.currentTimeMillis();
                d.findDeviceByFuzzyWay4("学习", "device", String.valueOf(1500), String.valueOf(2000));
                double endTime04 = System.currentTimeMillis();
                NumberFormat numberFormat4 = new DecimalFormat("0.000");
                System.out.println("分类查询方法4（先根据内连接）的查询时间为：" + numberFormat4.format((endTime04 - startTime04)/ 1000 )+ "s");

                break;

            }
            else{
                System.out.print("输入有误");
                ans = in.nextInt();
            }
        }
    }

}*/
