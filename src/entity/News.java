package entity;

import java.sql.Date;

public class News {

    private int id;
    private Date postDate;
    private int categoryId;
    private String title;
    private String content;
    private int views;
    private String imageURL;

    public News() {
    }

    public News(int id, Date postDate, int categoryId, String title, String content, int views, String imageURL) {
        this.id = id;
        this.postDate = postDate;
        this.categoryId = categoryId;
        this.title = title;
        this.content = content;
        this.views = views;
        this.imageURL = imageURL;
    }

    public News(Date postDate, int categoryId, String title, String content, int views, String imageURL) {
        this.postDate = postDate;
        this.categoryId = categoryId;
        this.title = title;
        this.content = content;
        this.views = views;
        this.imageURL = imageURL;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public Date getPostDate() {
        return postDate;
    }

    public void setPostDate(Date postDate) {
        this.postDate = postDate;
    }

    public int getCategoryId() {
        return categoryId;
    }

    public void setCategoryId(int categoryId) {
        this.categoryId = categoryId;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public int getViews() {
        return views;
    }

    public void setViews(int views) {
        this.views = views;
    }

    public String getImageURL() {
        return imageURL;
    }

    public void setImageURL(String imageURL) {
        this.imageURL = imageURL;
    }

    @Override
    public String toString() {
        return "News{" +
                "id=" + id +
                ", postDate=" + postDate +
                ", categoryId=" + categoryId +
                ", title='" + title + '\'' +
                ", content='" + content + '\'' +
                ", views=" + views +
                ", imageURL='" + imageURL + '\'' +
                '}';
    }
}
