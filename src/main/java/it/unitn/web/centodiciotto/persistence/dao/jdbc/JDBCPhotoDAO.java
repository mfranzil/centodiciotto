package it.unitn.web.centodiciotto.persistence.dao.jdbc;

import it.unitn.web.centodiciotto.persistence.dao.PhotoDAO;
import it.unitn.web.centodiciotto.persistence.entities.Photo;
import it.unitn.web.persistence.dao.exceptions.DAOException;
import it.unitn.web.persistence.dao.exceptions.DAOFactoryException;
import it.unitn.web.persistence.dao.jdbc.JDBCDAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

@SuppressWarnings({"FieldCanBeLocal", "unused", "DuplicatedCode"})
public class JDBCPhotoDAO extends JDBCDAO<Photo, Integer> implements PhotoDAO {

    final private String INSERT = "INSERT INTO photo (patient_id, upload_date) values (?, ?) " +
            "RETURNING photo_id;";
    final private String UPDATE = "UPDATE photo SET upload_date = ? WHERE photo_id = ?";
    final private String DELETE = "DELETE from photo WHERE photo_id = ?";

    final private String FINDBYPRIMARYKEY = "SELECT * FROM photo WHERE photo_id = ?;";
    final private String SELECTALL = "SELECT * FROM photo;";
    final private String COUNT = "SELECT COUNT(*) FROM photo;";

    final private String GETCURRENTPHOTO = "SELECT * " +
            "FROM photo " +
            "WHERE patient_id = ? " +
            "ORDER BY upload_date DESC " +
            "LIMIT 1;";
    final private String GETALLPHOTOS = "SELECT * " +
            "FROM photo " +
            "WHERE patient_id = ? " +
            "ORDER BY upload_date DESC;";

    public JDBCPhotoDAO(Connection con) throws DAOFactoryException {
        super(con);
    }

    @Override
    public void insert(Photo photo) throws DAOException {
        try {
            PreparedStatement stm = CON.prepareStatement(INSERT);
            stm.setString(1, photo.getPatientID());
            stm.setTimestamp(2, photo.getUploadDate());

            int photoID = stm.executeUpdate();

            photo.setID(photoID);
            System.out.println("Row affected returned: " + photoID);

        } catch (SQLException e) {
            throw new DAOException("Error inserting Photo: ", e);
        }
    }

    @Override
    public void update(Photo photo) throws DAOException {
        try {
            PreparedStatement stm = CON.prepareStatement(UPDATE);
            stm.setTimestamp(1, photo.getUploadDate());
            stm.setInt(2, photo.getID());

            int row = stm.executeUpdate();
            System.out.println("Rows affected: " + row);

        } catch (SQLException e) {
            throw new DAOException("Error updating Photo: ", e);
        }
    }

    @Override
    public void delete(Photo photo) throws DAOException {
        try (PreparedStatement stm = CON.prepareStatement(DELETE)) {
            stm.setInt(1, photo.getID());

            int row = stm.executeUpdate();
            System.out.println("Rows affected: " + row);
        } catch (SQLException e) {
            throw new DAOException("Error deleting Photo: ", e);
        }
    }

    @Override
    public Photo getByPrimaryKey(Integer primaryKey) throws DAOException {
        Photo photo = null;
        try (PreparedStatement stm = CON.prepareStatement(FINDBYPRIMARYKEY)) {
            stm.setInt(1, primaryKey);

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
    public Long getCount() throws DAOException {
        try (PreparedStatement stm = CON.prepareStatement(COUNT)) {
            try (ResultSet rs = stm.executeQuery()) {
                if (rs.next()) {
                    return Integer.toUnsignedLong(rs.getInt("count"));
                }
            }
        } catch (SQLException e) {
            throw new DAOException("Error counting Photos: ", e);
        }
        return -1L;
    }

    @Override
    public Photo getCurrentPhoto(String patientID) throws DAOException {
        Photo photo = null;
        try {
            PreparedStatement stm = CON.prepareStatement(GETCURRENTPHOTO);
            stm.setString(1, patientID);

            ResultSet rs = stm.executeQuery();

            if (rs.next()) {
                photo = mapRowToEntity(rs);
            }
        } catch (SQLException e) {
            throw new DAOException("Error getting current Photo: ", e);
        }
        return photo;
    }

    @Override
    public List<Photo> getAllPhotos(String patientID) throws DAOException {
        List<Photo> photos = new ArrayList<>();
        try {
            PreparedStatement stm = CON.prepareStatement(GETALLPHOTOS);
            stm.setString(1, patientID);

            ResultSet rs = stm.executeQuery();

            while (rs.next()) {
                Photo photo = mapRowToEntity(rs);
                photos.add(photo);
            }
        } catch (SQLException e) {
            throw new DAOException("Error getting all Photos: ", e);
        }
        return photos;
    }

    @Override
    protected Photo mapRowToEntity(ResultSet rs) throws DAOException {
        try {
            Photo photo = new Photo();

            photo.setID(rs.getInt("photo_id"));
            photo.setPatientID(rs.getString("patient_id"));
            photo.setUploadDate(rs.getTimestamp("upload_date"));

            return photo;
        } catch (SQLException e) {
            throw new DAOException("Error mapping row to Photo:", e);
        }
    }
}