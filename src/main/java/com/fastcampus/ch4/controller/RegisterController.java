package com.fastcampus.ch4.controller;

import java.net.URLEncoder;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.fastcampus.ch4.dao.UserDao;
import com.fastcampus.ch4.domain.User;

@Controller // ctrl+shift+o 자동 임포트
public class RegisterController {

	@Autowired
	UserDao userdao;

//	@RequestMapping(value="/register/add", method=RequestMethod.GET) // 신규회원 가입
	@GetMapping("/register/add") // 4.3부터 추가
	public String register(HttpSession session) {
        session.invalidate();
		return "registerForm"; // WEB-INF/views/registerForm.jsp
	}

//	@RequestMapping(value="/register/save", method=RequestMethod.POST) // 신규회원 가입
	@PostMapping("/register/save")
//	@PostMapping("/register/add")
	public String save(@ModelAttribute("user") User user, Model m, RedirectAttributes rattr) throws Exception {

		if (!isValid(user)) {
			String msg = URLEncoder.encode("id를 잘못입력하셨습니다.", "utf-8");

			m.addAttribute("msg", msg);
			return "redirect:/register/add"; // 신규회원 가입화면으로 이동(redirect)
		}

		userdao.insertUser(user);
		rattr.addFlashAttribute("msg", "REG_OK");
		return "redirect:/login/login";

	}

	private boolean isValid(User user) {
		return true;
	}

}