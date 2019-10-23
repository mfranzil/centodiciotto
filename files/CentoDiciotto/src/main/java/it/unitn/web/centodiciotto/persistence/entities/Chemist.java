package it.unitn.web.centodiciotto.persistence.entities;

public class Chemist extends User {
    private String name;
    private Province province;

    public String getName() {
        return this.name;
    }

    public void setName(String Name) {
        this.name = Name;
    }

    public Province getProvince() {
        return province;
    }

    public void setProvince(Province province) {
        this.province = province;
    }

}

