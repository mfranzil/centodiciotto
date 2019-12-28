package it.unitn.web.centodiciotto.services;

import be.quodlibet.boxable.utils.PDStreamUtils;
import it.unitn.web.centodiciotto.persistence.entities.DrugPrescription;
import it.unitn.web.centodiciotto.persistence.entities.GeneralPractitioner;
import it.unitn.web.centodiciotto.persistence.entities.Patient;
import it.unitn.web.centodiciotto.utils.CustomDTFormatter;
import it.unitn.web.centodiciotto.utils.QRCodeCreator;
import it.unitn.web.centodiciotto.utils.entities.Pair;
import org.apache.pdfbox.pdmodel.PDDocument;
import org.apache.pdfbox.pdmodel.PDPage;
import org.apache.pdfbox.pdmodel.PDPageContentStream;
import org.apache.pdfbox.pdmodel.common.PDRectangle;
import org.apache.pdfbox.pdmodel.font.PDFont;
import org.apache.pdfbox.pdmodel.font.PDType1Font;
import org.apache.pdfbox.pdmodel.graphics.image.PDImageXObject;

import javax.servlet.ServletContext;
import java.awt.*;
import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;

/**
 * PDFService service class, used to generate PDF prescriptions.
 * <p>
 * The service implements the Singleton pattern.
 * <p>
 * The service requires a servletContext for retrieving the system path and storing files.
 */
@SuppressWarnings("SameParameterValue")
public class PDFService {

    private static PDFService instance;
    private transient ServletContext sc;

    private PDFService(ServletContext servletContext) {
        sc = servletContext;
    }

    /**
     * Configuration method for the service.
     *
     * @param servletContext the servletContext
     * @throws ServiceException in case of error during processing
     */
    public static void configure(ServletContext servletContext) throws ServiceException {
        if (instance == null) {
            instance = new PDFService(servletContext);
        } else {
            throw new ServiceException("PDFService already configured. You can call configure only one time");
        }
    }

    /**
     * Instance retriever for the service.
     *
     * @return the instance
     * @throws ServiceException in case of error during processing
     */
    public static PDFService getInstance() throws ServiceException {
        if (instance == null) {
            throw new ServiceException("PDFService not yet configured. " +
                    "Call PDFService.configure() before use the class");
        }
        return instance;
    }

    /**
     * Wrapper method for evenly spacing characters in the PDF.
     *
     * @param stream   the PDPageContentStream
     * @param text     the text to be inserted
     * @param font     the font to be used
     * @param fontSize the fontSize to be used
     * @param x        the x coordinate on the pdf for printing
     * @param y        the y coordinate on the pdf for printing
     * @param color    the color to be used
     * @param space    the space between each character
     */
    private void spacedWrite(PDPageContentStream stream, String text,
                             PDFont font, float fontSize, float x, float y, Color color, int space) {
        char[] arr = text.toCharArray();
        for (int i = 0; i < arr.length; i++) {
            PDStreamUtils.write(stream, String.valueOf(arr[i]), font, fontSize, x + (float) i * (space + fontSize), y, color);
        }
    }

    /**
     * Wrapper method that inserts line breaks in a string and prints it to the PDF.
     *
     * @param stream   the PDPageContentStream
     * @param text     the text to be inserted
     * @param font     the font to be used
     * @param fontSize the fontSize to be used
     * @param x        the x coordinate on the pdf for printing
     * @param y        the y coordinate on the pdf for printing
     * @param color    the color to be used
     * @param split    the number of character for splitting the {@code text}
     */
    private void splitWrite(PDPageContentStream stream, String text,
                            PDFont font, float fontSize, float x, float y, Color color, int split) {
        String[] arr = text.split("(?<=\\G.{" + split + "})");
        for (int i = 0; i < arr.length; i++) {
            PDStreamUtils.write(stream, arr[i], font, fontSize, x, (float) (y - (i * fontSize * 1.6)), color);
        }
    }

