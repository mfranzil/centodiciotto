package it.unitn.web.centodiciotto.persistence.dao;

import it.unitn.web.centodiciotto.persistence.entities.SpecializedDoctor;
import it.unitn.web.persistence.dao.DAO;

public interface SpecializedDoctorDAO extends DAO<SpecializedDoctor, String> {

    void insert(SpecializedDoctor specializedDoctor);

    void update(SpecializedDoctor specializedDoctor);

    void delete(SpecializedDoctor specializedDoctor);

}
