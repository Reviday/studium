<%@page import="com.studium.category.model.vo.Category"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
 <%
 	String locate=(String)request.getAttribute("locate");
 	List<Category> mCategoryList=(List)request.getAttribute("mCategoryList");
 	List<Category> categoryList=(List)request.getAttribute("categoryList");
 
 	//게시판 마다 띄워줄 제목과 문구 처리.
 	//추후, DB에 넣어서 가져오는 방법으로 처리할 예정.
 	String mTit="",mSub="";
 	switch(locate) {
 	case"intro" :  break;
 	case"study" : mTit="공부마당"; mSub="서로가 문제를 출제하고 문제를 풀어보는 공간입니다."; break;
 	case"free" : mTit="자유마당"; mSub="자유롭게 글을 올리는 공간입니다."; break;
 	case"share" : mTit="공유마당"; mSub="자유롭게 정보와 자료를 공유하는 공간입니다.<br>(저작권엔 유의하여 주시기 바랍니다 ^ - ^)";break;
 	case"boast" : mTit="자랑마당"; mSub="자랑하고 싶은 부분을 마음껏 자랑하는 공간입니다!";break;
 	case"question" : mTit="자랑마당"; mSub="자랑하고 싶은 부분을 마음껏 자랑하는 공간입니다!"; break;
 	}
 %>
<%@ include file="/views/common/header.jsp"%>
<!-- 마당에 적용할  css -->
<link href="<%=request.getContextPath()%>/css/madang.css"
	rel="stylesheet">
<link href="<%=request.getContextPath()%>/css/madang-writer.css"
	rel="stylesheet">
<script src="<%=request.getContextPath()%>/js/jquery-3.4.1.min.js"></script>
<!-- Smart Editor2 -->
<script type="text/javascript"
   src="<%=request.getContextPath()%>/SE2/js/HuskyEZCreator.js"
   charset="utf-8"></script>
 </style>
<div class="header-background"
	style="background-image: url('<%=request.getContextPath()%>/img/1.jpg');">
	<div class="header-background-cover"></div>
