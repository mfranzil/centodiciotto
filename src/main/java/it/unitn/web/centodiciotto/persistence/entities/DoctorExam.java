package it.unitn.web.centodiciotto.persistence.entities;

/**
 * The type Doctor exam.
 */
public class DoctorExam {
    private String doctorID;
    private Integer examListID;

    /**
     * Gets doctor id.
     *
     * @return the doctor id
     */
    public String getDoctorID() {
        return doctorID;
    }

    /**
     * Sets doctor id.
     *
     * @param doctorID the doctor id
     */
    public void setDoctorID(String doctorID) {
        this.doctorID = doctorID;
    }

    /**
     * Gets exam list id.
     *
     * @return the exam list id
     */
    public Integer getExamListID() {
        return examListID;
    }

    /**
     * Sets exam list id.
     *
     * @param examListID the exam list id
     */
    public void setExamListID(Integer examListID) {
        this.examListID = examListID;
    }
}
