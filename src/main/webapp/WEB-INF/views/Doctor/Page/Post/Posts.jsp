<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html lang="vi">
<head>
<meta charset="UTF-8">
<title>Bài viết</title>
<jsp:include page="/WEB-INF/views/Doctor/layout/header.jsp" />
<style>
.img-blog {
    width: 100%; /* Ensure image covers the container width */
    height: 200px; /* Fixed height for uniformity */
    object-fit: cover; /* Maintain aspect ratio while covering the container */
    border-radius: 0.5rem; /* Optional: Rounded corners for a modern look */
}

/* Recent Posts Section */
.section-title {
    position: relative;
    padding-bottom: 1rem;
    margin-bottom: 1rem;
}

.section-title h3 {
    font-size: 1.5rem;
    font-weight: 600;
    color: #007bff; /* Màu chính của tiêu đề */
}

.section-title-divider {
    position: absolute;
    left: 0;
    bottom: 0;
    width: 50px;
    height: 4px;
    background-color: #007bff; /* Màu của đường viền dưới tiêu đề */
    border-radius: 2px;
}

/* Item Container */
.recent-post-item {
    border-bottom: 1px solid #dee2e6; /* Đường viền giữa các bài viết */
    padding: 10px;
    display: flex;
    align-items: center;
    background-color: #f8f9fa; /* Màu nền */
    border-radius: 5px; /* Bo góc cho phần tử */
}
/* Post Details */
.post-details {
    flex: 1;
    display: flex;
    flex-direction: column;
    justify-content: space-between;
}

/* Title Link */
.post-title {
    font-size: 1rem;
    font-weight: 600;
    color: #333; /* Màu chữ */
    text-decoration: none;
    display: flex;
    align-items: center;
    overflow: hidden;
    white-space: nowrap;
    text-overflow: ellipsis; /* Hiển thị dấu ... khi tiêu đề quá dài */
}

.post-title:hover {
    color: #007bff; /* Màu chữ khi hover */
}

/* CSS cho mô tả ngắn */
.post-description {
    font-size: 0.875rem; /* Kích thước chữ */
    color: #6c757d; /* Màu chữ */
    display: -webkit-box;
    -webkit-line-clamp: 2; /* Số dòng để hiển thị */
    -webkit-box-orient: vertical;
    overflow: hidden;
    text-overflow: ellipsis;
    white-space: normal; /* Cho phép văn bản xuống dòng */
    line-height: 1.4; /* Chiều cao dòng */
    max-height: 3.8rem; /* Chiều cao tối đa để phù hợp với số dòng */
}
/* Blog Image */
.img-blogs {
    width: 100px;
    height: 100px;
    object-fit: cover;
    border-radius: 5px; /* Bo góc ảnh */
    margin-right: 15px; /* Khoảng cách giữa ảnh và tiêu đề */
}
</style>

</head>

<body>
	<jsp:include page="/WEB-INF/views/Doctor/layout/navbar.jsp" />

	<!-- Navbar Start -->


    <div class="container-fluid bg-primary py-5 text-center"
        style="background: linear-gradient(rgba(9, 30, 62, 0.7), rgba(9, 30, 62, 0.7)), url('${contextPath}/resources/asset/img/carousel-1.jpg') center center no-repeat; background-size: cover; min-height: 400px;">
        <div class="row py-5">
            <div class="col-12">
                <h1 class="display-4 text-white animated zoomIn">Danh Sách Blog</h1>
                <nav aria-label="breadcrumb">
                    <ol class="breadcrumb justify-content-center">
                        <li class="breadcrumb-item"><a href="${contextPath}/" class="text-white">Trang Chủ</a></li>
                        <li class="breadcrumb-item active" aria-current="page">Danh Sách Blog</li>
                    </ol>
                </nav>
            </div>
        </div>
    </div>

