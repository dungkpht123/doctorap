<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Giới thiệu về website</title>
<jsp:include page="/WEB-INF/views/Doctor/layout/header.jsp" />
<!-- Bootstrap CSS -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">

<!-- Bootstrap JS and Popper.js -->
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.min.js"></script>
<style>
/* Tùy chỉnh modal */
.modal-content {
    border-radius: 10px;
    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
    background: #f9f9f9;
    border: none;
}

.modal-header {
    border-bottom: 1px solid #ddd;
    background: #007bff;
    color: #fff;
    border-top-left-radius: 10px;
    border-top-right-radius: 10px;
}

.modal-title {
    font-size: 1.5rem;
    font-weight: bold;
}

.btn-close {
    filter: invert(100%);
}

.modal-body {
    padding: 2rem;
    color: #333;
}

.modal-footer {
    border-top: 1px solid #ddd;
    background: #f8f9fa;
    border-bottom-left-radius: 10px;
    border-bottom-right-radius: 10px;
}

.modal-footer .btn {
    border-radius: 20px;
    padding: 0.5rem 1rem;
}

.modal-dialog {
    max-width: 800px;
}

/* Tùy chỉnh cho nút 'Read More' */
.btn-primary {
    background: #007bff;
    border: none;
    border-radius: 20px;
    padding: 0.75rem 1.5rem;
    transition: background 0.3s ease;
}

.btn-primary:hover {
    background: #0056b3;
}
 .modal-dialog.custom-width {
            max-width: 900px;
            width: 100%;
}
.feature-text {
    padding-left: 2rem;
    padding-right: 2rem;
}
</style>
</head>
<body>
    <jsp:include page="/WEB-INF/views/Doctor/layout/navbar.jsp" />
   

    <!-- Page Header Start -->
    <div class="container-fluid page-header py-5 mb-5 wow fadeIn" data-wow-delay="0.1s">
        <div class="container py-5">
            <h1 class="display-3 text-white mb-3 animated slideInDown">${post.title}</h1>
            <nav aria-label="breadcrumb animated slideInDown">
                <ol class="breadcrumb text-uppercase mb-0">
                    <li class="breadcrumb-item"><a class="text-white" href="${contextPath}/Home/">Trang chủ</a></li>
                    <li class="breadcrumb-item"><a class="text-white" href="#">Trang</a></li>
                    <li class="breadcrumb-item text-primary active" aria-current="page">${post.url}</li>
                </ol>
            </nav>
        </div>
    </div>
    <!-- Page Header End -->


    <!-- About Start -->
    <div class="container-xxl py-5">
        <div class="container">
            <div class="row g-5">
                <div class="col-lg-6 wow fadeIn" data-wow-delay="0.1s">
                    <div class="d-flex flex-column">
                        <img class="img-fluid rounded w-75 align-self-end" src="${contextPath }/resources/img/medium_mo_hinh_cap_cuu_002_a74f776a5e.png" alt="">
                        <img class="img-fluid rounded w-50 bg-white pt-3 pe-3" src="${contextPath }/resources/img/medium_cap_cu_dich_vu_001_a4320f30f2.jpg" alt="" style="margin-top: -25%;">
                    </div>
                </div>
                <div class="col-lg-6 wow fadeIn" data-wow-delay="0.5s">
                    <p class="d-inline-block border rounded-pill py-1 px-4"> ${post.title}</p>
                    <h1 class="mb-4">Tại sao bạn nên tin tưởng chúng tôi? Hãy tìm hiểu về chúng tôi!</h1>
                    <p> ${post.shortDescription} </p>
                    <p><i class="far fa-check-circle text-primary me-3"></i>Chăm sóc sức khỏe chất lượng</p>
                    <p><i class="far fa-check-circle text-primary me-3"></i>Chỉ có bác sĩ đủ tiêu chuẩn</p>
                    <p><i class="far fa-check-circle text-primary me-3"></i>Chuyên gia nghiên cứu y khoa</p>
                    <a class="btn btn-primary rounded-pill py-3 px-5 mt-3" href="#" data-bs-toggle="modal" data-bs-target="#readMoreModal">Xem thêm</a>
                </div>
           		
           
            </div>
        </div>
    </div>
    <!-- About End -->

