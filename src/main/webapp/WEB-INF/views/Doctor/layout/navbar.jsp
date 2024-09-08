<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />

<!-- Topbar Start -->
<div class="container-fluid bg-light p-0 wow fadeIn" data-wow-delay="0.1s">
    <div class="row gx-0 d-none d-lg-flex">
        <div class="col-lg-7 px-5 text-start">
            <div class="h-100 d-inline-flex align-items-center py-3 me-4">
                <small class="fa fa-map-marker-alt text-primary me-2"></small>
                <small>Tòa nhà FPT Complex, Ngũ Hành Sơn, Đà Nẵng</small>
            </div>
            <div class="h-100 d-inline-flex align-items-center py-3">
                <small class="far fa-clock text-primary me-2"></small>
                <small>Mon - Fri : 06.00 AM - 18:00 PM</small>
            </div>
        </div>
        <div class="col-lg-5 px-5 text-end">
            <div class="h-100 d-inline-flex align-items-center py-3 me-4">
                <small class="fa fa-phone-alt text-primary me-2"></small>
                <small>+ 0905 048 797</small>
            </div>
            <div class="h-100 d-inline-flex align-items-center">
                <a class="btn btn-sm-square rounded-circle bg-white text-primary me-1" href="#"><i class="fab fa-facebook-f"></i></a>
                <a class="btn btn-sm-square rounded-circle bg-white text-primary me-1" href="#"><i class="fab fa-twitter"></i></a>
                <a class="btn btn-sm-square rounded-circle bg-white text-primary me-1" href="#"><i class="fab fa-linkedin-in"></i></a>
                <a class="btn btn-sm-square rounded-circle bg-white text-primary me-0" href="#"><i class="fab fa-instagram"></i></a>
            </div>
        </div>
    </div>
</div>
<!-- Topbar End -->

<!-- Navbar Start -->
<nav class="navbar navbar-expand-lg bg-white navbar-light sticky-top p-0 wow fadeIn" data-wow-delay="0.1s">
    <a href="index.html" class="navbar-brand d-flex align-items-center px-4 px-lg-5">
        <img class="m-0 text-primary img-fluid" style="height: 7rem;width: 11rem;" src="${contextPath}/resources/asset/img/doctor.png" alt="">
    </a>
    <button type="button" class="navbar-toggler me-4" data-bs-toggle="collapse" data-bs-target="#navbarCollapse">
        <span class="navbar-toggler-icon"></span>
    </button>
    <div class="collapse navbar-collapse" id="navbarCollapse">
        <div class="navbar-nav ms-auto p-4 p-lg-0">
            <a href="${contextPath}/" class="nav-item nav-link active">Trang chủ</a>
            <a href="${contextPath}/ve-chung-toi" class="nav-item nav-link">Về Chúng Tôi</a>
            <a href="${contextPath}/Bac-si" class="nav-item nav-link">Bác sĩ</a>
             <a href="${contextPath}/lien-he" class="nav-item nav-link">Liên hệ</a>
 			<a href="${contextPath}/bai-viet" class="nav-item nav-link">Bài viết</a>
            <c:choose>
                <c:when test="${not empty sessionScope['SPRING_SECURITY_CONTEXT']}">
                    <!-- Đã đăng nhập -->
                    <c:if test="${not empty sessionScope['username']}">
                        <div class="nav-item dropdown">
                            <a href="#" class="nav-link dropdown-toggle" data-bs-toggle="dropdown">${sessionScope.username}</a>
                            <div class="dropdown-menu rounded-0 rounded-bottom m-0">
                                <a href="${contextPath}/your-appointment" class="dropdown-item">Lịch khám</a>
                                <a href="${contextPath}/profile" class="dropdown-item">Thông tin cá nhân</a>
                                <a href="${contextPath}/logout" class="dropdown-item">Đăng Xuất</a>
                            </div>
                        </div>
                    </c:if>
                    <sec:authorize access="hasRole('ROLE_ADMIN')">
                        <a href="${contextPath}/admin" class="nav-item nav-link">Admin Page</a>
                    </sec:authorize>
                    <sec:authorize access="hasRole('ROLE_DOCTOR')">
                        <a href="${contextPath}/doctor/Appointmentlist-current" class="nav-item nav-link">Doctor Page</a>
                    </sec:authorize>
                </c:when>
                <c:otherwise>
                    <!-- Chưa đăng nhập -->
                    <a href="${contextPath}/login" class="nav-item nav-link">Đăng Nhập</a>
                </c:otherwise>
            </c:choose>
        </div>
        <a href="appointment_with_extra_step" class="btn btn-primary rounded-0 py-4 px-lg-5 d-none d-lg-block">Đặt lịch<i class="fa fa-arrow-right ms-3"></i></a>
    </div>
</nav>
<!-- Navbar End -->
