<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>

<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<!DOCTYPE html >
<html  xmlns:th="http://www.thymeleaf.org">
<head>
<meta charset="UTF-8">
<title>Thông tin người dùng</title>
<jsp:include page="/WEB-INF/views/Doctor/layout/header.jsp" />
<link rel="stylesheet" href="${contextPath}/resources/css/profile.css">
</head>
<body>
	<jsp:include page="/WEB-INF/views/Doctor/layout/navbar.jsp" />
    <section class="section profile d-flex justify-content-center align-items-center">
        <div class="col-xl-8">
            <div class="card">
                <div class="card-body pt-3">
                    <!-- Bordered Tabs -->
                    <ul class="nav nav-tabs nav-tabs-bordered">
                        <li class="nav-item">
                            <button class="nav-link active" data-bs-toggle="tab" data-bs-target="#profile-overview">Overview</button>
                        </li>
                        <li class="nav-item">
                            <button class="nav-link" data-bs-toggle="tab" data-bs-target="#profile-edit">Edit Profile</button>
                        </li>
                        <li class="nav-item">
                            <button class="nav-link" data-bs-toggle="tab" data-bs-target="#profile-change-password">Change Password</button>
                        </li>
                    </ul>
                    <div class="tab-content pt-2">

                       <div class="tab-pane fade show active profile-overview" id="profile-overview">
		    <h5 class="card-title">Profile Details</h5>
		    <div class="d-flex align-items-start">
		        <!-- Avatar Section -->
		        <div class="profile-avatar me-4">
		            <img id="profileImg" src="${contextPath}${account.avatar != null ? account.avatar : '/resources/img/profile-img.jpg'}" alt="Profile" />
		        </div>
		        <!-- Profile Details Section -->
		        <div class="profile-details">
		            <div class="row mb-2">
		                <div class="col-lg-3 col-md-4 label">Tên</div>
		                <div class="col-lg-9 col-md-8">${account.userName}</div>
		            </div>
		            <div class="row mb-2">
		                <div class="col-lg-3 col-md-4 label">Giới tính</div>
		                <div class="col-lg-9 col-md-8">${account.gender}</div>
		            </div>
		            <div class="row mb-2">
		                <div class="col-lg-3 col-md-4 label">Địa chỉ</div>
		                <div class="col-lg-9 col-md-8">${account.address} </div>
		            </div>
		            <div class="row mb-2">
		                <div class="col-lg-3 col-md-4 label">Điện thoại</div>
		                <div class="col-lg-9 col-md-8">${account.phoneNumber}</div>
		            </div>
		            <div class="row mb-2">
		                <div class="col-lg-3 col-md-4 label">Email</div>
		                <div class="col-lg-9 col-md-8">${account.email}</div>
		            </div>
		            <!-- Display role information based on the user's role -->
		            <sec:authorize access="hasRole('ROLE_ADMIN') or hasRole('ROLE_DOCTOR')">
		                <div class="row">
		                    <div class="col-lg-3 col-md-4 label">Quyền hạn</div>
		                    <div class="col-lg-9 col-md-8">
		                        <sec:authorize access="hasRole('ROLE_ADMIN')">Admin</sec:authorize>
		                        <sec:authorize access="hasRole('ROLE_DOCTOR')">Bác sĩ</sec:authorize>
		                    </div>
		                </div>
		            </sec:authorize>
		        </div>
    </div>
