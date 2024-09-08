<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Feature</title>
<jsp:include page="/WEB-INF/views/Doctor/layout/header.jsp" />
</head>
<body>
	<jsp:include page="/WEB-INF/views/Doctor/layout/navbar.jsp" />
	<!-- Page Header Start -->
	<div class="container-fluid page-header py-5 mb-5 wow fadeIn"
		data-wow-delay="0.1s">
		<div class="container py-5">
			<h1 class="display-3 text-white mb-3 animated slideInDown">Feature</h1>
			<nav aria-label="breadcrumb animated slideInDown">
				<ol class="breadcrumb text-uppercase mb-0">
					<li class="breadcrumb-item"><a class="text-white" href="#">Home</a></li>
					<li class="breadcrumb-item"><a class="text-white" href="#">Pages</a></li>
					<li class="breadcrumb-item text-primary active" aria-current="page">Feature</li>
				</ol>
			</nav>
		</div>
	</div>
	<!-- Page Header End -->
	<!-- Feature Start -->
	<div class="container-fluid bg-primary overflow-hidden px-lg-0"
		style="margin: 6rem 0;">
		<div class="container feature px-lg-0">
			<div class="row g-0 mx-lg-0">
				<div class="col-lg-6 feature-text py-5 wow fadeIn"
					data-wow-delay="0.1s">
					<div class="p-lg-5 ps-lg-0">
						<p class="d-inline-block border rounded-pill text-light py-1 px-4">Features</p>
						<h1 class="text-white mb-4">Why Choose Us</h1>
						<p class="text-white mb-4 pb-2">Tempor erat elitr rebum at
							clita. Diam dolor diam ipsum sit. Aliqu diam amet diam et eos.
							Clita erat ipsum et lorem et sit, sed stet lorem sit clita duo
							justo erat amet</p>
						<div class="row g-4">
							<div class="col-6">
								<div class="d-flex align-items-center">
									<div
										class="d-flex flex-shrink-0 align-items-center justify-content-center rounded-circle bg-light"
										style="width: 55px; height: 55px;">
										<i class="fa fa-user-md text-primary"></i>
									</div>
									<div class="ms-4">
										<p class="text-white mb-2">Experience</p>
										<h5 class="text-white mb-0">Doctors</h5>
									</div>
								</div>
							</div>
							<div class="col-6">
								<div class="d-flex align-items-center">
									<div
										class="d-flex flex-shrink-0 align-items-center justify-content-center rounded-circle bg-light"
										style="width: 55px; height: 55px;">
										<i class="fa fa-check text-primary"></i>
									</div>
									<div class="ms-4">
										<p class="text-white mb-2">Quality</p>
										<h5 class="text-white mb-0">Services</h5>
									</div>
								</div>
							</div>
							<div class="col-6">
								<div class="d-flex align-items-center">
									<div
										class="d-flex flex-shrink-0 align-items-center justify-content-center rounded-circle bg-light"
										style="width: 55px; height: 55px;">
										<i class="fa fa-comment-medical text-primary"></i>
									</div>
									<div class="ms-4">
										<p class="text-white mb-2">Positive</p>
										<h5 class="text-white mb-0">Consultation</h5>
									</div>
								</div>
							</div>
							<div class="col-6">
								<div class="d-flex align-items-center">
									<div
										class="d-flex flex-shrink-0 align-items-center justify-content-center rounded-circle bg-light"
										style="width: 55px; height: 55px;">
										<i class="fa fa-headphones text-primary"></i>
									</div>
									<div class="ms-4">
										<p class="text-white mb-2">24 Hours</p>
										<h5 class="text-white mb-0">Support</h5>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
				<div class="col-lg-6 pe-lg-0 wow fadeIn" data-wow-delay="0.5s"
					style="min-height: 400px;">
					<div class="position-relative h-100">
						<img class="position-absolute img-fluid w-100 h-100"
							src="${contextPath }/resources/asset/feature.jpg" style="object-fit: cover;" alt="">
					</div>
				</div>
			</div>
		</div>
	</div>
	<!-- Feature End -->
	<jsp:include page="/WEB-INF/views/Doctor/layout/footer.jsp" />
	<jsp:include page="/WEB-INF/views/Doctor/layout/script.jsp" />

</body>
</html>