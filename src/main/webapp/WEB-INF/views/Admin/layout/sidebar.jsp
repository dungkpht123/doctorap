<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>

<c:set var="contextPath" value="${pageContext.request.contextPath}" />

<!-- ======= Sidebar ======= -->
<aside id="sidebar" class="sidebar">

    <ul class="sidebar-nav" id="sidebar-nav">
        <li class="nav-item">
            <a class="nav-link" href="${contextPath}/admin">
                <i class="bi bi-house-door"></i> <span>Dashboard</span>
            </a>
        </li>
        <!-- End Dashboard Nav -->
        <c:if test="${pageContext.request.userPrincipal != null}">
            <!-- phân quyền admin -->
            <sec:authorize access="hasRole('ROLE_ADMIN')">
                <li class="nav-item">
                    <a class="nav-link collapsed" data-bs-target="#doctor-nav" data-bs-toggle="collapse" href="#">
                        <i class="bi bi-person"></i><span>Quản lý bác sĩ</span><i class="bi bi-chevron-down ms-auto"></i>
                    </a>
                    <ul id="doctor-nav" class="nav-content collapse" data-bs-parent="#sidebar-nav">
                        <li><a href="${contextPath}/admin/doctors"><i class="bi bi-list"></i><span>Danh sách bác sĩ</span></a></li>
                        <li><a href="${contextPath}/admin/addDoctor"><i class="bi bi-plus"></i><span>Thêm bác sĩ</span></a></li>
                    </ul>
                </li>
                <!-- End Doctor Nav -->


                <li class="nav-item">
                    <a class="nav-link collapsed" data-bs-target="#specialty-nav" data-bs-toggle="collapse" href="#">
                        <i class="bi bi-tags"></i><span>Quản lý chuyên khoa</span><i class="bi bi-chevron-down ms-auto"></i>
                    </a>
                    <ul id="specialty-nav" class="nav-content collapse" data-bs-parent="#sidebar-nav">
                        <li><a href="${contextPath}/admin/SpecialtyAdd"><i class="bi bi-plus-circle"></i><span>Thêm mới</span></a></li>
                        <li><a href="${contextPath}/admin/SpecialtyList"><i class="bi bi-list"></i><span>Danh sách chuyên khoa</span></a></li>
                    </ul>
                </li>
                <!-- End Specialty Nav -->

               

                <li class="nav-item">
                    <a class="nav-link collapsed" data-bs-target="#post-nav" data-bs-toggle="collapse" href="#">
                        <i class="bi bi-newspaper"></i><span>Quản lý bài viết</span><i class="bi bi-chevron-down ms-auto"></i>
                    </a>
                    <ul id="post-nav" class="nav-content collapse" data-bs-parent="#sidebar-nav">
                        <li><a href="${contextPath}/admin/Post/create"><i class="bi bi-pencil-square"></i><span>Tạo bài viết</span></a></li>
                        <li><a href="${contextPath}/admin/Post/list"><i class="bi bi-file-text"></i><span>Quản lý bài viết</span></a></li>
                    </ul>
                </li>
                <!-- End Post Nav -->

                <li class="nav-item">
                    <a class="nav-link collapsed" data-bs-target="#contact-nav" data-bs-toggle="collapse" href="#">
                        <i class="bi bi-telephone"></i><span>Thông tin liên hệ</span><i class="bi bi-chevron-down ms-auto"></i>
                    </a>
                    <ul id="contact-nav" class="nav-content collapse" data-bs-parent="#sidebar-nav">
                        <li><a href="${contextPath}/admin/hien-thi-lien-he"><i class="bi bi-person-lines-fill"></i><span>Danh sách liên hệ</span></a></li>
                    </ul>
                </li>
                <!-- End Contact Nav -->

                <li class="nav-item">
                    <a class="nav-link collapsed" data-bs-target="#user-nav" data-bs-toggle="collapse" href="#">
                        <i class="bi bi-person"></i><span>Quản lý người dùng</span><i class="bi bi-chevron-down ms-auto"></i>
                    </a>
                    <ul id="user-nav" class="nav-content collapse" data-bs-parent="#sidebar-nav">
                        <li><a href="${contextPath}/admin/quan-ly-tai-khoan"><i class="bi bi-person-check"></i><span>Danh sách tài khoản</span></a></li>
                    </ul>
                </li>
                <!-- End User Nav -->
            </sec:authorize>

            <!-- phân quyền doctor -->
            <sec:authorize access="hasRole('ROLE_DOCTOR')">
                <!-- Hiển thị các phần cho doctor -->
                <li class="nav-item">
                    <a class="nav-link collapsed" data-bs-target="#doctor-schedule-nav" data-bs-toggle="collapse" href="#">
                        <i class="bi bi-calendar"></i><span>Quản lý lịch khám</span><i class="bi bi-chevron-down ms-auto"></i>
                    </a>
                    <ul id="doctor-schedule-nav" class="nav-content collapse" data-bs-parent="#sidebar-nav">
                        <li><a href="${contextPath}/admin/AppointmentList"><i class="bi bi-calendar-check"></i><span>Danh sách lịch khám</span></a></li>
                    </ul>
                </li>
                <!-- End Doctor Schedule Nav -->

                <li class="nav-item">
                    <a class="nav-link collapsed" data-bs-target="#doctor-post-nav" data-bs-toggle="collapse" href="#">
                        <i class="bi bi-newspaper"></i><span>Quản lý bài viết</span><i class="bi bi-chevron-down ms-auto"></i>
                    </a>
                    <ul id="doctor-post-nav" class="nav-content collapse" data-bs-parent="#sidebar-nav">
                        <li><a href="${contextPath}/admin/Post/create"><i class="bi bi-pencil-square"></i><span>Tạo bài viết</span></a></li>
                        <li><a href="${contextPath}/admin/Post/list"><i class="bi bi-file-text"></i><span>Quản lý bài viết</span></a></li>
                    </ul>
                </li>
                <!-- End Doctor Post Nav -->
            </sec:authorize>
        </c:if>

        <!-- Kiểm tra nếu người dùng chưa đăng nhập -->
        <c:if test="${pageContext.request.userPrincipal == null}">
            <li class="nav-item">
                <a href="${contextPath}/login" class="nav-link">
                    <i class="bi bi-box-arrow-in-right"></i> <span>Đăng Nhập</span>
                </a>
            </li>
        </c:if>
    </ul>

</aside>
<!-- End Sidebar-->
