<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>Sửa bài viết</title>
    <jsp:include page="/WEB-INF/views/Admin/layout/header.jsp" />
    <style>
        #imageContainer {
            border: 2px solid #ddd;
            border-radius: 10px;
            padding: 10px;
            max-width: 300px;
            background-color: #f9f9f9;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            display: none; /* Ban đầu ẩn đi, sẽ hiện khi có hình ảnh */
        }

        #imagePreview {
            max-width: 100%;
            height: auto;
            border-radius: 10px;
            display: block;
            margin: 0 auto;
        }

        #notificationContainer {
            position: fixed;
            bottom: 20px;
            right: 20px;
            z-index: 1000;
            width: 300px;
        }

        .notification {
            background-color: #4caf50;
            color: white;
            padding: 15px;
            margin-top: 10px;
            border-radius: 5px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            position: relative;
            overflow: hidden;
        }

        .notification.error {
            background-color: #f44336;
        }

        .notification .progress-bar {
            position: absolute;
            bottom: 0;
            left: 0;
            height: 5px;
            background-color: rgba(255, 255, 255, 0.7);
            width: 100%;
            animation: progress 5s linear forwards;
        }

        @keyframes progress {
            from { width: 100%; }
            to { width: 0; }
        }
    </style>
</head>
<body>
    <jsp:include page="/WEB-INF/views/Admin/layout/navbar.jsp" />
    <jsp:include page="/WEB-INF/views/Admin/layout/sidebar.jsp" />
    <div id="notificationContainer"></div>
    
     <main id="main" class="main">
        <section class="section">
            <div class="row">
                <div class="col-lg-12">
                    <div class="card">
                        <div class="card-body">
                            <h2 class="card-title text-center">Sửa bài viết</h2>

                            <c:if test="${not empty successMessage}">
                                <div class="alert alert-success text-center">
                                    <c:out value="${successMessage}" />
                                </div>
                            </c:if>

                            <c:if test="${not empty error}">
                                <div class="alert alert-danger text-center">
                                    <c:out value="${error}" />
                                </div>
                            </c:if>

                            <!-- General Form Elements -->
                            <form:form action="${contextPath}/admin/Post/edit" method="post" enctype="multipart/form-data" modelAttribute="post">
                                <input type="hidden" name="id" value="${post.id}" /> <!-- Add hidden field for ID -->

                                <div class="row mb-3">
                                    <label for="title" class="col-sm-2 col-form-label">Tiêu đề</label>
                                    <div class="col-sm-10">
                                        <form:input type="text" class="form-control" path="title" id="title" oninput="generateSlug()" />
                                          <!-- Error handling for the 'title' field -->
                                        <form:errors path="title" cssClass="text-danger" />
                                    </div>
                                </div>
                                <div class="row mb-3">
                                    <label for="url" class="col-sm-2 col-form-label">Đường dẫn</label>
                                    <div class="col-sm-10">
                                        <form:input type="text" path="url" class="form-control" id="url" />
                                          <!-- Error handling for the 'url' field -->
                                        <form:errors path="url" cssClass="text-danger" />
                                    </div>
                                </div>

								<div class="row mb-3">
									<label for="formFile" class="col-sm-2 col-form-label">File
										Upload</label>
									<div class="col-sm-10">
										<input class="form-control" type="file" id="formFile"
											name="file" onchange="previewImage(event)"  value="${contextPath }${post.imageUrl}"/>
										<c:if test="${not empty post.imageUrl}">
											<input type="hidden" id="imageUrl" value="${contextPath }${post.imageUrl}">
											<div id="imageContainer" style="display: block;">
												<img id="imagePreview" src="${contextPath }${post.imageUrl}"
													alt="Image Preview">
											</div>
										</c:if>
									</div>
								</div>

								<div class="row mb-3">
                                    <label for="shortDescription" class="col-sm-2 col-form-label">Mô tả ngắn</label>
                                    <div class="col-sm-10">
                                    
                                        <form:textarea class="form-control" style="height: 100px" path="shortDescription" id="shortDescription"></form:textarea>
                                    	  <!-- Error handling for the 'shortDescription' field -->
                                        <form:errors path="shortDescription" cssClass="text-danger" />
                                    </div>
                                </div>
                                <div class="row mb-3">
                                    <label for="content" class="col-sm-2 col-form-label">Nội dung bài viết</label>
                                    <div class="col-sm-10">
                                        <!-- TinyMCE Editor -->
                                        <form:textarea class="tinymce-editor" path="content" id="content"></form:textarea>
                                        <!-- End TinyMCE Editor -->
                                          <!-- Error handling for the 'content' field -->
                                        <form:errors path="content" cssClass="text-danger" />
                                    </div>
                                </div>
                                <fieldset class="row mb-3">
                                    <legend class="col-form-label col-sm-2 pt-0">Trạng thái</legend>
                                    <div class="col-sm-10">
                                        <div class="form-check form-check-inline">
                                            <form:radiobutton path="status" value="1" cssClass="form-check-input" id="gridRadios1" />
                                            <label class="form-check-label" for="gridRadios1">Hiện bài</label>
                                        </div>
                                        <div class="form-check form-check-inline">
                                            <form:radiobutton path="status" value="0" cssClass="form-check-input" id="gridRadios2" />
                                            <label class="form-check-label" for="gridRadios2">Ẩn bài</label>
                                        </div>
                                    </div>
                                </fieldset>

                                <div class="row mb-3">
                                    <label class="col-sm-2 col-form-label">Chuyên khoa</label>
                                    <div class="col-sm-10">
                                        <form:select path="specialty.id" class="form-select" aria-label="Default select example">
                                            <option value="" selected>Chọn chuyên khoa</option>
                                            <form:options items="${specialtyList}" itemLabel="name" itemValue="id" />
                                        </form:select>
                                    </div>
                                </div>

                                <div class="row mb-3">
                                    <div class="col-sm-10 d-flex justify-content-center">
                                        <input type="submit" class="btn btn-primary me-2" value="Submit" />
                                        <input type="reset" value="Reset" class="btn btn-secondary" />
                                    </div>
                                </div>
                            </form:form>
                            <!-- End General Form Elements -->
                        </div>
                    </div>
                </div>
            </div>
        </section>
    </main>
    <jsp:include page="/WEB-INF/views/Admin/layout/footer.jsp" />
    <jsp:include page="/WEB-INF/views/Admin/layout/script.jsp" />

    <!-- Notification Script -->
    <script type="text/javascript">
    document.addEventListener('DOMContentLoaded', function () {
        var imageUrl = document.getElementById('imageUrl')?.value;
        if (imageUrl) {
            var imagePreview = document.getElementById('imagePreview');
            var imageContainer = document.getElementById('imageContainer');
            imagePreview.src = imageUrl;
            imageContainer.style.display = 'block'; // Hiển thị khung chứa hình ảnh
        }
    });

    function previewImage(event) {
        console.log("File input changed"); // Debugging line
        var input = event.target;
        var reader = new FileReader();
        reader.onload = function(){
            var dataURL = reader.result;
            var imagePreview = document.getElementById('imagePreview');
            var imageContainer = document.getElementById('imageContainer');
            imagePreview.src = dataURL;
            imageContainer.style.display = 'block'; // Hiển thị khung chứa hình ảnh khi hình ảnh được tải lên
        };
        reader.readAsDataURL(input.files[0]);
    }

        function generateSlug() {
            let title = document.getElementById('title').value;
            let slug = title.toLowerCase()
                            .replace(/á|à|ả|ã|ạ|â|ấ|ầ|ẩ|ẫ|ậ|ă|ắ|ằ|ẳ|ẵ|ặ|đ/g, 'a')
                            .replace(/é|è|ẻ|ẽ|ẹ|ê|ế|ề|ể|ễ|ệ/g, 'e')
                            .replace(/í|ì|ỉ|ĩ|ị/g, 'i')
                            .replace(/ó|ò|ỏ|õ|ọ|ô|ố|ồ|ổ|ỗ|ộ|ơ|ớ|ờ|ở|ỡ|ợ/g, 'o')
                            .replace(/ú|ù|ủ|ũ|ụ|ư|ứ|ừ|ử|ữ|ự/g, 'u')
                            .replace(/ý|ỳ|ỷ|ỹ|ỵ/g, 'y')
                            .replace(/[^a-z0-9\s-]/g, '') // Loại bỏ ký tự đặc biệt
                            .replace(/\s+/g, '-') // Thay thế khoảng trắng bằng dấu gạch ngang
                            .replace(/-+/g, '-'); // Loại bỏ dấu gạch ngang thừa
            document.getElementById('url').value = slug;
        }

        function showNotification(message, type) {
            // Create notification element
            const notification = document.createElement('div');
            notification.className = 'notification';
            
            if (type === 'error') {
                notification.classList.add('error');
            }
            
            notification.innerHTML = `
                <span>${message}</span>
                <div class="progress-bar"></div>
            `;

            // Append notification to container
            document.getElementById('notificationContainer').appendChild(notification);

            // Remove notification after 5 seconds
            setTimeout(() => {
                notification.style.opacity = '0';
                setTimeout(() => notification.remove(), 600); // 600ms for the fade out
            }, 5000); // 5 seconds
        }

        // Trigger notifications based on JSP conditions
        <c:if test="${not empty successMessage}">
            showNotification('${fn:escapeXml(successMessage)}', 'success');
        </c:if>

        <c:if test="${not empty error}">
            showNotification('${fn:escapeXml(error)}', 'error');
        </c:if>
    </script>
</body>
</html>
