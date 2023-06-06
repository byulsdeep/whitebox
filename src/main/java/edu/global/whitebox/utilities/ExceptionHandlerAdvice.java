package edu.global.whitebox.utilities;

import org.springframework.ui.Model;
import org.springframework.web.bind.MethodArgumentNotValidException;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.servlet.NoHandlerFoundException;

@ControllerAdvice
public class ExceptionHandlerAdvice {

    @ExceptionHandler(MethodArgumentNotValidException.class)
    public String handleBadRequest(Model model, MethodArgumentNotValidException e) {
        model.addAttribute("message", e.getMessage());
        e.printStackTrace();
        return "400";
    }

    @ExceptionHandler(Exception.class)
    public String handleException(Model model, Exception e) {
    	 model.addAttribute("message", e.getMessage());
    	 e.printStackTrace();
        return "500";
    }
}