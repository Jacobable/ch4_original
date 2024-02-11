<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@taglib prefix="c" uri="http://java.sun.com/jstl/core_rt"%>
<%@ page session="true"%>
<!-- 세션에서 로그인 정보 가져오기 -->
<c:set var="loginId" value="${pageContext.request.getSession(false) == null ? '' : pageContext.request.session.getAttribute('id')}" />

<!-- 로그인 여부에 따라 로그인/로그아웃 링크 및 ID 설정 -->
<c:set var="loginOutLink"
	value="${loginId=='' ? '/login/login' : '/login/logout'}" />
<c:set var="loginOut" value="${loginId=='' ? 'Login' : 'Logout'}" />
<c:set var="bnoValue" value="${boardDto.bno}" />

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>fastcampus</title>
<link rel="stylesheet" href="<c:url value='/css/menu.css'/>">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<script src="https://code.jquery.com/jquery-1.11.3.js"></script>
<style>
* {
	box-sizing: border-box;
	margin: 0;
	padding: 0;
	font-family: "Noto Sans KR", sans-serif;
}

.container {
	width: 50%;
	margin: auto;
}

.writing-header {
	position: relative;
	margin: 20px 0 0 0;
	padding-bottom: 10px;
	border-bottom: 1px solid #323232;
}

input {
	width: 100%;
	height: 35px;
	margin: 5px 0px 10px 0px;
	border: 1px solid #e9e8e8;
	padding: 8px;
	background: #f8f8f8;
	outline-color: #e6e6e6;
}

textarea {
	width: 100%;
	background: #f8f8f8;
	margin: 5px 0px 10px 0px;
	border: 1px solid #e9e8e8;
	resize: none;
	padding: 8px;
	outline-color: #e6e6e6;
}

.frm {
	width: 100%;
}

.btn {
	background-color: rgb(236, 236, 236); /* Blue background */
	border: none; /* Remove borders */
	color: black; /* White text */
	padding: 6px 12px; /* Some padding */
	font-size: 16px; /* Set a font size */
	cursor: pointer; /* Mouse pointer on hover */
	border-radius: 5px;
}

.btn:hover {
	text-decoration: underline;
}

/*======= 아래는 댓글 및 대댓글 css ======*/

#commentList {
    width : 50%;
    margin : auto;
}

/* 수정된 CSS 코드 */
.comment-content {
    overflow-wrap: break-word;
    margin-top: 10px; /* 추가: 댓글 내용과의 간격 조정 */
}


.comment-bottom {
    font-size:9pt;
    color : rgb(97,97,97);
    padding: 8px 0 8px 0;
}

.comment-bottom > a {
    color : rgb(97,97,97);
    text-decoration: none;
    margin : 0 6px 0 0;
}

.comment-area {
    padding : 10px 0 0 56px; /* 수정: 댓글 영역의 padding 및 위치 조정 */
}
.commenter {
    font-size:12pt;
    font-weight:bold;
}

.commenter-writebox {
    padding : 15px 20px 20px 20px;
}

.comment-img {
    font-size:36px;
    position: absolute;
}

.comment-item {
    position: relative;
    margin-bottom: 20px; /* 추가: 댓글 항목 간의 간격 조정 */
    list-style-type: none; /* 추가: 댓글 li 점 제거 */
}

.up_date {
    margin : 0 8px 0 0;
}

#comment-writebox {
    background-color: white;
    border : 1px solid #e5e5e5;
    border-radius: 5px;
}

#comment-writebox-bottom {
    padding : 3px 10px 10px 10px;
    min-height : 35px;
}


#btn-write-comment, #btn-write-reply { 
    color : #009f47;
    background-color: #e0f8eb;
}

#btn-cancel-reply { 
    background-color: #eff0f2;
    margin-right : 10px;
}

#btn-write-modify { 
    color : #009f47;
    background-color: #e0f8eb;
}

#btn-cancel-modify { 
    margin-right : 10px;
}

