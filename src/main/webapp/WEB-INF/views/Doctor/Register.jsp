<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html lang="en">

<head>
  <meta charset="utf-8">
  <meta content="width=device-width, initial-scale=1.0" name="viewport">

  <title> Đăng ký tài khoản</title>
  <meta content="" name="description">
  <meta content="" name="keywords">

  <!-- Favicons -->		
  <link href="${contextPath}/resources/img/favicon.png" rel="icon">
  <link href="${contextPath}/resources/img/apple-touch-icon.png" rel="apple-touch-icon">

  <!-- Google Fonts -->
  <link href="https://fonts.gstatic.com" rel="preconnect">
  <link href="https://fonts.googleapis.com/css?family=Open+Sans:300,300i,400,400i,600,600i,700,700i|Nunito:300,300i,400,400i,600,600i,700,700i|Poppins:300,300i,400,400i,500,500i,600,600i,700,700i" rel="stylesheet">

  <!-- Vendor CSS Files -->
  <link href="${contextPath}/resources/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
  <link href="${contextPath}/resources/vendor/bootstrap-icons/bootstrap-icons.css" rel="stylesheet">
  <link href="${contextPath}/resources/vendor/boxicons/css/boxicons.min.css" rel="stylesheet">
  <link href="${contextPath}/resources/vendor/quill/quill.snow.css" rel="stylesheet">
  <link href="${contextPath}/resources/vendor/quill/quill.bubble.css" rel="stylesheet">
  <link href="${contextPath}/resources/vendor/remixicon/remixicon.css" rel="stylesheet">
  <link href="${contextPath}/resources/vendor/simple-datatables/style.css" rel="stylesheet">

  <!-- Template Main CSS File -->
  <link href="${contextPath}/resources/css/style.css" rel="stylesheet">

</head>

