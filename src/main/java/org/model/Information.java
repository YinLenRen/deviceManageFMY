package org.model;

public class Information {
    private Integer informationId;
    private String informationContent;
    private String informationImage;
    private String infomationCreateTime;

    public Integer getInformationId() {
        return informationId;
    }

    public void setInformationId(Integer informationId) {
        this.informationId = informationId;
    }

    public String getInformationContent() {
        return informationContent;
    }

    public void setInformationContent(String informationContent) {
        this.informationContent = informationContent;
    }

    public String getInformationImage() {
        return informationImage;
    }

    public void setInformationImage(String informationImage) {
        this.informationImage = informationImage;
    }

    public String getInfomationCreateTime() {
        return infomationCreateTime;
    }

    public void setInfomationCreateTime(String infomationCreateTime) {
        this.infomationCreateTime = infomationCreateTime;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        Information that = (Information) o;

        if (informationId != null ? !informationId.equals(that.informationId) : that.informationId != null)
            return false;
        if (informationContent != null ? !informationContent.equals(that.informationContent) : that.informationContent != null)
            return false;
        if (informationImage != null ? !informationImage.equals(that.informationImage) : that.informationImage != null)
            return false;
        if (infomationCreateTime != null ? !infomationCreateTime.equals(that.infomationCreateTime) : that.infomationCreateTime != null)
            return false;

        return true;
    }

    @Override
    public int hashCode() {
        int result = informationId != null ? informationId.hashCode() : 0;
        result = 31 * result + (informationContent != null ? informationContent.hashCode() : 0);
        result = 31 * result + (informationImage != null ? informationImage.hashCode() : 0);
        result = 31 * result + (infomationCreateTime != null ? infomationCreateTime.hashCode() : 0);
        return result;
    }
}
