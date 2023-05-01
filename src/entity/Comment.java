package entity;

import java.sql.Date;

public class Comment {

    private int id;
    private String comment;
    private Date postDate;
    private int userId;
    private int newsId;

    public Comment() {
    }

    public Comment(int id, String comment, Date postDate, int userId, int newsId) {
        this.id = id;
        this.comment = comment;
        this.postDate = postDate;
        this.userId = userId;
        this.newsId = newsId;
    }

    public Comment(String comment, Date postDate, int userId, int newsId) {
        this.comment = comment;
        this.postDate = postDate;
        this.userId = userId;
        this.newsId = newsId;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getComment() {
        return comment;
    }

    public void setComment(String comment) {
        this.comment = comment;
    }

    public Date getPostDate() {
        return postDate;
    }

    public void setPostDate(Date postDate) {
        this.postDate = postDate;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public int getNewsId() {
        return newsId;
    }

    public void setNewsId(int newsId) {
        this.newsId = newsId;
    }

    @Override
    public String toString() {
        return "Comment{" +
                "id=" + id +
                ", comment='" + comment + '\'' +
                ", postDate=" + postDate +
                ", userId=" + userId +
                ", newsId=" + newsId +
                '}';
    }
}