</div>


                        <div class="tab-pane fade profile-edit pt-3" id="profile-edit">
                            <!-- Profile Edit Form -->
                            <form action="${contextPath}/profile/update" method="post" enctype="multipart/form-data">
                                <div class="row mb-3">
                                    <label for="profileImage" class="col-md-4 col-lg-3 col-form-label">Profile Image</label>
                                    <div class="col-md-8 col-lg-9">
                                        <c:choose>
                                            <c:when test="${account.avatar != null}">
                                                <img id="profileImg" src="${contextPath}${account.avatar}"
                                                    alt="Profile" style="width: 120px; height: 120px; border-radius: 72px;">
                                            </c:when>
                                            <c:otherwise>
                                                <img id="profileImg" src="${contextPath}/resources/img/profile-img.jpg"
                                                    alt="Profile" style="width: 120px; height: 120px; border-radius: 72px;">
                                            </c:otherwise>
                                        </c:choose>
                                        <div class="pt-2">
                                            <a href="#" class="btn btn-primary btn-sm" title="Upload new profile image"
                                                onclick="document.getElementById('formFile').click();">
                                                <i class="bi bi-upload"></i>
                                            </a>
                                            <input class="form-control" type="file" id="formFile" name="file" style="display: none;"
                                                onchange="previewImage(event)" />
                                            <a href="#" class="btn btn-danger btn-sm" title="Remove my profile image">
                                                <i class="bi bi-trash"></i>
                                            </a>
                                        </div>
                                    </div>
                                </div>
                                <div class="row mb-3">
                                    <label for="fullName" class="col-md-4 col-lg-3 col-form-label">Full Name</label>
                                    <div class="col-md-8 col-lg-9">
                                        <input name="userName" type="text" class="form-control" id="fullName" value="${account.userName}">
                                    </div>
                                </div>
                                <div class="row mb-3">
                                    <label for="gender" class="col-md-4 col-lg-3 col-form-label">Gender</label>
                                    <div class="col-md-8 col-lg-9 gender-info">
                                        <select name="gender" class="form-control" id="gender">
                                            <option value="MALE" ${account.gender == 'MALE' ? 'selected' : ''}>Male</option>
                                            <option value="FEMALE" ${account.gender == 'FEMALE' ? 'selected' : ''}>Female</option>
                                        </select>
                                    </div>
                                </div>
                                <div class="row mb-3">
                                    <label for="address" class="col-md-4 col-lg-3 col-form-label">Address</label>
                                    <div class="col-md-8 col-lg-9">
                                        <input name="address" type="text" class="form-control" id="address" value="${account.address}">
                                    </div>
                                </div>
                                <div class="row mb-3">
                                    <label for="phone" class="col-md-4 col-lg-3 col-form-label">Phone</label>
                                    <div class="col-md-8 col-lg-9">
                                        <input name="phoneNumber" type="text" class="form-control" id="phone" value="${account.phoneNumber}">
                                    </div>
                                </div>
                                <div class="row mb-3">
                                    <label for="email" class="col-md-4 col-lg-3 col-form-label">Email</label>
                                    <div class="col-md-8 col-lg-9">
                                        <input name="email" type="email" class="form-control" id="email" value="${account.email}" readonly>
                                    </div>
                                </div>
                                <div class="text-center">
                                    <button type="submit" class="btn btn-primary">Save Changes</button>
                                </div>
                            </form><!-- End Profile Edit Form -->
                        </div>
					<div class="tab-pane fade pt-3" id="profile-change-password">
				    <!-- Change Password Form -->
				    <form action="${contextPath}/change-password" method="post">
					                                 <!-- Display success or error messages -->
					        <c:if test="${not empty message}">
					            <div class="alert alert-success text-center">
					                <c:out value="${message}" />
					            </div>
					        </c:if>
					
					        <c:if test="${not empty error}">
					            <div class="alert alert-danger text-center">
					                <c:out value="${error}" />
					            </div>
					        </c:if>

                        
                                <div class="row mb-3">
                                    <label for="currentPassword" class="col-md-4 col-lg-3 col-form-label">Current Password</label>
                                    <div class="col-md-8 col-lg-9">
                                        <input name="currentPassword" type="password" class="form-control" id="currentPassword" required>
                                    </div>
                                </div>
                                <div class="row mb-3">
                                    <label for="newPassword" class="col-md-4 col-lg-3 col-form-label">New Password</label>
                                    <div class="col-md-8 col-lg-9">
                                        <input name="newPassword" type="password" class="form-control" id="newPassword" required>
                                    </div>
                                </div>
                                <div class="row mb-3">
                                    <label for="renewPassword" class="col-md-4 col-lg-3 col-form-label">Re-enter New Password</label>
                                    <div class="col-md-8 col-lg-9">
                                        <input name="confirmNewPassword" type="password" class="form-control" id="renewPassword" required>
                                    </div>
                                </div>
                                <div class="text-center">
                                    <button type="submit" class="btn btn-primary">Change Password</button>
                                </div>
                            </form>
				    <!-- End Change Password Form -->
				</div>


                    </div><!-- End Bordered Tabs -->
                </div>
            </div>
        </div>
    </section>
    <jsp:include page="/WEB-INF/views/Doctor/layout/footer.jsp" />
    <jsp:include page="/WEB-INF/views/Doctor/layout/script.jsp" />
    <script type="text/javascript">
        function previewImage(event) {
            const reader = new FileReader();
            reader.onload = function(){
                const output = document.getElementById('profileImg');
                output.src = reader.result; // Update the image source to the new file selected
            };
            reader.readAsDataURL(event.target.files[0]); // Convert the file to a data URL
        }
    </script>
</body>
</html>
