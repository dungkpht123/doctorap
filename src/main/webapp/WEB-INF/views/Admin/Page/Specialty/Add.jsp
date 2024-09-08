<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Admin</title>
<jsp:include page="/WEB-INF/views/Admin/layout/header.jsp" />

<style>
		#imageContainer {
			border: 2px solid #ddd;
			border-radius: 10px;
			padding: 10px;
			max-width: 300px;
			background-color: #f9f9f9;
			box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
			display: none;
			/* Ban đầu ẩn đi, sẽ hiện khi có hình ảnh */
		}

		#imagePreview {
			max-width: 100%;
			height: auto;
			border-radius: 10px;
			display: block;
			margin: 0 auto;

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
				from {
					width: 100%;
				}

				to {
					width: 0;
				}
			}
		}
	</style>



</head>
<body>
    <jsp:include page="/WEB-INF/views/Admin/layout/navbar.jsp" />
    <jsp:include page="/WEB-INF/views/Admin/layout/sidebar.jsp" />
    
    
    <main id="main" class="main">

    <div class="pagetitle">
      <h1>Form Elements</h1>
      <nav>
        <ol class="breadcrumb">
          <li class="breadcrumb-item"><a href="index.html">Home</a></li>
          <li class="breadcrumb-item">Forms</li>
          <li class="breadcrumb-item active">Elements</li>
        </ol>
      </nav>
    </div><!-- End Page Title -->

    <section class="section">
      <div class="card">
            <div class="card-body">
              <h5 class="card-title">General Form Elements</h5>

              <!-- General Form Elements -->
              <form:form action="SpecialtyAdd" method="post" modelAttribute="newSpecialty" enctype="multipart/form-data">
                <div class="row mb-3">
                  <label for="inputText" class="col-sm-2 col-form-label">Tên chuyên khoa</label>
                  <div class="col-sm-10">
                    <form:input path="name" type="text" class="form-control" required="required"/>
                  </div>
                </div>
                
                
                
                <div class="row mb-3">
                  <label for="inputPassword" class="col-sm-2 col-form-label">Mô tả</label>
                  <div class="col-sm-10">
                    <form:textarea path="description" class="form-control" style="height: 100px"></form:textarea>
                  </div>
                </div>
                
               
                <div class="row mb-3">
                  <label class="col-sm-2 col-form-label">Icon</label>
                  <div class="col-sm-10">
                    <form:select path="icon" class="form-select fa" aria-label="Default select example" required="required">
                      <option class="form-select fa" value="fas fa-user-md">&#xf0f0;</option>
                      <option class="form-select fa" value="fas fa-syringe">&#xf48e;</option>
                      <option class="form-select fa" value="fas fa-briefcase-medical">&#xf469;</option>
                      <option class="form-select fa" value="fas fa-brain">&#xf5dc;</option>
                      <option class="form-select fa" value="fas fa-heartbeat">&#xf21e;</option>
                      <option class="form-select fa" value="fas fa-tooth">&#xf5c9;</option>
                      <option class="form-select fa" value="fas fa-x-ray">&#xf497;</option>
                      <option class="form-select fa" value="fas fa-diagnoses">&#xf470;</option>
                      <option class="form-select fa" value="fas fa-baby">&#xf77c;</option>
                      <option class="form-select fa" value="fas fa-dna">&#xf471;</option>
                    </form:select>
                  </div>
                </div>
                			
				<div class="row mb-3">
					<label for="formFile" class="col-sm-2 col-form-label">File
						Upload</label>
					<div class="col-sm-10">
    						<input class="form-control" type="file" id="formFile" name="file" onchange="previewImage(event)" />
					</div>
				</div>
				
				<div class="row mb-3">
					<div class="col-sm-2"></div>
					<div class="col-sm-10">
						<div id="imageContainer">
							<img id="imagePreview" src="" alt="Image Preview" />
						</div>
					</div>
				</div>
				
				
                <div class="row mb-3">
                  <label class="col-sm-2 col-form-label"></label>
                  <div class="col-sm-10">
                   <input type="submit" class="btn btn-primary me-2" value="Submit" />
                  </div>
                </div>
              </form:form><!-- End General Form Elements -->

            </div>
      </div>

    </section>

  </main><!-- End #main -->
    
    
	<jsp:include page="/WEB-INF/views/Admin/layout/footer.jsp" />
	<jsp:include page="/WEB-INF/views/Admin/layout/script.jsp" />
	<!-- Notification Script -->
	<script type="text/javascript">
		function previewImage(event) {
			var input = event.target;
			var reader = new FileReader();
			reader.onload = function () {
				var dataURL = reader.result;
				var imagePreview = document.getElementById('imagePreview');
				var imageContainer = document.getElementById('imageContainer');
				imagePreview.src = dataURL;
				imageContainer.style.display = 'block'; // Hiển thị container khi có hình ảnh
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
	</script>
	
</body>
</html>