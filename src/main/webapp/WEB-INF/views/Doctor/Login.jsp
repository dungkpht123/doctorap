<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html lang="en">

<head>
<meta charset="utf-8">
<meta content="width=device-width, initial-scale=1.0" name="viewport">
<title>Login - NiceAdmin</title>
<meta content="" name="description">
<meta content="" name="keywords">

<!-- Favicons -->
<link href="${contextPath}/resources/img/favicon.png" rel="icon">
<link href="${contextPath}/resources/img/apple-touch-icon.png"
	rel="apple-touch-icon">
<link rel="stylesheet"
	href="${contextPath}/resources/css/modal-styles.css">

<!-- Google Fonts -->
<link href="https://fonts.gstatic.com" rel="preconnect">
<link
	href="https://fonts.googleapis.com/css?family=Open+Sans:300,300i,400,400i,600,600i,700,700i|Nunito:300,300i,400,400i,600,600i,700,700i|Poppins:300,300i,400,400i,500,500i,600,600i,700,700i"
	rel="stylesheet">

<!-- Bootstrap CSS -->
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
	rel="stylesheet">

<!-- Vendor CSS Files -->
<link
	href="${contextPath}/resources/vendor/bootstrap/css/bootstrap.min.css"
	rel="stylesheet">
<link
	href="${contextPath}/resources/vendor/bootstrap-icons/bootstrap-icons.css"
	rel="stylesheet">
<link
	href="${contextPath}/resources/vendor/boxicons/css/boxicons.min.css"
	rel="stylesheet">
<link href="${contextPath}/resources/vendor/quill/quill.snow.css"
	rel="stylesheet">
<link href="${contextPath}/resources/vendor/quill/quill.bubble.css"
	rel="stylesheet">
<link href="${contextPath}/resources/vendor/remixicon/remixicon.css"
	rel="stylesheet">
<link href="${contextPath}/resources/vendor/simple-datatables/style.css"
	rel="stylesheet">
<link href="${contextPath}/resources/css/style.css" rel="stylesheet">

<style>
.form-footer {
	display: flex;
	justify-content: space-between;
	align-items: center;
}

.forgot-password {
	margin-left: auto;
}

.modal-body .form-group {
	margin-bottom: 1rem;
}
</style>
</head>

