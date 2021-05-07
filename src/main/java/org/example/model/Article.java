package org.example.model;


import javax.persistence.*;
import javax.validation.constraints.NotBlank;
import java.io.Serializable;
import java.text.SimpleDateFormat;
import java.util.Date;

@Entity
public class Article implements Serializable, Comparable<Article> {
    @Id
    @GeneratedValue
    private Long id;
    @NotBlank(message = "Please, fill this field")
    @Column
    private String title;
    @NotBlank(message = "Please, fill this field")
    @Column(length = 1000000)
    @Lob
    private String content;
    @Column
    private String username;
    @Column
    private long creationTimestamp;

    public Article() {
        this.creationTimestamp = System.currentTimeMillis();
    }

    public Article(String title, String Context, String username) {
        this.content = Context;
        this.title = title;
        this.username = username;
        this.creationTimestamp = System.currentTimeMillis();
    }

    @Override
    public int compareTo(Article that) {
        return Long.compare(this.creationTimestamp, that.creationTimestamp);
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

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getCreationTimestamp() {
        SimpleDateFormat sdf = new SimpleDateFormat("дата: dd.MMM.yyyy, время: HH:mm");
        Date data = new Date(creationTimestamp);
        return sdf.format(data);
    }

    public void setCreationTimestamp(long creationTimestamp) {
        this.creationTimestamp = creationTimestamp;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }
}
