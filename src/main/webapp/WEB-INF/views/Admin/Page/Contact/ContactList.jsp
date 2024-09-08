<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Admin</title>
<jsp:include page="/WEB-INF/views/Admin/layout/header.jsp" />


</head>
<body>
	<jsp:include page="/WEB-INF/views/Admin/layout/navbar.jsp" />
	<jsp:include page="/WEB-INF/views/Admin/layout/sidebar.jsp" />



	<!-- start main -->

	<main id="main" class="main">
		<section class="section">
			<div class="row">
				<div class="col-lg-12">

					<div class="card">
						<div class="card-body">
							<h5 class="card-title">Thông tin liên hệ</h5>
							<div class="d-flex justify-content-end"></div>
							<!-- Table with stripped rows -->
							<table class="table datatable">
								<thead>
									<tr>
										<th>ID</th>
										<th>Tên người dùng</th>
										<th>Email</th>
										<th>Tiêu đề</th>
										<th>Nội dung</th>
										<th>Thao tác</th>
									</tr>
								</thead>
								<tbody>
									
									
									<c:forEach items="${contacts}" var="contact">
										<tr>
											<td>${contact.id}</td>
						                    <td>${contact.account.userName}</td>
						                    <td>${contact.account.email}</td>
						                    <td>${contact.subject}</td>
						                    <td>${contact.message}</td>			
											<td>
							                   <button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#responseModal" data-contact-id="${contact.id}" data-contact-subject="${contact.subject}" data-contact-message="${contact.message}" data-contact-email="${contact.account.email}">
							                       Phản hồi
							                   </button>
							               </td>
										</tr>
									</c:forEach>


								</tbody>
							</table>
							<!-- End Table with stripped rows -->

						</div>
					</div>

				</div>
			</div>
		</section>
	</main>

	<!-- end main -->
	
	<!-- Modal -->
	<div class="modal fade" id="responseModal" tabindex="-1" aria-labelledby="responseModalLabel" aria-hidden="true">
	    <div class="modal-dialog">
	        <div class="modal-content">
	            <div class="modal-header">
	                <h5 class="modal-title" id="responseModalLabel">Phản hồi liên hệ</h5>
	                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
	            </div>
	            <div class="modal-body">
	                <form id="responseForm">
	                    <div class="mb-3">
	                        <label for="contactSubject" class="form-label">Tiêu đề</label>
	                        <input type="text" class="form-control" id="contactSubject" readonly>
	                    </div>
	                    <div class="mb-3">
	                        <label for="contactMessage" class="form-label">Nội dung</label>
	                        <textarea class="form-control" id="contactMessage" rows="3" readonly></textarea>
	                    </div>
	                    <div class="mb-3">
	                        <label for="responseText" class="form-label">Trả lời</label>
	                        <textarea class="form-control" id="responseText" rows="3" required></textarea>
	                    </div>
	                    <input type="hidden" id="contactId" name="contactId">
	                    <input type="hidden" id="contactEmail" name="contactEmail">
	                    <button type="submit" class="btn btn-primary">Gửi</button>
	                </form>
	            </div>
	        </div>
	    </div>
	</div>

	<script>
	document.addEventListener('DOMContentLoaded', function () {
	    var responseModal = document.getElementById('responseModal');
	    responseModal.addEventListener('show.bs.modal', function (event) {
	        var button = event.relatedTarget;
	        var contactId = button.getAttribute('data-contact-id');
	        var contactSubject = button.getAttribute('data-contact-subject');
	        var contactMessage = button.getAttribute('data-contact-message');
	        var contactEmail = button.getAttribute('data-contact-email');
	        
	        var modalSubject = responseModal.querySelector('#contactSubject');
	        var modalMessage = responseModal.querySelector('#contactMessage');
	        var modalResponseText = responseModal.querySelector('#responseText');
	        var modalContactId = responseModal.querySelector('#contactId');
	        var modalContactEmail = responseModal.querySelector('#contactEmail');
	        
	        modalSubject.value = contactSubject;
	        modalMessage.textContent = contactMessage;
	        modalResponseText.value = '';
	        modalContactId.value = contactId;
	        modalContactEmail.value = contactEmail;
	    });
	
	    var responseForm = document.getElementById('responseForm');
	    responseForm.addEventListener('submit', function (event) {
	        event.preventDefault();
	
	        var contactId = document.getElementById('contactId').value;
	        var responseText = document.getElementById('responseText').value;
	        var contactEmail = document.getElementById('contactEmail').value;
	
	        fetch('${contextPath}/xuly-phan-hoi', {
	            method: 'POST',
	            headers: {
	                'Content-Type': 'application/x-www-form-urlencoded'
	            },
	            body: new URLSearchParams({
	                contactId: contactId,
	                response: responseText,
	                email: contactEmail
	            })
	        })
	        .then(response => response.text())
	        .then(result => {
	            // Xử lý kết quả, ví dụ thông báo thành công
	            alert('Phản hồi đã được gửi.');
	            var modal = bootstrap.Modal.getInstance(responseModal);
	            modal.hide();
	        })
	        .catch(error => {
	            console.error('Error:', error);
	        });
	    });
	});
	</script>



	<jsp:include page="/WEB-INF/views/Admin/layout/footer.jsp" />
	<jsp:include page="/WEB-INF/views/Admin/layout/script.jsp" />

</body>
</html>