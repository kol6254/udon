<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<fmt:requestEncoding value="utf-8"/>


<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="마이페이지" name="pageTitle"/>
</jsp:include>
<!-- mypage css -->
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/mypage.css">

<style>
a{text-decoration: none; color: black;}
</style>

    <!--================Home Banner Area =================-->
    <!-- breadcrumb start-->
	<section class="breadcrumb breadcrumb_bg">
        <div class="container">
            <div class="row justify-content-center">
                <div class="col-lg-8">
                    <div class="breadcrumb_iner">
                        <div class="breadcrumb_iner_item">
                            <h2>마이페이지</h2>
							<!-- <h3>서울 강남구 논현동</h3> -->
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <!-- breadcrumb start-->
    
    
    
    
    <div class="row py-5 px-4">
	    <div class="col-md-5 mx-auto">
	        <!-- Profile widget -->
	        <div class="bg-white shadow rounded overflow-hidden">
	            <div class="px-4 pt-0 pb-4 cover">
	                <div class="media align-items-end profile-head">
	                    <div class="profile mr-3">
	                    	<!-- LoggdeInUser 정보 가져오기  -->
	                        <sec:authentication property="principal" var="loggedInUser" />
	                    	<img src="${pageContext.request.contextPath }/resources/img/member/${member.renamedFileName == null 
	                    															 ? member.originalFileName:member.renamedFileName}" 
	                    		 alt="..." 
	                    		 width="130" 
	                    		 class="rounded mb-2 img-thumbnail">
	                    	<a href="${pageContext.request.contextPath}/member/editprofile" class="btn btn-outline-dark btn-sm btn-block">Edit profile</a></div>
	                    <div class="media-body mb-5 text-white">
	                        <h4 class="mt-0 mb-0" style="color:white;">${member.nickName}</h4>
	                        <p class="small mb-4" style="color:white;"> <i class="fas fa-map-marker-alt mr-2"></i>${member.address}</p>
	                    </div>
	                </div>
	            </div>
	            <div class="bg-light p-4 d-flex justify-content-end text-center">
	                <ul class="list-inline mb-0">
	                    <li class="list-inline-item">            
	                       <h6 class="font-weight-bold mb-0 d-block">	                       	
	                       	<a href="${pageContext.request.contextPath }/member/salesList?userId=${member.userId}">
	                       		<i class="fas fa-receipt fa-2x" ></i> <br /> 판매내역
	                       	</a>
	                       </h6>
	                    </li>
	                    <li class="list-inline-item">
	                    	<h6 class="font-weight-bold mb-0 d-block">	                       	
	                       	<a href="${pageContext.request.contextPath }/member/buyList?userId=${member.userId}">
	                       		<i class="fas fa-shopping-bag fa-2x" ></i> <br /> 구매내역
	                       	</a>
	                       </h6>
	                    </li>
	                    <li class="list-inline-item">
	                    	<h6 class="font-weight-bold mb-0 d-block">	                       	
	                       	<a href="${pageContext.request.contextPath }/member/wishList?userId=${member.userId}">
	                       		<i class="fas fa-heart fa-2x" ></i> <br /> 관심목록
	                       	</a>
	                       </h6>
	                    </li>
	                </ul>
	            </div>
	            <div class="px-4 py-3">
	                <div class="p-4 rounded shadow-sm bg-light">
				        <!-- Vertical Menu-->
				        <nav class="nav flex-column bg-white shadow-sm rounded p-3">			          
				        <sec:authentication property="principal.username" var="loggedInUserId" />
	  				           <a href="${pageContext.request.contextPath }/member/settingsArea?userId=${member.userId}" class="nav-link px-4 rounded-pill">
	                           <i class="fas fa-map-marker-alt"></i>&nbsp; 내 동네 설정
	                      </a>
	                      <a href="">${loginMember.userId}</a>
				          <a href="${pageContext.request.contextPath }/member/keywordNoti?userId=${member.userId}" class="nav-link px-4 rounded-pill">
		                      <i class="fas fa-tag"></i>&nbsp; 키워드 알림
	                      </a>
				          <a href="${pageContext.request.contextPath }/member/myReviewList?userId=${member.userId}" class="nav-link px-4 rounded-pill">
		                      <i class="far fa-smile"></i>&nbsp; 받은 거래 후기
	                      </a>
				        </nav>
	                </div>
	            </div>
	            <div class="px-4 py-3">
	                <div class="p-4 rounded shadow-sm bg-light">
				        <!-- Vertical Menu-->
				        <nav class="nav flex-column bg-white shadow-sm rounded p-3">
				          <a href="${pageContext.request.contextPath}/member/myPost" class="nav-link px-4 rounded-pill">
	                           <i class="far fa-edit"></i>&nbsp; 동네생활 글
	                      </a>
				          <a href="${pageContext.request.contextPath}/member/myComment" class="nav-link px-4 rounded-pill">
		                      <i class="far fa-comment-dots"></i>&nbsp; 동네생활 댓글
	                      </a>
				          <a href="${pageContext.request.contextPath}/member/interList" class="nav-link px-4 rounded-pill">
		                      <i class="far fa-star"></i>&nbsp; 관심 주제 목록
	                      </a>
				        </nav>
	                </div>
	            </div>
	            <div class="px-4 py-3">
	                <div class="p-4 rounded shadow-sm bg-light">
				        <!-- Vertical Menu-->
				        <nav class="nav flex-column bg-white shadow-sm rounded p-3">
				          <a href="#" class="nav-link px-4 rounded-pill">
	                           <i class="far fa-envelope"></i>&nbsp; 친구초대
	                      </a>
				          <a href="#" class="nav-link px-4 rounded-pill">
		                      <i class="fas fa-share-alt"></i>&nbsp; 당근마켓 공유
	                      </a>
				          <a href="${pageContext.request.contextPath}/member/announce" class="nav-link px-4 rounded-pill">
		                      <i class="far fa-flag"></i>&nbsp; 공지사항
	                      </a>
				          <a href="${pageContext.request.contextPath}/member/FAQ" class="nav-link px-4 rounded-pill">
		                      <i class="far fa-question-circle"></i>&nbsp; 자주 묻는 질문
	                      </a>
				        </nav>
	                </div>
	            </div>
	        </div>
	    </div>
	</div>


<jsp:include page="/WEB-INF/views/common/footer.jsp"/>
	
	
	
	