<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"  %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
	
<%-- 	한글 인코딩 처리 --%>
<fmt:requestEncoding value="utf-8"/>	
	
	<jsp:include page="/WEB-INF/views/common/header.jsp">
		<jsp:param value="신고관리(게시글)" name="pageTitle"/>
	</jsp:include>



<style>
a {
	text-decoration: none;
	color: black;
}
</style>

    <!--================Home Banner Area =================-->
    <!-- breadcrumb start-->
	<section class="breadcrumb breadcrumb_bg">
        <div class="container">
            <div class="row justify-content-center">
                <div class="col-lg-8">
                    <div class="breadcrumb_iner">
                        <div class="breadcrumb_iner_item">
                            <h2>관리자용 페이지</h2>
							<!-- <h3>서울 강남구 논현동</h3> -->
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
	
		<!--================ 사이드바 =================-->	
    <section class="cat_product_area section_padding">
        <div class="container">
            <div class="row">
                <div class="col-lg-3">
                    <div class="left_sidebar_area">
                        <aside class="left_widgets p_filter_widgets">
                            <div class="l_w_title">
                                <h3>관리자 메뉴</h3>
                            </div>
                            <div class="widgets_inner">
                                <ul class="list">
                                    <li><a href="${pageContext.request.contextPath }/admin/memberList">회원 조회 / 등록 / 삭제</a></li>
									<li><a href="${pageContext.request.contextPath }/admin/declareMemberList">신고 관리(사용자)</a></li>
									<li><a href="${pageContext.request.contextPath }/admin/declareBoardList">신고 관리(게시글)</a></li>
									<li><a href="${pageContext.request.contextPath }/admin/declareReplyList">신고 관리(댓글)</a></li>
									<li><a href="${pageContext.request.contextPath }/admin/CouponListList">쿠폰 관리</a></li>
                                </ul>
                            </div>
                        </aside>
                    </div>
                </div>
 			<div class="col-lg-9">
                    <div class="row align-items-center latest_product_inner">
                        <div class="col-lg-4 col-sm-6">
                            <div class="single_product_item">n
                            		<table id="tbl-declareReplyList" class="table table-striped table-hover">
										<tr>
											<th>신고번호</th>
											<th>댓글번호</th>
											<th>신고자</th>
											<th>카테고리의 사유내용</th>
										</tr>
										<c:forEach items="${ list }" var="ReplyReport">
											<tr>
												<td>${ ReplyReport.reportCode }</td>
												<td>${ ReplyReport.replyCode }</td>
												<td>${ ReplyReport.reportId }</td>
												<td>${ ReplyReport.reasonContent }</td>
											</tr>
										</c:forEach>
									</table>
                            </div>
                        </div>
					</div>
                </div>
            </div>
        </div>
	</section>

	
	<jsp:include page="/WEB-INF/views/common/footer.jsp"/>