package com.fastcampus.ch4.controller;

import java.time.Instant;
import java.time.LocalDate;
import java.time.ZoneId;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.fastcampus.ch4.domain.BoardDto;
import com.fastcampus.ch4.domain.PageHandler;
import com.fastcampus.ch4.domain.SearchCondition;
import com.fastcampus.ch4.service.BoardService;

@Controller
@RequestMapping("/board")
public class BoardController {
	
	@Autowired
	BoardService boardService;
	
	
	@GetMapping("/read")
	public String read(Integer bno, Integer page, Integer pageSize, Model m) {
		try {
			BoardDto boardDto = boardService.read(bno);
//			m.addAttribute("boardDto", boardDto); 아래 문장과 동일 이름을 생략하면 타입의 첫 글자를 소문자로 하여 이름 저장
			m.addAttribute(boardDto);
			m.addAttribute("page", page);
			m.addAttribute("pageSize", pageSize);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return "board";
	}
	
	
	
	@GetMapping("/list")
	public String list(SearchCondition sc, Model m, HttpServletRequest request) {
		if(!loginCheck(request))
			return "redirect:/login/login?toURL="+request.getRequestURL();  // 로그인을 안했으면 로그인 화면으로 이동

        try {
            int totalCnt = boardService.getSearchResultCnt(sc);
            m.addAttribute("totalCnt", totalCnt);

            PageHandler pageHandler = new PageHandler(totalCnt, sc);

            List<BoardDto> list = boardService.getSearchResultPage(sc);
            m.addAttribute("list", list);
            m.addAttribute("ph", pageHandler);

            Instant startOfToday = LocalDate.now().atStartOfDay(ZoneId.systemDefault()).toInstant();
            m.addAttribute("startOfToday", startOfToday.toEpochMilli());
        } catch (Exception e) {
            e.printStackTrace();
            m.addAttribute("msg", "LIST_ERR");
            m.addAttribute("totalCnt", 0);
        }
		
		
		return "boardList"; // 로그인을 한 상태이면, 게시판 화면으로 이동
	}
	
	@PostMapping("/remove")
	public String remove(Integer bno, Integer page, Integer pageSize, Model m, HttpSession session, RedirectAttributes rattr) {
		String writer = (String)session.getAttribute("id");
		try {
			// redirect에 붙히는 것보다 모델에 담아서 전달하는게 깔끔해서 이렇게 한다고 함
			m.addAttribute("page", page);
			m.addAttribute("pageSize", pageSize);
			
			int rowCnt = boardService.remove(bno, writer);
			
			if(rowCnt!=1)
				throw new Exception("board remove error");

			// 세션에 잠깐 저장했다 1회성으로 사용 후 삭제! 
			rattr.addFlashAttribute("msg", "DEL_OK");
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			rattr.addFlashAttribute("msg", "DEL_ERR");
		}
		
		return "redirect:/board/list";
		
	}
	
	@GetMapping("/write")
	public String write(Model m) {
		m.addAttribute("mode","new");
		return "board"; // 읽기와 쓰기에 사용, 쓰기에 사용할 때는 mode=new
	}
	
	@PostMapping("/write")
	public String write(BoardDto boardDto, HttpSession session, Model m, RedirectAttributes rtts) {
		
		String writer = (String)session.getAttribute("id");
		boardDto.setWriter(writer);
		
		try {
			
			int rowCnt = boardService.write(boardDto); //insert
			
			if(rowCnt!=1) throw new Exception("Write failed");
			
			//이건 세션을 이용한 1회성 저장용 (사용 후 삭제)
			rtts.addFlashAttribute("msg", "WRT_OK");
			
			return "redirect:/board/list";
		} catch (Exception e) {
			e.printStackTrace();
			//앞의 key값을 생략하면 타입의 이름 첫 글자가 key값으로 자동 입력된다.
			//예외발생 시 boardDto에 있는 내용을 board.jsp로 전달해주기 때문에 입력한 내용을 잃어버리지 않는 것이다.
			m.addAttribute(boardDto);
			m.addAttribute("msg", "WRT_ERR");
			return "board";
		}
		
	}

	@PostMapping("/modify")
	public String modify(BoardDto boardDto, HttpSession session, Model m, RedirectAttributes rtts) {
		
		String writer = (String)session.getAttribute("id");
		boardDto.setWriter(writer);
		
		try {
			
			int rowCnt = boardService.modify(boardDto); //insert
			
			if(rowCnt!=1) throw new Exception("Modify failed");
			
			//이건 세션을 이용한 1회성 저장용 (사용 후 삭제)
			rtts.addFlashAttribute("msg", "MOD_OK");
			
			return "redirect:/board/list";
		} catch (Exception e) {
			e.printStackTrace();
			//앞의 key값을 생략하면 타입의 이름 첫 글자가 key값으로 자동 입력된다.
			//예외발생 시 boardDto에 있는 내용을 board.jsp로 전달해주기 때문에 입력한 내용을 잃어버리지 않는 것이다.
			m.addAttribute(boardDto);
			m.addAttribute("msg", "MOD_ERR");
			return "board";
		}
		
	}
	
	
	
	
	private boolean loginCheck(HttpServletRequest request) {
		// 1. 세션을 얻어서
		HttpSession session = request.getSession(false);
		// 2. 세션에 id가 있는지 확인, 있으면 true를 반환
		    return session.getAttribute("id")!=null;
	}
}