package it.unitn.web.centodiciotto.persistence.dao.jdbc;

import it.unitn.web.centodiciotto.persistence.base.jdbc.JDBCDAO;
import it.unitn.web.centodiciotto.persistence.dao.PhotoDAO;
import it.unitn.web.centodiciotto.persistence.dao.exceptions.DAOException;
import it.unitn.web.centodiciotto.persistence.dao.exceptions.DAOFactoryException;
import it.unitn.web.centodiciotto.persistence.entities.Photo;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Logger;

/**
 * {@link PhotoDAO} JDBC concrete implementation.
 */
@SuppressWarnings({"FieldCanBeLocal", "unused", "DuplicatedCode"})
public class JDBCPhotoDAO extends JDBCDAO<Photo, Integer> implements PhotoDAO {

    final private String INSERT = "INSERT INTO photo (patient_id, upload_date, extension) values (?, ?, ?) " +
            "RETURNING photo_id;";
    final private String UPDATE = "UPDATE photo SET upload_date = ?, extension = ? WHERE photo_id = ?";
    final private String DELETE = "DELETE FROM photo WHERE photo_id = ?";

    final private String GET_BY_PRIMARY_KEY = "SELECT * FROM photo WHERE photo_id = ?;";
    final private String GET_ALL = "SELECT * FROM photo;";
    final private String COUNT = "SELECT COUNT(*) FROM photo;";

    final private String GET_CURRENT_BY_PATIENT = "SELECT * FROM photo WHERE patient_id = ? " +
            "ORDER BY upload_date DESC LIMIT 1;";
    final private String GET_ALL_BY_PATIENT = "SELECT * FROM photo WHERE patient_id = ? " +
            "ORDER BY upload_date DESC;";

    /**
     * Instantiates the {@link JDBCDAO} using the currently opened connection.
     *
     * @param con the {@link Connection} to the database
     * @throws DAOFactoryException in case of DAO instantiation or connection failures
     */
    public JDBCPhotoDAO(Connection con) throws DAOFactoryException {
        super(con);
    }

    @Override
    public void insert(Photo photo) throws DAOException {
        try {
            PreparedStatement stm = CON.prepareStatement(INSERT);
            stm.setString(1, photo.getPatientID());
            stm.setTimestamp(2, photo.getUploadDate());
            stm.setString(3, photo.getExtension());

            ResultSet rs = stm.executeQuery();

            if (rs.next()) {
                Integer photoID = rs.getInt("photo_id");
                photo.setID(photoID);
                Logger.getLogger("C18").info("PhotoDAO::insert row affected returned " + photoID);
            } else {
                throw new DAOException("Error inserting Photo, query returnet an empty ResultSet.");
            }
        } catch (SQLException e) {
            throw new DAOException("Error inserting Photo: ", e);
        }
    }

    @Override
    public void update(Photo photo) throws DAOException {
        try {
            PreparedStatement stm = CON.prepareStatement(UPDATE);
            stm.setTimestamp(1, photo.getUploadDate());
            stm.setString(2, photo.getExtension());
            stm.setInt(3, photo.getID());

            int row = stm.executeUpdate();
            Logger.getLogger("C18").info("PhotoDAO::update affected " + row + " rows");
        } catch (SQLException e) {
            throw new DAOException("Error updating Photo: ", e);
        }
    }

    @Override
    public void delete(Photo photo) throws DAOException {
        try (PreparedStatement stm = CON.prepareStatement(DELETE)) {
            stm.setInt(1, photo.getID());

            int row = stm.executeUpdate();
            Logger.getLogger("C18").info("PhotoDAO::delete affected " + row + " rows");
        } catch (SQLException e) {
            throw new DAOException("Error deleting Photo: ", e);
        }
    }

    @Override
    public Photo getByPrimaryKey(Integer primaryKey) throws DAOException {
        Photo photo = null;
        try (PreparedStatement stm = CON.prepareStatement(GET_BY_PRIMARY_KEY)) {
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
        try (PreparedStatement stm = CON.prepareStatement(GET_ALL)) {
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
    public Photo getCurrentByPatient(String patientID) throws DAOException {
        Photo photo = null;
        try {
            PreparedStatement stm = CON.prepareStatement(GET_CURRENT_BY_PATIENT);
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
    public List<Photo> getAllByPatient(String patientID) throws DAOException {
        List<Photo> photos = new ArrayList<>();
        try {
            PreparedStatement stm = CON.prepareStatement(GET_ALL_BY_PATIENT);
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
            photo.setExtension(rs.getString("extension"));

            return photo;
        } catch (SQLException e) {
            throw new DAOException("Error mapping row to Photo:", e);
        }
    }
}