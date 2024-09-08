<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html lang="en">

<head>
<meta charset="utf-8">
<meta content="width=device-width, initial-scale=1.0" name="viewport">

<title>Not Found 404</title>
<meta content="" name="description">
<meta content="" name="keywords">

<!-- Favicons -->
<link href="${contextPath}/resources/img/favicon.png" rel="icon">
<link href="${contextPath}/resources/img/apple-touch-icon.png"
	rel="apple-touch-icon">

<!-- Google Fonts -->
<link href="https://fonts.gstatic.com" rel="preconnect">
<link
	href="https://fonts.googleapis.com/css?family=Open+Sans:300,300i,400,400i,600,600i,700,700i|Nunito:300,300i,400,400i,600,600i,700,700i|Poppins:300,300i,400,400i,500,500i,600,600i,700,700i"
	rel="stylesheet">

<!-- Vendor CSS Files -->
<link
	href="${contextPath}/resources/vendor/bootstrap/css/bootstrap.min.css"
	rel="stylesheet">
<link
	href="${contextPath}/resources/vendor/bootstrap-icons/bootstrap-icons.css"
	rel="stylesheet">
<link
	href="${contextPath}/resources/vendor/boxicons/css/boxicons.min.css"
	rel="stylesheet">
<link href="${contextPath}/resources/vendor/quill/quill.snow.css"
	rel="stylesheet">
<link href="${contextPath}/resources/vendor/quill/quill.bubble.css"
	rel="stylesheet">
<link href="${contextPath}/resources/vendor/remixicon/remixicon.css"
	rel="stylesheet">
<link href="${contextPath}/resources/vendor/simple-datatables/style.css"
	rel="stylesheet">

<!-- Template Main CSS File -->
<link href="${contextPath}/resources/css/style.css" rel="stylesheet">

<!-- =======================================================
  * Template Name: NiceAdmin
  * Template URL: https://bootstrapmade.com/nice-admin-bootstrap-admin-html-template/
  * Updated: Apr 20 2024 with Bootstrap v5.3.3
  * Author: BootstrapMade.com
  * License: https://bootstrapmade.com/license/
  ======================================================== -->
</head>

<body>

	<main>
		<div class="container">

			<section
				class="section error-404 min-vh-100 d-flex flex-column align-items-center justify-content-center">
				<h1>404</h1>
				<h2>Bạn không có quyền truy cập vào trang này.</h2>
				<a class="btn" href="${contextPath }/admin">Quay lại trang quản lý</a> <img
					src="${contextPath}/resources/img/not-found.svg"
					class="img-fluid py-5" alt="Page Not Found">
				<div class="credits">
					<!-- All the links in the footer should remain intact. -->
					<!-- You can delete the links only if you purchased the pro version. -->
					<!-- Licensing information: https://bootstrapmade.com/license/ -->
					<!-- Purchase the pro version with working PHP/AJAX contact form: https://bootstrapmade.com/nice-admin-bootstrap-admin-html-template/ -->
					Designed by <a href="https://bootstrapmade.com/">BootstrapMade</a>
				</div>
			</section>

		</div>
	</main>
	<!-- End #main -->

	<a href="#"
		class="back-to-top d-flex align-items-center justify-content-center"><i
		class="bi bi-arrow-up-short"></i></a>

	<!-- Vendor JS Files -->
	<script
		src="${contextPath}/resources/vendor/apexcharts/apexcharts.min.js"></script>
	<script
		src="${contextPath}/resources/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
	<script src="${contextPath}/resources/vendor/chart.js/chart.umd.js"></script>
	<script src="${contextPath}/resources/vendor/echarts/echarts.min.js"></script>
	<script src="${contextPath}/resources/vendor/quill/quill.js"></script>
	<script
		src="${contextPath}/resources/vendor/simple-datatables/simple-datatables.js"></script>
	<script src="${contextPath}/resources/vendor/tinymce/tinymce.min.js"></script>
	<script
		src="${contextPath}/resources/vendor/php-email-form/validate.js"></script>

	<!-- Template Main JS File -->
	<script src="${contextPath}/resources/js/main.js"></script>

</body>

</html>