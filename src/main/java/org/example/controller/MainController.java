package org.example.controller;


import org.example.dao.ArticleRepository;
import org.example.model.Article;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.data.web.PageableDefault;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;
import java.util.Collections;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/blog")
public class MainController {

    @Autowired
    private ArticleRepository service;

    @RequestMapping
    public String mainPage(Model model, @PageableDefault(sort = {"id"}, direction = Sort.Direction.DESC) Pageable pageable) {
        Page<Article> articles;
        articles = service.findAll(pageable);
        model.addAttribute("page", articles);
        model.addAttribute("url", "/blog");
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        Boolean isAdmin = false;
        for (GrantedAuthority grantedAuthority : auth.getAuthorities()) {
            if (grantedAuthority.getAuthority().equals("ROLE_ADMIN")) {
                isAdmin = true;
            }
        }
        model.addAttribute("isAdmin", isAdmin);
        return "main";
    }

    @RequestMapping(value = "/editor")
    public String editorPage(Model model) {
        model.addAttribute("article", new Article());
        return "editor";
    }

    @RequestMapping(value = "/editor/submit", method = RequestMethod.POST)
    public String submitArticle(
            @Valid Article article,
            BindingResult bindingResult, Model model) {
        if (bindingResult.hasErrors()) {
            Map<String, String> errorMap = UtilsController.getErrors(bindingResult);
            model.mergeAttributes(errorMap);
            model.addAttribute("message", article);
            return "editor";
        } else {
            Authentication auth = SecurityContextHolder.getContext().getAuthentication();
            article.setUsername(auth.getName());
            service.save(article);
        }
        model.addAttribute("message", null);
        return "redirect:../";
    }

    @GetMapping("/user-messages/{user}")
    private String userMessage(Model model, @PathVariable String user, @RequestParam(required = false) Long id) {
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        Article article;
        Boolean access = false;
        if (user.equals("-1") || user.equals(auth.getName())) {
            user = auth.getName();
            access = true;
        }
        List<Article> messages = service.findAll();
        messages = service.findAllByUsernameContains(user);
        Collections.sort(messages);
        Collections.reverse(messages);
        model.addAttribute("messages", messages);
        model.addAttribute("message", service.findById(id));
        model.addAttribute("article", new Article());
        model.addAttribute("access", access);
        return "userMessages";
    }

    @PostMapping("/user-messages/save")
    public String updateMessage(@Valid Article article) {
        List<Article> messages = service.findAll();
        Article article1 = service.findById(article.getId());
        article1.setTitle(article.getTitle());
        article1.setContent(article.getContent());
        service.save(article1);
        return "redirect:/blog";
    }

    @GetMapping("/delete/{article}")
    public String deleteArticle(@PathVariable String article) {
        List<Article> messages = service.findAll();
        Article currentArticle = service.findById(Long.valueOf(article));
        service.delete(currentArticle);
        return "redirect:/blog";
    }
}
