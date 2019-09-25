package it.unitn.web.utils;

import javax.servlet.ServletContext;
import java.io.File;
import java.io.FileNotFoundException;

public class Common {
    public static String getPhotoPosition(ServletContext servletContext, String email, Integer id) throws FileNotFoundException {
        String context = servletContext.getRealPath("/");
        String avatarFolder = File.separator + servletContext.getInitParameter("avatar-folder") + File.separator;

        String photoPath = avatarFolder + email + File.separator + id;

        if (new File(context + photoPath + ".jpg").exists()) {
            photoPath = avatarFolder + email + File.separator + id + ".jpg";
        } else if (new File(context + photoPath + ".png").exists()) {
            photoPath = avatarFolder + email + File.separator + id + ".png";
        } else {
            throw new FileNotFoundException("Cannot find user photo.");
        }

        return photoPath;
    }
}
