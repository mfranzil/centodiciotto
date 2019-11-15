package it.unitn.web.centodiciotto.persistence.entities;

/**
 * The type Doctor exam.
 */
public class DoctorExam {
    private String doctorID;
    private Integer examListID;

    /**
     * Gets the doctorID
     *
     * @return the doctorID
     */
    public String getDoctorID() {
        return doctorID;
    }

    /**
     * Sets the doctorID
     *
     * @param doctorID the doctorID
     */
    public void setDoctorID(String doctorID) {
        this.doctorID = doctorID;
    }

    /**
     * Gets the exam listID.
     *
     * @return the exam listID
     */
    public Integer getExamListID() {
        return examListID;
    }

    /**
     * Sets the exam listID.
     *
     * @param examListID the exam listID
     */
    public void setExamListID(Integer examListID) {
        this.examListID = examListID;
    }
}
