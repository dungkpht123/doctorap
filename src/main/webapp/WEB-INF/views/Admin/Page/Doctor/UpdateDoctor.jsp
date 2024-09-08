<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Cập nhật thông tin bác sĩ</title>
    <link rel="stylesheet" href="${contextPath}/resources/css/doctor.css">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
</head>
<body>
    <jsp:include page="/WEB-INF/views/Admin/layout/header.jsp" />
    <jsp:include page="/WEB-INF/views/Admin/layout/navbar.jsp" />
    <jsp:include page="/WEB-INF/views/Admin/layout/sidebar.jsp" />
    
    <main id="main" class="main">
        <div class="pagetitle">
            <h1>Cập nhật thông tin bác sĩ</h1>
        </div>
        <section class="section">
            <div class="row">
                <div class="col-md-8 offset-md-2">
                    <form action="${contextPath}/admin/doctors/update" method="post">
                        <input type="hidden" name="id" value="${doctor.id}">
                        
                        <div class="form-group">
                            <label for="name">Tên bác sĩ:</label>
                            <input type="text" class="form-control" id="name" name="name" value="${doctor.account.userName}" readonly>
                        </div>
                        
                        <div class="form-group">
                            <label for="email">Email:</label>
                            <input type="email" class="form-control" id="email" name="email" value="${doctor.account.email}" readonly>
                        </div>
                        
                        <div class="form-group">
                            <label for="phoneNumber">Số điện thoại:</label>
                            <input type="text" class="form-control" id="phoneNumber" name="phoneNumber" value="${doctor.account.phoneNumber}" readonly>
                        </div>

                        <div class="form-group">
                            <label for="address">Địa chỉ:</label>
                            <input type="text" class="form-control" id="address" name="address" value="${doctor.account.address}" readonly>
                        </div>
                        
                        <div class="form-group">
                            <label for="specialty">Chuyên môn:</label>
                            <select id="specialty" name="specialty.id" class="form-control">
                                <option value="" disabled>Chọn chuyên môn</option>
                                <c:forEach var="specialty" items="${specialtyList}">
                                    <option value="${specialty.id}" 
                                            <c:if test="${doctor.specialty != null && doctor.specialty.id == specialty.id}">selected</c:if>>
                                        ${specialty.name}
                                    </option>
                                </c:forEach>
                            </select>
                        </div>

                        <div class="form-group">
                            <label for="experience">Kinh nghiệm:</label>
                            <textarea id="experience" name="experience" class="form-control" rows="3">${doctor.experience}</textarea>
                        </div>

                        <div class="form-group">
                            <label for="qualifications">Trình độ:</label>
                            <textarea id="qualifications" name="qualifications" class="form-control" rows="3">${doctor.qualifications}</textarea>
                        </div>

                        <button type="submit" class="btn btn-primary">Cập nhật</button>
                        <a href="${contextPath}/doctors" class="btn btn-secondary">Hủy</a>
                    </form>
                </div>
            </div>
        </section>
    </main>

    <jsp:include page="/WEB-INF/views/Admin/layout/footer.jsp" />
    <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>
