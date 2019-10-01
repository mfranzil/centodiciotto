package it.unitn.web.centodiciotto.persistence.entities;

import java.sql.Timestamp;

public class Photo {
    private Integer photoId;
    private String patientEmail;
    private Timestamp uploadDate;

    public Photo(Integer photoId, String patientEmail, Timestamp uploadDate) {
        this.photoId = photoId;
        this.patientEmail = patientEmail;
        this.uploadDate = uploadDate;
    }

    public Photo(String patientEmail, Timestamp uploadDate) {
        this.patientEmail = patientEmail;
        this.uploadDate = uploadDate;
    }

    public Integer getPhotoId() {
        return photoId;
    }

    public void setPhotoId(int photoId) {
        this.photoId = photoId;
    }

    public String getPatientEmail() {
        return patientEmail;
    }

    public void setPatientEmail(String patientEmail) {
        this.patientEmail = patientEmail;
    }

    public Timestamp getUploadDate() {
        return uploadDate;
    }

    public void setUploadDate(Timestamp uploadDate) {
        this.uploadDate = uploadDate;
    }
}
