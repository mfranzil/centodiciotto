package it.unitn.web.centodiciotto.persistence.entities;

public class GeneralPractitioner extends User{
        private String firstName;
        private String lastName;
        private String workingProvince;

        public GeneralPractitioner(String email, String password, String firstName, String lastName, String workingProvince) {
            super(email, password);
            this.firstName = firstName;
            this.lastName = lastName;
            this.workingProvince = workingProvince;
        }

        public String getFirstName() {
            return firstName;
        }

        public void setFirstName(String firstName) {
            this.firstName = firstName;
        }

        public String getLastName() {
            return lastName;
        }

        public void setLastName(String lastName) {
            this.lastName = lastName;
        }

        public String getWorkingProvince() {
            return workingProvince;
        }

        public void setWorkingProvince(String workingProvince) {
            this.workingProvince = workingProvince;
        }
}

