<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Thông tin Bác sĩ</title>
<jsp:include page="/WEB-INF/views/Doctor/layout/header.jsp" />
<style type="text/css">
/* Your existing CSS here */
/* Modal Container */
.modal-content {
    display: flex;
    align-items: center; /* Căn chỉnh theo chiều dọc giữa các phần tử */
    background-color: #fefefe;
    margin: 5% auto;
    padding: 20px;
    border: 1px solid #888;
    width: 80%;
    max-width: 1000px; /* Maximum width of the modal */
    position: relative; /* Để nút đóng nằm ở góc phải */
}

/* Close Button */
.close {
    position: absolute;
    top: 10px; /* Khoảng cách từ trên cùng */
    right: 10px; /* Khoảng cách từ bên phải */
    width: 35px; /* Kích thước nút đóng */
    height: 35px; /* Kích thước nút đóng */
    background-color: #aaa;
    color: #fff;
    border: none;
    border-radius: 50%; /* Tạo thành hình tròn */
    text-align: center;
    line-height: 35px; /* Căn giữa ký tự */
    font-size: 20px;
    cursor: pointer;
}

.close:hover,
.close:focus {
    background-color: #333;
    color: #fff;
    text-decoration: none;
}

/* Modal Body Inner */
.modal-body-inner {
    display: flex;
    align-items: center; /* Căn chỉnh hình ảnh và văn bản theo chiều dọc */
    width: 100%;
}

/* Modal Image */
.modal-image {
    width: 250px; /* Chiều rộng của hình ảnh */
    height: auto;
    object-fit: cover;
    margin-right: 20px; /* Khoảng cách giữa hình ảnh và thông tin */
    border-radius: 5px;
}

/* Modal Text */
.modal-text {
    flex: 1;
    text-align: center; /* Căn giữa tất cả nội dung trong modal-text */
}

.modal-text .info-title {
    font-size: 18px;
    font-weight: bold;
    margin-bottom: 10px;
}

.modal-text h2 {
    font-size: 24px;
    font-weight: bold;
    color: #333;
    margin-top: 0;
}

.modal-text p {
    font-size: 16px;
    line-height: 1.5;
    color: #555;
    margin: 10px 0;
}

.modal-text strong {
    font-weight: bold;
    color: #000;
}
/* Team Item */
.team-item {
    position: relative;
    overflow: hidden;
    border-radius: 10px;
}

.team-item img {
    width: 100%;
    height: 400px; /* Chiều cao cố định cho ảnh */
    object-fit: cover; /* Đảm bảo ảnh không bị biến dạng và chiếm toàn bộ khung */
}

/* Modal Image */
.modal-image {
   	width: 200px;
    height: 350px;/* Chiều cao cố định cho ảnh trong modal */
    object-fit: cover; /* Đảm bảo ảnh không bị biến dạng và chiếm toàn bộ khung */
    border-radius: 5px;
}
/* Pagination Container */
.pagination {
    display: flex;
    justify-content: center;
    padding: 0;
    margin: 20px 0;
    list-style: none;
}

/* Pagination Item */
.page-item {
    margin: 0 5px;
}

/* Pagination Link */
.page-link {
    display: block;
    padding: 10px 15px;
    font-size: 16px;
    color: #007bff;
    text-decoration: none;
    border: 1px solid #ddd;
    border-radius: 5px;
    transition: background-color 0.2s, color 0.2s;
}

/* Hover State for Pagination Link */
.page-link:hover,
.page-link:focus {
    background-color: #007bff;
    color: #fff;
    border-color: #007bff;
}

/* Active Pagination Link */
.page-item.active .page-link {
    background-color: #007bff;
    color: #fff;
    border-color: #007bff;
    cursor: default;
}

/* Disabled Pagination Link */
.page-item.disabled .page-link {
    color: #6c757d;
    border-color: #ddd;
    cursor: not-allowed;
}



</style>
</head>
<body>
	<jsp:include page="/WEB-INF/views/Doctor/layout/navbar.jsp" />

	<!-- Page Header Start -->
	<div class="container-fluid page-header py-5 mb-5 wow fadeIn"
		data-wow-delay="0.1s">
		<div class="container py-5">
			<h1 class="display-3 text-white mb-3 animated slideInDown">Doctors</h1>
			<nav aria-label="breadcrumb animated slideInDown">
				<ol class="breadcrumb text-uppercase mb-0">
					<li class="breadcrumb-item"><a class="text-white" href="#">Home</a></li>
					<li class="breadcrumb-item"><a class="text-white" href="#">Pages</a></li>
					<li class="breadcrumb-item text-primary active" aria-current="page">Doctors</li>
				</ol>
			</nav>
		</div>
	</div>
	<!-- Page Header End -->
