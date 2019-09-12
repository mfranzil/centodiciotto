package it.unitn.web.centodiciotto.persistence.entities;

public class Chemist extends User{
        private String Name;
        private String ChemistProvince;

        public Chemist(String email, String password, String Name, String ChemistProvince) {
            super(email, password);
            this.Name = Name;
            this.ChemistProvince = ChemistProvince;
        }

        public String getName() {
            return this.Name;
        }

        public void setName(String Name) {
            this.Name = Name;
        }

        public String getChemistProvince() {
            return ChemistProvince;
        }

        public void setChemistProvince(String chemistProvince) {
            this.ChemistProvince = chemistProvince;
        }
}

