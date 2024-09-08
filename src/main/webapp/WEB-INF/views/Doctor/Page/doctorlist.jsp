<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Thông tin Bác sĩ</title>
<jsp:include page="/WEB-INF/views/Doctor/layout/header.jsp" />
<style>
	.bla{
		width:100%;	
	}
</style>
</head>
<body>
	<jsp:include page="/WEB-INF/views/Doctor/layout/navbar.jsp" />

	<!-- Page Header Start -->
	<div class="container-fluid page-header py-5 mb-5 wow fadeIn"
		data-wow-delay="0.1s">
		<div class="container py-5">
			<h1 class="display-3 text-white mb-3 animated slideInDown">Doctors</h1>
			<nav aria-label="breadcrumb animated slideInDown">
				<ol class="breadcrumb text-uppercase mb-0">
					<li class="breadcrumb-item"><a class="text-white" href="#">Home</a></li>
					<li class="breadcrumb-item"><a class="text-white" href="#">Pages</a></li>
					<li class="breadcrumb-item text-primary active" aria-current="page">Doctors</li>
				</ol>
			</nav>
		</div>
	</div>
	<!-- Page Header End -->


<!-- Team Start -->
<div class="container-xxl py-5">
    <div class="container">
        <div class="text-center mx-auto mb-5 wow fadeInUp" data-wow-delay="0.1s" style="max-width: 600px;">
            <p class="d-inline-block border rounded-pill py-1 px-4">Doctors</p>
            <h1>Our Experienced Doctors</h1>
        </div>
        <div class="row g-4">
            <c:forEach var="doctor" items="${doctors}">
                <div class="col-lg-3 col-md-6 wow fadeInUp" data-wow-delay="0.3s">
                    <div class="team-item position-relative rounded overflow-hidden">
                        <div class="overflow-hidden">
                            <img class="img-fluid" src="${contextPath}${doctor.account.avatar != null ? doctor.account.avatar : '/resources/img/profile-img.jpg'}" alt="${doctor.account.userName}">
                        </div>
                        <div class="team-text bg-light text-center p-4">
                            <a href="appointment/booking?doctorid=${doctor.id}">
                                <h5>${doctor.account.userName}</h5>
                                <p class="text-primary">
                                    ${doctor.specialty != null ? doctor.specialty.name : 'Specialty not available'}
                                </p>
                                <div class="team-social text-center">
                                    <h5 class="text-primary">Bác sĩ</h5>
                                </div>
                            </a>
                        </div>
                    </div>
                </div>
            </c:forEach>
        </div>
    </div>
</div>
<!-- Team End -->
	<jsp:include page="/WEB-INF/views/Doctor/layout/footer.jsp" />
	<jsp:include page="/WEB-INF/views/Doctor/layout/script.jsp" />

</body>
</html>