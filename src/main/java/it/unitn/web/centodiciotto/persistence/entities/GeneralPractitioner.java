package it.unitn.web.centodiciotto.persistence.entities;

public class GeneralPractitioner extends User {
    private String firstName;
    private String lastName;
    private Province workingProvince;
    private String workingPlace;

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

    public Province getWorkingProvince() {
        return workingProvince;
    }

    public void setWorkingProvince(Province workingProvince) {
        this.workingProvince = workingProvince;
    }

    public String getWorkingPlace() {
        return workingPlace;
    }

    public void setWorkingPlace(String workingPlace) {
        this.workingPlace = workingPlace;
    }

    @Override
    public String toString() {
        return firstName + " " + lastName;
    }
}

