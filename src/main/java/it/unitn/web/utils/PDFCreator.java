package it.unitn.web.utils;

import be.quodlibet.boxable.utils.PDStreamUtils;
import it.unitn.web.centodiciotto.persistence.entities.DrugPrescription;
import net.glxn.qrgen.QRCode;
import net.glxn.qrgen.image.ImageType;
import org.apache.pdfbox.pdmodel.PDDocument;
import org.apache.pdfbox.pdmodel.PDPage;
import org.apache.pdfbox.pdmodel.PDPageContentStream;
import org.apache.pdfbox.pdmodel.common.PDRectangle;
import org.apache.pdfbox.pdmodel.font.PDType1Font;
import org.apache.pdfbox.pdmodel.graphics.image.PDImageXObject;

import javax.servlet.ServletContext;
import java.awt.*;
import java.io.File;
import java.io.IOException;

public class PDFCreator {

    private static ServletContext sc;

    public static void configure(ServletContext servletContext) throws RuntimeException {
        sc = servletContext;
    }

    public static void main(String[] args) {
        var dp = new DrugPrescription();

        createDrugPrescription(null,null,null,null,null);

    }

    public static PDDocument createDrugPrescription(String practitionerID, String patientSSN, String prescriptionDate,
                                                    String prescriptionID, String prescriptionDescription) throws RuntimeException {
        PDRectangle rec = new PDRectangle(1000, 765);
        PDDocument doc = new PDDocument();
        PDPage page = new PDPage(rec);
        doc.addPage(page);

        String QRcontent = "";
        QRcontent += "practitionerID:" + practitionerID + ";";
        QRcontent += "patientSSN:" + patientSSN + ";";
        QRcontent += "prescriptionDate:" + prescriptionDate + ";";
        QRcontent += "prescriptionID:" + prescriptionID + ";";
        QRcontent += "prescriptionDescription:" + prescriptionDescription + ";";
        File file = QRCode.from(QRcontent).to(ImageType.PNG).withSize(230, 230).file();

        try {
            String imagePath = sc.getRealPath("/") + File.separator + "img" + File.separator + "prescription.png";
            PDImageXObject QRCode = PDImageXObject.createFromFileByContent(file, doc);
            PDImageXObject pdImage = PDImageXObject.createFromFile(imagePath, doc);
            PDPageContentStream contents = new PDPageContentStream(doc, page);

            StringBuilder SSN = new StringBuilder();
            int spaces = 2;

            for (char c : patientSSN.toCharArray()) {
                SSN.append(c);
                SSN.append(" ".repeat(spaces));
            }

            contents.drawImage(pdImage, 0, 0);
            contents.drawImage(QRCode, 730, 184);
            PDStreamUtils.write(
                    contents,
                    SSN.toString(),
                    PDType1Font.HELVETICA,
                    22,
                    532,
                    610,
                    Color.BLACK);

            PDStreamUtils.write(
                    contents,
                    prescriptionDescription,
                    PDType1Font.HELVETICA,
                    22,
                    70,
                    770,
                    Color.BLACK);
            PDStreamUtils.write(
                    contents,
                    practitionerID,
                    PDType1Font.HELVETICA,
                    30,
                    1150,
                    495,
                    Color.BLACK);
            /*
            PDStreamUtils.write(
                    contents,
                    "SERVIZIO SANITARIO NAZIONALE",
                    PDType1Font.HELVETICA,
                    14,
                    50,
                    800,
                    Color.BLACK);
            PDStreamUtils.write(
                    contents,
                    "RICETTA MEDICA",
                    PDType1Font.HELVETICA_BOLD,
                    14,
                    420,
                    800,
                    Color.BLACK);

            //Practioner ID
            PDStreamUtils.write(
                    contents,
                    "Medico di base ",
                    PDType1Font.HELVETICA_BOLD,
                    12,
                    50,
                    720,
                    Color.BLACK);
            PDStreamUtils.write(
                    contents,
                    practitionerID,
                    PDType1Font.HELVETICA,
                    12,
                    50,
                    700,
                    Color.BLACK);
            //Patient SSN
            PDStreamUtils.write(
                    contents,
                    "Codice fiscale paziente ",
                    PDType1Font.HELVETICA_BOLD,
                    12,
                    400,
                    720,
                    Color.BLACK);
            PDStreamUtils.write(
                    contents,
                    patientSSN,
                    PDType1Font.HELVETICA,
                    12,
                    400,
                    700,
                    Color.BLACK);
            //Prescription Date
            PDStreamUtils.write(
                    contents,
                    "Data emissione ",
                    PDType1Font.HELVETICA_BOLD,
                    12,
                    50,
                    650,
                    Color.BLACK);
            PDStreamUtils.write(
                    contents,
                    prescriptionDate,
                    PDType1Font.HELVETICA,
                    12,
                    50,
                    630,
                    Color.BLACK);
            //Prescription Number
            PDStreamUtils.write(
                    contents,
                    "Numero ricetta ",
                    PDType1Font.HELVETICA_BOLD,
                    12,
                    400,
                    650,
                    Color.BLACK);
            PDStreamUtils.write(
                    contents,
                    prescription_id,
                    PDType1Font.HELVETICA,
                    12,
                    400,
                    630,
                    Color.BLACK);
            //Prescription description
            PDStreamUtils.write(
                    contents,
                    "Descrizione",
                    PDType1Font.HELVETICA_BOLD,
                    12,
                    50,
                    580,
                    Color.BLACK);
            PDStreamUtils.write(
                    contents,
                    prescription_description,
                    PDType1Font.HELVETICA,
                    12,
                    50,
                    560,
                    Color.BLACK);
        */
            contents.close();
            return doc;
        } catch (IOException e) {
            throw new RuntimeException("Error in Prescription creation: ", e);
        }
    }
}
