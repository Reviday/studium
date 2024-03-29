<%@page import="com.studium.member.model.vo.MyPurchase"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@ page import="java.util.*,com.studium.pstudy.model.vo.Pstudy,com.studium.mypage.model.vo.MyDibs,com.studium.story.model.vo.Story" %>
 <%
 	Pstudy p=(Pstudy)request.getAttribute("pstudy");
     MyDibs md=(MyDibs)request.getAttribute("md"); 
     int totaldata =(Integer)request.getAttribute("totaldata");
     List<Story> slist=(List)request.getAttribute("slist");
    List<MyPurchase> mlist=(List)request.getAttribute("mlist");
 %>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
</head>
<body>
<!DOCTYPE html>
<html lang="ko">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>스터디소개페이지</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/reset-css@4.0.1/reset.min.css">
    <link rel="stylesheet" href="<%=request.getContextPath() %>/css/studyIntro.css">
    <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Open+Sans:300,400,700,800">
    <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Do+Hyeon&display=swap">
    <script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
   
    <style type="text/css">
   
.header-background-cover {
         height: 95px;
         background-color: rgba(0,0,0,0.8);
      }
   


</style>
    
    
 
    
</head>

<body>
	  <%@ include file="../../views/common/header.jsp" %> 
    <div class="header-background" style="background-image: url('<%=request.getContextPath()%>/img/1.jpg');">
		<div class="header-background-cover">
      </div>
    </div>
    <section class="studyIntro">
        <!--스터디소개페이지-섹션 -->
       
        <article>
            <!-- 가운데 위치배치를 위한 article -->
            <div class="intro">
                <!-- 왼쪽에 위치한 메인 소개 div -->
                <div id="toast" >
                <span class="icon"></span>
                <span id="message" class="message"></span>
                </div>
                <div class="intro-img">
                    <!-- 이미지슬라이드 div -->
                    <img src="<%=request.getContextPath()%>/upload/pstudy/<%=p.getpImg1()%>" alt="">
                </div>

                <div class="intro-img">
                    <!-- 이미지슬라이드 div -->
                    <img src="<%=request.getContextPath()%>/upload/pstudy/<%=p.getpImg2()%>"
                        alt="">
                </div>

                <div class="intro-img">
                    <!-- 이미지슬라이드 div -->
                    <img src="<%=request.getContextPath()%>/upload/pstudy/<%=p.getpImg3()%>" alt="">
                </div>

                <div style="text-align:center">
                    <span class="dot" onclick="currentSlide(1)"></span>
                    <span class="dot" onclick="currentSlide(2)"></span>
                    <span class="dot" onclick="currentSlide(3)"></span>
                </div>

						
						<br><br><br>

                <div class="intro-title">
                 
                    <div>
                        <!-- 스터디지역 -->
                       	<%=p.getpArea() %>
                    </div>
                    <div>
                        <!-- 스터디 타이틀 -->
                       <%=p.getpTitle().replace("\r\n","<br>") %>
                    </div>
                </div>
                <div class="intro-category">
                    <!-- 카테고리 div (fix) -->
                   	<%=p.getpCategory() %>
                </div>
                <div class="line-title-bottom"></div> <!-- 파트를 구분하는 선 div -->
                <div class="intro-content">
                    <!-- 소개 content -->
                    <div class="intro-content-study">
                    	    스터디소개
                    </div> <!-- 스터디 소개 텍스트 -->
                    <div>
                     <br><br><br>
                     <textarea cols="60" rows="15" id="textarea1" readonly>
                       <%=p.getpIntro1().replace("\r\n","<br>") %>
					</textarea>
					<textarea cols="60" rows="15" id="textarea2" readonly>
					 <%=p.getpIntro2().replace("\r\n","<br>") %>
					 </textarea>
                    </div> <!-- 스터디 소개 content -->
                </div>
                <div class="line-content-bottom"></div><!-- 파트를 구분하는 선 div -->
                <div class="study-information">
                    <!-- 스터디 상세정보 -->
                    <div>
                       		 상세 정보
                    </div>
                    <div>
                        <span class="info-left"><span style="color:#a0a0a0">지역:</span>
                            &nbsp;&nbsp;<span><%=p.getpArea() %></span></span>
                        <span class="info-right"><span style="color:#a0a0a0">인원:</span>
                            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span><%=p.getpStudypserson() %></span></span> <br>
                        <span class="info-right"><span style="color:#a0a0a0">장소비:</span>
                            &nbsp;&nbsp;<span>포함</span></span> <br>
                        <span class="info-left"><span style="color:#a0a0a0">시간:</span>
                            &nbsp;&nbsp;<span>A그룹(화)</span></span> <span class="info-time"><%=p.getpDay() %></span> <br>
                        <span class="info">지금 신청하면&nbsp; <p><%=p.getpDatestart() %></p>&nbsp; 첫 스터디 시작!</span>
                    </div>
                </div>
                <div>
                 <% if(loginMember!=null&&loginMember.getMemCode()=='M'){ %>
                 	<input type="image" src="<%=request.getContextPath()%>/img/delete.png" onclick="fn_delete();"/>
                 	<input type="image" src="<%=request.getContextPath()%>/img/update.png" onclick="fn_update();"/>
                 	<%}else{ %>
                 	<%} %>
                </div>
                <div class="line-information-bottom"></div> <!-- 파트를 구분하는 선 div -->
                <div class="review">
                    <!-- 스터디 후기 -->
                    <div class="review-1">
                        <h2>리더에 대한 후기</h2>
                        
                    </div>
                    
           
		<div>
		<div class="star1">
		         <%if(p.getpLike()==1){ %>
				<img src="<%=request.getContextPath()%>/img/star1.png" width=100px; class="star1">
			<%}else if(p.getpLike()==2) {%>
			<img src="<%=request.getContextPath()%>/img/star2.png" width=100px; class="star1">
			<%}else if(p.getpLike()==3){ %>
			<img src="<%=request.getContextPath()%>/img/star3.png" width=100px; class="star1">
			<%}else if(p.getpLike()==4){ %>
			<img src="<%=request.getContextPath()%>/img/star4.png" width=100px; class="star1">
			<%}else if(p.getpLike()==5){ %>
			<img src="<%=request.getContextPath()%>/img/star5.png" width=100px; class="star1">
			<%} else{%>
			<p>아직 별점이 작성되지 않았습니다</p>
			<%} %>
                   
		<b><%=p.getpLike() %></b>점
		</div>
			
		
		
		</div>
	
                    <div>
                        <div class="review">
                <div class="review-title">
                    <!-- 후기 -->

                </div>
                <div class="rine"></div> <!-- 구분선 -->
                <div class="reviewContainer">
                <%
               	if(slist.size()!=0){
                for(Story s : slist) { 
                %>
                    <!-- 후기 들어가는 div -->
                      
                   
		
                    <div class="reviewAll">
                        <!-- 개인후기 div -->
                         <img src="<%=request.getContextPath()%>/upload/myPage/<%=s.getStoryStudentpicture()%>"/>
                        
                        <!-- 후기올린 사람 사진 -->
                      
                        <div class="reviewName">
                            <!-- 이름 -->
                            
                          <%=s.getStoryWrite()%>
                          <span class="subjectName">
                        		 <%=s.getStorySubject()%>
                          </span>

                 
                        </div>
                    
                       
		<div class="star">
		
		         <%if(s.getStoryStar()==1){ %>
				<img src="<%=request.getContextPath()%>/img/star1.png" width=100px; class="star">
			<%}else if(s.getStoryStar()==2) {%>
			<img src="<%=request.getContextPath()%>/img/star2.png" width=100px; class="star">
			<%}else if(s.getStoryStar()==3){ %>
			<img src="<%=request.getContextPath()%>/img/star3.png" width=100px; class="star">
			<%}else if(s.getStoryStar()==4){ %>
			<img src="<%=request.getContextPath()%>/img/star4.png" width=100px; class="star">
			<%}else if(s.getStoryStar()==5){ %>
			<img src="<%=request.getContextPath()%>/img/star5.png" width=100px; class="star">
			
			<%} else{%>
			
			<%} %>

		
		
		<div class="score">
		<b><%=s.getStoryStar() %></b>점
		</div>
		</div>
                        <div class="reviewContent">
                            
                            <div class="reviewText">
                                <!-- 내용 -->
                               <%=s.getStoryContent()%>
                                 &nbsp; <span></span>
                            </div>
                            <div class="reviewTeacherTime">
                                <div class="reviewTime">
                                    <!-- 후기올린 시간 -->
                                    <%=s.getStoryTime()%>
                                </div>
                                <div class="reviewTeacher">
                                    <!-- 강사 이름, 사진 -->
                                    <div>
                                        <!-- 강사 이름 -->
                                        <%=s.getStoryTeachername()%>
                                    </div>
                                    <img src="<%=request.getContextPath()%>/upload/myPage/<%=s.getStoryTeacherpicture()%>"/>
                   
                                    <!-- 강사 사진 -->
                                    
                          </div>
                                
                            </div>
                              
                            <div class="reviewrine"></div> <!-- 후기 구분선 -->
                        
                        </div>
                      <%
                } }else{
                	%>
                	<div class="review-title">
                    <!-- 후기 -->
				등록된 후기가 존재하지 않습니다
                </div>
                <%
                         }
                
                        %>
                    </div>
                         
                </div>
            </div>
                </div>
            </div>
            <div class="pay">
                <!-- 오른쪽에 위치한 신청 고정 div -->
                <div>
                    <!-- 신청 타이틀 -->
                   <%=p.getpTitle() %>
                </div>
                <div class="pay-line"></div> <!-- 구분 선 -->
                <div class="pay-date">
                    <!-- 스터디 기간 -->
                    <img src="https://cdn.studysearch.co.kr/static/images/purchase/item_radio_checked.1f99efef95e3.png"
                        alt="">
                        
                    <span>~<%=p.getpDateend() %></span>
                </div>
                <div class="pay-line1"></div> <!-- 구분 선 -->
                <div class="pay-pay">
                    <!-- 참가비용 -->
                    <span>참가비</span>
                    <span><%=p.getpPrice() %></span>
                </div>
                <div class="sinchung">
                    <!-- 신청 버튼 -->
                  
                    <input type="button" value="참여 신청하기"
						<%if(mlist.size()!=0){ 
						for(MyPurchase m : mlist){  %>
						<%if(loginMember!=null&&m.getMemNo()==loginMember.getMemNo()) {%>
							onclick="fn_ifAlert();"
                    <%} 
						
						else{ %>
                    
                    <% 
                    	if(loginMember!=null&&loginMember.getMemCode()!='A') {
                    %>
                    	onclick="location.href='<%=request.getContextPath()%>/pstudy/pstudyPay?pNo=<%=p.getpNo()%>&mPoint=<%=loginMember.getMemPoint()%>';"
                    <% 		
                    	} else if(loginMember!=null&&loginMember.getMemCode()=='A'){
                    %>		
                    
                    	onclick="fn_addAlert();"
                    <% 
                    	}else {
                    	
                    %>		
                 		onclick="fn_loginAlert();"
                 	<%
                    	} } } }
                    %>
                    		
                   
                   
                    />
                    
                </div>
                <div class="zzim">
                    <!-- 찜하기 버튼 -->
                    <span class="icon"></span>
                   <form id="dibs_form">
                	<%if(loginMember!=null) {%>
                   <input type="hidden" name="mNo" id="mNo" value="<%=loginMember.getMemNo()%>"/>
                 	<%}else{ } %>
                   <input type="hidden" name="pNo" id="pNo" value="<%=p.getpNo()%>"/>
                	<div id="dibsimg">
                	 <%if(md==null){ %>
                	<input type="hidden" id="A" value="1" name="A"/>
                	   <% }else if(loginMember.getMemNo()==md.getMemberNo()&&p.getpNo()==md.getpNo()){ %>
                	    <input type="hidden" id="A" value="0" name="A"/>
                	   <%}else {%>
                	   <input type="hidden" id="A" value="1" name="A"/>
                	   <%} %>
                	 </div>

                </form>
                	
                	<button onclick="fn_dibs2();" id="dibscon"  >
                	
                	  <%if(md==null){ %>
                  
                      <img alt="" src="<%=request.getContextPath()%>/img/dibsoff.png"  style="width:150px" >
                     		
                   <% }else if(loginMember.getMemNo()==md.getMemberNo()&&p.getpNo()==md.getpNo()){ %>
                  
                   <img alt=""  src="<%=request.getContextPath()%>/img/dibson.png" style="width:150px">
                   	 	
                    <%}else {%>
                
                     <img alt="" src="<%=request.getContextPath()%>/img/dibsoff.png" style="width:150px">
                   			 
                    <%} %>
                	
                	 </button>
             
                
                     
                </div>
                <div class="pay-line"></div> <!-- 구분 선 -->
                <div class="hugi">
                    <!-- 후기 버튼 -->
                    <a href="<%=request.getContextPath()%>//story">
                        <stong>100% 리얼 후기</stong> (<%=totaldata %>)
                    </a>
                </div>
                <div class="pay-line"></div> <!-- 구분 선 -->
            </div>
        </article>
    </section>
    
    
    <style>

    	
			.star1{
			padding-left : 20px;
			}

    #toast {
    display: none;
    position: fixed;
    top: 8pc;
    left: 50%;
    margin-left: -5in;
    width: 60pc;
    height: 50px;
    line-height: 50px;
    background: #ef6c00;
    text-align: center;
    color: #fff;
    z-index: 9999;
    border-radius: 2px;
}
#toast .icon {
    text-indent: -9999em;
    margin-right: 24px;
    display: inline-block;
    width: 24px;
    height: 100%;
    background: transparent url(https://cdn.studysearch.co.kr/static/images/base/icon_toast_confirmed.6f9750454287.png)0 11px no-repeat;
}
#toast .message {
    display: inline-block;
    vertical-align: top;
}
    
    
    
    </style>
    <script type="text/javascript" >
        $(function () {
            $(window).scroll(function () { 
                var num = $(this).scrollTop();
                if (num > 40) { 
                    $(".pay").css("position", "fixed");
                    $(".pay").css("top", "94px");
                    
                } else {
                    $(".pay").css("position", "absolute");
                    $(".pay").css("top", "95px");
                  
                }
            });
        });
        var slideIndex = 1;
        showSlides(slideIndex);

        function plusSlides(n) {
            showSlides(slideIndex += n);
        }

        function currentSlide(n) {
            showSlides(slideIndex = n);
        }

        function showSlides(n) {
            var i;
            var slides = document.getElementsByClassName("intro-img");
            var dots = document.getElementsByClassName("dot");
            if (n > slides.length) {
                slideIndex = 1
            }
            if (n < 1) {
                slideIndex = slides.length
            }
            for (i = 0; i < slides.length; i++) {
                slides[i].style.display = "none";
            }
            for (i = 0; i < dots.length; i++) {
                dots[i].className = dots[i].className.replace(" active", "");
            }
            slides[slideIndex - 1].style.display = "block";
            dots[slideIndex - 1].className += " active";
        }
	 
        function fn_delete(){
        	var msg = "삭제하시겠습니까";
    		var flag = confirm(msg);
    		if(flag==true) {
    		location.href="<%=request.getContextPath()%>/pstudy/pstudyDelete?pNo=<%=p.getpNo()%>";
    		}
    		else alert("취소하였습니다.");
        }
        function fn_update(){
        	
        	location.href="<%=request.getContextPath()%>/pstudy/pstudyUpdate?pNo=<%=p.getpNo()%>";
        	
        }
        function fn_loginAlert(){
        	return alert("로그인후 이용하세요 ");
        }
        
      	function fn_addAlert(){
      		   alert("추가 정보를 입력하세요");
      			location.href="<%=request.getContextPath()%>/myPage/addMyInfo";
        }    
      	function fn_ifAlert(){
      		return alert("이미 구매하신 스터디입니다");
      	}
		//1. 추가한 input a값 기준으로 파라미터로 보내
		//2. 컨트롤러 에서 a 값에 따라 찜하기, 찜하기 풀기(?) 상태 변경
		//3. 각각 경우에 따라 return값 다르게
		//4. ajax success에 data 값에따라 alert 처리 다르게 변경		
		 function fn_dibs2(){
        	/* var mno = $("#mNo").val();
			var pno = $("#pNo").val();*/
			var A = $("#A").val();	 //a값을 받아서 a에 넣기		
			var params = jQuery("#dibs_form").serialize();
				if(<%=loginMember!=null%>){
				$.ajax({
				url: "<%=request.getContextPath()%>/pstudy/pstudyDibss",  //doGet3 만들어서 찜하기 아닌상태 컨트롤러 만들어서 사용
				type: "POST",
				cache: false,
				dataType: "json",
				// data 이렇게 했을때 파라티머 받는지 확인 
				// 보내는 방법 ex) 컨트롤러파라미터변수이름 : 보낼데이터   {mno : mno}
				//data: {"mno":mno, "pno" : pno, "A" : A }, 
				data: params , 
				//아이디가 like_form인 곳의 모든 정보를 가져와 파라미터 전송 형태(표준 쿼리형태)로 만들어줌
				success:
				function(data){ //ajax통신 성공시 넘어오는 데이터 통째 이름 =data
				console.log(data+"ajax데이터 들어오는거");
				if(data==("1")){ //넘어온 데이터 값이 1이면 찜하기 구현
					$("#A").val("0");
					$("#dibscon").html($("<input>").attr({"value":"0",
						"type":"hidden",
						"id":"A",
						"name":"A"}));
					$("#dibscon").html($("<img>").attr({"src":"<%=request.getContextPath()%>/img/dibson.png",
														"class":"dibs",
														"style":"width:150px"
															}));
					$('#toast').animate({opacity: '1'}, 100);
					$("#toast").css("display","block");
					$("#message").html(("찜하기 성공"));
					$('#toast').animate({opacity: '0'}, 1000);
				}else {//
					
					$("#A").val("1");
					$("#dibscon").html($("<input>").attr({"value":"1","type":"hidden",
						"id":"A",
						"name":"A"}));
					$("#dibscon").html($("<img>").attr({"src":"<%=request.getContextPath()%>/img/dibsoff.png",
														"class":"dibs",
														"style":"width:150px"}));
					$('#toast').animate({opacity: '1'}, 100);
					$("#toast").css("display","block");
					$("#message").html(("찜하기 취소"));
					$('#toast').animate({opacity: '0'}, 1000);
					
				}
				
				},
				error:
				function (request, status, error){
				alert("ajax실패");
				$("#A").val("0");
				$("#dibscon").html(data);
				}
				});
        	}
				else{
					fn_loginAlert();
					return false;
				}      
        }
       <%--  function fn_dibs(){
        	
        	var params = jQuery("#dibs_form").serialize();
        	if(<%=loginMember!=null%>){
        	$.ajax({
        	url: "<%=request.getContextPath()%>/pstudy/pstudyDibss",
        	type: "POST",
        	cache: false,
        	dataType: "json",
        	data:params , 
        	//아이디가 like_form인 곳의 모든 정보를 가져와 파라미터 전송 형태(표준 쿼리형태)로 만들어줌
        	success:
        	function(data){ //ajax통신 성공시 넘어오는 데이터 통째 이름 =data
        	alert("'찜하기'가 반영되었습니다!") ; // data중 put한 것의 이름 like
        
        	},
        	error:
        	function (request, status, error){
        	alert("ajax실패");
        	
        	}
        	});
        	}
        	else{
            	fn_loginAlert();
            	return false;
            }
        }    --%>

        var str = $('#textarea1').val();

        str = str.split('<br/>').join("\r\n");

        $('#textarea1').val(str);
        var str = $('#textarea2').val();

        str = str.split('<br/>').join("\r\n");

        $('#textarea2').val(str);
        

    </script>
    
 <%@ include file="../../views/common/footer.jsp" %> 
</body>

</html>



</body>
</html>