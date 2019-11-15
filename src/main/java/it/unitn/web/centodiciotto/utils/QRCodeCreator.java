package it.unitn.web.centodiciotto.utils;

import it.unitn.web.centodiciotto.utils.entities.Pair;
import net.glxn.qrgen.QRCode;
import net.glxn.qrgen.image.ImageType;

import java.util.List;

/**
 * The type Qr code creator.
 */
public class QRCodeCreator {
    /**
     * Create qr code url qr code.
     *
     * @param url        the url
     * @param parameters the parameters
     * @param width      the width
     * @param height     the height
     * @return the qr code
     */
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

