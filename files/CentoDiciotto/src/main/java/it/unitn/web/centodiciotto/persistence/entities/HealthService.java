package it.unitn.web.centodiciotto.persistence.entities;

public class HealthService extends User {
    private String OperatingProvince;

    public String getOperatingProvince() {
        return OperatingProvince;
    }

    public void setOperatingProvince(String operatingProvince) {
        this.OperatingProvince = operatingProvince;
    }
}

