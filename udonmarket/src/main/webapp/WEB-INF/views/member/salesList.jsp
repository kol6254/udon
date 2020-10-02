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
	                    	<a href="${pageContext.request.contextPath }/member/mypage?userId=${member.userId}" class="btn btn-outline-dark btn-sm btn-block">Mypage</a>
	                    </div>
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
	                       	<a href="#">
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
						
							<ul class="nav nav-pills mb-3" id="pills-tab" role="tablist">
							  <li class="nav-item">
							    <a class="nav-link active" id="pills-home-tab" data-toggle="pill" href="#pills-home" role="tab" aria-controls="pills-home" aria-selected="true">판매중</a>
							  </li>
							  <li class="nav-item">
							    <a class="nav-link" id="pills-profile-tab" data-toggle="pill" href="#pills-profile" role="tab" aria-controls="pills-profile" aria-selected="false">거래완료</a>
							  </li>
							  <li class="nav-item">
							    <a class="nav-link" id="pills-contact-tab" data-toggle="pill" href="#pills-contact" role="tab" aria-controls="pills-contact" aria-selected="false">숨김</a>
							  </li>
							</ul>
							<div class="tab-content" id="pills-tabContent">
							  <div class="tab-pane fade show active" id="pills-home" role="tabpanel" aria-labelledby="pills-home-tab">
							  	<table class="table table-hover">
								  <tbody>
								    <tr>
								      <th scope="row">
								      	<a href="#">
								      		<img src="/udon/resources/img/product/product/feature-product/f-p-1.jpg" 
								      			 class="img-fluid" alt="product"
								      			 style="max-height: 230px;">
								      	</a>
								       </th>
								      <td colspan="3">
								      	<p style="font-size: 1rem;">아이패드 프로 3세대 64기가 애플펜슬 1세대 포함</p>
								      	<p style="color: #545454; font-size: 0.9rem;">서울시 강남구 역삼동</p>
								      	<p style="font-weight: bold;">580,000원</p>
								      	<p><i class="far fa-heart"></i> 8  <i class="far fa-comments"></i> 2<br />
								      	<div style="margin:10px 0px;">
								      	<button type="button" class="btn btn-outline-secondary btn-sm"
								      			style="margin: 0px 0.15rem;">예약중으로 변경</button>
								      	<button type="button" class="btn btn-outline-secondary btn-sm"
								      			style="margin: 0px 0.15rem;">거래완료로 변경</button>
								      	</div>
								      </td>
								      <td>
								      	<div class="btn-group">
										  <button type="button" 
										  		  class="btn btn-outline-link btn-sm dropdown-toggle" 
										  		  data-toggle="dropdown" 
										  		  aria-haspopup="true">
										  </button>
										  <div class="dropdown-menu dropdown-menu-right">
										    <button class="dropdown-item" type="button">수정</button>
										    <button class="dropdown-item" type="button">끌어 올리기</button>
										    <button class="dropdown-item" type="button">게시물 삭제</button>
										  </div>
										</div>
								      </td>
								    </tr>
								    <tr>
								      <th scope="row">
								      	<a href="#">
								      		<img src="/udon/resources/img/product/product/feature-product/f-p-3.jpg" 
								      			 class="img-fluid" alt="product"
								      			 style="max-height: 230px;">
								      	</a>
								       </th>
								      <td colspan="3">
								      	<p style="font-size: 1rem;">애플워치 3세대</p>
								      	<p style="color: #545454; font-size: 0.9rem;">서울시 강남구 역삼동</p>
								      	<p style="font-weight: bold;">160,000원</p>
								      	<br />
								      	<p><i class="far fa-heart"></i> 8  <i class="far fa-comments"></i> 2<br />
								      	<div style="margin:10px 0px;">
								      	<button type="button" class="btn btn-outline-secondary btn-sm"
								      			style="margin: 0px 1.5px;">예약중으로 변경</button>
								      	<button type="button" class="btn btn-outline-secondary btn-sm"
								      			style="margin: 0px 1.5px;">거래완료로 변경</button>
								      	</div>
								      </td>
								      <td>
								      	<div class="btn-group">
										  <button type="button" 
										  		  class="btn btn-outline-link btn-sm dropdown-toggle" 
										  		  data-toggle="dropdown" 
										  		  aria-haspopup="true">
										  </button>
										  <div class="dropdown-menu dropdown-menu-right">
										    <button class="dropdown-item" type="button">수정</button>
										    <button class="dropdown-item" type="button">끌어 올리기</button>
										    <button class="dropdown-item" type="button">게시물 삭제</button>
										  </div>
										</div>
								      </td>
								    </tr>
								    <tr>
								      <th scope="row">
								      	<a href="#">
								      		<img src="/udon/resources/img/product/product/feature-product/f-p-2.jpg" 
								      			 class="img-fluid" alt="product"
								      			 style="max-height: 230px;">
								      	</a>
								       </th>
								      <td colspan="3">
								      	<p style="font-size: 1rem;">질스튜어트가방</p>
								      	<p style="color: #545454; font-size: 0.9rem;">서울시 강남구 역삼동</p>
								      	<p style="font-weight: bold;">60,000원</p>
								      	<br />
								      	<p><i class="far fa-heart"></i> 8  <i class="far fa-comments"></i> 2<br />
								      	<div style="margin:10px 0px;">
								      	<button type="button" class="btn btn-outline-secondary btn-sm"
								      			style="margin: 0px 1.5px;">예약중으로 변경</button>
								      	<button type="button" class="btn btn-outline-secondary btn-sm"
								      			style="margin: 0px 1.5px;">거래완료로 변경</button>
								      	</div>
								      </td>
								      <td>
								      	<div class="btn-group">
										  <button type="button" 
										  		  class="btn btn-outline-link btn-sm dropdown-toggle" 
										  		  data-toggle="dropdown" 
										  		  aria-haspopup="true">
										  </button>
										  <div class="dropdown-menu dropdown-menu-right">
										    <button class="dropdown-item" type="button">수정</button>
										    <button class="dropdown-item" type="button">끌어 올리기</button>
										    <button class="dropdown-item" type="button">게시물 삭제</button>
										  </div>
										</div>
								      </td>
								    </tr>
								  </tbody>
								</table>
							  
							  </div>
							  <div class="tab-pane fade" id="pills-profile" role="tabpanel" aria-labelledby="pills-profile-tab">
							  ...
							  </div>
							  <div class="tab-pane fade" id="pills-contact" role="tabpanel" aria-labelledby="pills-contact-tab">
							  ...
							  </div>
							</div>
						
				        </nav>
	                </div>
	            </div>
	        </div>
	    </div>
	</div>

<jsp:include page="/WEB-INF/views/common/footer.jsp"/>
	
	
	
	