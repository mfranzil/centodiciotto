package it.unitn.web.centodiciotto.utils;

import net.glxn.qrgen.QRCode;
import net.glxn.qrgen.image.ImageType;

import java.util.List;

public class QRCodeCreator {

    public static QRCode createQRCodeURL(String url, List<Pair<String, Object>> parameters, int width, int height) {
        StringBuilder QRcontent = new StringBuilder();
        QRcontent.append(url);

        for (int i = 0; i < parameters.size(); i++) {
            Pair<String, Object> parameter = parameters.get(i);
            if (i == 0) {
                QRcontent.append("?");
            } else {
                QRcontent.append("&");
            }
            QRcontent.append(parameter.getFirst()).append("=").append(parameter.getSecond().toString());
        }
        return QRCode.from(QRcontent.toString()).to(ImageType.PNG).withSize(width, height);
    }
}