<!-- Navbar End -->


	<!-- Blog Start -->
	<div class="container-fluid py-5 wow fadeInUp" data-wow-delay="0.1s">
		<div class="container py-5">
			<div class="row g-5">
				<!-- Blog list Start -->
				<div class="col-lg-8">
				    <div class="row g-5">
				        <c:forEach var="blog" items="${blogs}">
				            <div class="col-md-6 wow slideInUp" data-wow-delay="0.1s">
				                <div class="blog-item bg-light rounded overflow-hidden">
				                    <div class="blog-img position-relative overflow-hidden">
				                        <img class="img-blog img-fluid" src="${contextPath}${blog.imageUrl}" alt="Ảnh Blog">
				                        <a class="position-absolute top-0 start-0 bg-primary text-white rounded-end mt-5 py-2 px-4" href="${contextPath}/bai-viet/${blog.id}">Chi Tiết</a>
				                    </div>
				                    <div class="p-4">
				                        <div class="d-flex mb-3">
				                            <small class="me-3"><i class="far fa-user text-primary me-2"></i>Bác sĩ</small>
				                            <small><i class="far fa-calendar-alt text-primary me-2"></i>${blog.createdAt}</small>
				                        </div>
				                        <h4 class="mb-3">${blog.title}</h4>
				                        <p style="font-size: 15px; overflow: hidden; text-overflow: ellipsis; display: -webkit-box; -webkit-line-clamp: 2; -webkit-box-orient: vertical;">${blog.shortDescription}</p>
				                        <a class="text-uppercase" href="${contextPath}/bai-viet/${blog.id}">Chi Tiết <i class="bi bi-arrow-right"></i></a>
				                    </div>
				                </div>
				            </div>
				        </c:forEach>
				        <!-- Pagination -->
				        <div class="col-12 wow slideInUp" data-wow-delay="0.1s">
				            <nav aria-label="Page navigation">
				                <ul class="pagination pagination-lg m-0">
				                    <!-- Previous Button -->
				                    <c:if test="${currentPage > 0}">
				                        <li class="page-item"><a class="page-link rounded-0"
				                            href="${contextPath}/bai-viet?page=${currentPage - 1}&size=${size}"
				                            aria-label="Previous"> <span aria-hidden="true"><i
				                                class="bi bi-arrow-left"></i></span>
				                        </a></li>
				                    </c:if>
				                    <!-- Page Numbers -->
				                    <c:forEach var="i" begin="0" end="${totalPages - 1}">
				                        <li class="page-item ${i == currentPage ? 'active' : ''}">
				                            <a class="page-link" href="${contextPath}/bai-viet?page=${i}&size=${size}">${i + 1}</a>
				                        </li>
				                    </c:forEach>
				                    <!-- Next Button -->
				                    <c:if test="${currentPage < totalPages - 1}">
				                        <li class="page-item"><a class="page-link rounded-0"
				                            href="${contextPath}/bai-viet?page=${currentPage + 1}&size=${size}"
				                            aria-label="Next"> <span aria-hidden="true"><i
				                                class="bi bi-arrow-right"></i></span>
				                        </a></li>
				                    </c:if>
				                </ul>
				            </nav>
				        </div>
				    </div>
				</div>
				<!-- Blog list End -->

				<!-- Sidebar Start -->
				<div class="col-lg-4">
					<!-- Search Form Start -->
					<div class="mb-5 wow slideInUp" data-wow-delay="0.1s">
						<div class="input-group">
							<input type="text" class="form-control p-3" placeholder="Tìm kiếm từ khóa">
							<button class="btn btn-primary px-4"><i class="bi bi-search"></i></button>
						</div>
					</div>
					<!-- Search Form End -->
					
						 <!-- Recent Posts Start -->
							<div class="mb-5 wow slideInUp" data-wow-delay="0.1s">
							    <div class="section-title section-title-sm position-relative pb-3 mb-4">
							        <h3 class="mb-0 text-primary">Bài Viết Mới</h3>
							        <hr class="section-title-divider">
							    </div>
							    <c:forEach var="recentBlog" items="${blogs}">
							        <div class="recent-post-item d-flex rounded overflow-hidden mb-3">
							            <img class="img-blogs img-fluid" src="${contextPath}${recentBlog.imageUrl}"
							                alt="Ảnh Blog">
							            <div class="post-details d-flex flex-column justify-content-between p-2">
							                <a href="${contextPath}/bai-viet/${recentBlog.id}"
							                    class="post-title d-flex align-items-center mb-2">${recentBlog.title}</a>
							                <p class="post-description">${recentBlog.shortDescription}</p>
							            </div>
							        </div>
							    </c:forEach>
							</div>
							<!-- Recent Posts End -->

						</div>
						<!-- Recent Posts End -->
				</div>
				<!-- Sidebar End -->
			</div>
		</div>
	</div>
	<!-- Blog End -->

	<jsp:include page="/WEB-INF/views/Doctor/layout/footer.jsp" />
	<jsp:include page="/WEB-INF/views/Doctor/layout/script.jsp" />
</body>
</html>
