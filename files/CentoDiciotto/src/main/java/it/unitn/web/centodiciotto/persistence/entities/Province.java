package it.unitn.web.centodiciotto.persistence.entities;

public class Province {
    private Integer provinceID;
    private String provinceName;
    private String provinceAbbreviation;
    private String provinceRegion;

    public Integer getProvinceID() {
        return provinceID;
    }

    public void setProvinceID(Integer provinceID) {
        this.provinceID = provinceID;
    }

    public String getProvinceName() {
        return provinceName;
    }

    public void setProvinceName(String provinceName) {
        this.provinceName = provinceName;
    }

    public String getProvinceAbbreviation() {
        return provinceAbbreviation;
    }

    public void setProvinceAbbreviation(String provinceAbbreviation) {
        this.provinceAbbreviation = provinceAbbreviation;
    }

    public String getProvinceRegion() {
        return provinceRegion;
    }

    public void setProvinceRegion(String provinceRegion) {
        this.provinceRegion = provinceRegion;
    }
}
