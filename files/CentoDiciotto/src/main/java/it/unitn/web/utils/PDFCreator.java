package it.unitn.web.utils;

import be.quodlibet.boxable.utils.PDStreamUtils;
import net.glxn.qrgen.QRCode;
import net.glxn.qrgen.image.ImageType;
import org.apache.pdfbox.pdmodel.PDDocument;
import org.apache.pdfbox.pdmodel.PDPage;
import org.apache.pdfbox.pdmodel.PDPageContentStream;
import org.apache.pdfbox.pdmodel.common.PDRectangle;
import org.apache.pdfbox.pdmodel.font.PDType1Font;
import org.apache.pdfbox.pdmodel.graphics.image.PDImageXObject;

import java.awt.*;
import java.io.File;
import java.io.IOException;

public class PDFCreator {

    public static PDDocument createPrescription(String practitioner_id, String patient_ssn, String prescription_date, String prescription_id, String prescription_description) throws IOException {
        PDRectangle rec = new PDRectangle(1545, 1182);
        PDDocument doc = new PDDocument();
        PDPage page = new PDPage(rec);
        doc.addPage(page);

        String QRcontent = "";
        QRcontent += "practitioner_id:" + practitioner_id + ";";
        QRcontent += "patient_ssn:" + patient_ssn + ";";
        QRcontent += "prescription_date:" + prescription_date + ";";
        QRcontent += "prescription_id:" + prescription_id + ";";
        QRcontent += "prescription_description:" + prescription_description + ";";
        File file = QRCode.from(QRcontent)
                .to(ImageType.PNG)
                .withSize(350, 350)
                .file();

        PDImageXObject QRCode = PDImageXObject.createFromFileByContent(file, doc);

        PDImageXObject pdImage = PDImageXObject.createFromFile("/home/simone/pdf_ricetta/src/prescription.jpg", doc);


        try (PDPageContentStream contents = new PDPageContentStream(doc, page)) {
            //add spaces in ssn:
            String ssn = "";
            int spaces = 2;

            for (char c : patient_ssn.toCharArray()) {
                ssn = ssn + c;
                for (int i = 0; i < spaces; i++) {
                    ssn = ssn + " ";
                }
            }
            contents.drawImage(pdImage, 0, 0);
            contents.drawImage(QRCode, 725, 425);
            PDStreamUtils.write(
                    contents,
                    ssn,
                    PDType1Font.HELVETICA,
                    34,
                    827,
                    942,
                    Color.BLACK);

            PDStreamUtils.write(
                    contents,
                    prescription_description,
                    PDType1Font.HELVETICA,
                    30,
                    70,
                    770,
                    Color.BLACK);
            PDStreamUtils.write(
                    contents,
                    practitioner_id,
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
                    practitioner_id,
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
                    patient_ssn,
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
                    prescription_date,
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

        } catch (IOException e) {
            e.printStackTrace();
        }
        return doc;
    }
}
