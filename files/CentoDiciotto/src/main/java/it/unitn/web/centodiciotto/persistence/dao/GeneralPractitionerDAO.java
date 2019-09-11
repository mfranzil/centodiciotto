package it.unitn.web.centodiciotto.persistence.dao;

import it.unitn.web.centodiciotto.persistence.entities.GeneralPractitioner;
import it.unitn.web.centodiciotto.persistence.entities.Patient;
import it.unitn.web.persistence.dao.DAO;

import java.util.List;

public interface GeneralPractitionerDAO extends DAO<GeneralPractitioner, String> {

    public void insert(GeneralPractitioner generalPractitioner);

    public void update(GeneralPractitioner generalPractitioner);

    public void delete(GeneralPractitioner generalPractitioner);

    public GeneralPractitioner getByEmail(String email);

    public List<GeneralPractitioner> getByProvince(String province_abbreviation);
}
