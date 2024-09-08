<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Chi Tiết Blog</title>
    <jsp:include page="/WEB-INF/views/Doctor/layout/header.jsp"/>
    <style type="text/css">
    .post-description {
        font-size: 0.875rem;
        color: #6c757d;
        display: -webkit-box;
        -webkit-line-clamp: 2;
        -webkit-box-orient: vertical;
        overflow: hidden;
        text-overflow: ellipsis;
        white-space: normal;
        line-height: 1.4;
        max-height: 3rem;
    }
  
    .blog-detail-content img {
        max-width: 100%;
        height: auto;
    }
    .breadcrumb {
        justify-content: center;
    }
    </style>
</head>
<body>
    <jsp:include page="/WEB-INF/views/Doctor/layout/navbar.jsp" />
    
    <!-- Banner Start -->
    <div class="container-fluid bg-primary py-5 text-center"
        style="background: linear-gradient(rgba(9, 30, 62, 0.7), rgba(9, 30, 62, 0.7)), url('${contextPath}/resources/asset/img/carousel-1.jpg') center center no-repeat; background-size: cover; min-height: 400px;">
        <div class="row py-5">
            <div class="col-12">
                <h1 class="display-4 text-white animated zoomIn">${blog.title}</h1>
                <nav aria-label="breadcrumb">
                    <ol class="breadcrumb justify-content-center">
                        <li class="breadcrumb-item"><a href="${contextPath}/" class="text-white">Trang Chủ</a></li>
                        <li class="breadcrumb-item"><a href="${contextPath}/bai-viet" class="text-white">Danh Sách Blog</a></li>
                        <li class="breadcrumb-item active" aria-current="page">${blog.title}</li>
                    </ol>
                </nav>
            </div>
        </div>
    </div>
    <!-- Banner End -->

    <!-- Blog Details Start -->
    <div class="container-fluid py-5">
        <div class="container py-5">
            <div class="row g-5">
                <div class="col-lg-8 mx-auto">
                    <!-- Blog Detail -->
                    <div class="blog-detail-content mb-5">
                       
                        <h2 class="mb-4">${blog.title}</h2>
                        <p class="text-muted mb-4">${blog.shortDescription}</p>
                        <p>${blog.content}</p>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- Blog Details End -->

    <!-- Vendor Start -->
    <div class="container-fluid py-5">
        <div class="container py-5 mb-5">
            <div class="bg-white rounded p-4">
                <div class="owl-carousel vendor-carousel">
                    <img src="${contextPath}/resources/asset/img/vendor-1.jpg" alt="Vendor 1">
                    <img src="${contextPath}/resources/asset/img/vendor-2.jpg" alt="Vendor 2">
                    <img src="${contextPath}/resources/asset/img/vendor-3.jpg" alt="Vendor 3">
                    <img src="${contextPath}/resources/asset/img/vendor-4.jpg" alt="Vendor 4">
                    <img src="${contextPath}/resources/asset/img/vendor-5.jpg" alt="Vendor 5">
                    <img src="${contextPath}/resources/asset/img/vendor-6.jpg" alt="Vendor 6">
                    <img src="${contextPath}/resources/asset/img/vendor-7.jpg" alt="Vendor 7">
                    <img src="${contextPath}/resources/asset/img/vendor-8.jpg" alt="Vendor 8">
                    <img src="${contextPath}/resources/asset/img/vendor-9.jpg" alt="Vendor 9">
                </div>
            </div>
        </div>
    </div>
    <!-- Vendor End -->

    <!-- Back to Top -->
    <a href="#" class="btn btn-lg btn-primary btn-lg-square rounded-circle back-to-top">
        <i class="bi bi-arrow-up"></i>
    </a>

    <jsp:include page="/WEB-INF/views/Doctor/layout/footer.jsp"/>
    <jsp:include page="/WEB-INF/views/Doctor/layout/script.jsp"/>
</body>
</html>
