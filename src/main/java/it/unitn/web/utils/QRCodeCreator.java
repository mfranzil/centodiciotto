package it.unitn.web.utils;

import net.glxn.qrgen.QRCode;
import net.glxn.qrgen.image.ImageType;

import java.util.List;

public class QRCodeCreator {

    // TODO Dare un senso al qr
    public static QRCode createQRCodeURL(String url, List<Pair<String, Object>> parameters, int width, int height) {
        StringBuilder QRcontent = new StringBuilder();
        QRcontent.append(url);
        for (Pair<String, Object> parameter : parameters) {
            QRcontent.append(parameter.getFirst()).append(":")
                     .append(parameter.getSecond().toString()).append(";");
        }
        return QRCode.from(QRcontent.toString()).to(ImageType.PNG).withSize(width, height);
    }
}

