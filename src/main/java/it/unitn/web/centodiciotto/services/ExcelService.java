package it.unitn.web.centodiciotto.services;

import it.unitn.web.centodiciotto.persistence.dao.*;
import it.unitn.web.centodiciotto.persistence.dao.exceptions.DAOException;
import it.unitn.web.centodiciotto.persistence.dao.exceptions.DAOFactoryException;
import it.unitn.web.centodiciotto.persistence.dao.factories.DAOFactory;
import it.unitn.web.centodiciotto.persistence.entities.*;
import jakarta.servlet.ServletContext;
import org.jxls.common.Context;
import org.jxls.util.JxlsHelper;

import java.io.*;
import java.net.HttpURLConnection;
import java.net.URL;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

/**
 * ExcelService service class, used to generate Health Service reports in XLS format.
 * <p>
 * The service implements the Singleton pattern.
 * <p>
 * The service needs an initialized DAOFactory to instantiate one DAO for each user class, and a
 * servletContext for retrieving the system path and storing files.
 */
public class ExcelService {

    private static ExcelService instance;

    private transient ServletContext sc;

    private transient PatientDAO patientDAO;
    private transient GeneralPractitionerDAO practitionerDAO;
    private transient SpecializedDoctorDAO doctorDAO;
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
            doctorDAO = daoFactory.getDAO(SpecializedDoctorDAO.class);
            chemistDAO = daoFactory.getDAO(ChemistDAO.class);
            healthServiceDAO = daoFactory.getDAO(HealthServiceDAO.class);

