package web.action.imp;

import com.opensymphony.xwork2.ActionSupport;
import org.apache.struts2.ServletActionContext;
import org.apache.struts2.interceptor.ServletRequestAware;
import org.apache.struts2.interceptor.ServletResponseAware;
import org.dao.InformationDao;
import org.model.Information;
import web.action.InformationAction;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.*;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.UUID;

public class InformationActionImp extends ActionSupport implements InformationAction {

    private String informationImage;
    private String informationTitle;
    private String informationImageFileName;
    private String informationBrief;
    private String informationMainBody;
    InformationDao informationDao;
    private String infoId;

    public String getInfoId() {
        return infoId;
    }

    public void setInfoId(String infoId) {
        this.infoId = infoId;
    }

    public void setInformationDao(InformationDao informationDao) {
        this.informationDao = informationDao;
    }

    public String getInformationImage() {
        return informationImage;
    }

    public void setInformationImage(String informationImage) {
        this.informationImage = informationImage;
    }

    public String getInformationTitle() {
        return informationTitle;
    }

    public void setInformationTitle(String informationTitle) {
        this.informationTitle = informationTitle;
    }

    public String getInformationImageFileName() {
        return informationImageFileName;
    }

    public void setInformationImageFileName(String informationImageFileName) {
        this.informationImageFileName = informationImageFileName;
    }

    public String getInformationBrief() {
        return informationBrief;
    }

    public void setInformationBrief(String informationBrief) {
        this.informationBrief = informationBrief;
    }

    public String getInformationMainBody() {
        return informationMainBody;
    }

    public void setInformationMainBody(String informationMainBody) {
        this.informationMainBody = informationMainBody;
    }

    @Override
    public String addInformation() throws IOException {
        Information information = new Information();
      //  informationMainBody = informationMainBody
        //??????
        String informationContent = "<x>" + informationTitle + "</x>" + "<x>" + informationBrief + "</x>" +
                "<x>" + informationMainBody + "</x>";
        information.setInformationContent(informationContent);
        //SimpleDateFormat??????????????????????????????????????????
        SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        information.setInfomationCreateTime(format.format(new Date()));
        //informationImageFileName????????????????????????
        if(informationImageFileName != null){
            //realPath???tomcat?????????????????????????????????tomcat/.../image???
            String realPath = ServletActionContext.getRequest().getRealPath("/image");
            //hz???????????????.??????????????????.png???
            String hz = informationImageFileName.substring(informationImageFileName.lastIndexOf("."));
            //??????UUID?????????????????????????????????newFileName???web????????????????????????????????????????????????????????????web???
            String newFileName = UUID.randomUUID().toString() + hz;
            OutputStream os = new FileOutputStream(new File(realPath, newFileName));
            String titleImageFullName = "<img src=\"http://localhost:8080/DeviceManage/image/" + newFileName + " \"/>";
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
            System.out.println("???????????????");
        }
        informationDao.addInformation(information);
        return SUCCESS;

    }

    @Override
    public String updateInformation() throws IOException {

        Information information = informationDao.findInformationById(new Integer(infoId));
        //??????
        String informationContent = "<x>" + informationTitle + "</x>" + "<x>" + informationBrief + "</x>" +
                "<x>" + informationMainBody + "</x>";
        information.setInformationContent(informationContent);
        //SimpleDateFormat??????????????????????????????????????????
        SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        information.setInfomationCreateTime(format.format(new Date()));
        //informationImageFileName????????????????????????
        if(informationImageFileName != null){
            //realPath???tomcat?????????????????????????????????tomcat/.../image???
            String realPath = ServletActionContext.getRequest().getRealPath("/image");
            //hz???????????????.??????????????????.png???
            String hz = informationImageFileName.substring(informationImageFileName.lastIndexOf("."));
            //??????UUID?????????????????????????????????newFileName???web????????????????????????????????????????????????????????????web???
            String newFileName = UUID.randomUUID().toString() + hz;
            OutputStream os = new FileOutputStream(new File(realPath, newFileName));
            String titleImageFullName = "<img src=\"http://localhost:8080/DeviceManage/image/" + newFileName + " \"/>";
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
            System.out.println("???????????????");
        }
        informationDao.updateInformation(information);
        return SUCCESS;
    }

}
