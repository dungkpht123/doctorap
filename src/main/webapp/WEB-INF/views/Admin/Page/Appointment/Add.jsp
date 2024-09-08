<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Admin</title>
<jsp:include page="/WEB-INF/views/Admin/layout/header.jsp" />
</head>
<body>
    <jsp:include page="/WEB-INF/views/Admin/layout/navbar.jsp" />
    <jsp:include page="/WEB-INF/views/Admin/layout/sidebar.jsp" />
    
    
    <main id="main" class="main">

    <div class="pagetitle">
      <h1>Form Elements</h1>
      <nav>
        <ol class="breadcrumb">
          <li class="breadcrumb-item"><a href="index.html">Home</a></li>
          <li class="breadcrumb-item">Forms</li>
          <li class="breadcrumb-item active">Elements</li>
        </ol>
      </nav>
    </div><!-- End Page Title -->

    <section class="section">
      <div class="card">
            <div class="card-body">
              <h5 class="card-title">General Form Elements</h5>

              <!-- General Form Elements -->
              <form:form action="AppointmentAdd" method="post" modelAttribute="newAppointment">
                <div class="row mb-3">
                  <label for="inputText" class="col-sm-2 col-form-label">bs</label>
                  <div class="col-sm-10">
                    <form:input path="doctorId" type="text" class="form-control" required="required" value="1"/>
                  </div>
                </div>
                
                
                <div class="row mb-3">
                  <label for="inputText" class="col-sm-2 col-form-label">bn</label>
                  <div class="col-sm-10">
                    <form:input path="patientId" type="text" class="form-control" required="required" value="1"/>
                  </div>
                </div>
                
                <div class="row mb-3">
                  <label class="col-sm-2 col-form-label">Giờ</label>
                  <div class="col-sm-10">
                    <form:select path="doctorSchedule.id" class="form-select" aria-label="Default select example" required="required">
                    <c:forEach items="${availableSchedules }"	 var="item">
                    	<option value="${item.id }">${item.date } |  ${item.schedule.schedule }</option>
                    </c:forEach>
                      
                      
                    </form:select>
                  </div>
                </div>
				
                <div class="row mb-3">
                  <label class="col-sm-2 col-form-label"></label>
                  <div class="col-sm-10">
                    <button type="submit" class="btn btn-primary">Thêm</button>
                  </div>
                </div>
              </form:form><!-- End General Form Elements -->

            </div>
      </div>

    </section>

  </main><!-- End #main -->
    
    
	<jsp:include page="/WEB-INF/views/Admin/layout/footer.jsp" />
	<jsp:include page="/WEB-INF/views/Admin/layout/script.jsp" />
	
</body>
</html>