package it.unitn.web.centodiciotto.persistence.entities;

public class Chemist extends User {
    private String name;
    private String chemistProvince;

    public String getName() {
        return this.name;
    }

    public void setName(String Name) {
        this.name = Name;
    }

    public String getChemistProvince() {
        return chemistProvince;
    }

    public void setChemistProvince(String chemistProvince) {
        this.chemistProvince = chemistProvince;
    }

}

