package it.unitn.web.utils;

import it.unitn.web.centodiciotto.persistence.dao.GeneralPractitionerDAO;
import it.unitn.web.centodiciotto.persistence.dao.PatientDAO;
import it.unitn.web.centodiciotto.persistence.dao.ProvinceDAO;
import it.unitn.web.centodiciotto.persistence.entities.GeneralPractitioner;
import it.unitn.web.centodiciotto.persistence.entities.Patient;
import it.unitn.web.centodiciotto.persistence.entities.Province;
import it.unitn.web.persistence.dao.exceptions.DAOException;
import it.unitn.web.persistence.dao.exceptions.DAOFactoryException;
import it.unitn.web.persistence.dao.factories.DAOFactory;

import javax.servlet.ServletContext;

public class UserService {

    private static ServletContext sc;

    private static PatientDAO patientDAO;
    private static ProvinceDAO provinceDAO;
    private static GeneralPractitionerDAO practitionerDAO;

    public static void configure(DAOFactory daoFactory, ServletContext servletContext) throws RuntimeException {
        sc = servletContext;

        if (daoFactory == null) {
            throw new RuntimeException("Impossible to get dao factory for user storage system");
        }
        try {
            patientDAO = daoFactory.getDAO(PatientDAO.class);
            provinceDAO = daoFactory.getDAO(ProvinceDAO.class);
            practitionerDAO = daoFactory.getDAO(GeneralPractitionerDAO.class);
        } catch (DAOFactoryException ex) {
            throw new RuntimeException("Impossible to get dao factory for user storage system", ex);
        }
    }

    public static Patient powerUpPatient(Patient patient) throws RuntimeException {
        if (patient == null) {
            return null;
        }

        try {
            // TODO change back to working
            Province province = provinceDAO.getByAbbreviation(patient.getLivingProvince());
            //patient.setProvinceFullName(province.getProvinceName() + " (" + province.getProvinceAbbreviation() + ")");

            GeneralPractitioner generalPractitioner = practitionerDAO.getByPrimaryKey(patient.getPractitionerID());
            //patient.setPractitionerFirstName(generalPractitioner.getFirstName());
            //patient.setPractitionerLastName(generalPractitioner.getLastName());

            //patient.setCurrentPhotoPath(PhotoService.getLastPhoto(patient));
        } catch (DAOException e) {
            throw new RuntimeException("Cannot contact DAO.", e);
        }

        return patient;
    }
}