</div>
<section id="madang_writer" class="row">
	<div class="col-xs-4 col-sm-3 col-md-3 col-lg-2" style="padding-left: 0">
		<!-- 사이드 메뉴가 들어갈 곳 -->
		<%@ include file="/views/common/sideMenuBar.jsp"%>
	</div>
	<div class="col-lg-1"></div><!-- 공백용 -->
    <div class="main-area col-md-6 col-lg-6">
        <div class="madang-list mldiv">
            <div class="sub-tit row mldiv">
                <div class="title-area mldiv">
                	<%
                		if(locate.equals("free") || (choiceSub!=null&&choiceSub.equals("null"))) {
                			%>
                				<h3 class="list-title"><%=mTit%></h3>
                			<%
                		} else {
                			%>
                				<h3 class="list-title"><%=mTit%><%=choiceSub!=null?" - " +choiceSub:""%></h3>
                			<%
                		}
                	%>
                    <p class="list-sub"><%=mSub%></p>
                </div>
            </div>
        </div>
        <hr />
        <div class="write_form">
            <form action="<%=request.getContextPath()%>/madang/<%=locate%>/writeEnd" method="post" id="frm" enctype="Multipart/form-data">
                <div class="subject_cover">
                    <ul class="subject">
                        <li class="post_subject">
                            <label class="item" for="subject">제　목</label>
                            <div class="label">
                                <input type="text" name="subject" placeholder="게시글 제목을 입력하세요" id="subject"
                                    class="box_input" required>
                            </div>

                        </li>
                        <li id="file_attach_menu" class="file_attach_menu">
                            <div class="filebox">
                                
                                <label for="files" class="item">업로드<a id="fileDB" class="ico_file" href="#"></a></label>
                                
                                <input type="file" id="files" class="upload-hidden" name="file" multiple>
                                <input class="upload-name" value="no files yet" disabled="disabled">
                                <!--<button onclick="abortRead();">Cancel read</button> 지금 구현하지않음.-->
                                <div id="progress_bar">
                                    <div class="percent">0%</div>
                                </div>
                                <script>
                                    var reader;
                                    var progress = document.querySelector('.percent');

                                    function abortRead() {
                                        reader.abort();
                                    }

                                    function errorHandler(evt) {
                                        switch (evt.target.error.code) {
                                            case evt.target.error.NOT_FOUND_ERR:
                                                alert('File Not Found!');
                                                break;
                                            case evt.target.error.NOT_READABLE_ERR:
                                                alert('File is not readable');
                                                break;
                                            case evt.target.error.ABORT_ERR:
                                                break; // noop
                                            default:
                                                alert('An error occurred reading this file.');
                                        };
                                    }

                                    function updateProgress(evt) {
                                        // evt is an ProgressEvent.
                                        if (evt.lengthComputable) {
                                            var percentLoaded = Math.round((evt.loaded / evt.total) * 100);
                                            // Increase the progress bar length.
                                            if (percentLoaded < 100) {
                                                progress.style.width = percentLoaded + '%';
                                                progress.textContent = percentLoaded + '%';
                                            }
                                        }
                                    }

                                    function handleFileSelect(evt) {
                                        // Reset progress indicator on new file selection.
                                        progress.style.width = '0%';
                                        progress.textContent = '0%';

                                        reader = new FileReader();
                                        reader.onerror = errorHandler;
                                        reader.onprogress = updateProgress;
                                        reader.onabort = function (e) {
                                            alert('File read cancelled');
                                        };
                                        reader.onloadstart = function (e) {
                                            document.getElementById('progress_bar').className = 'loading';
                                        };
                                        reader.onload = function (e) {
                                            // Ensure that the progress bar displays 100% at the end.
                                            progress.style.width = '100%';
                                            progress.textContent = '100%';
                                            setTimeout("document.getElementById('progress_bar').className='';",
                                                2000);
                                        }

                                        // Read in the image file as a binary string.
                                        reader.readAsBinaryString(evt.target.files[0]);
                                    }

                                    document.getElementById('files').addEventListener('change', handleFileSelect, false);
                                </script>
                            </div>
                        </li>
                        <%
                        	if(locate.equals("free") ) {
                        %>
		                        <!-- 출력해 줄 것이 없다.. -->
		                <%
                       		} else if(choiceSub.equals("null")) {		                
		                %>        
		                        <li class="post_mCategory">
		                            <label class="item" for="mCategory">카테고리</label>
		                            <div class="inputInteresting" style="margin-left:68px;">
										<% if(!categoryList.isEmpty()&&!mCategoryList.isEmpty()){
											//m이랑 b랑 비교해서 같은 값 있으면 뿌려주고
											for(int i=0;i<mCategoryList.size();i++){
											%>
											<div><p><%=mCategoryList.get(i).getTitleB()%></p></div>
											
												<% for(int j=0;j<categoryList.size();j++){
													if(mCategoryList.get(i).getCategoryBId().equals(categoryList.get(j).getCategoryBId())){%>
														<label class="check-label">
					                                        <input type="radio" class="option-input checkbox"  name="inter" required
					                                        	id="<%=categoryList.get(j).getCategoryMId()%>" value="<%=categoryList.get(j).getTitleM() %>">
					                                        <%=categoryList.get(j).getTitleM() %>
					                                     </label>
													<%}
											}
										}
										}%>
		                             </div>
		                        </li>
		                        <li class="post_subCategory">
		                            <label class="item" for="subCategory">상세<br/>카테고리</label>
		                            <div class="inputInteresting" style="margin-left:68px; margin-top:10px;">
		                            	<input type="text" name="subCategory1" class="subCategory" id="subCategory1" placeholder="상세 카테고리를 입력해주세요.">
		                            	<input type="text" name="subCategory2" class="subCategory" id="subCategory2" placeholder="상세 카테고리를 입력해주세요.">
		                            	<input type="text" name="subCategory3" class="subCategory" id="subCategory3" placeholder="상세 카테고리를 입력해주세요.">
		                            	<div class="subscript">
		                            		<small>상세 카테고리는 최소 0개, 최대 3개까지 입력 가능하고<br/>첫 번째 카테고리의 내용이 제목에 출력됩니다.</small>
		                            	</div>
		                            </div>
		                        </li>
		                        
                        <%
								} else {
                        %>
		                       <li class="post_mCategory">
		                            <label class="item" for="mCategory">카테고리</label>
		                            <div class="inputInteresting" style="margin-left:68px;">
										<% if(!categoryList.isEmpty()&&!mCategoryList.isEmpty()){
											//m이랑 b랑 비교해서 같은 값 있으면 뿌려주고
											
											for(int i=0;i<mCategoryList.size();i++){
												
												if(mCategoryList.get(i).getTitleB().equals(choiceSub)) {
											%>
											<div><p><%=mCategoryList.get(i).getTitleB()%></p></div>
											
												<% for(int j=0;j<categoryList.size();j++){
													if(mCategoryList.get(i).getCategoryBId().equals(categoryList.get(j).getCategoryBId())){%>
														<label class="check-label">
					                                        <input type="radio" class="option-input checkbox"  name="inter" required
					                                        	id="<%=categoryList.get(j).getCategoryMId()%>" value="<%=categoryList.get(j).getTitleM() %>">
					                                        <%=categoryList.get(j).getTitleM() %>
					                                     </label>
													<%}
											}	
											}
										}
										}%>
		                             </div>
		                        </li>
		                        <li class="post_subCategory">
		                            <label class="item" for="subCategory">상세<br/>카테고리</label>
		                            <div class="inputInteresting" style="margin-left:68px; margin-top:10px;">
		                            	<input type="text" name="subCategory1" class="subCategory" id="subCategory1" placeholder="상세 카테고리를 입력해주세요.">
		                            	<input type="text" name="subCategory2" class="subCategory" id="subCategory2" placeholder="상세 카테고리를 입력해주세요.">
		                            	<input type="text" name="subCategory3" class="subCategory" id="subCategory3" placeholder="상세 카테고리를 입력해주세요.">
		                            	<div class="subscript">
		                            		<small>상세 카테고리는 최소 0개, 최대 3개까지 입력 가능하고<br/>첫 번째 카테고리의 내용이 제목에 출력됩니다.</small>
		                            	</div>
		                            </div>
		                        </li>
                        
                        <%
								}
                        %>
                    </ul>
                </div>
				<div class="smdarteditor_area">
					<div class="write_tag">
						<label>작성하기</label>
					</div>
					<div style="clear:both"></div>
	                <textarea name="smarteditor" id="smarteditor" rows="10" cols="100" > </textarea>
	
	
	                
	                <!-- 버튼 -->
					<div class="post_btns">
						<div class="fr">
							<input type="reset" class="btn_type1" value="취소" 
							onclick="location.href='<%=request.getContextPath()%>/madang/<%=locate%>MadangList?cPage=1'">
							<input type="submit" id="savebutton" class="btn_type1" value="확인">
						</div>
					</div>
                </div>
                <div style="display:none">
                	<!-- 함께 전달해야 할 데이터 -->
                	<input type="hidden" name="userUid" value="<%=loginMember.getMemNo()%>">
                	<input type="hidden" name="userEmail" value="<%=loginMember.getMemUserEmail()%>"> 
                	<input type="hidden" name="userName" value="<%=loginMember.getMemName()%>">
                	<input type="hidden" name="REMOTE_ADDR" value="<%=REMOTE_ADDR%>">
                	<input type="hidden" name="choice" value="<%=choice %>">
                	<input type="hidden" name="choiceSub" value="<%=choiceSub%>">
                </div>
            </form>
        </div>
    </div>
