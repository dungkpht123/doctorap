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
<style>
 	.onhoover{
 		height:400px;
 		width:500px;
 		position:absolute;
 		margin-left:auto;
 		margin-right:auto;
 		margin-top:auto;
 		margin-bottom:auto;
 		top:0;
 		bottom:0;
 		left:0;
 		right:0;
 		display:none;
 	}
 	.hoover:hover ~ .onhoover{
 		display:block;
 	}
 	.hoover:hover{
 		color:red;
 	}
 table{
 position:relative;
 }
 </style>
</head>
<body>
    <jsp:include page="/WEB-INF/views/Admin/layout/navbar.jsp" />
    <jsp:include page="/WEB-INF/views/Doctor/Page/doctor/layout/sidebar.jsp" />
    <main id="main" class="main">

		<div class="pagetitle">
			<h1>Danh sách lịch làm việc</h1>
			
		</div>
		<!-- End Page Title -->
		<section class="section">
			<div class="card">
				<div class="card-body">
					<h5 class="card-title">Lịch khám sắp tới</h5>

					<!-- Table with hoverable rows -->
					<table class="table table-hover">
						<thead>
							<tr>
								<th scope="col">#</th>
								<th scope="col">Bác sĩ</th>
								<th scope="col">Bệnh nhân</th>
								<th scope="col">Ngày khám</th>
								<th scope="col">Giờ khám</th>
								<th scope="col">Chi tiết</th>
								<th scope="col">Trạng thái</th>
							</tr>
						</thead>
						<tbody>
						<c:forEach items="${upcoming}" var="item">
							<tr>
								<th scope="row"> ${item.id }</th>
								<td>
									 ${item.doctor.account.userName }
								</td>
								<td>${item.account.userName }</td>
								<td>${item.date }</td>
								<td>${item.schedule.schedule }</td>
								<td><button class="btn btn-warming hoover">xem thêm</button>
									<div class="alert alert-secondary alert-dismissible fade show onhoover" role="alert">
						                <h4 class="alert-heading"></h4>
						                <p>Bác sĩ: ${item.doctor.account.userName }</p>
						                <p>Bệnh nhân: ${item.patientName }</p>
						                <p>Ngày khám: ${item.date }</p>
						                <hr>
						                <h6 class="alert-heading">Triệu chứng</h6>
						                <p class="mb-0"> ${item.description }</p>
						                
					              </div>
								</td>
								<td>
									<c:if test="${item.appointmentStatus=='SUCCESS' }"><p class="text-success">Đã khám</p></c:if>
									<c:if test="${item.appointmentStatus=='BOOKED' }"><p class="text-primary">Chờ khám</p></c:if>
									<c:if test="${item.appointmentStatus=='CANCELED' }"><p class="text-danger">Huỷ khám</p></c:if>

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
    
	<jsp:include page="/WEB-INF/views/Admin/layout/script.jsp" />
	
</body>
</html>