#reply-writebox {
    display : none;
    background-color: white;
    border : 1px solid #e5e5e5;
    border-radius: 5px;
    margin : 10px;
}

#reply-writebox-bottom {
    padding : 3px 10px 10px 10px;
    min-height : 35px;
}

#modify-writebox {
    background-color: white;
    border : 1px solid #e5e5e5;
    border-radius: 5px;
    margin : 10px;
}

#modify-writebox-bottom {
    padding : 3px 10px 10px 10px;
    min-height : 35px;
}

/* The Modal (background) */
.modal {
    display: none; /* Hidden by default */
    position: fixed; /* Stay in place */
    z-index: 1; /* Sit on top */
    padding-top: 100px; /* Location of the box */
    left: 0;
    top: 0;
    width: 100%; /* Full width */
    height: 100%; /* Full height */
    overflow: auto; /* Enable scroll if needed */
    background-color: rgb(0,0,0); /* Fallback color */
    background-color: rgba(0,0,0,0.4); /* Black w/ opacity */
}

/* Modal Content */
.modal-content {
    background-color: #fefefe;
    margin: auto;
    padding: 20px;
    border: 1px solid #888;
    width: 50%;
}

/* The Close Button */
.close {
    color: #aaaaaa;
    float: right;
    font-size: 28px;
    font-weight: bold;
}

.close:hover,
.close:focus {
    color: #000;
    text-decoration: none;
    cursor: pointer;
}



.paging {
    color: black;
    width: 100%;
    text-align: center;
}

.page {
    color: black;
    text-decoration: none;
    padding: 6px;
    margin-right: 10px;
}

.paging-active {
    background-color: rgb(216, 216, 216);
    border-radius: 5px;
    color: rgb(24, 24, 24);
}

.paging-container {
    width:100%;
    height: 70px;
    margin-top: 50px;
    margin : auto;
}

</style>
</head>
<body>
	<div id="menu">
		<ul>
			<li id="logo"><a href="<c:url value='/'/>">fastcampus</a></li>
			<li><a href="<c:url value='/'/>">Home</a></li>
			<li><a href="<c:url value='/board/list'/>">Board</a></li>
			<li><a href="<c:url value='${loginOutLink}'/>">${loginOut}</a></li>
			<li><a href="<c:url value='/register/add'/>">Sign in</a></li>
			<li><a href=""><i class="fa fa-search"></i></a></li>
		</ul>
	</div>
	<script>
  let msg = "${msg}";
  if(msg=="WRT_ERR") alert("게시물 등록에 실패하였습니다. 다시 시도해 주세요.");
  if(msg=="MOD_ERR") alert("게시물 수정에 실패하였습니다. 다시 시도해 주세요.");