<!-- Team Start -->
<div class="container-xxl py-5">
    <div class="container">
        <div class="text-center mx-auto mb-5 wow fadeInUp" data-wow-delay="0.1s" style="max-width: 600px;">
            <p class="d-inline-block border rounded-pill py-1 px-4">Doctors</p>
            <h1>Our Experienced Doctors</h1>
        </div>
        <div class="row g-4">
            <c:forEach var="doctor" items="${doctors}">
                <div class="col-lg-3 col-md-6 wow fadeInUp" data-wow-delay="0.3s">
                    <div class="team-item position-relative rounded overflow-hidden">
                        <div class="overflow-hidden">
                            <img class="img-fluid" src="${contextPath}${doctor.account.avatar != null ? doctor.account.avatar : '/resources/img/profile-img.jpg'}" alt="${doctor.account.userName}">
                        </div>
                        <div class="team-text bg-light text-center p-4">
                            <h5 class="button" data-modal-target="#popup-${doctor.id}">${doctor.account.userName}</h5>
                            <p class="text-primary">
                                ${doctor.specialty != null ? doctor.specialty.name : ''}
                            </p>
                            <div class="team-social text-center">
                                <a class="openModal button-mod" data-modal-target="#popup-${doctor.id}">Xem thêm >></a>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- The Modal -->
                <div id="popup-${doctor.id}" class="modal">
                    <!-- Modal content -->
                    <div class="modal-content">
                        <span class="close">&times;</span>
                        <div class="modal-body-inner">
                            <img class="modal-image" src="${contextPath}${doctor.account.avatar != null ? doctor.account.avatar : '/resources/img/profile-img.jpg'}" alt="Doctor Image" />
                            <div class="modal-text">
                                <h2 class="info-title">Thông tin chi tiết</h2>
                                <p>Tên Bác sĩ: ${doctor.account.userName}</p>
                                <p><strong>Kinh nghiệm:</strong> ${doctor.experience != null ? doctor.experience : 'Không có thông tin'}</p>
                                <p><strong>Chuyên môn:</strong> ${doctor.specialty != null ? doctor.specialty.name : 'Không có thông tin'}</p>
                                <!-- Thêm thông tin chi tiết khác nếu cần -->
                            </div>
                        </div>
                    </div>
                </div>
            </c:forEach>
        </div>

       <!-- Pagination Start -->
			<div class="row mt-4">
			    <div class="col-12">
			        <nav aria-label="Page navigation">
			            <ul class="pagination justify-content-center">
			                <c:if test="${currentPage > 1}">
			                    <li class="page-item">
			                        <a class="page-link" href="?page=${currentPage - 1}&size=${pageList.size}" aria-label="Previous">
			                            <span aria-hidden="true">&laquo;</span>
			                        </a>
			                    </li>
			                </c:if>
			
			                <c:forEach var="i" begin="1" end="${totalPages}">
			                    <li class="page-item ${i == currentPage ? 'active' : ''}">
			                        <a class="page-link" href="?page=${i}&size=${pageList.size}">${i}</a>
			                    </li>
			                </c:forEach>
			
			                <c:if test="${currentPage < totalPages}">
			                    <li class="page-item">
			                        <a class="page-link" href="?page=${currentPage + 1}&size=${pageList.size}" aria-label="Next">
			                            <span aria-hidden="true">&raquo;</span>
			                        </a>
			                    </li>
			                </c:if>
			            </ul>
			        </nav>
			    </div>
			</div>
			<!-- Pagination End -->

    </div>
</div>
<!-- Team End -->

	<jsp:include page="/WEB-INF/views/Doctor/layout/footer.jsp" />
	<jsp:include page="/WEB-INF/views/Doctor/layout/script.jsp" />

<script type="text/javascript">
// Your existing JS here
document.addEventListener('DOMContentLoaded', function() {
    // Mở modal khi nút được nhấn
    document.querySelectorAll('.openModal').forEach(button => {
        button.addEventListener('click', function() {
            const modalId = this.getAttribute('data-modal-target');
            const modal = document.querySelector(modalId);
            if (modal) {
                modal.style.display = 'block';
            }
        });
    });

    // Đóng modal khi nhấn vào dấu x
    document.querySelectorAll('.close').forEach(span => {
        span.addEventListener('click', function() {
            this.closest('.modal').style.display = 'none';
        });
    });

    // Đóng modal khi nhấn bên ngoài modal
    window.addEventListener('click', function(event) {
        if (event.target.classList.contains('modal')) {
            event.target.style.display = 'none';
        }
    });
});

</script>
</body>
</html>
