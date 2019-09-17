package it.unitn.web.centodiciotto.persistence.dao.jdbc;

import it.unitn.web.centodiciotto.persistence.dao.PhotoDAO;
import it.unitn.web.centodiciotto.persistence.entities.Photo;
import it.unitn.web.persistence.dao.exceptions.DAOException;
import it.unitn.web.persistence.dao.jdbc.JDBCDAO;
import it.unitn.web.utils.Pair;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class JDBCPhotoDAO extends JDBCDAO<Photo, Pair<Integer, String>> implements PhotoDAO {

    final private String INSERT = "INSERT INTO photo values (?, ?, ?);";
    final private String UPDATE = "UPDATE photo SET upload_date = ? WHERE photoid = ?, email = ?;";
    final private String DELETE = "DELETE from photo WHERE photoid = ?, email = ?;";
    final private String FINDBYPRIMARYKEY = "SELECT * FROM photo WHERE photoid = ?, email = ?;";
    final private String SELECTALL = "SELECT * FROM photo;";
    final private String FINDBYEMAIL = "SELECT * FROM photo WHERE email = ? ORDER BY upload_date DESC, photoid DESC;";
    final private String SELECTMAX = "SELECT MAX(photoid) + 1 AS nextid FROM photo WHERE email = ?;";

    public JDBCPhotoDAO(Connection con) {
        super(con);
    }

    @Override
    public Integer insert(Photo photo) {
        int photoid = 0;
        try {
            PreparedStatement maxStatement = CON.prepareStatement(SELECTMAX);
            maxStatement.setString(1, photo.getEmail());
            ResultSet rs = maxStatement.executeQuery();

            if (rs.next()) { // Assumo ci sia un risultato solo
                photoid = rs.getInt("nextid");
                photo.setPhotoid(photoid);
            }

            PreparedStatement preparedStatement = CON.prepareStatement(INSERT);
            preparedStatement.setInt(1, photoid);
            preparedStatement.setString(2, photo.getEmail());
            preparedStatement.setDate(3, photo.getUploadDate());

            int row = preparedStatement.executeUpdate();
            System.out.println("Rows affected: " + row);

        } catch (SQLException e) {
            System.err.println("Error inserting Photo: " + e.getMessage());
        }
        return photoid;
    }

    @Override
    public void update(Photo photo) {
        try {
            PreparedStatement preparedStatement = CON.prepareStatement(UPDATE);
            preparedStatement.setDate(1, photo.getUploadDate());
            preparedStatement.setInt(2, photo.getPhotoid());
            preparedStatement.setString(3, photo.getEmail());

            int row = preparedStatement.executeUpdate();
            System.out.println("Rows affected: " + row);

        } catch (SQLException e) {
            System.err.println("Error updating Photo: " + e.getMessage());
        }
    }

    @Override
    public void delete(Photo photo) {
        try (PreparedStatement stm = CON.prepareStatement(DELETE)) {
            stm.setInt(1, photo.getPhotoid());
            stm.setString(2, photo.getEmail());

            int row = stm.executeUpdate();
        } catch (SQLException e) {
            System.err.println("Error deleting Photo: " + e.getMessage());
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
            System.err.println("Error counting Photos: " + e.getMessage());
        }
        return res;
    }

    @Override
    public Photo getByPrimaryKey(Pair<Integer, String> primaryKey) throws DAOException {
        Photo res;
        try (PreparedStatement stm = CON.prepareStatement(FINDBYPRIMARYKEY)) {
            stm.setInt(1, primaryKey.getFirst());
            stm.setString(2, primaryKey.getSecond());

            try (ResultSet rs = stm.executeQuery()) {
                if (rs.next()) {
                    res = new Photo(
                            rs.getInt("photoid"),
                            rs.getString("email"),
                            rs.getDate("upload_date"));
                    return res;
                }
            }
        } catch (SQLException e) {
            System.err.println("Error getting Photo:" + e.getMessage());
        }
        return null;
    }

    @Override
    public List<Photo> getAll() throws DAOException {
        List<Photo> res = new ArrayList<>();
        Photo tmp;
        try (PreparedStatement stm = CON.prepareStatement(SELECTALL)) {
            try (ResultSet rs = stm.executeQuery()) {
                while (rs.next()) {
                    tmp = new Photo(
                            rs.getInt("photoid"),
                            rs.getString("email"),
                            rs.getDate("upload_date"));
                    res.add(tmp);
                }
                return res;
            }
        } catch (SQLException e) {
            System.err.println("Error getting all Photos: " + e.getMessage());
        }
        return null;
    }

    @Override
    public List<Photo> getByEmail(String email) throws DAOException {
        List<Photo> res = new ArrayList<>();
        Photo tmp;

        try (PreparedStatement stm = CON.prepareStatement(FINDBYEMAIL)) {
            stm.setString(1, email);

            try (ResultSet rs = stm.executeQuery()) {
                while (rs.next()) {
                    tmp = new Photo(
                            rs.getInt("photoid"),
                            rs.getString("email"),
                            rs.getDate("upload_date"));
                    res.add(tmp);
                }
                return res;
            }
        } catch (SQLException e) {
            System.err.println("Error getting Photo:" + e.getMessage());
        }
        return null;
    }

    @Override
    public Photo getLastPhotoByEmail(String email) throws DAOException {
        Photo tmp;

        try (PreparedStatement stm = CON.prepareStatement(FINDBYEMAIL)) {
            stm.setString(1, email);

            try (ResultSet rs = stm.executeQuery()) {
                if (rs.next()) {
                    tmp = new Photo(
                            rs.getInt("photoid"),
                            rs.getString("email"),
                            rs.getDate("upload_date"));
                    return tmp;
                }
            }
        } catch (SQLException e) {
            System.err.println("Error getting Photo:" + e.getMessage());
        }
        return null;
    }


}