<!-- Feature Start -->
<div class="container-fluid bg-primary overflow-hidden my-5 px-lg-0">
    <div class="container feature px-lg-0">
        <div class="row g-0 mx-lg-0">
            <div class="col-lg-6 feature-text py-5 wow fadeIn" data-wow-delay="0.1s">
                <div class="p-lg-5 ps-lg-0" style="padding-left: 2rem; padding-right: 2rem;">
                    <p class="d-inline-block border rounded-pill text-light py-1 px-4">Đặc điểm</p>
                    <h1 class="text-white mb-4">Vì sao nên chọn chúng tôi</h1>
                    <p class="text-white mb-4 pb-2">Chúng tôi cam kết cung cấp dịch vụ chăm sóc khách hàng tận tâm và sản phẩm chất lượng vượt trội. Với đội ngũ chuyên gia giàu kinh nghiệm và sự đổi mới không ngừng, chúng tôi không chỉ đáp ứng mà còn vượt qua mong đợi của khách hàng. Đặt niềm tin vào chúng tôi, bạn sẽ nhận được sự hỗ trợ tận tình, giải pháp tối ưu và giá trị lâu dài, giúp bạn đạt được mục tiêu và tận hưởng sự hài lòng tối đa. 
                    Sự khác biệt của chúng tôi chính là cam kết mang lại sự thành công cho từng khách hàng, đồng hành cùng bạn trên hành trình phát triển và thành công.</p>
                    <div class="row g-4">
                        <div class="col-6">
                            <div class="d-flex align-items-center">
                                <div class="d-flex flex-shrink-0 align-items-center justify-content-center rounded-circle bg-light" style="width: 55px; height: 55px;">
                                    <i class="fa fa-user-md text-primary"></i>
                                </div>
                                <div class="ms-4">
                                    <p class="text-white mb-2">Kinh nghiệm</p>
                                    <h5 class="text-white mb-0">Bác sĩ</h5>
                                </div>
                            </div>
                        </div>
                        <div class="col-6">
                            <div class="d-flex align-items-center">
                                <div class="d-flex flex-shrink-0 align-items-center justify-content-center rounded-circle bg-light" style="width: 55px; height: 55px;">
                                    <i class="fa fa-check text-primary"></i>
                                </div>
                                <div class="ms-4">
                                    <p class="text-white mb-2">Chất lương</p>
                                    <h5 class="text-white mb-0">Dịch Vụ</h5>
                                </div>
                            </div>
                        </div>
                        <div class="col-6">
                            <div class="d-flex align-items-center">
                                <div class="d-flex flex-shrink-0 align-items-center justify-content-center rounded-circle bg-light" style="width: 55px; height: 55px;">
                                    <i class="fa fa-comment-medical text-primary"></i>
                                </div>
                                <div class="ms-4">
                                    <p class="text-white mb-2">Tích cực</p>
                                    <h5 class="text-white mb-0">Tư vấn</h5>
                                </div>
                            </div>
                        </div>
                        <div class="col-6">
                            <div class="d-flex align-items-center">
                                <div class="d-flex flex-shrink-0 align-items-center justify-content-center rounded-circle bg-light" style="width: 55px; height: 55px;">
                                    <i class="fa fa-headphones text-primary"></i>
                                </div>
                                <div class="ms-4">
                                    <p class="text-white mb-2">24 Giờ</p>
                                    <h5 class="text-white mb-0">Hỗ trợ</h5>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-lg-6 pe-lg-0 wow fadeIn" data-wow-delay="0.5s" style="min-height: 400px;">
                <div class="position-relative h-100">
                    <img class="position-absolute img-fluid w-100 h-100" src="${contextPath }/resources/asset/img/feature.jpg" style="object-fit: cover;" alt="">
                </div>
            </div>
        </div>
    </div>