</script>
	<div class="container">
		<h2 class="writing-header">게시판 ${mode=="new" ? "글쓰기" : "읽기"}</h2>
		<form id="form" class="frm" action="" method="post">
			<input type="hidden" name="bno" value="${boardDto.bno}"> 
			<input
				name="title" type="text" value="${boardDto.title}"
				placeholder="  제목을 입력해 주세요."
				${mode=="new" ? "" : "readonly='readonly'"}><br>
			<textarea name="content" rows="20" placeholder=" 내용을 입력해 주세요."
				${mode=="new" ? "" : "readonly='readonly'"}>${boardDto.content}</textarea>
			<br>

			<c:if test="${mode eq 'new'}">
				<button type="button" id="writeBtn" class="btn btn-write">
					<i class="fa fa-pencil"></i> 등록
				</button>
			</c:if>
			<c:if test="${mode ne 'new'}">
				<button type="button" id="writeNewBtn" class="btn btn-write">
					<i class="fa fa-pencil"></i> 글쓰기
				</button>
			</c:if>
			<c:if test="${boardDto.writer eq loginId}">
				<button type="button" id="modifyBtn" class="btn btn-modify">
					<i class="fa fa-edit"></i> 수정
				</button>
				<button type="button" id="removeBtn" class="btn btn-remove">
					<i class="fa fa-trash"></i> 삭제
				</button>
			</c:if>
			<button type="button" id="listBtn" class="btn btn-list">
				<i class="fa fa-bars"></i> 목록
			</button>
		</form>
	</div>
	
	<!--댓글 및 대댓글 구현 코드 -->
	<br>
	    <div id="commentList" ${mode=="new" ? "style='display:none'" : ""}>
	    <!-- 댓글 헤더 제목 -->
    	<h3 class="writing-header">댓글</h3><br>
        
       <!-- 댓글 등록 란  -->
        <div id="comment-writebox">
            <div class="commenter commenter-writebox">${id}</div>
            <div class="comment-writebox-content">
                <textarea name="comment" id="" cols="30" rows="3" placeholder="댓글을 남겨보세요"></textarea>
            </div>
            <div id="comment-writebox-bottom">
                <div class="register-box">
                    <a href="#" class="btn" id="btn-write-comment">등록</a>
                </div>
            </div>
        
    <br><p></p>
     	<div id="comment-list">
    </div>
    <br><p></p>
    
    <!-- 대댓글 등록 란  -->
    <div id="reply-writebox">
        <div class="commenter commenter-writebox">${id}</div>
        <div class="reply-writebox-content">
            <textarea name="replyComment" id="" cols="30" rows="3" placeholder="댓글을 남겨보세요"></textarea>
        </div>
        <div id="reply-writebox-bottom">
            <div class="register-box">
                <a href="#" class="btn" id="btn-write-reply">등록</a>
                <a href="#" class="btn" id="btn-cancel-reply">취소</a> 
            </div>
        </div>
    </div>
    </div>
    </div>
    
    <div id="modalWin" class="modal">
        <!-- Modal content -->
        <div class="modal-content">
            <span class="close">&times;</span>
            <p>
            <h2> | 댓글 수정</h2>
            	<div id="modify-writebox">
                	<div class="commenter commenter-writebox"></div>
                	<div class="modify-writebox-content">
                    <textarea name="modal-comment" id="" cols="30" rows="5" placeholder="댓글을 남겨보세요"></textarea>
                </div>
                <div id="modify-writebox-bottom">
                    <div class="register-box">
                        <a href="#" class="btn" id="btn-write-modify">등록</a>
                    </div>
                </div>
            	</div>
            </p>
        </div>
    </div>
    
	<script>
    // 서버에서 전달받은 bno 값을 JavaScript 변수에 할당
    let bno = "${bnoValue}";

    // 이제 bno 변수를 사용하여 댓글 기능 등을 구현할 수 있음
    // console.log("댓글을 작성할 게시물 번호: " + bno);

    
	//코드 해석 document -> html 문서, ready -> 문서가 준비되면 함수를 실행하겠다.
	//function은 main()과 같다. 브라우저가 html 문서를 쫙 읽고 DOM을 다 구성하고나면 스크립트 코드가 실행된다.
	$(document).ready(function(){ 
	    let formCheck = function() {
	      let form = document.getElementById("form");
	      if(form.title.value=="") {
	        alert("제목을 입력해 주세요.");
	        form.title.focus();
	        return false;
	      }
	
	      if(form.content.value=="") {
	        alert("내용을 입력해 주세요.");
	        form.content.focus();
	        return false;
	      }
	      return true;
	    }

	    $("#writeNewBtn").on("click", function(){
	      location.href="<c:url value='/board/write'/>";
	    });
	
	    $("#writeBtn").on("click", function(){
	      let form = $("#form");
	      form.attr("action", "<c:url value='/board/write'/>");
	      form.attr("method", "post");
	
	      if(formCheck())
	        form.submit();
	    });
	
	    $("#modifyBtn").on("click", function(){
	      let form = $("#form");
	      let isReadonly = $("input[name=title]").attr('readonly');
	
	      // 1. 읽기 상태이면, 수정 상태로 변경
	      if(isReadonly=='readonly') {
	        $(".writing-header").html("게시판 수정");
	        $("input[name=title]").attr('readonly', false);
	        $("textarea").attr('readonly', false);
	        $("#modifyBtn").html("<i class='fa fa-pencil'></i> 등록");
	        return;
	      }
	
	      // 2. 수정 상태이면, 수정된 내용을 서버로 전송
	      form.attr("action", "<c:url value='/board/modify${searchCondition.queryString}'/>");
	      form.attr("method", "post");
	      if(formCheck())
	        form.submit();
	    });

	    $("#removeBtn").on("click", function(){
	      if(!confirm("정말로 삭제하시겠습니까?")) return;
	
	      let form = $("#form");
	      form.attr("action", "<c:url value='/board/remove${searchCondition.queryString}'/>");
	      form.attr("method", "post");
	      form.submit();
	    });


		// 실행코드 위치
		$('#listBtn').on("click", function(){
			//location의 의미는 브라우저 창에 url 입력하는 부분을 의미한다.
			//***** url 입력 시 맨 앞에 '/'를 생략하면 절대 경로로 인식한다.(중요)
			location.href = "<c:url value='/board/list?page=${page}&pageSize=${pageSize}'/>";
		})
		
		
		/* =================댓글&대댓글 시작================= */
		

		/* 해당하는 게시물의 댓글목록 불러오는 showList 함수 */
		let showList = function(bno) {

		    $.ajax({
				type : 'GET', // 요청 메서드
				url : '/ch4/comments?bno=' + bno, // 요청 URI
				success : function(result) {
		            if (result) {
		                // 서버 응답이 있는 경우에만 실행
						$("#comment-list").html(toHtml(result)); // 서버로부터 응답이 도착하면 호출될 함수
						return;
		            } else {
		    		    // 비동기 처리로 인하여 댓글이 없으면 무한정 대기 아래의 태그들이 랜더링되지 않는 에러로 인해서 유효성 검사 필수!!!
		            	return;
		            }
				},
				// 에러가 발생했을 때, 호출될 함수
				error : function() {
					alert("error")
				} 
			}); 
		    // $.ajax()
			
			//ajax는 비동기 처리이기 때문에 서버에서 데이터를 받아온 다음 바로 출력해야한다. 그래서 페이지가 로드된 후에 showList 함수를 호출할 수 있도록 내부에서 함수 호출해줘야 한다.
			//showList(bno);
		}
		showList(bno);
		
		

		//대댓글 작성란 나타나는 로직
		$("#comment-list").on("click", ".btn-write", function(e) {
			e.preventDefault();
            let target = e.target;
            let cno = target.getAttribute("data-cno")
            let bno = target.getAttribute("data-bno")
         	//답글의 부모 즉, 어느 댓글인지 확인
            let pcno = target.getAttribute("data-pcno")

            let repForm = $("#reply-writebox");
            repForm.appendTo($("li[data-cno="+cno+"]"));
            repForm.css("display", "block");
            repForm.attr("data-pcno", pcno);
            repForm.attr("data-bno",  bno);
    		
		});
		
		
		//대댓글 등록 로직
		$("#reply-writebox-bottom").on("click", "#btn-write-reply", function(e) {
			e.preventDefault();		
            let target = $(this).closest("li"); // 클릭한 버튼의 가장 가까운 li 엘리먼트를 찾음
            console.log(target);
            let bno = target.attr("data-bno");
         	//답글의 부모 즉, 어느 댓글인지 확인
            let pcno = target.attr("data-cno");
            let comment = $("textarea[name=replyComment]").val();

			if (comment.trim() == '') {
				alert("댓글을 입력해주세요.");
				$("textarea[name=replyComment]").focus()
				return;

			}

			$.ajax({
				type : 'POST', // 요청 메서드
				url : '/ch4/comments?bno=' + bno, // 요청 URI /ch4/comments?bno=1085  POST
				headers : {
					"content-type" : "application/json"
				}, // 요청 헤더
				data : JSON.stringify({
					//자기 부모 댓글에 대한 정보가 들어가야하므로 pcno
					pcno : pcno,
					bno : bno,
					comment : comment
				}), // 서버로 전송받을 데이터 타입. stringify()로 직렬화 필요.
				success : function(result) {
					alert(result);
					showList(bno);
				},
				error : function() {
					alert("error")
				} // 에러가 발생했을 때, 호출될 함수
			}); // $.ajax()

			//대댓글 창이 사라지도록 styel none으로 설정
			$("#reply-writebox").css("display", "none");
			//대댓글 창 비우기
			$("textarea[name=replyComment]").val('');
			//다시 원래 위치(body의 아래)로 돌려놓기
			$("#reply-writebox").appendTo("body");
		});
		
		//대댓글 취소 버튼
		$("#reply-writebox-bottom").on("click", "#btn-cancel-reply", function(e) {
			e.preventDefault();
	        $("#reply-writebox").css("display", "none");
		});

		//댓글 등록 로직
		$("#btn-write-comment").click(function(e) {
			e.preventDefault();
			
			let comment = $("textarea[name=comment]").val();

			if (comment.trim() == '') {
				alert("댓글을 입력해주세요.");
				$("textarea[name=comment]").focus()
				return;
			}

			$.ajax({
				type : 'POST', // 요청 메서드
				url : '/ch4/comments?bno=' + bno, // 요청 URI /ch4/comments?bno=1085  POST
				headers : {
					"content-type" : "application/json"
				}, // 요청 헤더
				data : JSON.stringify({
					bno : bno,
					comment : comment
				}), // 서버로 전송받을 데이터 타입. stringify()로 직렬화 필요.
				success : function(result) {
					alert(result);
					showList(bno);
				},
				error : function() {
					alert("error")
				} // 에러가 발생했을 때, 호출될 함수
			}); // $.ajax()
			$("textarea[name=comment]").val('');

		});



		// 요청이 오기 전에 실행이 되기 때문에 버튼이 안먹힌다. 그래서 고정된 요소에 걸어줘야 한다 .
		// 그래서 commentList에 이벤트를 걸어준다.
		// @@@ 이 방법이 동적으로 생성되는 요소에 이벤트를 걸어주는 것이다.
		//  $(".delBtn").click(function(){
		// 댓글 삭제 기능 구현
		$("#comment-list").on("click", ".btn-delete", function(e) {
			e.preventDefault();			
	      if(!confirm("정말로 삭제하시겠습니까?")) {e.preventDefault(); return;}
	      
            let target = e.target;
            let cno = target.getAttribute("data-cno");
            let bno = target.getAttribute("data-bno");

			$.ajax({
				type : 'DELETE', // 요청 메서드
				url : '/ch4/comments/' + cno + '?bno=' + bno, // 요청 URI
				success : function(result) {
					alert(result)
					showList(bno);
				},
				error : function() {
					alert("error")
				} // 에러가 발생했을 때, 호출될 함수
			}); // $.ajax()           
		});
		
		//댓글 수정
	     $("#comment-list").on("click", ".btn-modify", function(e) {
            let target = e.target;
            let cno = target.getAttribute("data-cno");
            let bno = target.getAttribute("data-bno");
            let pcno = target.getAttribute("data-pcno");
            let li = $("li[data-cno="+cno+"]");
            let commenter = $(".commenter", li).first().text();
            let comment = $(".comment-content", li).first().text();

            $("#modalWin .commenter").text(commenter);
            $("#modalWin textarea").text(comment);
            $("#btn-write-modify").attr("data-cno", cno);
            $("#btn-write-modify").attr("data-pcno", pcno);
            $("#btn-write-modify").attr("data-bno", bno);

            // 팝업창을 열고 내용을 보여준다.
            $("#modalWin").css("display","block");
        });
		
		//모달창 닫기 버튼 구현
         $(".close").click(function(){
        	 $("#modalWin").css("display", "none");
         });

         $("#btn-write-modify").click(function(){
             // 1. 변경된 내용을 서버로 전송
        	let cno = $(this).attr("data-cno");
			let comment = $("textarea[name=modal-comment]").val();

 			if (comment.trim() == '') {
				alert("댓글을 입력해주세요.");
				$("textarea[name=modal-comment]").focus()
				return;
			}

			$.ajax({
				type : 'PATCH', // 요청 메서드
				url : '/ch4/comments/' + cno, // 요청 URI /ch4/comments/26  PATCH
				headers : {
					"content-type" : "application/json"
				}, // 요청 헤더
				data : JSON.stringify({
					cno : cno,
					comment : comment
				}), // 서버로 전송받을 데이터 타입. stringify()로 직렬화 필요.
				success : function(result) {
					alert(result);
					showList(bno);
				},
				error : function() {
					alert("error")
				} // 에러가 발생했을 때, 호출될 함수
			}); // $.ajax()
             
             // 2. 모달 창을 닫는다. 
 			$("#modalWin").css("display", "none");
         });
		 
		
		// 댓글 작성 날짜 작성 로직 addZero는 시간을 표시할 때 한자리 수의 경우 앞에 0을 붙혀준다. 
		 let addZero = function(value=1){
       	return value > 9 ? value : "0"+value;
	    }
	
	    let dateToString = function(ms=0) {
	        let date = new Date(ms);
	
	        let yyyy = date.getFullYear();
	        let mm = addZero(date.getMonth() + 1);
	        let dd = addZero(date.getDate());
	
	        let HH = addZero(date.getHours());
	        let MM = addZero(date.getMinutes());
	        let ss = addZero(date.getSeconds());          
	
	        return yyyy+"."+mm+"."+dd+ " " + HH + ":" + MM + ":" + ss;            
	    }
	    

		//댓글 및 대댓글 UI에 출력하는 로직
		let toHtml = function(comments) {

			
			let tmp = '<ul id="commentList-ul">'

			comments.forEach(function(comment) {
				console.log("comments = " + comment.cno);
				console.log("comments = " + comment.pcno);
				
			if (comment.cno == comment.pcno){	
			tmp += '<li class="comment-item" data-cno=' + comment.cno
       		tmp += ' data-pcno=' + comment.pcno
       		tmp += ' data-bno=' + comment.bno + '>'
       		tmp += ' <span class="comment-img"><i class="fa fa-user-circle" aria-hidden="true"></i></span>'
       		tmp += ' <div class="comment-area"><div class="commenter">'+comment.commenter+'</div>'
       		tmp += ' <div class="comment-content">'+comment.comment+'</div>'
			tmp += ' <div class="comment-bottom">'
			tmp += ' <div class="comment-bottom"> <span class="up_date">'+comment.up_date+'</span>'
			tmp += ' <a href="#" class="btn-write" data-cno="'+comment.cno+'" data-bno="'+comment.bno+'" data-pcno="">답글쓰기</a>'
			tmp += ' <a href="#" class="btn-modify" data-cno="'+comment.cno+'" data-bno="'+comment.bno+'" data-pcno="">수정</a>'
			tmp += ' <a href="#" class="btn-delete" data-cno="'+comment.cno+'" data-bno="'+comment.bno+'" data-pcno="">삭제</a></div>'
			tmp += ' </div>'

			tmp += ' </li>'
			} else if(comment.cno != comment.pcno){
				tmp += '<span class="commenter">&nbsp;&nbsp;&nbsp;&nbsp ㄴ ' + comment.commenter +'님의 답글: </span><br>'
				tmp += '<span class="comment">&nbsp;&nbsp;&nbsp;&nbsp&nbsp;&nbsp;&nbsp;&nbsp ' + comment.comment + '</span><br>'
				
			}

			})

			return tmp + '</ul>';

		}
		})
		
</script>
</body>
</html>