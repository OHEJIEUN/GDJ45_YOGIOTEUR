package com.tp.yogioteur.controller;

import java.io.IOException;
import java.text.ParseException;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.tp.yogioteur.domain.PaymentDTO;
import com.tp.yogioteur.domain.ReservationDTO;
import com.tp.yogioteur.service.PaymentService;
import com.tp.yogioteur.service.ReservationService;
import com.tp.yogioteur.service.RoomService;

@Controller
public class ReservationController {

	@Autowired
	private ReservationService reservationService;
	
	@Autowired
	private PaymentService paymentService;
	
	@Autowired
	private RoomService roomService;
	
	@PostMapping("reservation/reservationPage")
	public String reservationPage(HttpServletRequest request, Model model) {

		reservationService.reserToken(request, model);
		roomService.findRoomTypeByNo(request, model);
		
		Map<String, Object> roomInfo = new HashMap<>();
		roomInfo.put("chkIn", request.getParameter("chkIn"));
		roomInfo.put("chkOut", request.getParameter("chkOut"));
		roomInfo.put("roomNo", request.getParameter("roomNo"));
		roomInfo.put("roomName", request.getParameter("roomName"));
		roomInfo.put("roomPrice", request.getParameter("roomPr"));
		
		model.addAttribute("roomInfo", roomInfo);
		
		return "reservation/reservationPage";
	}
	
	@GetMapping("reservation/reservationConfirm")
	public String reservationConfirm(HttpServletRequest request, Model model) {
		reservationService.confirms(request, model);
		return "reservation/reservationConfirm";
	}
	
	@PostMapping("/payments")
	public void payments(@RequestParam(value="resRoomNo", required=false) Long roomNo, HttpServletRequest request, HttpServletResponse response) throws ParseException {
		reservationService.payments(request, response);
		roomService.changeRoomStatusOff(roomNo);
	}
	
	@GetMapping("/reservation/reservationCancel/{no}")
	public String reservationCancel(@PathVariable String no, HttpServletRequest request, Model model){
		reservationService.confirmsPopUp(no, request, model);
		return "reservation/reservationCancel";
	}
	
	@ResponseBody
	@PostMapping(value="/payment/complete", produces="application/json")
	public Map<String, Object> paymentComplete(@RequestBody PaymentDTO payments) throws IOException {
		return paymentService.paymentSave(payments);
	}
	
	@ResponseBody // 업데이트로 변경 
	@DeleteMapping(value="/reserRemove/{resNo}", produces="application/json")
	public Map<String, Object> removeReservation(@PathVariable String resNo){
		return reservationService.removeReservation(resNo);
	}
	
	@ResponseBody
	@PutMapping(value="/reserModify", produces="application/json")
	public Map<String, Object> changeMember(@RequestBody ReservationDTO reservation) throws IOException{ 
		String resNo = reservation.getReserNo();
		Long rooNo = reservation.getRoomNo();
		String reason = reservation.getReserRequest();
		
		roomService.changeRoomStatusOn(rooNo);
		
		String token = paymentService.getToken();
		String impUid = paymentService.paymentSearch(resNo);
		
		int amount = paymentService.paymentInfo(impUid, token);
		
		paymentService.paymentCancle(resNo, token, amount, reason);
		
		return reservationService.changeReservation(reservation);
	}
	
}