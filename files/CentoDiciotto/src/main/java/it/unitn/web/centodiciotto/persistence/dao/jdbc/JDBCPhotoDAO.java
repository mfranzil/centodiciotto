package it.unitn.web.centodiciotto.persistence.dao.jdbc;

import it.unitn.web.centodiciotto.persistence.dao.PhotoDAO;
import it.unitn.web.centodiciotto.persistence.entities.Patient;
import it.unitn.web.centodiciotto.persistence.entities.Photo;
import it.unitn.web.persistence.dao.exceptions.DAOException;
import it.unitn.web.persistence.dao.jdbc.JDBCDAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class JDBCPhotoDAO extends JDBCDAO<Photo, Integer> implements PhotoDAO {

    final private String INSERT = "INSERT INTO photo (email, upload_date) values (?, ?) RETURNING photo_id;";
    final private String UPDATE = "UPDATE photo SET upload_date = ? WHERE photo_id = ?";
    final private String DELETE = "DELETE from photo WHERE photo_id = ?";
    final private String FINDBYPRIMARYKEY = "SELECT * FROM photo WHERE photo_id = ?;";
    final private String SELECTALL = "SELECT * FROM photo;";

    final private String GET_CURRENT_PHOTO = "SELECT * " +
            "FROM photo " +
            "WHERE email = ? " +
            "ORDER BY upload_date DESC " +
            "LIMIT 1;";

    final private String GET_ALL_PHOTOS = "SELECT * " +
            "FROM photo " +
            "WHERE email = ? " +
            "ORDER BY upload_date DESC;";

    public JDBCPhotoDAO(Connection con) {
        super(con);
    }

    @Override
    public void insert(Photo photo) throws DAOException {
        try {
            PreparedStatement preparedStatement = CON.prepareStatement(INSERT);
            preparedStatement.setString(1, photo.getPatientEmail());
            preparedStatement.setTimestamp(2, photo.getUploadDate());

            int photoId = preparedStatement.executeUpdate();
            //System.out.println("Rows affected: " + row);

            photo.setPhotoId(photoId);

        } catch (SQLException e) {
            throw new DAOException("Error inserting Photo: ", e);
        }
    }

    @Override
    public void update(Photo photo) throws DAOException {
        try {
            PreparedStatement preparedStatement = CON.prepareStatement(UPDATE);
            preparedStatement.setTimestamp(1, photo.getUploadDate());
            preparedStatement.setInt(2, photo.getPhotoId());

            int row = preparedStatement.executeUpdate();
            System.out.println("Rows affected: " + row);

        } catch (SQLException e) {
            throw new DAOException("Error updating Photo: ", e);
        }
    }

    @Override
    public void delete(Photo photo) throws DAOException {
        try (PreparedStatement stm = CON.prepareStatement(DELETE)) {
            stm.setInt(1, photo.getPhotoId());

            int row = stm.executeUpdate();
        } catch (SQLException e) {
            throw new DAOException("Error deleting Photo: ", e);
        }
    }

    @Override
    protected Photo mapRowToEntity(ResultSet resultSet) throws DAOException {
        try {
            Photo photo = new Photo();

            photo.setPhotoId(resultSet.getInt("photo_id"));
            photo.setPatientEmail(resultSet.getString("email"));
            photo.setUploadDate(resultSet.getTimestamp("upload_date"));

            return photo;
        } catch (SQLException e) {
            throw new DAOException("Error mapping row to Photo:", e);
        }
    }

    @Override
    public Long getCount() throws DAOException {
        Long res = 0L;
        try (PreparedStatement stm = CON.prepareStatement(SELECTALL)) {
            try (ResultSet rs = stm.executeQuery()) {
                while (rs.next()) {
                    res++;
                }
            }
        } catch (SQLException e) {
            throw new DAOException("Error counting Photos: ", e);
        }
        return res;
    }

    @Override
    public Photo getByPrimaryKey(Integer photoId) throws DAOException {
        Photo photo = null;
        try (PreparedStatement stm = CON.prepareStatement(FINDBYPRIMARYKEY)) {
            stm.setInt(1, photoId);

            try (ResultSet rs = stm.executeQuery()) {
                if (rs.next()) {
                    photo = mapRowToEntity(rs);
                }
            }
        } catch (SQLException e) {
            throw new DAOException("Error getting Photo:", e);
        }
        return photo;
    }

    @Override
    public List<Photo> getAll() throws DAOException {
        List<Photo> photos = new ArrayList<>();
        Photo tmp;
        try (PreparedStatement stm = CON.prepareStatement(SELECTALL)) {
            try (ResultSet rs = stm.executeQuery()) {
                while (rs.next()) {
                    tmp = mapRowToEntity(rs);
                    photos.add(tmp);
                }
                return photos;
            }
        } catch (SQLException e) {
            throw new DAOException("Error getting all Photos: ", e);
        }
    }


    @Override
    public Photo getCurrentPhoto(Patient patient) throws DAOException {
        Photo photo = null;
        try {
            String email = patient.getUserID();
            PreparedStatement preparedStatement = CON.prepareStatement(GET_CURRENT_PHOTO);
            preparedStatement.setString(1, email);

            ResultSet rs = preparedStatement.executeQuery();

            if (rs.next()) { // only one
                photo = mapRowToEntity(rs);
            }
        } catch (SQLException e) {
            throw new DAOException("Error retrieving current photo: ", e);
        }
        return photo;
    }


    @Override
    public List<Photo> getAllPhotos(Patient patient) throws DAOException {
        List<Photo> photos = new ArrayList<>();
        try {
            String email = patient.getUserID();
            PreparedStatement preparedStatement = CON.prepareStatement(GET_ALL_PHOTOS);
            preparedStatement.setString(1, email);

            ResultSet rs = preparedStatement.executeQuery();

            while (rs.next()) {
                Photo photo = mapRowToEntity(rs);
                photos.add(photo);
            }

        } catch (SQLException e) {
            throw new DAOException("Error retrieving all photos: ", e);
        }
        return photos;
    }
}