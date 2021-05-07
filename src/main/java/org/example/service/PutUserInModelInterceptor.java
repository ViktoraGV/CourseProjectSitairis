package org.example.service;

import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.security.Principal;

public class PutUserInModelInterceptor implements HandlerInterceptor {

    @Override
    public boolean preHandle(HttpServletRequest aRequest, HttpServletResponse aResponse, Object aHandler) throws Exception {
        return true;
    }

    @Override
    public void postHandle(HttpServletRequest aRequest, HttpServletResponse aResponse, Object aHandler, ModelAndView aModelAndView) throws Exception {
        if(aModelAndView != null) {
            Principal user = aRequest.getUserPrincipal();
            aModelAndView.addObject("__user", user);
        }
    }

    @Override
    public void afterCompletion(HttpServletRequest aRequest, HttpServletResponse aResponse, Object aHandler, Exception aEx) throws Exception { }

}