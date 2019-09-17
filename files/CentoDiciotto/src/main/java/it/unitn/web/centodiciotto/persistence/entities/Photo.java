package it.unitn.web.centodiciotto.persistence.entities;

import java.sql.Date;

public class Photo {
    private int photoid;
    private String email;
    private Date uploadDate;

    public Photo(int photoid, String email, Date uploadDate) {
        this.photoid = photoid;
        this.email = email;
        this.uploadDate = uploadDate;
    }

    public Photo(String email, Date uploadDate) {
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

    public Date getUploadDate() {
        return uploadDate;
    }

    public void setUploadDate(Date uploadDate) {
        this.uploadDate = uploadDate;
    }
}