<body>

  <main>
    <div class="container">

      <section class="section register min-vh-100 d-flex flex-column align-items-center justify-content-center py-4">
        <div class="container">
          <div class="row justify-content-center">
            <div class="col-lg-4 col-md-6 d-flex flex-column align-items-center justify-content-center">

              <div class="d-flex justify-content-center py-4">
                <a href="index.html" class="logo d-flex align-items-center w-auto">
                  <img src="${contextPath}/resources/img/logo.png" alt="">
                  <span class="d-none d-lg-block">NiceAdmin</span>
                </a>
              </div><!-- End Logo -->
              <div class="card mb-3">
                <div class="card-body">
                  <div class="pt-4 pb-2">
                    <h5 class="card-title text-center pb-0 fs-4">Tạo tài khoản</h5>
                    <p class="text-center small">Nhập thông tin cá nhân của bạn để tạo tài khoản</p>
                    <c:if test="${not empty message}">
	                    <div class="alert alert-info mt-3">
	                      <c:out value="${message}"/>
	                    </div>
	                  </c:if>
                  </div>
				<form:form class="row g-3 needs-validation" method="post" action="${contextPath}/register" modelAttribute="accountEntity" >
                     <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                    
                    <div class="col-12">
                        <label for="yourName" class="form-label">Họ và tên</label>
                        <input type="text" name="userName" class="form-control" id="yourName" required>
                        <div class="invalid-feedback">Vui lòng nhập họ và tên</div>
                    </div>
                    
                    <div class="col-12">
                        <label for="yourEmail" class="form-label">Nhập email</label>
                        <input type="email" name="email" class="form-control" id="yourEmail" required>
                        <div class="invalid-feedback">Vui lòng nhập email!</div>
                    </div>
                
                    <div class="col-12">
                        <label for="yourPhone" class="form-label">Số điện thoại</label>
                        <div class="input-group has-validation">
                            <input type="text" name="phoneNumber" class="form-control" id="yourPhone" required>
                            <div class="invalid-feedback">Vui lòng nhập số điện thoại.</div>
                        </div>
                    </div>
                    <div class="col-12">
                        <label for="gender" class="form-label">Giới Tính</label>
                        <select class="form-select" name="gender" id="gender" required>
                            <option value="" disabled selected>Chọn Giới Tính</option>
                            <option value="MALE">Nam</option>
                            <option value="FEMALE">Nữ</option>
                            <option value="OTHER">Khác</option>
                        </select>
                        <div class="invalid-feedback">Vui lòng chọn giới tính!</div>
                    </div>
                    <div class="col-12">
                        <label for="yourPassword" class="form-label">Mật Khẩu</label>
                        <div class="input-group">
                            <input type="password" name="password" class="form-control" id="yourPassword" required>
                            <span class="input-group-text">
                                <i class="bi bi-eye-slash" id="togglePassword" style="cursor: pointer;"></i>
                            </span>
                            <div class="invalid-feedback">Vui lòng nhập mật khẩu!</div>
                        </div>
                    </div>
                    <div class="col-12">
                        <label for="confirmPassword" class="form-label">Nhập lại Mật Khẩu</label>
                        <div class="input-group">
                            <input type="password" name="confirmPassword" class="form-control" id="confirmPassword" required>
                            <span class="input-group-text">
                                <i class="bi bi-eye-slash" id="toggleConfirmPassword" style="cursor: pointer;"></i>
                            </span>
                            <div class="invalid-feedback">Vui lòng nhập mật khẩu!</div>
                        </div>
                    </div>
                
                    <div class="col-12">
                        <div class="form-check">
                            <input class="form-check-input" name="terms" type="checkbox" value="" id="acceptTerms" required>
                            <label class="form-check-label" for="acceptTerms">I agree and accept the <a href="#">terms and conditions</a></label>
                            <div class="invalid-feedback">You must agree before submitting.</div>
                        </div>
                    </div>
                    <div class="col-12">
                        <button class="btn btn-primary w-100" type="submit">Create Account</button>
                    </div>
                    <div class="col-12">
                        <p class="small mb-0">Already have an account? <a href="${contextPath}/login">Log in</a></p>
                    </div>
                </form:form>

                </div>
              </div>

              <div class="credits">
                Designed by <a href="#">Intern JAVA</a>
              </div>

            </div>
          </div>
        </div>

      </section>

    </div>
  </main><!-- End #main -->

  <a href="#" class="back-to-top d-flex align-items-center justify-content-center"><i class="bi bi-arrow-up-short"></i></a>

  <!-- Vendor JS Files -->
  <script src="${contextPath}/resources/vendor/apexcharts/apexcharts.min.js"></script>
  <script src="${contextPath}/resources/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
  <script src="${contextPath}/resources/vendor/chart.js/chart.umd.js"></script>
  <script src="${contextPath}/resources/vendor/echarts/echarts.min.js"></script>
  <script src="${contextPath}/resources/vendor/quill/quill.js"></script>
  <script src="${contextPath}/resources/vendor/simple-datatables/simple-datatables.js"></script>
  <script src="${contextPath}/resources/vendor/tinymce/tinymce.min.js"></script>
  <script src="${contextPath}/resources/vendor/php-email-form/validate.js"></script>
<script type="text/javascript">
document.addEventListener('DOMContentLoaded', function () {
    const togglePassword = document.querySelector('#togglePassword');
    const passwordField = document.querySelector('#yourPassword');

    const toggleConfirmPassword = document.querySelector('#toggleConfirmPassword');
    const confirmPasswordField = document.querySelector('#confirmPassword');

    togglePassword.addEventListener('click', function () {
        const type = passwordField.getAttribute('type') === 'password' ? 'text' : 'password';
        passwordField.setAttribute('type', type);
        this.classList.toggle('bi-eye');
    });

    toggleConfirmPassword.addEventListener('click', function () {
        const type = confirmPasswordField.getAttribute('type') === 'password' ? 'text' : 'password';
        confirmPasswordField.setAttribute('type', type);
        this.classList.toggle('bi-eye');
    });
});
</script>
  <!-- Template Main JS File -->
  <script src="${contextPath}/resources/js/main.js"></script>

</body>

</html>
