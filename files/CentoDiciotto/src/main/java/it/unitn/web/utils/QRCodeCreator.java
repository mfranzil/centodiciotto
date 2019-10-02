package it.unitn.web.utils;

import net.glxn.qrgen.QRCode;
import net.glxn.qrgen.image.ImageType;

import java.awt.*;
import java.io.ByteArrayInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
/*
public class QRCodeCreator {
    public static FileOutputStream createPrescription(){
        final byte[] imageBytes = QRCode
                .from("ciao")
                .withSize(320, 240)
                .to(ImageType.PNG)
                .stream()
                .toByteArray();
        Image qrImage = new Image(new ByteArrayInputStream(imageBytes));
        try {
            FileOutputStream res = new FileOutputStream( );
            fout.write(out.toByteArray());
            fout.flush();
            fout.close();
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
}
*/
