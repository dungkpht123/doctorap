<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Admin</title>
<jsp:include page="/WEB-INF/views/Admin/layout/header.jsp" />
<style type="text/css">
.role-admin {
    color: white; /* Màu chữ bên trong */
    font-weight: bold; /* Tô đậm chữ */
    background-color: red; /* Màu nền để tạo hiệu ứng bo tròn */
    border-radius: 8px; /* Bo tròn góc */
    padding: 5px 10px; /* Khoảng cách bên trong */
    text-shadow: 
        -1px -1px 0 red,  
        1px -1px 0 red,
        -1px 1px 0 red,
        1px 1px 0 red; /* Tạo viền màu đỏ */
    display: inline-block; /* Để áp dụng bo tròn và padding hiệu quả */
}

.role-doctor {
    color: white; /* Màu chữ bên trong */
    font-weight: bold; /* Tô đậm chữ */
    background-color: green; /* Màu nền để tạo hiệu ứng bo tròn */
    border-radius: 8px; /* Bo tròn góc */
    padding: 5px 10px; /* Khoảng cách bên trong */
    text-shadow: 
        -1px -1px 0 green,  
        1px -1px 0 green,
        -1px 1px 0 green,
        1px 1px 0 green; /* Tạo viền màu xanh lá */
    display: inline-block; /* Để áp dụng bo tròn và padding hiệu quả */
}


</style>
</head>
<body>
    <jsp:include page="/WEB-INF/views/Admin/layout/navbar.jsp" />
    <jsp:include page="/WEB-INF/views/Admin/layout/sidebar.jsp" />
   	 <main id="main" class="main">
     <section class="section profile">
      <div class="row">
        <div class="col-xl-4">

          <div class="card">
            <div class="card-body profile-card pt-4 d-flex flex-column align-items-center">

              <img src="${contextPath}${account.avatar != null ? account.avatar : '/resources/img/profile-img.jpg'}" alt="Profile" class="rounded-circle">
              <h2> ${account.userName}</h2>
							<h3>
								<c:choose>
									<c:when test="${account.gender == 'MALE'}">
										<h3>Nam</h3>
									</c:when>
									<c:otherwise>
										<h3>Nữ</h3>
									</c:otherwise>
								</c:choose>
							</h3>
							<div class="social-links mt-2">
               			<p>
					    <sec:authorize access="hasRole('ROLE_ADMIN')">
					        <span class="role-admin">Admin</span>
					    </sec:authorize>
					    <sec:authorize access="hasRole('ROLE_DOCTOR')">
					        <span class="role-doctor">Bác sĩ</span>
					    </sec:authorize>
					</p>

                        
           			   </div>
            </div>
          </div>

        </div>

        <div class="col-xl-8">

          <div class="card">
            <div class="card-body pt-3">
              <!-- Bordered Tabs -->
              <ul class="nav nav-tabs nav-tabs-bordered">

                <li class="nav-item">
                  <button class="nav-link active" data-bs-toggle="tab" data-bs-target="#profile-overview">Overview</button>
                </li>
                <li class="nav-item">
                  <button class="nav-link" data-bs-toggle="tab" data-bs-target="#profile-change-password">Change Password</button>
                </li>

              </ul>
              <div class="tab-content pt-2">

                <div class="tab-pane fade show active profile-overview" id="profile-overview">
                  <h5 class="card-title">Về chúng tôi</h5>
                  <p class="small fst-italic">Chúng tôi cam kết cung cấp dịch vụ chuyên nghiệp và tận tâm. Với đội ngũ giàu kinh nghiệm và đam mê, chúng tôi luôn sẵn sàng hỗ trợ bạn trong mọi tình huống. Chúng tôi hiểu rằng thời gian là vô giá, và vì vậy, chúng tôi không ngừng nỗ lực để mang lại những giải pháp nhanh chóng và hiệu quả nhất. Chúng tôi không chỉ đáp ứng nhu cầu của bạn mà còn vượt qua mong đợi của bạn. Với tinh thần trách nhiệm và sự tận tụy, chúng tôi luôn hướng tới mục tiêu mang lại sự hài lòng tuyệt đối cho mọi khách hàng.</p>

                  <h5 class="card-title">Thông tin chi tiết</h5>

                  <div class="row">
                    <div class="col-lg-3 col-md-4 label ">Họ tên </div>
                    <div class="col-lg-9 col-md-8">${account.userName}</div>
                  </div>

                  <div class="row">
                    <div class="col-lg-3 col-md-4 label">Giới tính</div>
                    <c:choose>
									<c:when test="${account.gender == 'MALE'}">
										<div class="col-lg-9 col-md-8">Nam</div>
									</c:when>
									<c:otherwise>
										<div class="col-lg-9 col-md-8">Nữ</div>
									</c:otherwise>
								</c:choose>
					</div>
                 

                 <div class="row">
                    <div class="col-lg-3 col-md-4 label ">Quyền hạn</div>
                    <div class="col-lg-9 col-md-8">
                        <sec:authorize access="hasRole('ROLE_ADMIN')">Admin</sec:authorize>
                        <sec:authorize access="hasRole('ROLE_DOCTOR')">Bác sĩ</sec:authorize>
                    </div>
                </div>

                  <div class="row">
                    <div class="col-lg-3 col-md-4 label">Số Điện thoại</div>
                    <div class="col-lg-9 col-md-8">${account.phoneNumber}</div>
                  </div>

                  <div class="row">
                    <div class="col-lg-3 col-md-4 label">Địa chỉ</div>
                    <div class="col-lg-9 col-md-8">${account.address}</div>
                  </div>

                  <div class="row">
                    <div class="col-lg-3 col-md-4 label">Email </div>
                    <div class="col-lg-9 col-md-8">${account.email}</div>
                  </div>

                </div>

             

             
                <div class="tab-pane fade pt-3" id="profile-change-password">
                  <!-- Change Password Form -->
				     
                  <form>
                  <c:if test="${pageContext.request.userPrincipal != null}">
				     <!-- phân quyền admin  -->
				    <sec:authorize access="hasRole('ROLE_DOCTOR')">
                    <div class="row mb-3">
                      <label for="currentPassword" class="col-md-4 col-lg-3 col-form-label">Mật khẩu hiện tại</label>
                      <div class="col-md-8 col-lg-9">
                        <input name="password" type="password" class="form-control" id="currentPassword">
                      </div>
                    </div>

                    <div class="row mb-3">
                      <label for="newPassword" class="col-md-4 col-lg-3 col-form-label">Mật khẩu mới</label>
                      <div class="col-md-8 col-lg-9">
                        <input name="newpassword" type="password" class="form-control" id="newPassword">
                      </div>
                    </div>

                    <div class="row mb-3">
                      <label for="renewPassword" class="col-md-4 col-lg-3 col-form-label">Nhập lại mật khẩu</label>
                      <div class="col-md-8 col-lg-9">
                        <input name="renewpassword" type="password" class="form-control" id="renewPassword">
                      </div>
                    </div>

                    <div class="text-center">
                      <button type="submit" class="btn btn-primary">Change Password</button>
                    </div>
                    </sec:authorize>
					</c:if>
                  </form><!-- End Change Password Form -->

                </div>

              </div><!-- End Bordered Tabs -->

            </div>
          </div>

        </div>
      </div>
    </section>
	</main>
	<jsp:include page="/WEB-INF/views/Admin/layout/footer.jsp" />
	<jsp:include page="/WEB-INF/views/Admin/layout/script.jsp" />
	
</body>
</html>