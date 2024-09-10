<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>

<style>
/* Đảm bảo dropdown được hiển thị đúng */
.dropdown {
    position: relative; /* Để kiểm soát vị trí của dropdown */
    z-index: 1000; /* Hiển thị trên các phần tử khác */
}

.dropdown-menu {
    position: absolute;
    top: 100%; /* Đặt menu dưới nút chuyển ngôn ngữ */
    left: 0;
    right: auto;
    margin-top: 0.5rem; /* Khoảng cách với nút chuyển ngôn ngữ */
    z-index: 1001; /* Hiển thị trên các phần tử khác */
}

/* Tùy chỉnh cho các biểu tượng cờ */
.dropdown-item img {
    margin-right: 0.5rem; /* Khoảng cách giữa hình ảnh và text */
    height: 20px;
    width: 30px;
}

.dropdown-item {
    padding: 0.5rem 1rem; /* Tùy chỉnh padding cho dropdown */
}

/* Điều chỉnh nút ngôn ngữ */
#dropdownLanguage {
    display: inline-flex;
    align-items: center;
    justify-content: center;
    padding: 0.5rem;
    border-radius: 0.25rem;
    background-color: white;
}

.btn.btn-sm-square {
    width: 40px;
    height: 40px;
    display: inline-flex;
    justify-content: center;
    align-items: center;
}

/* Đảm bảo dropdown hiển thị trên menu */
.navbar-nav {
    position: relative;
    z-index: 999; /* Hiển thị dưới dropdown ngôn ngữ */
}
/* Tùy chỉnh cho ảnh cờ */
.flag-icon {
    height: 24px;  /* Điều chỉnh chiều cao ảnh cho đẹp */
    width: auto;   /* Đảm bảo giữ tỷ lệ khung hình */
    border-radius: 3px; /* Bo góc nhẹ để ảnh trông mềm mại hơn */
    box-shadow: 0 0 5px rgba(0, 0, 0, 0.2); /* Tạo hiệu ứng đổ bóng nhẹ */
}

/* Tùy chỉnh dropdown để đảm bảo không bị khuất */
.dropdown-menu {
    z-index: 1001;
    top: 100%;
    left: 0;
    margin-top: 0.5rem;
}

.dropdown-toggle {
    padding: 0.5rem;
    display: inline-flex;
    align-items: center;
}
</style>
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
        <!-- Language Switcher -->
		<div class="h-100 d-inline-flex align-items-center py-3 ms-4">
		    <div class="dropdown">
		        <a class="btn btn-sm-square rounded bg-white text-primary dropdown-toggle" href="#" role="button" id="dropdownLanguage" data-bs-toggle="dropdown" aria-expanded="false">
		            <!-- Cờ hiện tại được cập nhật qua JSP -->
		            <c:choose>
		                <c:when test="${param.lang == 'vi'}">
		                    <img id="currentFlag" src="${contextPath}/resources/img/vn.png" alt="Vietnam" class="flag-icon">
		                </c:when>
		                <c:otherwise>
		                    <img id="currentFlag" src="${contextPath}/resources/img/en.png" alt="English" class="flag-icon">
		                </c:otherwise>
		            </c:choose>
		        </a>
		        <ul class="dropdown-menu" aria-labelledby="dropdownLanguage">
		            <li>
		                <a class="dropdown-item" href="?lang=vi" onclick="changeLanguage('vi', '${contextPath}/resources/img/vn.png')">
		                    <img src="${contextPath}/resources/img/vn.png" alt="Vietnam" class="flag-icon">
		                    Tiếng Việt
		                </a>
		            </li>
		            <li>
		                <a class="dropdown-item" href="?lang=en" onclick="changeLanguage('en', '${contextPath}/resources/img/en.png')">
		                    <img src="${contextPath}/resources/img/en.png" alt="English" class="flag-icon">
		                    English
		                </a>
		            </li>
		        </ul>
		    </div>
		</div>
		<!-- End Language Switcher -->


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
            <a href="${contextPath}/" class="nav-item nav-link active"><spring:message code="homepage.title"/></a>
            <a href="${contextPath}/ve-chung-toi" class="nav-item nav-link"><spring:message code="about.us"/></a>
            <a href="${contextPath}/Bac-si" class="nav-item nav-link"><spring:message code="doctors"/></a>
             <a href="${contextPath}/lien-he" class="nav-item nav-link"><spring:message code="contact"/></a>
 			<a href="${contextPath}/bai-viet" class="nav-item nav-link"><spring:message code="articles"/></a>
            <c:choose>
                <c:when test="${not empty sessionScope['SPRING_SECURITY_CONTEXT']}">
                    <!-- Đã đăng nhập -->
                    <c:if test="${not empty sessionScope['username']}">
                        <div class="nav-item dropdown">
                            <a href="#" class="nav-link dropdown-toggle" data-bs-toggle="dropdown">${sessionScope.username}</a>
                            <div class="dropdown-menu rounded-0 rounded-bottom m-0">
                                <a href="${contextPath}/your-appointment" class="dropdown-item"><spring:message code="appointments"/></a>
                                <a href="${contextPath}/profile" class="dropdown-item"><spring:message code="profile"/></a>
                                <a href="${contextPath}/logout" class="dropdown-item"><spring:message code="logout"/></a>
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
                    <a href="${contextPath}/login" class="nav-item nav-link"><spring:message code="login"/></a>
                </c:otherwise>
            </c:choose>
        </div>
        <a href="appointment_with_extra_step" class="btn btn-primary rounded-0 py-4 px-lg-5 d-none d-lg-block"><spring:message code="appointment_with"/><i class="fa fa-arrow-right ms-3"></i></a>
    </div>
</nav>
<!-- Navbar End -->
<script>
function changeLanguage(lang, flagSrc) {
    // Cập nhật nguồn hình ảnh của cờ hiện tại
    document.getElementById('currentFlag').src = flagSrc;
    
    // Tự động tải lại trang với ngôn ngữ đã chọn
    window.location.href = `?lang=${lang}`;
}
</script>


