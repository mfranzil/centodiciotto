package it.unitn.web.utils;

import javax.servlet.ServletContext;
import java.io.File;
import java.io.FileNotFoundException;

public class Common {
    public static String getPhotoPosition(ServletContext servletContext, String email, Integer id) throws FileNotFoundException {
        String context = servletContext.getRealPath("/");

        String photoPath = "/img/avatars/" + email + "/" + id;

        if (new File(context + photoPath + ".jpg").exists()) {
            photoPath = "img/avatars/" + email + "/" + id + ".jpg";
        } else if (new File(context + photoPath + ".png").exists()) {
            photoPath = "img/avatars/" + email + "/" + id + ".png";
        } else {
            throw new FileNotFoundException("Cannot find user photo.");
        }

        return photoPath;
    }
}
