<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/views/common/header.jsp"%>
<%@ page import="com.studium.category.model.vo.Category,
				java.util.List"%>
<% 
	List<Category> listM=(List)request.getAttribute("categoryM");

	List<Category> listB=(List)request.getAttribute("categoryB");
	
%>

<link href="<%=request.getContextPath()%>/css/all.css" rel="stylesheet">
    <link href="<%=request.getContextPath()%>/css/font-awesome-4.7/css/font-awesome.min.css" rel="stylesheet" media="all">
 
<style>
.header-background-cover {
	height: 95px;
	background-color: rgba(0, 0, 0, 0.8);
}
</style>

    <!-- 달력 -->
    <link href="<%=request.getContextPath()%>/css/daterangepicker.css" rel="stylesheet" media="all">
    
<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<section>
	<div class="header-background" style="background-image: url('<%=request.getContextPath()%>/img/1.jpg');">
		<div class="header-background-cover">
      </div>
    </div>


    <div class="section-content">

        <!--추가정보 받는 div-->
        <div class="row">
            <div class="col-sm-2">
            </div>
            <div class="col-sm-8 navbar-myMenu" style=" margin-top:20px">
                <div class="addMoreInfo" id="addMoreInfo">
                    <h5>추가 정보 입력</h5>
                    <p>추가정보를 입력하면 더 많은 스터디움의 기능을 누릴 수 있습니다!</p>

                    <div class="row">
                        <div class="col-5">
                            <p class="myI-0">생년월일</p>
                            <p class="myI-0">성별</p>
                            <p class="myI-0">전화번호</p>
                            <p class="myI-0-address">주소</p>
                            <p class="myI-0">관심사</p>
                        </div>
                        <div class="col-7">
                            <form action="<%=request.getContextPath() %>/myPage/addmyInfoEntered?no=<%=loginMember.getMemNo()%>" 
                            	id="update-member" method="post"  onsubmit="return add_moreInformation();">
                                <div class="inputForm">
                                <input type="hidden" name="loginMember" value="<%=loginMember.getMemUserEmail()%>">
                                    <input class="js-datepicker myI-1" type="text" placeholder="Birthdate" id="birthday" name="birthday" readonly>
                                     <i class="fa fa-calendar input-icon js-btn-calendar " style="color:#515151;" ></i>
                                </div>
                                <div class="inputForm ">
                                    <div>
                                        <select name="gender" id="gender" class="myI-1 ">
                                            <option disabled="disabled" selected="selected">Gender</option>
                                            <option value="M">남성</option>
                                            <option value="F">여성</option>
                                            <option value="U">선택안함</option>
                                        </select>
                                        <div class="select-dropdown "></div>
                                    </div>
                                </div>

                                <div class="inputForm ">
                                    <input type="text" name="phone" id="phone" class="myI-1 " autocomplete=off placeholder="전화번호 " required>
                                </div>
                                <div class="inputAddress ">
                                    <input type="text" id="sample6_postcode" name="zipcode" class="myI-1-add " placeholder="우편번호 " readonly>
                                    <input type="button" onclick="sample6_execDaumPostcode() "  class="myI-1-add btn-address " value="우편번호 찾기 ">
                                    <input type="text" id="sample6_address" name="address1" class="myI-1 " placeholder="주소 " readonly>
                                    <input type="text" id="sample6_detailAddress" name="address2" class="myI-1 " placeholder="상세주소 ">
                                </div>

                                <div class="inputInteresting">
								<% if(!listM.isEmpty()&&!listB.isEmpty()){
									//m이랑 b랑 비교해서 같은 값 있으면 뿌려주고
									//<%-- for(Category cb : listB){
										
									for(int i=0;i<listB.size();i++){%>
									<div><p><%=listB.get(i).getTitleB()%></p></div>
									
										<% for(int j=0;j<listM.size();j++){
											if(listB.get(i).getCategoryBId().equals(listM.get(j).getCategoryBId())){%>
												<label class="check-label">
		                                        <input type="checkbox" class="option-input checkbox"  name="inter" id="<%=listM.get(j).getCategoryMId()%>" value="<%=listM.get(j).getTitleM() %>">
		                                        <%=listM.get(j).getTitleM() %>
		                                     </label>
											<%}
									}	
								}
								}%>
								
									
                                </div>
								<input type="submit" class="btn-sm btn-withStudium" value="작성완료">
                                
                        </div>

                        </form>
                    </div>
                </div>

            </div>



        </div>
        <div class="col-sm-2 "></div>

    </div>






    <script>
    //관심사 개수제한
    $('input[type=checkbox]').on('change', function (e) {
        if ($('input[type=checkbox]:checked').length > 3) {
            $(this).prop('checked', false);
            alert("관심사는 세 개만 선택 가능합니다.");
        }
    });
        //전화번호 정규표현식
        var regPhone = /^\d{3}\d{3,4}\d{4}$/;


        //회원정보수정 유효성 검사
        function add_moreInformation() {
            //생년월일
            var birth = $("#birthday");
            if (!birth.val()) {
                alert('생년월일을 입력해주세요.');
                birth.click();
                return false;
            }
            //성별
            var gender = $("#gender");
            if (!gender.val()) {
                alert('성별을 입력해주세요.');
                gender.click();
                return false;
            }
            //전화번호검사
            var phone = $('#phone');
            if (!phone.val()) {
                alert('전화번호를 입력해주세요.');
                phone.focus();
                return false;
            } else {
                if (!regPhone.test(phone.val().trim())) {
                    alert('전화번호 형식이 유효하지 않습니다.');
                    phone.focus();
                    return false;
                }
            }
            //주소
            var postcode = $('#sample6_postcode');
            //상세주소
            var detailAddress = $('#sample6_detailAddress');
            if (!postcode.val()) {
                alert('주소를 입력해주세요.');
                postcode.focus();
                return false;
            }
            if (!detailAddress.val()) {
                alert('상세주소를 입력해주세요.');
                detailAddress.focus();
                return false;
            }

            //관심사 체크여부확인
            if (!$('input:checkbox[name="inter"]').is(":checked")) {
                return false;
            }

			console.log("여기까지 와버렸네??");
            //모든사항 통과 
            return true;

        }


		//주소api스크립트
        function sample6_execDaumPostcode() {
            new daum.Postcode({
                oncomplete: function(data) {
                    // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

                    // 각 주소의 노출 규칙에 따라 주소를 조합한다.
                    // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                    var addr = ''; // 주소 변수
                    var extraAddr = ''; // 참고항목 변수

                    //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
                    if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                        addr = data.roadAddress;
                    } else { // 사용자가 지번 주소를 선택했을 경우(J)
                        addr = data.jibunAddress;
                    }

                    // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
                    if (data.userSelectedType === 'R') {
                        // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                        // 법정동의 경우 마지막 문자가 "동/로/가 "로 끝난다.
                        if (data.bname !== '' && /[동|로|가]$/g.test(data.bname)) {
                            extraAddr += data.bname;
                        }
                        // 건물명이 있고, 공동주택일 경우 추가한다.
                        if (data.buildingName !== '' && data.apartment === 'Y') {
                            extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                        }
                        // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                        if (extraAddr !== '') {
                            extraAddr = ' (' + extraAddr + ')';
                        }
                        // 조합된 참고항목을 해당 필드에 넣는다.
                        //document.getElementById("sample6_extraAddress ").value = extraAddr;

                    } else {
                        // document.getElementById("sample6_extraAddress ").value = '';
                    }

                    // 우편번호와 주소 정보를 해당 필드에 넣는다.
                    document.getElementById('sample6_postcode').value = data.zonecode;
                    document.getElementById("sample6_address").value = addr;
                    // 커서를 상세주소 필드로 이동한다.
                    document.getElementById("sample6_detailAddress").focus();
                }
            }).open();
        }
    </script>

    <!--달력 추가-->
    <script src="<%=request.getContextPath() %>/js/moment.min.js "></script>
    <script src="<%=request.getContextPath() %>/js/daterangepicker.js "></script>
    <script src="<%=request.getContextPath() %>/js/global.js "></script>

</section>

<%@ include file="/views/common/footer.jsp"%>
