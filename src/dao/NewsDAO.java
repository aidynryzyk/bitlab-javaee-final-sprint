package dao;

import db.DBConnector;
import entity.News;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class NewsDAO {

    private static final String CREATE_NEWS_SQL = "INSERT INTO news (postDate, categoryId, title, content, views, imageUrl) VALUES (?, ?, ?, ?, ?, ?)";
    private static final String CREATE_LIKE_SQL = "INSERT INTO likes (news_id, user_id) VALUES (?, ?)";
    private static final String GET_NEWS_BY_ID_SQL = "SELECT * FROM news WHERE id = ?";
    private static final String GET_ALL_NEWS_SQL = "SELECT * FROM news";
    private static final String GET_ALL_CATEGORIES_SQL = "SELECT * FROM categories";
    private static final String GET_ALL_NEWS_SORTED_BY_VIEWS_DESC_SQL = "SELECT * FROM news ORDER BY views DESC LIMIT ? OFFSET ?";
    private static final String GET_ALL_NEWS_SORTED_BY_DATE_DESC_SQL = "SELECT * FROM news ORDER BY postDate DESC LIMIT ? OFFSET ?";
    private static final String GET_ALL_NEWS_BY_CATEGORY = "SELECT * FROM news WHERE categoryId = ?";
    private static final String GET_ALL_NEWS_BY_WORD = "SELECT * FROM news WHERE LOWER(title) LIKE ? OR LOWER(content) LIKE ?";
    private static final String GET_COMMENTS_COUNT_SQL = "SELECT COUNT(*) FROM comments WHERE news_id = ?";
    private static final String GET_CATEGORY_NAME_SQL = "SELECT name FROM categories WHERE id = ?";
    private static final String GET_LIKED_BY_USER_NEWS = "SELECT * FROM likes WHERE news_id = ? AND user_id = ?";
    private static final String GET_ALL_LIKES_OF_NEWS = "SELECT COUNT(*) FROM likes WHERE news_id = ?";
    private static final String GET_LAST_INSERT_ID_SQL = "SELECT LAST_INSERT_ID()";
    private static final String UPDATE_NEWS_SQL = "UPDATE news SET postDate = ?, categoryId = ?, title = ?, content = ?,  views = ?, imageUrl = ? WHERE id = ?";
    private static final String UPDATE_NEWS_INCREMENT_VIEWS_SQL = "UPDATE news SET views = views + 1 WHERE id = ?";
    private static final String DELETE_NEWS_SQL = "DELETE FROM news WHERE id = ?";
    private static final String DELETE_LIKE_SQL = "DELETE FROM likes WHERE news_id = ? AND user_id = ?";

    public int createNews(News news) {
        try {
            int id = 0;
            Connection connection = DBConnector.getConnection();
            PreparedStatement preparedStatement = connection.prepareStatement(CREATE_NEWS_SQL);
            preparedStatement.setDate(1, news.getPostDate());
            preparedStatement.setInt(2, news.getCategoryId());
            preparedStatement.setString(3, news.getTitle());
            preparedStatement.setString(4, news.getContent());
            preparedStatement.setInt(5, news.getViews());
            preparedStatement.setString(6, news.getImageURL());
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

    public News getNewsById(int id) {
        try {
            Connection connection = DBConnector.getConnection();
            News news = new News();
            PreparedStatement preparedStatement = connection.prepareStatement(GET_NEWS_BY_ID_SQL);
            preparedStatement.setLong(1, id);
            ResultSet resultSet = preparedStatement.executeQuery();
            if (resultSet.next()) {
                news.setId(resultSet.getInt("id"));
                news.setPostDate(resultSet.getDate("postDate"));
                news.setCategoryId(resultSet.getInt("categoryId"));
                news.setTitle(resultSet.getString("title"));
                news.setContent(resultSet.getString("content"));
                news.setViews(resultSet.getInt("views"));
                news.setImageURL(resultSet.getString("imageUrl"));
                return news;
            }
            return null;
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    private List<News> getAll(boolean sortByViewsDesc, boolean selectByCategory, boolean sortByDateDesc, long categoryId, int limit, int offset, String word) {
        try {
            Connection connection = DBConnector.getConnection();
            List<News> newsList = new ArrayList<>();
            PreparedStatement preparedStatement;
            if (sortByViewsDesc) {
                preparedStatement = connection.prepareStatement(GET_ALL_NEWS_SORTED_BY_VIEWS_DESC_SQL);
                preparedStatement.setInt(1, limit);
                preparedStatement.setInt(2, offset);
            } else if (selectByCategory) {
                preparedStatement = connection.prepareStatement(GET_ALL_NEWS_BY_CATEGORY);
                preparedStatement.setLong(1, categoryId);
            } else if (sortByDateDesc) {
                preparedStatement = connection.prepareStatement(GET_ALL_NEWS_SORTED_BY_DATE_DESC_SQL);
                preparedStatement.setInt(1, limit);
                preparedStatement.setInt(2, offset);
            } else if (word != null) {
                preparedStatement = connection.prepareStatement(GET_ALL_NEWS_BY_WORD);
                preparedStatement.setString(1, "%" + word.toLowerCase() + "%");
                preparedStatement.setString(2, "%" + word.toLowerCase() + "%a");
            } else {
                preparedStatement = connection.prepareStatement(GET_ALL_NEWS_SQL);
            }
            ResultSet resultSet = preparedStatement.executeQuery();
            while (resultSet.next()) {
                News news = new News();
                news.setId(resultSet.getInt("id"));
                news.setPostDate(resultSet.getDate("postDate"));
                news.setCategoryId(resultSet.getInt("categoryId"));
                news.setTitle(resultSet.getString("title"));
                news.setContent(resultSet.getString("content"));
                news.setViews(resultSet.getInt("views"));
                news.setImageURL(resultSet.getString("imageUrl"));
                newsList.add(news);
            }
            return newsList;
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public List<News> getAllNews() {
        return getAll(false, false, false, 0, 0, 0, null);
    }

    public List<News> getAllNewsSortedByViewsDesc(int limit, int offset) {
        return getAll(true, false, false, 0, limit, offset, null);
    }

    public List<News> getAllNewsByCategory(long categoryId) {
        return getAll(false, true, false, categoryId, 0, 0, null);
    }

    public List<News> getAllNewsSortedByDateDesc(int limit, int offset) {
        return getAll(false, false, true, 0, limit, offset, null);
    }

    public List<News> getAllNewsByWord(int limit, int offset, String word) {
        return getAll(false, false, false, 0, limit, offset, word);
    }

    public List<String> getAllCategories() {
        List<String> categories = new ArrayList<>();
        try {
            Connection connection = DBConnector.getConnection();
            PreparedStatement preparedStatement = connection.prepareStatement(GET_ALL_CATEGORIES_SQL);
            ResultSet resultSet = preparedStatement.executeQuery();
            while (resultSet.next()) {
                categories.add(resultSet.getString("name"));
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return categories;
    }

    public int getCommentsCount(int id) {
        int count = 0;
        try {
            Connection connection = DBConnector.getConnection();
            PreparedStatement preparedStatement = connection.prepareStatement(GET_COMMENTS_COUNT_SQL);
            preparedStatement.setInt(1, id);
            ResultSet resultSet = preparedStatement.executeQuery();
            while (resultSet.next()) {
                count = resultSet.getInt("COUNT(*)");
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return count;
    }

    public String getCategoryName(int id) {
        String name = null;
        try {
            Connection connection = DBConnector.getConnection();
            PreparedStatement preparedStatement = connection.prepareStatement(GET_CATEGORY_NAME_SQL);
            preparedStatement.setInt(1, id);
            ResultSet resultSet = preparedStatement.executeQuery();
            while (resultSet.next()) {
                name = resultSet.getString("name");
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return name;
    }

    public int getLikesOfNews(int id) {
        int count = 0;
        try {
            Connection connection = DBConnector.getConnection();
            PreparedStatement preparedStatement = connection.prepareStatement(GET_ALL_LIKES_OF_NEWS);
            preparedStatement.setInt(1, id);
            ResultSet resultSet = preparedStatement.executeQuery();
            while (resultSet.next()) {
                count = resultSet.getInt("COUNT(*)");
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return count;
    }

    public boolean isLikedByUser(int newsId, int userId) {
        boolean liked = false;
        try {
            Connection connection = DBConnector.getConnection();
            PreparedStatement preparedStatement = connection.prepareStatement(GET_LIKED_BY_USER_NEWS);
            preparedStatement.setInt(1, newsId);
            preparedStatement.setInt(2, userId);
            ResultSet resultSet = preparedStatement.executeQuery();
            if (resultSet.next()) {
                liked = true;
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return liked;
    }

    public void like(int newsId, int userId) {
        try {
            Connection connection = DBConnector.getConnection();
            PreparedStatement preparedStatement = connection.prepareStatement(CREATE_LIKE_SQL);
            preparedStatement.setInt(1, newsId);
            preparedStatement.setInt(2, userId);
            preparedStatement.execute();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public void dislike(int newsId, int userId) {
        try {
            Connection connection = DBConnector.getConnection();
            PreparedStatement preparedStatement = connection.prepareStatement(DELETE_LIKE_SQL);
            preparedStatement.setInt(1, newsId);
            preparedStatement.setInt(2, userId);
            preparedStatement.execute();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public void updateNews(News news) {
        try {
            Connection connection = DBConnector.getConnection();
            PreparedStatement preparedStatement = connection.prepareStatement(UPDATE_NEWS_SQL);
            preparedStatement.setDate(1, news.getPostDate());
            preparedStatement.setInt(2, news.getCategoryId());
            preparedStatement.setString(3, news.getTitle());
            preparedStatement.setString(4, news.getContent());
            preparedStatement.setInt(5, news.getViews());
            preparedStatement.setString(6, news.getImageURL());
            preparedStatement.setLong(7, news.getId());
            preparedStatement.execute();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public void incrementViews(long id) {
        try {
            Connection connection = DBConnector.getConnection();
            PreparedStatement preparedStatement = connection.prepareStatement(UPDATE_NEWS_INCREMENT_VIEWS_SQL);
            preparedStatement.setLong(1, id);
            preparedStatement.execute();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public void deleteNews(long id) {
        try {
            Connection connection = DBConnector.getConnection();
            PreparedStatement preparedStatement = connection.prepareStatement(DELETE_NEWS_SQL);
            preparedStatement.setLong(1, id);
            preparedStatement.execute();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }
}
