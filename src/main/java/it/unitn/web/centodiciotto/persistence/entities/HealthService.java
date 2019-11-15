package it.unitn.web.centodiciotto.persistence.entities;

/**
 * The type Health service.
 */
public class HealthService extends User {
    private Province operatingProvince;

    /**
     * Gets operating province.
     *
     * @return the operating province
     */
    public Province getOperatingProvince() {
        return operatingProvince;
    }

    /**
     * Sets operating province.
     *
     * @param operatingProvince the operating province
     */
    public void setOperatingProvince(Province operatingProvince) {
        this.operatingProvince = operatingProvince;
    }
}