            examDAO = daoFactory.getDAO(ExamDAO.class);
            visitDAO = daoFactory.getDAO(VisitDAO.class);
            drugPrescriptionDAO = daoFactory.getDAO(DrugPrescriptionDAO.class);
        } catch (DAOFactoryException e) {
            throw new ServiceException("Error in DAO retrieval: ", e);
        }
    }

    /**
     * Configuration method for the service.
     *
     * @param daoFactory     the DAOFactory
     * @param servletContext the servletContext
     * @throws ServiceException in case of error during processing
     */
    public static void configure(DAOFactory daoFactory, ServletContext servletContext) throws ServiceException {
        if (instance == null) {
            instance = new ExcelService(daoFactory, servletContext);
        } else {
            throw new ServiceException("ExcelService already configured. You can call configure only one time");
        }
    }

    /**
     * Instance retriever for the service.
     *
     * @return the instance
     * @throws ServiceException in case of error during processing
     */
    public static ExcelService getInstance() throws ServiceException {
        if (instance == null) {
            throw new ServiceException("ExcelService not yet configured. " +
                    "Call ExcelService.configure() before use the class");
        }
        return instance;
    }

    /**
     * Creates a new XLS report for an Health Service and returns the location on the web server.
     *
     * @param healthServiceID           the {@code healthServiceID} requesting the report
     * @param date                      the date of the report
     * @param includeVisits             if visits shall be included in the report
     * @param includeRecalls            if recalls shall be included in the report
     * @param includeDoctorExams        if doctor exams shall be included in the report
     * @param includeHealthServiceExams if health service exams shall be included in the report
     * @param includePrescriptions      if prescriptions shall be included in the report
     * @return the relative path and name of the XLS file created
     * @throws ServiceException in case of error during processing
     */
    public String createReport(String healthServiceID, Date date, boolean includeVisits, boolean includeRecalls,
                               boolean includeDoctorExams, boolean includeHealthServiceExams,
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
                    GeneralPractitioner practitioner = practitionerDAO.getByPrimaryKey(visit.getPractitionerID());

                    Entry entry = new Entry(++i,
                            patient.getID(), patient.getFirstName(), patient.getLastName(),
                            "VISIT",
                            practitioner.getID(), practitioner.getFirstName(), practitioner.getLastName(),
                            0);
                    entries.add(entry);
                }
            }

            if (includeDoctorExams || includeHealthServiceExams || includeRecalls) {
                List<Exam> exams = examDAO.getByDate(new Timestamp(date.getTime()));

                for (Exam exam : exams) {
                    Entry entry;
                    Patient patient = patientDAO.getByPrimaryKey(exam.getPatientID());

                    boolean isRecall = exam.getRecall() != null && exam.getRecall() != 0;

                    if ((isRecall && includeRecalls)
                            || (!isRecall && exam.getHealthServiceID() == null && includeDoctorExams)) {
                        // Recall, doctorExam
                        SpecializedDoctor doctor = doctorDAO.getByPrimaryKey(exam.getDoctorID());

                        entry = new Entry(i++,
                                patient.getID(), patient.getFirstName(), patient.getLastName(),
                                isRecall ? "RECALL" : "DOCTOR_EXAM",
                                doctor.getID(), doctor.getFirstName(), doctor.getLastName(),
                                exam.getTicket());
                    } else if (!isRecall && exam.getDoctorID() == null && includeHealthServiceExams) {
                        // Health Service Exams
                        entry = new Entry(i++,
                                patient.getID(), patient.getFirstName(), patient.getLastName(),
                                "HEALTH_SERVICE_EXAM",
                                healthServiceID, "", "",
                                exam.getTicket());
                    } else {
                        continue;
                    }
                    entries.add(entry);
                }
            }

            if (includePrescriptions) {
                List<DrugPrescription> drugPrescriptions = drugPrescriptionDAO.getByDateSold(new Timestamp(date.getTime()));

                for (DrugPrescription prescription : drugPrescriptions) {
                    Patient patient = patientDAO.getByPrimaryKey(prescription.getPatientID());
                    Chemist chemist = chemistDAO.getByPrimaryKey(prescription.getChemistID());
                    Entry entry = new Entry(i++,
                            patient.getID(), patient.getFirstName(), patient.getLastName(),
                            "PRESCRIPTION",
                            chemist.getID(), chemist.getName(), "",
                            prescription.getTicket());
                    entries.add(entry);
                }
            }

            String filePath = sc.getAttribute("excelServer") + File.separator;

            // Format: AA_20200101.xlsx
            String fileName = healthService.getOperatingProvince().getID() + "_"
                    + new SimpleDateFormat("yyyyMMdd").format(date) + ".xlsx";

            URL inputURL = new URL(filePath + "report.xlsx");
            HttpURLConnection inputConn = (HttpURLConnection) inputURL.openConnection();
            inputConn.setRequestMethod("GET");

            try (InputStream is = inputConn.getInputStream()) {
                URL outputURL = new URL(filePath + fileName);
                HttpURLConnection outputConn = (HttpURLConnection) outputURL.openConnection();
                outputConn.setDoOutput(true);
                outputConn.setRequestMethod("PUT");
                try (OutputStream os = outputConn.getOutputStream()) {
                    Context context = new Context();
                    context.putVar("report", report);
                    context.putVar("entries", entries);
                    JxlsHelper.getInstance().processTemplate(is, os, context);
                }
            }

            /*
            inputConn.setConnectTimeout(5000);
            inputConn.setReadTimeout(5000);

            con.setInstanceFollowRedirects(false);

            int status = con.getResponseCode();

            if (status == HttpURLConnection.HTTP_MOVED_TEMP
                    || status == HttpURLConnection.HTTP_MOVED_PERM) {
                String location = con.getHeaderField("Location");
                URL newUrl = new URL(location);
                con = (HttpURLConnection) newUrl.openConnection();
            }*/

            return sc.getAttribute("excelServer") + File.separator + fileName;
        } catch (DAOException e) {
            throw new ServiceException("Failed to retrieve data from DAO for the report: ", e);
        } catch (IOException e) {
            throw new ServiceException("Failed to write to an XLS file during creation: ", e);
        }
    }

    /**
     * The type Report, to be serialized and fed to the {@link JxlsHelper}.
     */
    @SuppressWarnings("WeakerAccess")
    public static class Report {
        /**
         * The Region.
         */
        public String region;
        /**
         * The Province.
         */
        public String province;
        /**
         * The Day.
         */
        public String day;

        /**
         * Instantiates a new Report.
         *
         * @param region   the region
         * @param province the province
         * @param day      the day
         */
        Report(String region, String province, String day) {
            this.region = region;
            this.province = province;
            this.day = day;
        }
    }

    /**
     * The type Entry, to be serialized and fed to the {@link JxlsHelper}.
     */
    @SuppressWarnings("WeakerAccess")
    public static class Entry {
        /**
         * The Id.
         */
        public int ID;
        /**
         * The Patient id.
         */
        public String patientID;
        /**
         * The Patient first name.
         */
        public String patientFirstName;
        /**
         * The Patient last name.
         */
        public String patientLastName;
        /**
         * The Type.
         */
        public String type;
        /**
         * The Dispatcher id.
         */
        public String dispatcherID;
        /**
         * The Dispatcher first name.
         */
        public String dispatcherFirstName;
        /**
         * The Dispatcher last name.
         */
        public String dispatcherLastName;
        /**
         * The Ticket.
         */
        public int ticket;

        /**
         * Instantiates a new Entry.
         *
         * @param ID                  the id
         * @param patientID           the patient id
         * @param patientFirstName    the patient first name
         * @param patientLastName     the patient last name
         * @param type                the type
         * @param dispatcherID        the dispatcher id
         * @param dispatcherFirstName the dispatcher first name
         * @param dispatcherLastName  the dispatcher last name
         * @param ticket              the ticket
         */
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
