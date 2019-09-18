package it.unitn.web.centodiciotto.persistence.entities;

import java.sql.Timestamp;

public class Photo {
    private int photoid;
    private String email;
    private Timestamp uploadDate;

    public Photo(int photoid, String email, Timestamp uploadDate) {
        this.photoid = photoid;
        this.email = email;
        this.uploadDate = uploadDate;
    }

    public Photo(String email, Timestamp uploadDate) {
        this.email = email;
        this.uploadDate = uploadDate;
    }

    public int getPhotoid() {
        return photoid;
    }

    public void setPhotoid(int photoid) {
        this.photoid = photoid;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public Timestamp getUploadDate() {
        return uploadDate;
    }

    public void setUploadDate(Timestamp uploadDate) {
        this.uploadDate = uploadDate;
    }
}
