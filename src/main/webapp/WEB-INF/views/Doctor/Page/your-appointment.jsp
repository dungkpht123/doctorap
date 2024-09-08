<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Chuyên khoa</title>
<jsp:include page="/WEB-INF/views/Doctor/layout/header.jsp" />
</head>
<body>
    <jsp:include page="/WEB-INF/views/Doctor/layout/navbar.jsp" />
    



   <div class="container">
            <div class="text-center mx-auto mb-5 wow fadeInUp" data-wow-delay="0.1s" style="max-width: 600px; visibility: visible; animation-delay: 0.1s; animation-name: fadeInUp;">
                <p class="d-inline-block border rounded-pill py-1 px-4"></p>
                <h1>Lịch khám</h1>
            </div>
            <div class="row g-4">
            <c:forEach items="${appointments }" var="item">
            	<div class="col-lg-6 col-md-6 wow fadeInUp" data-wow-delay="0.1s" style="visibility: visible; animation-delay: 0.1s; animation-name: fadeInUp;">
                    <div class="service-item bg-light rounded h-100 p-5">
                        <div class="d-inline-flex align-items-center justify-content-center bg-white rounded-circle mb-4" style="width: 65px; height: 65px;">
                            <i class="${item.doctor.specialty.icon } text-primary fs-4"></i>
                        </div>
                        <p class="mb-4" style="color:black;">Bác sĩ: ${item.doctor.account.userName }</p>
                        <p class="mb-4" style="color:black;">Ngày khám: ${item.date }    ----------------   Trạng thái khám: 
                        <c:if test="${item.appointmentStatus=='SUCCESS' }"><span class="text-success">Đã khám</span></c:if>
                        <c:if test="${item.appointmentStatus=='BOOKED' }"><span class="text-primary">Chờ khám</span></c:if>
                        <c:if test="${item.appointmentStatus=='CANCELED' }"><span class="text-danger">Huỷ khám</span></c:if>
                        </p>
                        <p class="mb-4" style="color:black;">Giờ khám: ${item.schedule.schedule }</p>
                        <p class="mb-4" style="color:black;">Triệu chứng: ${item.description }</p>
                        <c:if test="${item.appointmentStatus=='BOOKED' }"><a class="btn" href="patient-cancel?appointmentid=${item.id }"><i class="fas fa-times text-danger me-3"></i>Huỷ khám</a></c:if>
                    </div>
                </div>
            </c:forEach>
                
               
            </div>
        </div>


        
   	<jsp:include page="/WEB-INF/views/Doctor/layout/footer.jsp" />
   	<jsp:include page="/WEB-INF/views/Doctor/layout/script.jsp" />
   	
   </body>
</html>