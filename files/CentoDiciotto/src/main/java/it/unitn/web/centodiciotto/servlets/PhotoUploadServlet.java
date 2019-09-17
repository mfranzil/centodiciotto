package it.unitn.web.centodiciotto.servlets;

import com.alibaba.fastjson.JSONObject;
import it.unitn.web.centodiciotto.persistence.dao.PhotoDAO;
import it.unitn.web.centodiciotto.persistence.entities.Photo;
import it.unitn.web.centodiciotto.persistence.entities.User;
import it.unitn.web.persistence.dao.exceptions.DAOFactoryException;
import it.unitn.web.persistence.dao.factories.DAOFactory;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;
import java.io.*;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.sql.Date;

@WebServlet("/upload")
@MultipartConfig

public class PhotoUploadServlet extends HttpServlet {

    private PhotoDAO photoDao;

    @Override
    public void init() throws ServletException {
        DAOFactory daoFactory = (DAOFactory) super.getServletContext().getAttribute("daoFactory");
        if (daoFactory == null) {
            throw new ServletException("Impossible to get dao factory for user storage system");
        }
        try {
            photoDao = daoFactory.getDAO(PhotoDAO.class);
        } catch (DAOFactoryException ex) {
            throw new ServletException("Impossible to get dao factory for user storage system", ex);
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        User user = (User) request.getSession().getAttribute("user");

        OutputStream out = null;
        InputStream filecontent = null;
        Part filePart = request.getPart("avatar-select");
        String extension = request.getParameter("extension");

        System.out.println(extension);

        Photo photo = new Photo(user.getEmail(), new Date(System.currentTimeMillis()));
        String fileName = photoDao.insert(photo).toString();

        String path = getServletContext().getRealPath("/") + "/img/avatars/" + user.getEmail();
        Files.createDirectories(Paths.get(path));

        JSONObject jobj = new JSONObject();

        try {
            out = new FileOutputStream(new File(path + File.separator + fileName + "." + extension));
            filecontent = filePart.getInputStream();

            int read = 0;
            final byte[] bytes = new byte[1024];

            while ((read = filecontent.read(bytes)) != -1) {
                out.write(bytes, 0, read);
            }
            System.out.println(fileName + " created at " + path);

            request.getSession().setAttribute("photo_path",
                    "/img/avatars/" + user.getEmail() + "/" + fileName + "." + extension);

            response.setStatus(200);
            jobj.put("output", true);
        } catch (FileNotFoundException ex) {
            request.getServletContext().log("Problems during file upload.", ex);
            response.setStatus(400);
            jobj.put("output", false);
        } finally {
            if (out != null) {
                out.close();
            }
            if (filecontent != null) {
                filecontent.close();
            }
        }
    }
}