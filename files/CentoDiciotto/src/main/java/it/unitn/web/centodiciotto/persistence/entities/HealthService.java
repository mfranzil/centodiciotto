package it.unitn.web.centodiciotto.persistence.entities;

public class HealthService extends User {
    private String operatingProvince;

    public String getOperatingProvince() {
        return operatingProvince;
    }

    public void setOperatingProvince(String operatingProvince) {
        this.operatingProvince = operatingProvince;
    }
}

