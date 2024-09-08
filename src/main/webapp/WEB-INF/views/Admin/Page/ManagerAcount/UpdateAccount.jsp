<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Cập nhật tài khoản</title>
<link rel="stylesheet" href="${contextPath}/resources/css/acc.css">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<style>
.toast-container {
	position: fixed;
	top: 1rem;
	right: 1rem;
	z-index: 1100;
}

.toast {
	min-width: 250px;
	margin-bottom: 0.5rem;
}
</style>
</head>
<body>
	<jsp:include page="/WEB-INF/views/Admin/layout/header.jsp" />
	<jsp:include page="/WEB-INF/views/Admin/layout/navbar.jsp" />
	<jsp:include page="/WEB-INF/views/Admin/layout/sidebar.jsp" />

	<main id="main" class="main">
		<div class="pagetitle">
			<h1>Cập nhật tài khoản</h1>
		</div>
		<section class="section">
			<div class="row">
				<div class="col-md-8 offset-md-2">
					<form action="${contextPath}/admin/quan-ly-tai-khoan/update"
						method="post">					
						<input type="hidden" name="id" value="${user.id}">
	
						<div class="form-group">
							<label for="userName">Username:</label> <input type="text"
								class="form-control" id="userName" name="userName"
								value="${user.userName}" required>
						</div>
						<div class="form-group">
							<label for="email">Email:</label> <input type="email"
								class="form-control" id="email" name="email"
								value="${user.email}" required>
						</div>
						<div class="form-group">
							<label for="phoneNumber">Phone Number:</label> <input type="text"
								class="form-control" id="phoneNumber" name="phoneNumber"
								value="${user.phoneNumber}">
						</div>
						<div class="form-group">
							<label for="address">Address:</label> <input type="text"
								class="form-control" id="address" name="address"
								value="${user.address}">
						</div>
						<div class="form-group">
							<label for="gender">Gender:</label> <select class="form-control"
								id="gender" name="gender">
								<option value="MALE" ${user.gender == 'MALE' ? 'selected' : ''}>Male</option>
								<option value="FEMALE"
									${user.gender == 'FEMALE' ? 'selected' : ''}>Female</option>
							</select>
						</div>
						<div class="form-group">
							<label for="status">Status:</label> <select class="form-control"
								id="status" name="status">
								<option value="BLOCK"
									${user.status == 'BLOCK' ? 'selected' : ''}>Block</option>
								<option value="ACTIVE"
									${user.status == 'ACTIVE' ? 'selected' : ''}>Active</option>
							</select>
						</div>
						<div class="form-group">
							<label for="password">Password:</label> <input type="password"
								class="form-control" id="password" name="password">
						</div>
						<div class="form-group">
							<label for="roles">Roles:</label> <select multiple
								class="form-control" id="roles" name="roles">
								<c:forEach var="option" items="${roles}">
									<option value="${option.role}"
										<c:forEach var="userRole" items="${user.accountRoles}">
<c:if test="${option.role == userRole.role}">selected</c:if>
</c:forEach>>
										${option.role}</option>
								</c:forEach>
							</select>
						</div>

						<button type="submit" class="btn btn-primary">Cập nhật</button>
						<a href="${contextPath}/quan-ly-tai-khoan"
							class="btn btn-secondary">Hủy</a>
					</form>
				</div>
			</div>
		</section>
	</main>

	<!-- Toast container -->
	<div class="toast-container">
		<!-- Success Toast -->
		<div class="toast bg-success text-white" id="successToast"
			role="alert" aria-live="assertive" aria-atomic="true">
			<div class="toast-header">
				<strong class="mr-auto">Thành công</strong>
				<button type="button" class="ml-2 mb-1 close" data-dismiss="toast"
					aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<div class="toast-body"></div>
		</div>

		<!-- Error Toast -->
		<div class="toast bg-danger text-white" id="errorToast" role="alert"
			aria-live="assertive" aria-atomic="true">
			<div class="toast-header">
				<strong class="mr-auto">Lỗi</strong>
				<button type="button" class="ml-2 mb-1 close" data-dismiss="toast"
					aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<div class="toast-body"></div>
		</div>
	</div>

	<!-- Scripts -->
	<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
	<script
		src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
	<script>
		$(document).ready(function() {
			<c:if test="${not empty successMessage}">
			$('#successToast .toast-body').text("${successMessage}");
			$('#successToast').toast({
				delay : 2000
			}).toast('show');
			</c:if>

			<c:if test="${not empty errorMessage}">
			$('#errorToast .toast-body').text("${errorMessage}");
			$('#errorToast').toast({
				delay : 2000
			}).toast('show');
			</c:if>
		});
	</script>

	<jsp:include page="/WEB-INF/views/Admin/layout/footer.jsp" />
</body>
</html>