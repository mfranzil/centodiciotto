package it.unitn.web.centodiciotto.services;

import it.unitn.web.centodiciotto.persistence.dao.*;
import it.unitn.web.centodiciotto.persistence.dao.exceptions.DAOException;
import it.unitn.web.centodiciotto.persistence.dao.exceptions.DAOFactoryException;
import it.unitn.web.centodiciotto.persistence.dao.factories.DAOFactory;
import it.unitn.web.centodiciotto.persistence.entities.*;
import org.jxls.common.Context;
import org.jxls.util.JxlsHelper;

import javax.servlet.ServletContext;
import java.io.*;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

public class ExcelService {

    private static ExcelService instance;

    private transient ServletContext sc;

    private transient PatientDAO patientDAO;
    private transient GeneralPractitionerDAO practitionerDAO;
    private transient SpecializedDoctorDAO specializedDoctorDAO;
    private transient ChemistDAO chemistDAO;
    private transient HealthServiceDAO healthServiceDAO;

    private transient ExamDAO examDAO;
    private transient VisitDAO visitDAO;
    private transient DrugPrescriptionDAO drugPrescriptionDAO;

    private ExcelService(DAOFactory daoFactory, ServletContext servletContext) throws ServiceException {
        sc = servletContext;
        if (daoFactory == null) {
            throw new ServiceException("DAOFactory is null.");
        }
        try {
            patientDAO = daoFactory.getDAO(PatientDAO.class);
            practitionerDAO = daoFactory.getDAO(GeneralPractitionerDAO.class);
            specializedDoctorDAO = daoFactory.getDAO(SpecializedDoctorDAO.class);
            chemistDAO = daoFactory.getDAO(ChemistDAO.class);
            healthServiceDAO = daoFactory.getDAO(HealthServiceDAO.class);

            examDAO = daoFactory.getDAO(ExamDAO.class);
            visitDAO = daoFactory.getDAO(VisitDAO.class);
            drugPrescriptionDAO = daoFactory.getDAO(DrugPrescriptionDAO.class);
        } catch (DAOFactoryException e) {
            throw new ServiceException("Error in DAO retrieval: ", e);
        }
    }

    public static void configure(DAOFactory daoFactory, ServletContext servletContext) throws ServiceException {
        if (instance == null) {
            instance = new ExcelService(daoFactory, servletContext);
        } else {
            throw new ServiceException("ExcelService already configured. You can call configure only one time");
        }
    }

    public static ExcelService getInstance() throws ServiceException {
        if (instance == null) {
            throw new ServiceException("ExcelService not yet configured. " +
                    "Call ExcelService.configure() before use the class");
        }
        return instance;
    }