</section>
   <script type="text/javascript">
      
   $(document).ready(function() { var oEditors = []; // 개발되어 있는 소스에 맞추느라, 전역변수로 사용하였지만, 지역변수로 사용해도 전혀 무관 함. 
   	
      // Editor Setting
      nhn.husky.EZCreator.createInIFrame({ 
         oAppRef : oEditors, // 전역변수 명과 동일해야 함. 
         elPlaceHolder : "smarteditor", // 에디터가 그려질 textarea ID 값과 동일 해야 함. 
         sSkinURI : "<%=request.getContextPath()%>/SE2/SmartEditor2Skin.html", // Editor HTML 
         fCreator : "createSEditor2", // SE2BasicCreator.js 메소드명이니 변경 금지 X 
         htParams : { 
            // 툴바 사용 여부 (true:사용/ false:사용하지 않음) 
            bUseToolbar : true, 
            // 입력창 크기 조절바 사용 여부 (true:사용/ false:사용하지 않음) 
            bUseVerticalResizer : true, 
            // 모드 탭(Editor | HTML | TEXT) 사용 여부 (true:사용/ false:사용하지 않음) 
            bUseModeChanger : true, 
         } 
      }); 
      
      // 전송버튼 클릭이벤트 
      $("#savebutton").click(function(){ 
         //if(confirm("저장하시겠습니까?")) { 
            // id가 smarteditor인 textarea에 에디터에서 대입 
            oEditors.getById["smarteditor"].exec("UPDATE_CONTENTS_FIELD", []);
            
            // 이부분에 에디터 validation 검증 
            if(validation()) { 
               $("#frm").submit(); 
            } 
         //} 
      }) 
      console.log(returnPath());
   }); 
   
   // 필수값 Check 
   function validation(){
      var contents = $.trim(oEditors[0].getContents());
      if(contents === '<p>&bnsp;</p>' || contents === ''){ // 기본적으로 아무것도 입력하지 않아도 값이 입력되어 있음. 
         alert("내용을 입력하세요."); 
         oEditors.getById['smarteditor'].exec('FOCUS'); 
         return false; 
      } 
      return true; 
   }
   
   function returnPath() {
	   return "<%=request.getContextPath()%>/upload/madang/";
   }
   
// textArea에 이미지 첨부
   function pasteHTML(filepath){
       var sHTML = '<img src="<%=request.getContextPath()%>/upload/madang/'+filepath+'">';
       oEditors.getById["textAreaContent"].exec("PASTE_HTML", [sHTML]);
   }
   </script>
   <script>
    $(document).ready(function () {
        var fileTarget = $('.filebox .upload-hidden');
        fileTarget.on('change',
            function () { // 값이 변경되면 
                if (window.FileReader) { // modern browser 
                    var filename = $(this)[0].files;
                } else { // old IE 
                    var filename = $(this).val().split('/').pop().split('\\').pop(); // 파일명만 추출 
                }

                // 추출한 파일명 삽입 
                $(this).siblings('.upload-name').val(filename);
            });
    });
</script>
<%@ include file="/views/common/footer.jsp"%>