</div>
<!-- Feature End -->



    <!-- Team Start -->
    <div class="container-xxl py-5">
        <div class="container">
            <div class="text-center mx-auto mb-5 wow fadeInUp" data-wow-delay="0.1s" style="max-width: 600px;">
                <p class="d-inline-block border rounded-pill py-1 px-4">Doctors</p>
                <h1>Our Experience Doctors</h1>
            </div>
            <div class="row g-4">
                <div class="col-lg-3 col-md-6 wow fadeInUp" data-wow-delay="0.1s">
                    <div class="team-item position-relative rounded overflow-hidden">
                        <div class="overflow-hidden">
                            <img class="img-fluid" src="${contextPath }/resources/asset/img/team-1.jpg" alt="">
                        </div>
                        <div class="team-text bg-light text-center p-4">
                            <h5>Doctor Name</h5>
                            <p class="text-primary">Department</p>
                            <div class="team-social text-center">
                                <a class="btn btn-square" href=""><i class="fab fa-facebook-f"></i></a>
                                <a class="btn btn-square" href=""><i class="fab fa-twitter"></i></a>
                                <a class="btn btn-square" href=""><i class="fab fa-instagram"></i></a>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-lg-3 col-md-6 wow fadeInUp" data-wow-delay="0.3s">
                    <div class="team-item position-relative rounded overflow-hidden">
                        <div class="overflow-hidden">
                            <img class="img-fluid" src="${contextPath }/resources/asset/img/team-2.jpg" alt="">
                        </div>
                        <div class="team-text bg-light text-center p-4">
                            <h5>Doctor Name</h5>
                            <p class="text-primary">Department</p>
                            <div class="team-social text-center">
                                <a class="btn btn-square" href=""><i class="fab fa-facebook-f"></i></a>
                                <a class="btn btn-square" href=""><i class="fab fa-twitter"></i></a>
                                <a class="btn btn-square" href=""><i class="fab fa-instagram"></i></a>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-lg-3 col-md-6 wow fadeInUp" data-wow-delay="0.5s">
                    <div class="team-item position-relative rounded overflow-hidden">
                        <div class="overflow-hidden">
                            <img class="img-fluid" src="${contextPath }/resources/asset/img/team-3.jpg" alt="">
                        </div>
                        <div class="team-text bg-light text-center p-4">
                            <h5>Doctor Name</h5>
                            <p class="text-primary">Department</p>
                            <div class="team-social text-center">
                                <a class="btn btn-square" href=""><i class="fab fa-facebook-f"></i></a>
                                <a class="btn btn-square" href=""><i class="fab fa-twitter"></i></a>
                                <a class="btn btn-square" href=""><i class="fab fa-instagram"></i></a>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-lg-3 col-md-6 wow fadeInUp" data-wow-delay="0.7s">
                    <div class="team-item position-relative rounded overflow-hidden">
                        <div class="overflow-hidden">
                            <img class="img-fluid" src="${contextPath }/resources/asset/img/team-4.jpg" alt="">
                        </div>
                        <div class="team-text bg-light text-center p-4">
                            <h5>Doctor Name</h5>
                            <p class="text-primary">Department</p>
                            <div class="team-social text-center">
                                <a class="btn btn-square" href=""><i class="fab fa-facebook-f"></i></a>
                                <a class="btn btn-square" href=""><i class="fab fa-twitter"></i></a>
                                <a class="btn btn-square" href=""><i class="fab fa-instagram"></i></a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- Modal Structure -->
	<div class="modal fade" id="readMoreModal" tabindex="-1"
		aria-labelledby="readMoreModalLabel" aria-hidden="true">
		<div class="modal-dialog custom-width">
			<div class="modal-content">
				<div class="modal-body">

					<!-- Nội dung của bài viết hoặc thông tin thêm ở đây -->
					<p>${post.content}</p>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-secondary"
						data-bs-dismiss="modal">Close</button>
					<a href="${contextPath}/${post.url}" class="btn btn-primary">Go
						to Full Article</a>
				</div>
			</div>
		</div>
	</div>

	<!-- Team End -->
   	<jsp:include page="/WEB-INF/views/Doctor/layout/footer.jsp" />
   	<jsp:include page="/WEB-INF/views/Doctor/layout/script.jsp" />
   	
   </body>
</html>