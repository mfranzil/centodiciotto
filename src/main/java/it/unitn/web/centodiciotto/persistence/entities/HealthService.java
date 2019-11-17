package it.unitn.web.centodiciotto.persistence.entities;

/**
 * HealthService entity. Represents the "health_service" user class.
 * Subclasses {@link User} for authentication purposes.
 */
public class HealthService extends User {
    private Province operatingProvince;

    /**
     * Gets the operating province.
     *
     * @return the operating province
     */
    public Province getOperatingProvince() {
        return operatingProvince;
    }

    /**
     * Sets the operating province.
     *
     * @param operatingProvince the operating province
     */
    public void setOperatingProvince(Province operatingProvince) {
        this.operatingProvince = operatingProvince;
    }

    @Override
    public String toString() {
        return operatingProvince.getName() + " Health Service";
    }
}