<body>

	<main>
		<div class="container">
			<section
				class="section register min-vh-100 d-flex flex-column align-items-center justify-content-center py-4">
				<div class="container">
					<div class="row justify-content-center">
						<div
							class="col-lg-4 col-md-6 d-flex flex-column align-items-center justify-content-center">

							<div class="d-flex justify-content-center py-4">
								<a href="${contextPath}"
									class="logo d-flex align-items-center w-auto"> <img
									src="${contextPath}/resources/img/logo.png" alt=""> <span
									class="d-none d-lg-block">Make a doctor appointment</span>
								</a>
							</div>
							<!-- End Logo -->

							<div class="card mb-3">
								<div class="card-body">

									<div class="pt-4 pb-2">
										<h5 class="card-title text-center pb-0 fs-4">Welcome to
											the Website</h5>
										<p class="text-center small">Please enter your email and
											password to continue</p>
									</div>

									<!-- Display error or success messages -->
									<c:if test="${not empty message}">
										<div class="alert alert-info mt-3">
											<c:out value="${message}" />
										</div>
									</c:if>

									<!-- Login Form -->
									<form  id="formSubmit" class="row g-3 needs-validation"
										action="${contextPath}/login-success" method="post">
										<div class="col-12">
											<label for="email" class="form-label">Email</label> <input
												type="email" name="email" class="form-control" id="email"
												required>
										<div class="invalid-feedback form-message"></div>
										</div>

										<div class="col-12">
											<label for="password" class="form-label">Password</label> <input
												type="password" name="password" class="form-control"
												id="password" required>
											<div class="invalid-feedback form-message"></div>
										</div>
										<div class="col-12">
											<div class="form-footer">
												<div class="form-check">
													<input class="form-check-input" type="checkbox"
														name="remember" value="true" id="rememberMe"> <label
														class="form-check-label" for="rememberMe">Remember
														me</label>
												</div>
												<a href="#" class="forgot-password" data-bs-toggle="modal"
													data-bs-target="#forgotPasswordModal">Forgot password?</a>
											</div>
										</div>

										<div class="col-12">
											<button class="btn btn-primary w-100" type="submit" >Login</button>
										</div>
										<div class="col-12">
											<p class="small mb-0">
												Don't have an account? <a href="${contextPath}/register">Create
													an account</a>
											</p>
										</div>
									</form>

								</div>
							</div>

							<div class="credits">
								Designed by <a href="https://bootstrapmade.com/">JAVA</a>
							</div>

						</div>
					</div>
				</div>
			</section>
		</div>
	</main>
	<!-- End #main -->

	<!-- Forgot Password Modal -->
	<div class="modal fade" id="forgotPasswordModal" tabindex="-1"
		aria-labelledby="forgotPasswordModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="forgotPasswordModalLabel">Quên Mật khẩu</h5>
					<button type="button" class="btn-close" data-bs-dismiss="modal"
						aria-label="Close"></button>
				</div>
				<div class="modal-body">
					<!-- Message Display -->
					<div id="forgotPasswordMessage" class="mt-3"></div>

					<!-- Step 1: Enter Email to Send Reset Code -->
					<div id="forgotPasswordStep1">
						<form id="forgotPasswordForm"
							action="${contextPath}/forgot-password" method="post">
							<input type="hidden" name="csrfToken" value="${csrfToken}" />
							<div class="form-group">
								<label for="forgotPasswordEmail">Vui lòng nhập email: </label> <input type="email" class="form-control"
									id="forgotPasswordEmail" name="email" required>
								<div class="invalid-feedback form-message"></div>
							</div>
							<button type="submit" class="btn btn-primary">Gửi mã code</button>
							<button type="button" class="btn btn-secondary"
								data-bs-dismiss="modal">Huỷ</button>
						</form>
					</div>

					<!-- Step 2: Enter Reset Code -->
					<div id="forgotPasswordStep2" style="display: none;">
						<form id="verifyCodeForm"
							action="${contextPath}/verify-reset-code" method="post">
							<input type="hidden" name="csrfToken" value="${csrfToken}" /> <input
								type="hidden" name="email" id="emailField">
							<div class="form-group otp-input-wrapper">
								<label for="resetCode"><span>Nhập mã OTP 6 số</span></label> <input type="tel" id="resetCode" class="otp-input"
									name="resetCode" autocomplete="one-time-code"
									inputmode="numeric" maxlength="6" required>
									<div class="invalid-feedback form-message"></div>
							</div>
							<div id="forgotPasswordMessage"></div>
							<div id="countdownWrapper">
								<span id="countdownTimer">60</span> giây trước khi yêu cầu mã
								mới.
							</div>
							<a href="#" id="resendCodeLink" style="display: none;">Gửi
								lại mã</a>

							<button type="submit" class="btn btn-primary">Xác thực</button>
							<button type="button" class="btn btn-secondary" id="backToStep1">Quay lại</button>
						</form>
					</div>


					<!-- Step 3: Enter New Password -->
					<div id="forgotPasswordStep3" style="display: none;">
						<form id="resetPasswordForm"
							action="${contextPath}/reset-password" method="post">
							<input type="hidden" name="csrfToken" value="${csrfToken}" /> <input
								type="hidden" name="email" id="verifiedEmailField"> <input
								type="hidden" name="resetCode" id="verifiedCodeField">
							
							<div class="form-group">
								<label for="newPassword">Mật khẩu mới:</label> <input
									type="password" class="form-control" id="newPassword"
									name="newPassword" required>
									<div class="invalid-feedback form-message"></div>
							</div>
							<div class="form-group">
								<label for="confirmPassword">Nhật lại mật khẩu mới: </label> <input
									type="password" class="form-control" id="confirmPassword"
									name="confirmPassword" required>
								<div class="invalid-feedback form-message"></div>
							</div>
							<button type="submit" class="btn btn-primary">Gửi</button>
						</form>
					</div>
				</div>
			</div>
		</div>
	</div>


	<!-- Vendor JS Files -->
	<script
		src="${contextPath}/resources/vendor/apexcharts/apexcharts.min.js"></script>
	<script
		src="${contextPath}/resources/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
	<script src="${contextPath}/resources/vendor/chart.js/chart.umd.js"></script>
	<script src="${contextPath}/resources/vendor/echarts/echarts.min.js"></script>
	<script src="${contextPath}/resources/vendor/quill/quill.js"></script>
	<script
		src="${contextPath}/resources/vendor/simple-datatables/simple-datatables.js"></script>
	<script src="${contextPath}/resources/vendor/tinymce/tinymce.min.js"></script>
	<script
		src="${contextPath}/resources/vendor/php-email-form/validate.js"></script>

	<!-- Template Main JS File -->
	<script src="${contextPath}/resources/js/main.js"></script>
	<script src="${contextPath}/resources/js/validator.js"></script>
	<script src="${contextPath}/resources/js/RequiredLogin.js"></script>
