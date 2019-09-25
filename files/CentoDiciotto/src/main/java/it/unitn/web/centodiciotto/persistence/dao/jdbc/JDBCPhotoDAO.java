package it.unitn.web.centodiciotto.persistence.dao.jdbc;

import it.unitn.web.centodiciotto.persistence.dao.PhotoDAO;
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

    final private String INSERT = "INSERT INTO photo (email, upload_date) values  (?, ?) RETURNING photo_id;;";
    final private String UPDATE = "UPDATE photo SET upload_date = ? WHERE photo_id = ?";
    final private String DELETE = "DELETE from photo WHERE photo_id = ?";
    final private String FINDBYPRIMARYKEY = "SELECT * FROM photo WHERE photo_id = ?;";
    final private String SELECTALL = "SELECT * FROM photo;";
    final private String FINDBYEMAIL = "SELECT * FROM photo WHERE email = ? ORDER BY upload_date DESC, photo_id DESC;";
    //final private String SELECTMAX = "SELECT MAX(photoid) + 1 AS nextid FROM photo WHERE email = ?;";

    public JDBCPhotoDAO(Connection con) {
        super(con);
    }

    @Override
    public void insert(Photo photo) {

        try {

            PreparedStatement preparedStatement = CON.prepareStatement(INSERT);
            preparedStatement.setString(1, photo.getPatientEmail());
            preparedStatement.setTimestamp(2, photo.getUploadDate());

            int photoId = preparedStatement.executeUpdate();
            //System.out.println("Rows affected: " + row);

            photo.setPhotoId(photoId);

        } catch (SQLException e) {
            System.err.println("Error inserting Photo: " + e.getMessage());
        }
    }

    @Override
    public void update(Photo photo) {
        try {
            PreparedStatement preparedStatement = CON.prepareStatement(UPDATE);
            preparedStatement.setTimestamp(1, photo.getUploadDate());
            preparedStatement.setInt(2, photo.getPhotoId());

            int row = preparedStatement.executeUpdate();
            System.out.println("Rows affected: " + row);

        } catch (SQLException e) {
            System.err.println("Error updating Photo: " + e.getMessage());
        }
    }

    @Override
    public void delete(Photo photo) {
        try (PreparedStatement stm = CON.prepareStatement(DELETE)) {
            stm.setInt(1, photo.getPhotoId());

            int row = stm.executeUpdate();
        } catch (SQLException e) {
            System.err.println("Error deleting Photo: " + e.getMessage());
        }
    }

    @Override
    public Photo mapRowToPhoto(ResultSet resultSet) throws SQLException {
        Photo photo = new Photo(
                resultSet.getInt("photo_id"),
                resultSet.getString("email"),
                resultSet.getTimestamp("upload_date")
        );
        return photo;
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
            System.err.println("Error counting Photos: " + e.getMessage());
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
                    photo = mapRowToPhoto(rs);
                }
            }
        } catch (SQLException e) {
            System.err.println("Error getting Photo:" + e.getMessage());
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
                    tmp = mapRowToPhoto(rs);
                    photos.add(tmp);
                }
                return photos;
            }
        } catch (SQLException e) {
            System.err.println("Error getting all Photos: " + e.getMessage());
        }
        return null;
    }

    @Override
    public List<Photo> getByEmail(String email) throws DAOException {
        List<Photo> photos = new ArrayList<>();
        Photo tmp;

        try (PreparedStatement stm = CON.prepareStatement(FINDBYEMAIL)) {
            stm.setString(1, email);

            try (ResultSet rs = stm.executeQuery()) {
                while (rs.next()) {
                    tmp = mapRowToPhoto(rs);
                    photos.add(tmp);
                }
                return photos;
            }
        } catch (SQLException e) {
            System.err.println("Error getting Photos:" + e.getMessage());
        }
        return null;
    }

    @Override
    public Photo getLastPhotoByEmail(String email) throws DAOException {
        Photo photo;

        try (PreparedStatement stm = CON.prepareStatement(FINDBYEMAIL)) {
            stm.setString(1, email);

            try (ResultSet rs = stm.executeQuery()) {
                if (rs.next()) {
                    photo = mapRowToPhoto(rs);
                    return photo;
                }
            }
        } catch (SQLException e) {
            System.err.println("Error getting Photo:" + e.getMessage());
        }
        return null;
    }


}