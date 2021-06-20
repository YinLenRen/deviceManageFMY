package app.action.imp;

import app.action.InformationAction;
import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.opensymphony.xwork2.ActionSupport;
import org.apache.struts2.ServletActionContext;
import org.apache.struts2.interceptor.ServletRequestAware;
import org.apache.struts2.interceptor.ServletResponseAware;
import org.dao.InformationDao;
import org.model.Information;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.*;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.UUID;

public class InformationActionImp extends ActionSupport implements InformationAction, ServletRequestAware, ServletResponseAware {

    HttpServletRequest request;
    HttpServletResponse response;
    InformationDao informationDao;
    private String informationImageFileName;

    public String getInformationImageFileName() {
        return informationImageFileName;
    }

    public void setInformationImageFileName(String informationImageFileName) {
        this.informationImageFileName = informationImageFileName;
    }

    public void setInformationDao(InformationDao informationDao) {
        this.informationDao = informationDao;
    }

    @Override
    public void findAllInformation() throws IOException {
        List<Information> list = informationDao.findAllInformation();
        makeJson(list);
    }

    void makeJson(List<Information> list) throws IOException {
        response.setHeader("Content-Type", "text/html;charset=utf-8");
        PrintWriter out = response.getWriter();
        JSONArray jsonArray = new JSONArray();
        for(Information i : list){
            JSONObject jsonObject = new JSONObject();
            jsonObject.put("InformationID", i.getInformationId());
            jsonObject.put("InformationContent", i.getInformationContent());
            jsonObject.put("InformationImage", i.getInformationImage());
            jsonObject.put("InformationCreateTime", i.getInfomationCreateTime());
            jsonArray.add(jsonObject);
        }
        System.out.println(jsonArray.toString());
        JSONObject root = new JSONObject();
        root.put("result", jsonArray);
        out.write(root.toString());
        out.flush();
        out.close();
    }

    @Override
    public void findInformationById() throws IOException {
        String id = request.getParameter("informationId");
        Information in = informationDao.findInformationById(new Integer(id));
        List<Information> list = new ArrayList<Information>();
        list.add(in);
        makeJson(list);
    }

    @Override
    public void addInformationFromJquery() throws IOException {
        String informationTitle = request.getParameter("informationTitle");
        String informationImage = request.getParameter("informationImage");
        String informationBrief = request.getParameter("informationBrief");
        String informationMainBody = request.getParameter("informationMainBody");
        Information information = new Information();
        //拼接
        String informationContent = "<x>" + informationTitle + "</x>" + "<x>" + informationBrief + "</x>" +
                "<x>" + informationMainBody + "</x>";
        information.setInformationContent(informationContent);
        //SimpleDateFormat生成一个带年月日时分秒的日期
        SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        information.setInfomationCreateTime(format.format(new Date()));
        //informationImageFileName是标题图片文件名
        if(informationImageFileName != null){
            //realPath是tomcat标题图片的存放地址，在tomcat/.../image下
            String realPath = ServletActionContext.getRequest().getRealPath("/image");
            //hz是文件名在.之后的后缀（.png）
            String hz = informationImageFileName.substring(informationImageFileName.lastIndexOf("."));
            //生成UUID来标识一些唯一的信息，newFileName是web服务器上的标题图片文件名，本地地址上传到web端
            String newFileName = UUID.randomUUID().toString() + hz;
            OutputStream os = new FileOutputStream(new File(realPath, newFileName));
            String titleImageFullName = "<img src=\"http://localhost:8080/DeviceManage/image/" + newFileName;
            information.setInformationImage(titleImageFullName);
            InputStream is = new FileInputStream(informationImage);
            byte flush[] = new byte[1024];
            int len = 0;
            while(0 <=(len= is.read(flush))){
                os.write(flush, 0, len);
            }
            is.close();
            os.close();
        }
        else {
            System.out.println("未上传图片");
        }
        informationDao.addInformation(information);
    }

    @Override
    public void showInformationByIdFromWebPortol() throws IOException {
        String infoId = request.getParameter("infoId");
        response.setHeader("Content-Type", "text/html;charset=utf-8");
        PrintWriter out = response.getWriter();
        Information information = informationDao.findInformationById(new Integer(infoId));
        if(information != null){
            String array[] = information.getInformationContent().split("<x>");
            String richtext = "<html><body><head>" + "<meta name='viewport' content='width=device-width, intial-scale=1.0, inimum-scale=0.5, maximum-scale=2.0, user-scalable=yes'/>" +
                    " <style>img{ max-width:100%; height:auto; }</style></head>" +
                    "<div class = 'text' style = 'text-align:center; font-size:35px'><strong>" + array[1]
                    + "</strong></div>"
                    + "<div class = 'text' style='text-align:center'>"
                    + information.getInformationImage()
                    + "</div>"
                    +"<div class='text' style='text-align:right'>"
                    + information.getInfomationCreateTime()
                    + "</div>"
                    + "<div class='text' style='text-align:center;font-size:20px;font-style: italic;'><p><strong>"
                    + array[2] + "</strong></p></div>" + "<p>"
                    + array[3] + "</p></body></html>";
            out.write(richtext);
            out.flush();
            out.close();
        }
    }

    @Override
    public void showInformationByIdFromAppPortol() throws IOException {
        String infoId = request.getParameter("infoId");
        response.setHeader("Content-Type", "text/html;charset=utf-8");
        PrintWriter out = response.getWriter();
        Information information = informationDao.findInformationById(new Integer(infoId));
        if (information != null) {
            String[] array = information.getInformationContent().split("<x>");
// 在移动app端上显示图片时，必须省略array[3]正文内容中的http://localhost:8080，否则无法显示图片
            String str = array[3];
            array[3] = str.replace("http://localhost:8080", "");
            String richtext = "<html><body><head>" + "<meta name='viewport' content='width=device-width, initial-scale=1.0, inimum-scale=0.5,maximum-scale=2.0,user-scalable=yes'/>"
                    + "<style>img{max-width:100%;height:auto;}</style></head>"
                    + "<div class='text' style='text-align:center;font-size:35px'><strong>"
                    + array[1]
                    + "</strong></div>"
                    + "<div class='text' style='text-align:center'>"
                    + information.getInformationImage()
                    + "</div>"
                    + "<div class='text' style='text-align:right'>"
                    + information.getInfomationCreateTime()
                    + "</div>"
                    + "<div class='text' style='text-align:center;font-size:20px;font-style: italic;'><p><strong>"
                    + array[2] + "</strong></p></div>" + "<p>"
                    + array[3] + "</p></body></html>";
            out.write(richtext);
            out.flush();
            out.close();
        }
    }

    @Override
    public void deleteInformation() {
        String id = request.getParameter("informationId");
        Information information = informationDao.findInformationById(new Integer(id));
        informationDao.deleteInformation(information);
    }

    @Override
    public void setServletRequest(HttpServletRequest httpServletRequest) {
        this.request = httpServletRequest;
    }

    @Override
    public void setServletResponse(HttpServletResponse httpServletResponse) {
        this.response = httpServletResponse;
    }
}