<script>
document.addEventListener('DOMContentLoaded', function() {
	 var forgotPasswordForm = document.getElementById('forgotPasswordForm');
	    var verifyCodeForm = document.getElementById('verifyCodeForm');
	    var resetPasswordForm = document.getElementById('resetPasswordForm');

	    var forgotPasswordStep1 = document.getElementById('forgotPasswordStep1');
	    var forgotPasswordStep2 = document.getElementById('forgotPasswordStep2');
	    var forgotPasswordStep3 = document.getElementById('forgotPasswordStep3');

	    var emailField = document.getElementById('emailField');
	    var verifiedEmailField = document.getElementById('verifiedEmailField');
	    var verifiedCodeField = document.getElementById('verifiedCodeField');
	    
	    var forgotPasswordMessage = document.getElementById('forgotPasswordMessage');
	    var backToStep1Button = document.getElementById('backToStep1');

	    var countdownWrapper = document.getElementById('countdownWrapper');
	    var countdownTimer = document.getElementById('countdownTimer');
	    var resendCodeLink = document.getElementById('resendCodeLink');

	    let countdownInterval;

	    function startCountdown() {
	        let timeLeft = 30; // 30 seconds countdown
	        countdownWrapper.style.display = "block";
	        resendCodeLink.style.display = "none"; // Hide resend link during countdown

	        countdownInterval = setInterval(() => {
	            if (timeLeft <= 0) {
	                clearInterval(countdownInterval);
	                countdownWrapper.style.display = "none";
	                resendCodeLink.style.display = "block"; // Show resend link after countdown
	            } else {
	                countdownTimer.textContent = timeLeft;
	                timeLeft -= 1;
	            }
	        }, 1000);
	    }

	    function resendCode() {
	        const email = emailField.value;
	        fetch('${contextPath}/forgot-password', {
	            method: 'POST',
	            headers: {
	                'Content-Type': 'application/x-www-form-urlencoded',
	                'X-CSRF-Token': document.querySelector('input[name="csrfToken"]').value
	            },
	            body: new URLSearchParams({
	                email: email
	            })
	        })
	        .then(response => response.json())
	        .then(data => {
	            if (data.success) {
	                startCountdown(); // Restart countdown after successful resend
	            } else {
	                alert(data.message); // Show error message
	            }
	        });
	    }

	    // Step 1: Handle sending reset code
	    forgotPasswordForm.addEventListener('submit', function(e) {
	        e.preventDefault(); // Prevent default form submission

	        var formData = new FormData(forgotPasswordForm);

	        fetch('${contextPath}/forgot-password', {
	            method: 'POST',
	            body: formData
	        })
	        .then(response => response.json())
	        .then(data => {
	            if (data.success) {
	                emailField.value = formData.get('email');
	                forgotPasswordStep1.style.display = 'none';
	                forgotPasswordStep2.style.display = 'block';
	                forgotPasswordMessage.innerHTML = '<div class="alert alert-info">' + data.message + '</div>';
	                startCountdown(); // Start countdown
	            } else {
	                forgotPasswordMessage.innerHTML = '<div class="alert alert-danger">' + data.message + '</div>';
	            }
	        })
	        .catch(error => console.error('Error:', error));
	    });

	    // Step 2: Handle verifying the reset code
	    verifyCodeForm.addEventListener('submit', function(e) {
	        e.preventDefault(); // Prevent default form submission

	        var formData = new FormData(verifyCodeForm);

	        fetch('${contextPath}/verify-reset-code', {
	            method: 'POST',
	            body: formData
	        })
	        .then(response => response.json())
	        .then(data => {
	            if (data.success) {
	                verifiedEmailField.value = emailField.value;
	                verifiedCodeField.value = formData.get('resetCode');
	                forgotPasswordStep2.style.display = 'none';
	                forgotPasswordStep3.style.display = 'block';
	                forgotPasswordMessage.innerHTML = '<div class="alert alert-success">Code verified! Please enter a new password.</div>';
	            } else {
	                forgotPasswordMessage.innerHTML = `
	                    <div class="alert alert-danger">
	                        Mã không hợp lệ hoặc đã hết hạn.
	                        <a href="#" id="resendCodeLink" style="display:none;">Gửi lại mã</a>
	                    </div>`;
	                
	            }
	        })
	        .catch(error => console.error('Error:', error));
	    });

	    // Step 3: Handle resetting the password
	    resetPasswordForm.addEventListener('submit', function(e) {
	        e.preventDefault(); // Prevent default form submission

	        var formData = new FormData(resetPasswordForm);

	        fetch('${contextPath}/reset-password', {
	            method: 'POST',
	            body: formData
	        })
	        .then(response => response.json())
	        .then(data => {
	            if (data.success) {
	                forgotPasswordMessage.innerHTML = '<div class="alert alert-success">' + data.message + '</div>';
	                setTimeout(() => window.location.href = '${contextPath}/login', 2000); // Redirect after 2 seconds
	            } else {
	                forgotPasswordMessage.innerHTML = '<div class="alert alert-danger">' + data.message + '</div>';
	            }
	        })
	        .catch(error => console.error('Error:', error));
	    });

	    // Back to Step 1
	    backToStep1Button.addEventListener('click', function() {
	        forgotPasswordStep2.style.display = 'none';
	        forgotPasswordStep1.style.display = 'block';
	        forgotPasswordMessage.innerHTML = ''; // Clear messages
	    });

	    // Resend code link click event
	    resendCodeLink.addEventListener('click', function(e) {
	        e.preventDefault();
	        resendCode(); // Trigger code resend
	    });
	});


	const input = document.querySelector('[autocomplete=one-time-code]');
	input.addEventListener('input', () => input.style.setProperty('--_otp-digit', input.selectionStart));
</script>
</body>

</html>
