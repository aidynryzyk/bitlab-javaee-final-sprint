package dao;

import db.DBConnector;
import entity.User;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class UserDAO {

    private static final String CREATE_USER_SQL = "INSERT INTO users (email, password, fullName, roleId) VALUES (?, ?, ?, ?)";
    private static final String GET_USER_BY_ID_SQL = "SELECT * FROM users WHERE id = ?";
    private static final String GET_USER_BY_EMAIL_SQL = "SELECT * FROM users WHERE email = ?";
    private static final String GET_ALL_USERS_SQL = "SELECT * FROM users";
    private static final String GET_LAST_INSERT_ID_SQL = "SELECT LAST_INSERT_ID()";
    private static final String GET_USER_ROLE_NAME_SQL = "SELECT name FROM roles WHERE id = ?";
    private static final String UPDATE_USER_SQL = "UPDATE users SET email = ?, password = ?, fullName = ?, roleId = ? WHERE id = ?";
    private static final String DELETE_USER_SQL = "DELETE FROM users WHERE id = ?";

    public int createUser(User user) {
        try {
            int id = 0;
            Connection connection = DBConnector.getConnection();
            PreparedStatement preparedStatement = connection.prepareStatement(CREATE_USER_SQL);
            preparedStatement.setString(1, user.getEmail());
            preparedStatement.setString(2, user.getPassword());
            preparedStatement.setString(3, user.getFullName());
            preparedStatement.setInt(4, user.getRole());
            preparedStatement.execute();
            preparedStatement = connection.prepareStatement(GET_LAST_INSERT_ID_SQL);
            ResultSet resultSet = preparedStatement.executeQuery();
            if (resultSet.next()) {
                id = resultSet.getInt(1);
            }
            return id;
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public User getUserById(long id) {
        try {
            Connection connection = DBConnector.getConnection();
            User user = new User();
            PreparedStatement preparedStatement = connection.prepareStatement(GET_USER_BY_ID_SQL);
            preparedStatement.setLong(1, id);
            ResultSet resultSet = preparedStatement.executeQuery();
            if (resultSet.next()) {
                user.setId(resultSet.getInt("id"));
                user.setEmail(resultSet.getString("email"));
                user.setPassword(resultSet.getString("password"));
                user.setFullName(resultSet.getString("fullName"));
                user.setRole(resultSet.getInt("roleId"));
                return user;
            }
            return null;
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public User getUserByEmail(String email) {
        try {
            Connection connection = DBConnector.getConnection();
            User user = new User();
            PreparedStatement preparedStatement = connection.prepareStatement(GET_USER_BY_EMAIL_SQL);
            preparedStatement.setString(1, email);
            ResultSet resultSet = preparedStatement.executeQuery();
            if (resultSet.next()) {
                user.setId(resultSet.getInt("id"));
                user.setEmail(resultSet.getString("email"));
                user.setPassword(resultSet.getString("password"));
                user.setFullName(resultSet.getString("fullName"));
                user.setRole(resultSet.getInt("roleId"));
                return user;
            }
            return null;
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public String getRoleName(int roleId) {
        try {
            String name = null;
            Connection connection = DBConnector.getConnection();
            PreparedStatement preparedStatement = connection.prepareStatement(GET_USER_ROLE_NAME_SQL);
            preparedStatement.setInt(1, roleId);
            ResultSet resultSet = preparedStatement.executeQuery();
            if (resultSet.next()) {
                name = resultSet.getString(1);
            }
            return name;
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public List<User> getAllUser() {
        try {
            Connection connection = DBConnector.getConnection();
            String query = GET_ALL_USERS_SQL;
            List<User> users = new ArrayList<>();
            PreparedStatement preparedStatement = connection.prepareStatement(GET_ALL_USERS_SQL);
            ResultSet resultSet = preparedStatement.executeQuery();
            while (resultSet.next()) {
                User user = new User();
                user.setId(resultSet.getInt("id"));
                user.setEmail(resultSet.getString("email"));
                user.setPassword(resultSet.getString("password"));
                user.setFullName(resultSet.getString("fullName"));
                user.setRole(resultSet.getInt("roleId"));
                users.add(user);
            }
            return users;
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public void updateUser(User user) {
        try {
            Connection connection = DBConnector.getConnection();
            PreparedStatement preparedStatement = connection.prepareStatement(UPDATE_USER_SQL);
            preparedStatement.setString(1, user.getEmail());
            preparedStatement.setString(2, user.getPassword());
            preparedStatement.setString(3, user.getFullName());
            preparedStatement.setInt(4, user.getRole());
            preparedStatement.setLong(5, user.getId());
            preparedStatement.execute();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public void deleteUser(long id) {
        try {
            Connection connection = DBConnector.getConnection();
            PreparedStatement preparedStatement = connection.prepareStatement(DELETE_USER_SQL);
            preparedStatement.setLong(1, id);
            preparedStatement.execute();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }
}
