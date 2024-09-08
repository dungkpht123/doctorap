<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Danh sách các bài viết</title>

<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.4/dist/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

<jsp:include page="/WEB-INF/views/Admin/layout/header.jsp" />
<style type="text/css">
.custom-title {
        text-transform: uppercase;
        text-align: center;
        font-size: 2rem; /* Adjust the font size as needed */
    }
    

.d-flex.justify-content-end {
    margin-bottom: 20px; /* Khoảng cách dưới để tạo không gian giữa nút và bảng */
}

.d-flex.justify-content-end .btn-primary {
    font-size: 1rem; /* Điều chỉnh kích thước font cho nút */
    padding: 10px 20px; /* Thêm padding cho nút để nút lớn hơn */
    border-radius: 5px; /* Thêm góc bo cho nút */
    margin-right: 10px; /* Khoảng cách giữa nút và phần tử khác (nếu có) */
}
</style>
</head>
<body>
	<jsp:include page="/WEB-INF/views/Admin/layout/navbar.jsp" />
	<jsp:include page="/WEB-INF/views/Admin/layout/sidebar.jsp" />
	<main id="main" class="main">
		<section class="section">
			<div class="row">
				<div class="col-lg-12">

					<div class="card">
						<div class="card-body">
							<h2 class="card-title text-center custom-title">Quản lý bài viết</h2>
							<div class="d-flex justify-content-end">
							    <a href="${contextPath}/Post/create" class="btn btn-primary btn-lg"> 
							        <i class="fa fa-plus-circle" aria-hidden="true"></i> Thêm mới
							    </a>
							</div>

							<!-- Table with stripped rows -->
							<table class="table datatable">
								<thead>
									<tr>
										<th>STT</th>
										<th>Tiêu đề</th>
										<th>Ảnh</th>
										<th>Ngày đăng bài</th>
										<th>Chuyên khoa</th>
										<th>Trạng thái</th>
										<th>Chức năng</th>

									</tr>
								</thead>
								<tbody>
									<c:forEach items="${postList }" var="item">
										<tr>
											<th scope="row" class="justify-content-center">${item.id}</th>
											<td>${item.title }</td>
											<td><img src="${contextPath}${item.imageUrl}"
												alt="Image" style="width: 200px; height: auto; text-aligin:center;" /></td>
											<td><fmt:formatDate pattern="dd-MM-yyyy"
													value="${item.createdAt}" /></td>
											<td><c:forEach items="${specialtyList}" var="specialty">
													<c:if test="${specialty.id == item.specialty.id}">
     										       ${specialty.name}
      												  </c:if>
												</c:forEach></td>

											<td><c:choose>
													<c:when test="${item.status == 1}">
														<span class="badge bg-success">Hiện</span>
													</c:when>
													<c:otherwise>
														<span class="badge bg-danger">Ẩn</span>
													</c:otherwise>
												</c:choose></td>


											<td>
											<a href="${contextPath}/admin/Post/edit/${item.id}"
												class="btn btn-warning btn-sm"> <i class="fa fa-edit"></i>
													Sửa
											</a>
											 <a href="#" class="btn btn-danger btn-sm"
												onclick="showConfirmModal('${contextPath}/admin/Post/delete?idd=${item.id}'); return false;">
													<i class="fa fa-trash"></i> Xóa
											</a> </td>
										</tr>
									</c:forEach>
									
								</tbody>
							</table>
				<!-- Pagination Controls -->
					<nav aria-label="Page navigation example">
					    <ul class="pagination justify-content-center">
					        <!-- Nút Previous -->
					        <li class="page-item ${pageList.first ? 'disabled' : ''}">
					            <a class="page-link" href="${contextPath}/admin/Post/list?page=${pageList.number}&size=${pageList.size}" aria-label="Previous">
					                <span aria-hidden="true">&laquo;</span>
					            </a>
					        </li>
					        
					        <!-- Các trang -->
					        <c:forEach var="i" begin="1" end="${pageList.totalPages}">
					            <li class="page-item ${i == pageList.number + 1 ? 'active' : ''}">
					                <a class="page-link" href="${contextPath}/admin/Post/list?page=${i}&size=${pageList.size}">${i}</a>
					            </li>
					        </c:forEach>
					        
					        <!-- Nút Next -->
					        <li class="page-item ${pageList.last ? 'disabled' : ''}">
					            <a class="page-link" href="${contextPath}/admin/Post/list?page=${pageList.number + 2}&size=${pageList.size}" aria-label="Next">
					                <span aria-hidden="true">&raquo;</span>
					            </a>
					        </li>
					    </ul>
					</nav>

						</div>
					</div>

				</div>
			</div>
		</section>
	</main>
<!-- Modal -->
												<div class="modal fade" id="confirmModal" tabindex="-1"
													role="dialog" aria-labelledby="confirmModalLabel"
													aria-hidden="true">
													<div class="modal-dialog" role="document">
														<div class="modal-content">
															<div class="modal-header">
																<h5 class="modal-title" id="confirmModalLabel">Xác
																	nhận xóa</h5>
																<button type="button" class="close" data-dismiss="modal"
																	aria-label="Close">
																	<span aria-hidden="true">&times;</span>
																</button>
															</div>
															<div class="modal-body">Bạn có chắc chắn muốn xóa
																bài viết này không?</div>
															<div class="modal-footer">
																<button type="button" class="btn btn-secondary"
																	data-dismiss="modal">Hủy</button>
																<a id="confirmDeleteButton" class="btn btn-danger"
																	href="#">Xóa</a>
															</div>
														</div>
													</div>
												</div>
	<jsp:include page="/WEB-INF/views/Admin/layout/footer.jsp" />
	<jsp:include page="/WEB-INF/views/Admin/layout/script.jsp" />
	<script type="text/javascript">
    function showConfirmModal(url) {
        $('#confirmDeleteButton').attr('href', url);
        $('#confirmModal').modal('show');
    }
</script>


</body>
</html>