    /**
     * Create a new PDF prescription.
     *
     * @param dp        the {@link DrugPrescription}
     * @param pat       the {@link Patient} associated to this prescription
     * @param pra       the {@link GeneralPractitioner} associated to this prescription
     * @param qrCodeURL the url to be inserted as a base for the QR code
     * @return the {@link PDDocument} freshly generated
     * @throws ServiceException in case of error during processing
     */
    public PDDocument createDrugPrescription(DrugPrescription dp, Patient pat, GeneralPractitioner pra, String qrCodeURL)
            throws ServiceException {

        if (dp == null) {
            throw new ServiceException("DrugPrescription parameter cannot be null.");
        }
        if (pat == null) {
            throw new ServiceException("Patient parameter cannot be null.");
        }
        if (pra == null) {
            throw new ServiceException("GeneralPractitioner parameter cannot be null.");
        }
        if (qrCodeURL == null) {
            throw new ServiceException("QRCodeURL parameter cannot be null.");
        }
        if (qrCodeURL.equals("")) {
            throw new ServiceException("QRCodeURL cannot be an empty string.");
        }

        PDRectangle rec = new PDRectangle(1000, 765);
        PDDocument doc = new PDDocument();
        PDPage page = new PDPage(rec);
        doc.addPage(page);

        List<Pair<String, Object>> parameters = new ArrayList<>();
        parameters.add(Pair.makePair("action", "qr"));
        parameters.add(Pair.makePair("practitionerID", pra.getID()));
        parameters.add(Pair.makePair("prescriptionID", dp.getID()));
        parameters.add(Pair.makePair("patientID", pat.getID()));

        File file = QRCodeCreator.createQRCodeURL(
                qrCodeURL + sc.getContextPath() + File.separator +
                        "restricted/chemist/prescriptions", parameters,
                220, 220).file();

        try {
            String imagePath = sc.getRealPath("/") + File.separator + "img" + File.separator + "prescription.png";

            PDImageXObject QRCode = PDImageXObject.createFromFileByContent(file, doc);
            PDImageXObject pdImage = PDImageXObject.createFromFile(imagePath, doc);
            PDPageContentStream contents = new PDPageContentStream(doc, page);

            contents.drawImage(pdImage, 0, 0);
            contents.drawImage(QRCode, 730, 184);

            // Patient name
            PDStreamUtils.write(
                    contents, pat.toString(),
                    PDType1Font.HELVETICA, 28, 30, 743, Color.BLACK);
            // Practitioner name
            PDStreamUtils.write(
                    contents, pra.toString(),
                    PDType1Font.HELVETICA, 28, 616, 743, Color.BLACK);
            // Birthdate and birthplace
            PDStreamUtils.write(
                    contents, pat.getBirthPlace() + " "
                            + new SimpleDateFormat("dd/MM/yyyy").format(pat.getBirthDate()),
                    PDType1Font.HELVETICA, 28, 30, 698, Color.BLACK);
            // Region
            PDStreamUtils.write(
                    contents, pat.getLivingPlace() + " (" + pat.getLivingProvince().getID() + "), " +
                            pat.getLivingProvince().getRegion(),
                    PDType1Font.HELVETICA, 28, 616, 698, Color.BLACK);
            // SSN
            this.spacedWrite(
                    contents, pat.getSSN(),
                    PDType1Font.HELVETICA, 21, 536, 610, Color.BLACK, 6);
            // Province
            this.spacedWrite(
                    contents, pat.getLivingProvince().getID(),
                    PDType1Font.HELVETICA, 21, 562, 560, Color.BLACK, 6);
            this.spacedWrite(
                    contents, CustomDTFormatter.formatCustom(dp.getDatePrescribed(), "ddMMyyHHmm"),
                    PDType1Font.HELVETICA, 21, 397, 320, Color.BLACK, 9);
            // Prescription ID
            PDStreamUtils.write(
                    contents, dp.getID().toString(),
                    PDType1Font.HELVETICA, 21, 826, 110, Color.BLACK);
            // Drug description
            splitWrite(
                    contents, dp.getType().getDescription(),
                    PDType1Font.HELVETICA, 21, 40, 500, Color.BLACK, 26);
            // Prescription description
            if (dp.getDescription() != null) {
                splitWrite(
                        contents, dp.getDescription(),
                        PDType1Font.HELVETICA, 21, 380, 500, Color.BLACK, 26);
            }
            // Ticket
            this.spacedWrite(
                    contents, ((float) dp.getTicket() / 10.0 <= 1 ? " " : "") + dp.getTicket() + "00",
                    PDType1Font.HELVETICA, 21, 820, 56, Color.BLACK, 9);
            contents.close();
            return doc;
        } catch (IOException e) {
            throw new ServiceException("Error in Prescription creation: ", e);
        }
    }
}
