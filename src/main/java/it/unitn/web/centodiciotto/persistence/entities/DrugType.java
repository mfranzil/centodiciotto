package it.unitn.web.centodiciotto.persistence.entities;

public class DrugType {
    private Integer ID;
    private String description;

    public Integer getID() {
        return ID;
    }

    public void setID(Integer ID) {
        this.ID = ID;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }
}
