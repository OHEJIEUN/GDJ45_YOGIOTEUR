package com.tp.yogioteur.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

import com.tp.yogioteur.service.QnaService;

@Controller
public class QnaController {
	
	@Autowired
	private QnaService qnaService;
	
	@GetMapping("/qna/qnaList")
	public String qnaList(HttpServletRequest request, Model model) {
		qnaService.selectQnas(request, model);
		return "qna/qnaList";
	}
	
	@GetMapping("/qna/qnaDetailPage")
	public String qnaDetailPage(Long qnaNo, Model model) {
		qnaService.selectDetailQna(qnaNo, model);
		return "qna/qnaDetail";
	}
	
	@GetMapping("/qna/qnaSavePage")
	public String qnaSavePage () {
		return "qna/qnaSave";
	}
	
	@PostMapping("/qna/qnaSave")
	public void qnaSave(HttpServletRequest request, HttpServletResponse response) {
		qnaService.AddQna(request, response);
	}
	
}
