package it.unitn.web.utils;

import be.quodlibet.boxable.utils.PDStreamUtils;
import org.apache.pdfbox.pdmodel.PDDocument;
import org.apache.pdfbox.pdmodel.PDPage;
import org.apache.pdfbox.pdmodel.PDPageContentStream;
import org.apache.pdfbox.pdmodel.common.PDRectangle;
import org.apache.pdfbox.pdmodel.font.PDType1Font;

import java.awt.*;
import java.io.IOException;

public class PDFCreator {

    public static PDDocument createPrescription(String practitioner_id, String patient_ssn, String prescription_date, String prescription_id, String prescription_description) throws IOException {
        PDDocument doc = new PDDocument();
        PDPage page = new PDPage(PDRectangle.A4);
        doc.addPage(page);

        try (PDPageContentStream contents = new PDPageContentStream(doc, page)) {
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


        } catch (IOException e) {
            e.printStackTrace();
        }
        return doc;
    }
}
