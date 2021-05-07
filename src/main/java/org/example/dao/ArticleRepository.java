package org.example.dao;


import org.example.model.Article;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface ArticleRepository extends CrudRepository<Article,Integer> {
    Page<Article> findAll(Pageable pageable);
    List<Article> findAll();
    List<Article> findAllByUsernameContains(String username);
    Article findById(Long id);
}