    public String createReport(String healthServiceID, Date date, boolean includeVisits, boolean includeRecalls,
                               boolean includeSpecialistExams, boolean includeHealthServiceExams,
                               boolean includePrescriptions) throws ServiceException {
        try {
            HealthService healthService = healthServiceDAO.getByPrimaryKey(healthServiceID);

            Report report = new Report(healthService.getOperatingProvince().getRegion(),
                    healthService.getOperatingProvince().toString(),
                    new SimpleDateFormat("dd/MM/yyyy").format(date));

            int i = 0;
            List<Entry> entries = new ArrayList<>();

            if (includeVisits) {
                List<Visit> visits = visitDAO.getByDate(new Timestamp(date.getTime()));

                for (Visit visit : visits) {
                    Patient patient = patientDAO.getByPrimaryKey(visit.getPatientID());
                    GeneralPractitioner generalPractitioner = practitionerDAO.getByPrimaryKey(visit.getPractitionerID());

                    Entry entry = new Entry(++i,
                            patient.getID(), patient.getFirstName(), patient.getLastName(),
                            "VISIT",
                            generalPractitioner.getID(), generalPractitioner.getFirstName(), generalPractitioner.getLastName(),
                            0);
                    entries.add(entry);
                }
            }

            if (includeSpecialistExams || includeHealthServiceExams || includeRecalls) {
                List<Exam> exams = examDAO.getByDate(new Timestamp(date.getTime()));

                for (Exam exam : exams) {
                    Entry entry;
                    Patient patient = patientDAO.getByPrimaryKey(exam.getPatientID());

                    if ((exam.isRecall() && includeRecalls)
                            || (!exam.isRecall() && exam.getHealthServiceID() == null && includeSpecialistExams)) {
                        // Recall, specialistExam
                        SpecializedDoctor specializedDoctor = specializedDoctorDAO.getByPrimaryKey(exam.getDoctorID());

                        entry = new Entry(i++,
                                patient.getID(), patient.getFirstName(), patient.getLastName(),
                                exam.isRecall() ? "RECALL" : "SPECIALIST_EXAM",
                                specializedDoctor.getID(), specializedDoctor.getFirstName(), specializedDoctor.getLastName(),
                                exam.getTicket());
                    } else if (!exam.isRecall() && exam.getDoctorID() == null && includeHealthServiceExams) { // Health Service Exams
                        entry = new Entry(i++,
                                patient.getID(), patient.getFirstName(), patient.getLastName(),
                                "HEALTH_SERVICE_EXAM",
                                healthServiceID, "", "",
                                exam.getTicket());
                    } else {
                        //System.out.println("Dropping Exam ID " + exam.getID());
                        continue;
                    }
                    entries.add(entry);
                }
            }

            if (includePrescriptions) {
                List<DrugPrescription> drugPrescriptions = drugPrescriptionDAO.getByDateSold(new Timestamp(date.getTime()));

                for (DrugPrescription drugPrescription : drugPrescriptions) {
                    Patient patient = patientDAO.getByPrimaryKey(drugPrescription.getPatientID());
                    Chemist chemist = chemistDAO.getByPrimaryKey(drugPrescription.getChemistID());
                    Entry entry = new Entry(i++,
                            patient.getID(), patient.getFirstName(), patient.getLastName(),
                            "PRESCRIPTION",
                            chemist.getID(), chemist.getName(), "",
                            drugPrescription.getTicket());
                    entries.add(entry);
                }
            }

            String path = sc.getRealPath("/") + File.separator + "xls" + File.separator;
            String fileName = new SimpleDateFormat("yyyyMMdd").format(date) + "_"
                    + healthService.getOperatingProvince().getAbbreviation() + ".xlsx";

            try (InputStream is = new FileInputStream(path + "report.xlsx")) {
                try (OutputStream os = new FileOutputStream(path + fileName)) {
                    Context context = new Context();
                    context.putVar("report", report);
                    context.putVar("entries", entries);
                    JxlsHelper.getInstance().processTemplate(is, os, context);
                }
            }

            return sc.getContextPath() + File.separator + "xls" + File.separator + fileName;

        } catch (DAOException | IOException e) {
            throw new ServiceException("Failure in XLS Report creation: ", e);
        }
    }


    public static class Report {
        public String region;
        public String province;
        public String day;

        Report(String region, String province, String day) {
            this.region = region;
            this.province = province;
            this.day = day;
        }
    }

    public static class Entry {
        public int ID;
        public String patientID;
        public String patientFirstName;
        public String patientLastName;
        public String type;
        public String dispatcherID;
        public String dispatcherFirstName;
        public String dispatcherLastName;
        public int ticket;

        Entry(int ID, String patientID, String patientFirstName, String patientLastName,
              String type, String dispatcherID, String dispatcherFirstName, String dispatcherLastName,
              int ticket) {
            this.ID = ID;
            this.patientID = patientID;
            this.patientFirstName = patientFirstName;
            this.patientLastName = patientLastName;
            this.type = type;
            this.dispatcherID = dispatcherID;
            this.dispatcherFirstName = dispatcherFirstName;
            this.dispatcherLastName = dispatcherLastName;
            this.ticket = ticket;
        }
    }
}
