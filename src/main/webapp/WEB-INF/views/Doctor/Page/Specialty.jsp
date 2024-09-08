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
    

    <!-- Page Header Start -->
    <div class="container-fluid page-header py-5 mb-5 wow fadeIn" data-wow-delay="0.1s">
        <div class="container py-5">
            <h1 class="display-3 text-white mb-3 animated slideInDown text-primary">Chuyên khoa</h1>
            <nav aria-label="breadcrumb animated slideInDown">
                <ol class="breadcrumb text-uppercase mb-0">
                    <li class="breadcrumb-item"><a class="text-white" style="text-shadow: 2px 2px #000000;" href="#">Chúng tôi cung cấp một loạt các dịch vụ và chuyên khoa lâm sàng toàn diện, kết hợp chuyên môn y khoa với công nghệ tiên tiến để mang lại dịch vụ chăm sóc chất lượng cao nhất cho bệnh nhân.</a></li>
                    
                </ol>
            </nav>
        </div>
    </div>
    <!-- Page Header End -->


   <!-- Service Start -->
    <div class="container-xxl py-5">
        <div class="container">
            <div class="text-center mx-auto mb-5 wow fadeInUp" data-wow-delay="0.1s" style="max-width: 600px;">
                <p class="d-inline-block border rounded-pill py-1 px-4">Services</p>
                <h1>Danh sách chuyên khoa</h1>
            </div>
            <div class="row g-4">
            
            <c:forEach items="${specialtyList }" var="item">
            	<div class="col-lg-4 col-md-6 wow fadeInUp"  data-wow-delay="0.1s">
                    <div class="service-item rounded h-100 p-5" style="background-image:linear-gradient(rgba(0, 0, 0, 0.3), rgba(0, 0, 0, 0.5)), url('${contextPath}${item.image}');background-size: cover;">
                        <div class="d-inline-flex align-items-center justify-content-center bg-white rounded-circle mb-4" style="width: 65px; height: 65px;">
                            <i class="${item.icon } text-primary fs-4"></i>
                        </div>
                        <h4 class="mb-3" style="color: white;">${item.name }</h4>
                        <p class="mb-4" style="color: white;width: 311px; height:120px;overflow: hidden;text-overflow: ellipsis;">${item.description }</p>
                        <a class="btn" href="doctorlist?specialtyid=${item.id }"><i class="fa fa-plus text-primary me-3"></i>Đọc thêm</a>
                    </div>
                </div>
            </c:forEach>
                
                
                    
                
            </div>
        </div>
    </div>
    <!-- Service End -->


   


    
        
   	<jsp:include page="/WEB-INF/views/Doctor/layout/footer.jsp" />
   	<jsp:include page="/WEB-INF/views/Doctor/layout/script.jsp" />
   	
   </body>
</html>