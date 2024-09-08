<%@page import="org.hibernate.cache.spi.support.AbstractReadWriteAccess.Item"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>Appointment</title>
<jsp:include page="/WEB-INF/views/Admin/layout/header.jsp" />
<style>
    .onhoover {
        height: 400px;
        width: 500px;
        position: absolute;
        margin: auto;
        top: 0; bottom: 0; left: 0; right: 0;
        display: none;
    }
    .hoover:hover ~ .onhoover {
        display: block;
    }
    .hoover:hover {
        color: red;
    }
    table {
        position: relative;
    }
    .email-sent {
        background-color: #d4edda;
        color: #155724;
    }
    .email-not-sent {
        background-color: #f8d7da;
        color: #721c24;
    }
</style>
</head>
<body>
    <jsp:include page="/WEB-INF/views/Admin/layout/navbar.jsp" />
    <jsp:include page="/WEB-INF/views/Admin/layout/sidebar.jsp" />
    <main id="main" class="main">
        <!-- Upcoming Appointments Section -->
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
                                <th scope="col">Email Status</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach items="${upcoming.getContent()}" var="item">
                                <tr class="${item.emailSent ? 'email-sent' : 'email-not-sent'}">
                                    <th scope="row">${item.id}</th>
                                    <td>${item.doctor.account.userName}</td>
                                    <td>${item.account.userName}</td>
                                    <td>${item.date}</td>
                                    <td>${item.schedule.schedule}</td>
                                    <td>
                                        <button class="btn btn-warming hoover">xem thêm</button>
                                        <div class="alert alert-secondary alert-dismissible fade show onhoover" role="alert">
                                            <h4 class="alert-heading"></h4>
                                            <p>Bác sĩ: ${item.doctor.account.userName}</p>
                                            <p>Bệnh nhân: ${item.patientName}</p>
                                            <p>Ngày khám: ${item.date}</p>
                                            <hr>
                                            <h6 class="alert-heading">Triệu chứng</h6>
                                            <p class="mb-0">${item.description}</p>
                                        </div>
                                    </td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${item.appointmentStatus == 'SUCCESS'}">
                                                <p class="text-success">Đã khám</p>
                                            </c:when>
                                            <c:when test="${item.appointmentStatus == 'BOOKED'}">
                                                <p class="text-primary">Chờ khám</p>
                                            </c:when>
                                            <c:otherwise>
                                                <p class="text-danger">Huỷ khám</p>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${item.emailSent}">
                                                <p class="text-success">Đã gửi email</p>
                                            </c:when>
                                            <c:otherwise>
                                                <button class="btn btn-primary send-email" data-id="${item.id}">Gửi email</button>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                    <!-- Pagination for Upcoming Appointments -->
                    <nav class="datatable-pagination">
                        <ul class="datatable-pagination-list">
                            <c:if test="${upcoming.hasPrevious()}">
                                <li class="datatable-pagination-list-item">
                                    <a class="datatable-pagination-list-item-link" href="${pageContext.request.contextPath}/admin/AppointmentList?upage=${upage - 1}&ppage=${ppage}">${upage - 1}</a>
                                </li>
                            </c:if>
                            <li class="datatable-pagination-list-item datatable-active">
                                <a data-page="1" class="datatable-pagination-list-item-link">${upage}</a>
                            </li>
                            <c:if test="${upcoming.hasNext()}">
                                <li class="datatable-pagination-list-item">
                                    <a class="datatable-pagination-list-item-link" href="${pageContext.request.contextPath}/admin/AppointmentList?upage=${upage + 1}&ppage=${ppage}">${upage + 1}</a>
                                </li>
                            </c:if>
                        </ul>
                    </nav>
                </div>
            </div>
        </section>

        <!-- Past Appointments Section -->
        <section class="section">
            <div class="card">
                <div class="card-body">
                    <h5 class="card-title">Lịch khám trước đây</h5>
                    <!-- Table with hoverable rows -->
                    <table class="table table-hover">
                        <thead>
                            <tr>
                                <th scope="col">#</th>
                                <th scope="col">Bác sĩ</th>
                                <th scope="col">Bệnh nhân</th>
                                <th scope="col">Ngày khám</th>
                                <th scope="col">Giờ khám</th>
                                <th scope="col">Triệu chứng</th>
                                <th scope="col">Trạng thái</th>
                                <th scope="col">Email Status</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach items="${past.getContent()}" var="item">
                                <tr class="${item.emailSent ? 'email-sent' : 'email-not-sent'}">
                                    <th scope="row">${item.id}</th>
                                    <td>${item.doctor.account.userName}</td>
                                    <td>${item.account.userName}</td>
                                    <td>${item.date}</td>
                                    <td>${item.schedule.schedule}</td>
                                    <td>
                                        <button class="btn btn-warming hoover">xem thêm</button>
                                        <div class="alert alert-secondary alert-dismissible fade show onhoover" role="alert">
                                            <h4 class="alert-heading"></h4>
                                            <p>Bác sĩ: ${item.doctor.account.userName}</p>
                                            <p>Bệnh nhân: ${item.patientName}</p>
                                            <p>Ngày khám: ${item.date}</p>
                                            <hr>
                                            <h6 class="alert-heading">Triệu chứng</h6>
                                            <p class="mb-0">${item.description}</p>
                                        </div>
                                    </td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${item.appointmentStatus == 'SUCCESS'}">
                                                <p class="text-success">Đã khám</p>
                                            </c:when>
                                            <c:when test="${item.appointmentStatus == 'BOOKED'}">
                                                <p class="text-primary">Chờ khám</p>
                                            </c:when>
                                            <c:otherwise>
                                                <p class="text-danger">Huỷ khám</p>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${item.emailSent}">
                                                <p class="text-success">Đã gửi email</p>
                                            </c:when>
                                            <c:otherwise>
                                                <button class="btn btn-primary send-email" data-id="${item.id}">Gửi email</button>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                    <!-- Pagination for Past Appointments -->
                    <nav class="datatable-pagination">
                        <ul class="datatable-pagination-list">
                            <c:if test="${past.hasPrevious()}">
                                <li class="datatable-pagination-list-item">
                                    <a class="datatable-pagination-list-item-link" href="${pageContext.request.contextPath}/admin/AppointmentList?upage=${upage}&ppage=${ppage - 1}">${ppage - 1}</a>
                                </li>
                            </c:if>
                            <li class="datatable-pagination-list-item datatable-active">
                                <a data-page="1" class="datatable-pagination-list-item-link">${ppage}</a>
                            </li>
                            <c:if test="${past.hasNext()}">
                                <li class="datatable-pagination-list-item">
                                    <a class="datatable-pagination-list-item-link" href="${pageContext.request.contextPath}/admin/AppointmentList?upage=${upage}&ppage=${ppage + 1}">${ppage + 1}</a>
                                </li>
                            </c:if>
                        </ul>
                    </nav>
                </div>
            </div>
        </section>
    </main>

    <jsp:include page="/WEB-INF/views/Admin/layout/footer.jsp" />
    <jsp:include page="/WEB-INF/views/Admin/layout/script.jsp" />
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

<script>
    document.querySelectorAll('.send-email').forEach(button => {
        button.addEventListener('click', function() {
            const id = this.getAttribute('data-id');
            console.log(id);
            fetch('${contextPath}/admin/send-email?id='+id, {
                method: 'POST',  
                headers: {
                    'Content-Type': 'application/json'
                }
              
            })
            .then(response => {
                // Check if response is ok
                if (!response.ok) {
                    throw new Error('Network response was not ok');
                }
                return response.json();  // Parse JSON response
            })
            .then(data => {
                if (data.message === "Email đã được gửi") {
                    // Update the button to indicate email has been sent
                    button.parentElement.innerHTML = '<p class="text-success">Đã gửi email</p>';
                } else {
                    alert(data.message);  // Show error message from server
                }
            })
            .catch(error => {
                console.error('Error:', error);
                alert('Có lỗi xảy ra. Vui lòng thử lại sau.');
            });
        });
    });
</script>




</body>
</html>
