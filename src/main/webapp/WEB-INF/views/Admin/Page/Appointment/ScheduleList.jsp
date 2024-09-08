<%@page import="org.hibernate.cache.spi.support.AbstractReadWriteAccess.Item"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Appointment</title>
<jsp:include page="/WEB-INF/views/Admin/layout/header.jsp" />

</head>
<body>
    <jsp:include page="/WEB-INF/views/Admin/layout/navbar.jsp" />
    <jsp:include page="/WEB-INF/views/Admin/layout/sidebar.jsp" />
    <main id="main" class="main">

		<div class="pagetitle">
			<h1>Danh sách lịch làm việc</h1>
			
		</div>
		<!-- End Page Title -->
		
		<section class="section">
			<div class="card">
				<div class="card-body">
					<h5 class="card-title"></h5>

					<!-- Table with hoverable rows -->
					<table class="table table-hover">
						<thead>
							<tr>
								<th scope="col">#</th>
								<th scope="col">Bác sĩ</th>
								<th scope="col">Ngày khám</th>
								<th scope="col">Giờ khám</th>
								<th scope="col"></th>
								<th scope="col">@</th>
							</tr>
						</thead>
						<tbody>
						<c:forEach items="${schedulelist}" var="item">
							<tr>
								<th scope="row"> ${item.id }</th>
								<td>
									 ${item.doctorId }
								</td>
								<td>${item.date }</td>
								<td>${item.schedule.schedule }</td>
								<td>
									<a class="btn btn-warning" href="AppointmentDelete?id=${item.id}">Xoá</a>
								</td>
							</tr>
						</c:forEach>
						</tbody>
					</table>
					<!-- End Table with hoverable rows -->

				</div>
			</div>
		</section>

	</main>
	<!-- End #main -->
    
	<jsp:include page="/WEB-INF/views/Admin/layout/footer.jsp" />
	<jsp:include page="/WEB-INF/views/Admin/layout/script.jsp" />
	
</body>
</html>