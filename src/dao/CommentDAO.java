package dao;

import db.DBConnector;
import entity.Comment;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class CommentDAO {

    private static final String CREATE_COMMENT_SQL = "INSERT INTO comments (comment, postDate, user_id, news_id) VALUES (?, ?, ?, ?)";
    private static final String GET_COMMENT_BY_ID_SQL = "SELECT * FROM comments WHERE id = ?";
    private static final String GET_ALL_COMMENT_BY_USER_ID_SQL = "SELECT * FROM comments WHERE user_id = ?";
    private static final String GET_ALL_COMMENT_BY_NEWS_ID_SORT_BY_ID_DESC_SQL = "SELECT * FROM comments WHERE news_id = ? ORDER BY id DESC";
    private static final String GET_ALL_COMMENTS_SQL = "SELECT * FROM comments";
    private static final String UPDATE_COMMENT_SQL = "UPDATE comments SET comment = ?, postDate = ?, user_id = ?, news_id = ? WHERE id = ?";
    private static final String DELETE_COMMENT_SQL = "DELETE FROM comments WHERE id = ?";

    public void createComment(Comment comment) {
        try {
            Connection connection = DBConnector.getConnection();
            PreparedStatement preparedStatement = connection.prepareStatement(CREATE_COMMENT_SQL);
            preparedStatement.setString(1, comment.getComment());
            preparedStatement.setDate(2, comment.getPostDate());
            preparedStatement.setInt(3, comment.getUserId());
            preparedStatement.setInt(4, comment.getNewsId());
            preparedStatement.execute();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public Comment getCommentById(int id) {
        try {
            Connection connection = DBConnector.getConnection();
            Comment comment = new Comment();
            PreparedStatement preparedStatement = connection.prepareStatement(GET_COMMENT_BY_ID_SQL);
            preparedStatement.setLong(1, id);
            ResultSet resultSet = preparedStatement.executeQuery();
            if (resultSet.next()) {
                comment.setId(resultSet.getInt("id"));
                comment.setComment(resultSet.getString("comment"));
                comment.setPostDate(resultSet.getDate("postDate"));
                comment.setUserId(resultSet.getInt("user_id"));
                comment.setNewsId(resultSet.getInt("news_id"));
                return comment;
            }
            return null;
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public List<Comment> getAllCommentsByUserId(int userId) {
        try {
            Connection connection = DBConnector.getConnection();
            List<Comment> comments = new ArrayList<>();
            PreparedStatement preparedStatement = connection.prepareStatement(GET_ALL_COMMENT_BY_USER_ID_SQL);
            preparedStatement.setInt(1, userId);
            ResultSet resultSet = preparedStatement.executeQuery();
            while (resultSet.next()) {
                Comment comment = new Comment();
                comment.setId(resultSet.getInt("id"));
                comment.setComment(resultSet.getString("comment"));
                comment.setPostDate(resultSet.getDate("postDate"));
                comment.setUserId(resultSet.getInt("user_id"));
                comment.setNewsId(resultSet.getInt("news_id"));
                comments.add(comment);
            }
            return comments;
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public List<Comment> getAllCommentsByNewsId(int newsId) {
        try {
            Connection connection = DBConnector.getConnection();
            List<Comment> comments = new ArrayList<>();
            PreparedStatement preparedStatement = connection.prepareStatement(GET_ALL_COMMENT_BY_NEWS_ID_SORT_BY_ID_DESC_SQL);
            preparedStatement.setInt(1, newsId);
            ResultSet resultSet = preparedStatement.executeQuery();
            while (resultSet.next()) {
                Comment comment = new Comment();
                comment.setId(resultSet.getInt("id"));
                comment.setComment(resultSet.getString("comment"));
                comment.setPostDate(resultSet.getDate("postDate"));
                comment.setUserId(resultSet.getInt("user_id"));
                comment.setNewsId(resultSet.getInt("news_id"));
                comments.add(comment);
            }
            return comments;
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public List<Comment> getAllComments() {
        try {
            Connection connection = DBConnector.getConnection();
            List<Comment> comments = new ArrayList<>();
            PreparedStatement preparedStatement = connection.prepareStatement(GET_ALL_COMMENTS_SQL);
            ResultSet resultSet = preparedStatement.executeQuery();
            while (resultSet.next()) {
                Comment comment = new Comment();
                comment.setId(resultSet.getInt("id"));
                comment.setComment(resultSet.getString("comment"));
                comment.setPostDate(resultSet.getDate("postDate"));
                comment.setUserId(resultSet.getInt("user_id"));
                comment.setNewsId(resultSet.getInt("news_id"));
                comments.add(comment);
            }
            return comments;
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public void updateComment(Comment comment) {
        try {
            Connection connection = DBConnector.getConnection();
            PreparedStatement preparedStatement = connection.prepareStatement(UPDATE_COMMENT_SQL);
            preparedStatement.setString(1, comment.getComment());
            preparedStatement.setDate(2, comment.getPostDate());
            preparedStatement.setInt(3, comment.getUserId());
            preparedStatement.setInt(4, comment.getNewsId());
            preparedStatement.setLong(5, comment.getId());
            preparedStatement.execute();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public void deleteComment(int id) {
        try {
            Connection connection = DBConnector.getConnection();
            PreparedStatement preparedStatement = connection.prepareStatement(DELETE_COMMENT_SQL);
            preparedStatement.setLong(1, id);
            preparedStatement.execute();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }
}
