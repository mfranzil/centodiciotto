package it.unitn.web.centodiciotto.persistence.entities;

public class HealthService extends User{
        private String OperatingProvince;

        public HealthService(String email, String hash, String salt, String OperatingProvince) {
            super(email, hash, salt);
            this.OperatingProvince = OperatingProvince;
        }

        public String getOperatingProvince() {
            return OperatingProvince;
        }

        public void setOperatingProvince(String operatingProvince) {
            this.OperatingProvince = operatingProvince;
        }
}

