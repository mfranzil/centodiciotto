package it.unitn.web.centodiciotto.persistence.entities;

public class Chemist extends User {
    private String name;
    private String province;

    public String getName() {
        return this.name;
    }

    public void setName(String Name) {
        this.name = Name;
    }

    public String getProvince() {
        return province;
    }

    public void setProvince(String province) {
        this.province = province;
    }

}

