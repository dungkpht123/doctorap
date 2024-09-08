<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Quản lý bác sĩ</title>
<jsp:include page="/WEB-INF/views/Admin/layout/header.jsp" />
<script type="text/javascript">
	function confirmDelete(doctorName) {
		var message = 'Bạn có chắc chắn muốn xóa bác sĩ ' + doctorName + '?';
		return confirm(message);
	}
</script>
</head>
<body>
	<jsp:include page="/WEB-INF/views/Admin/layout/navbar.jsp" />
	<jsp:include page="/WEB-INF/views/Admin/layout/sidebar.jsp" />

	<!-- start main -->
	<main id="main" class="main">
		<section class="section">
			<div class="row">
				<div class="col-lg-12">
					<div class="card">
						<div class="card-body">
							<h5 class="card-title">Danh sách bác sĩ</h5>
							<table class="table table-striped datatable">
								<thead>
									<tr>
										<th>ID</th>
										<th>Tên bác sĩ</th>
										<th>Email</th>
										<th>Điện thoại</th>
										<th>Địa chỉ</th>
										<th>Chuyên môn</th>
										<th>Kinh nghiệm</th>
										<th>Trình độ</th>
										<th>Hình ảnh</th>
										<th>Thao tác</th>
									</tr>
								</thead>
								<tbody>
									<c:forEach var="doctor" items="${doctors}">
										<tr>
											<td>${doctor.id}</td>
											<td>${doctor.account.userName}</td>
											<td>${doctor.account.email}</td>
											<td>${doctor.account.phoneNumber}</td>
											<td>${doctor.account.address}</td>
											<td><c:choose>
													<c:when test="${doctor.specialty != null}">
                                                        ${doctor.specialty.name}
</c:when>
													<c:otherwise>
                                                        Chưa có chuyên môn
</c:otherwise>
												</c:choose></td>
											<td><c:choose>
													<c:when
														test="${doctor.experience != null && !doctor.experience.isEmpty()}">
                                                        ${doctor.experience}
</c:when>
													<c:otherwise>
                                                        Chưa có kinh nghiệm
</c:otherwise>
												</c:choose></td>
											<td><c:choose>
													<c:when
														test="${doctor.qualifications != null && !doctor.qualifications.isEmpty()}">
							                            ${doctor.qualifications}
</c:when>
													<c:otherwise>
							                            Chưa có trình độ
</c:otherwise>
												</c:choose></td>
											<td><c:if
													test="${doctor.account.avatar != null && !doctor.account.avatar.isEmpty()}">
													<img src="${contextPath}${doctor.account.avatar}"
														alt="Avatar" width="50" height="50" />
												</c:if></td>
											<td><a href="${contextPath}/admin/doctors/update/${doctor.id}"
												class="btn btn-warning btn-sm">Sửa</a></td>
										</tr>
									</c:forEach>
								</tbody>
							</table>
							<!-- End Table with stripped rows -->
						</div>
					</div>
				</div>
			</div>
		</section>
	</main>
	<!-- end main -->

	<jsp:include page="/WEB-INF/views/Admin/layout/footer.jsp" />
	<jsp:include page="/WEB-INF/views/Admin/layout/script.jsp" />
</body>
</html>