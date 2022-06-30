package com.tp.yogioteur.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

import com.tp.yogioteur.service.ReviewReplyService;
import com.tp.yogioteur.service.ReviewService;


@Controller
public class ReviewReplyController {
	@Autowired
	private ReviewReplyService reviewReplyService;

	@Autowired
	public ReviewService reviewService;
	
	@GetMapping("/reply/reviewReplySavePage")
	public String reviewReplySavePage(Long reviewNo, Model model){
		reviewService.ReviewOne(reviewNo, model);
		return "review/reviewReplySave";
	}
	
	@PostMapping("review/reviewReplySave")
	public void reviewReplySave(HttpServletRequest request, HttpServletResponse response) {
		reviewReplyService.ReviewReplySave(request, response);
		
	}
	
	
	@GetMapping("/reply/reviewReplyRemove")
	public void reviewReplyRemove(HttpServletRequest request, HttpServletResponse response){
		reviewReplyService.ReviewReplyRemove(request, response);
	}
}