package it.unitn.web.centodiciotto.persistence.dao;

import it.unitn.web.centodiciotto.persistence.entities.SpecializedDoctor;
import it.unitn.web.persistence.dao.DAO;

import java.util.List;

public interface SpecializedDoctorDAO extends DAO<SpecializedDoctor, String> {

    public void insert(SpecializedDoctor specializedDoctor);

    public void update(SpecializedDoctor specializedDoctor);

    public void delete(SpecializedDoctor specializedDoctor);

    public SpecializedDoctor getByEmail(String email);

}
