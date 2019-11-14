package it.unitn.web.centodiciotto.services;

import be.quodlibet.boxable.utils.PDStreamUtils;
import it.unitn.web.centodiciotto.persistence.entities.DrugPrescription;
import it.unitn.web.centodiciotto.persistence.entities.GeneralPractitioner;
import it.unitn.web.centodiciotto.persistence.entities.Patient;
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
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.time.ZoneId;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;

@SuppressWarnings("SameParameterValue")
public class PDFService {

    private static PDFService instance;
    private transient ServletContext sc;

    private PDFService(ServletContext servletContext) {
        sc = servletContext;
    }

    public static void configure(ServletContext servletContext) throws ServiceException {
        if (instance == null) {
            instance = new PDFService(servletContext);
        } else {
            throw new ServiceException("PDFService already configured. You can call configure only one time");
        }
    }

    public static PDFService getInstance() throws ServiceException {
        if (instance == null) {
            throw new ServiceException("PDFService not yet configured. " +
                    "Call PDFService.configure() before use the class");
        }
        return instance;
    }

    private String insertSpaces(String string, int spaces) {
        StringBuilder res = new StringBuilder();

        for (char c : string.toCharArray()) {
            res.append(c);
            res.append(" ".repeat(spaces));
        }

        return res.toString();
    }

    private void splitWrite(PDPageContentStream stream, String text,
                            PDFont font, float fontSize, float x, float y, Color color, int split) {
        String[] arr = text.split("(?<=\\G.{" + split + "})");
        for (int i = 0; i < arr.length; i++) {
            PDStreamUtils.write(stream, arr[i], font, fontSize, x, (float) (y - (i * fontSize * 1.6)), color);
        }
    }

    private String dateTimeFormatter(Timestamp ts, String pattern) {
        return insertSpaces(DateTimeFormatter.ofPattern(pattern)
                .withZone(ZoneId.systemDefault()).format(ts.toInstant()), 3);
    }

    public PDDocument createDrugPrescription(DrugPrescription dp, Patient pat, GeneralPractitioner pra, String qrCodeURL)
            throws ServiceException {

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
                qrCodeURL + sc.getContextPath() + "/restricted/chemist/prescriptions", parameters,
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
                    contents, pat.getLivingProvince().getRegion(),
                    PDType1Font.HELVETICA, 28, 616, 698, Color.BLACK);
            // SSN
            PDStreamUtils.write(
                    contents, insertSpaces(pat.getSSN(), 2),
                    PDType1Font.HELVETICA, 21, 536, 610, Color.BLACK);
            // Province
            PDStreamUtils.write(
                    contents, insertSpaces(pat.getLivingProvince().getAbbreviation(), 2),
                    PDType1Font.HELVETICA, 21, 562, 560, Color.BLACK);
            // Prescription date
            PDStreamUtils.write(
                    contents, dateTimeFormatter(dp.getDatePrescribed(), "ddMMyyHHMM"),
                    PDType1Font.HELVETICA, 21, 397, 320, Color.BLACK);
            // Prescription time
            PDStreamUtils.write(
                    contents, dateTimeFormatter(dp.getDateSold(), "ddMMyy"),
                    PDType1Font.HELVETICA, 21, 758, 159, Color.BLACK);
            // Prescription ID
            PDStreamUtils.write(
                    contents, dp.getID().toString(),
                    PDType1Font.HELVETICA, 21, 826, 110, Color.BLACK);
            // Drug description
            splitWrite(
                    contents, dp.getDrugType().getDescription(),
                    PDType1Font.HELVETICA, 21, 40, 500, Color.BLACK, 26);
            // Prescription description
            if (dp.getDescription() != null) {
                splitWrite(
                        contents, dp.getDescription(),
                        PDType1Font.HELVETICA, 21, 380, 500, Color.BLACK, 26);
            }
            // Ticket
            PDStreamUtils.write(
                    contents, insertSpaces(((((float) dp.getTicket() / 10.0) <= 1) ? " " : "")
                            + dp.getTicket() + "00", 3),
                    PDType1Font.HELVETICA, 21, 820, 56, Color.BLACK);
            contents.close();
            return doc;
        } catch (IOException e) {
            throw new ServiceException("Error in Prescription creation: ", e);
        }
    }
}
