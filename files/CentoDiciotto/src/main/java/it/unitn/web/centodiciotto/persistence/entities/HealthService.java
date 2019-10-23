package it.unitn.web.centodiciotto.persistence.entities;

public class HealthService extends User {
    private Province operatingProvince;

    public Province getOperatingProvince() {
        return operatingProvince;
    }

    public void setOperatingProvince(Province operatingProvince) {
        this.operatingProvince = operatingProvince;
    }
}

