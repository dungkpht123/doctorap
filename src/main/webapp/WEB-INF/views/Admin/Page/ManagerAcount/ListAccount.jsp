<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Admin - Danh sách tài khoản</title>
    <jsp:include page="/WEB-INF/views/Admin/layout/header.jsp" />
    <link rel="stylesheet" href="${contextPath}/resources/css/acc.css">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
     <style>
        .toast-container {
            position: fixed;
            top: 1rem;
            right: 1rem;
            z-index: 1100;
        }
        .toast {
            min-width: 250px;
            margin-bottom: 0.5rem;
        }
    </style>
</head>
<body>
	
    <jsp:include page="/WEB-INF/views/Admin/layout/navbar.jsp" />
    <jsp:include page="/WEB-INF/views/Admin/layout/sidebar.jsp" />
    
    <main id="main" class="main">
        <div class="pagetitle">
            <h1>Danh sách tài khoản người dùng</h1>
            <nav>
                <ol class="breadcrumb">
                    <li class="breadcrumb-item"><a href="${contextPath}/admin">Trang chủ</a></li>
                    <li class="breadcrumb-item active">Danh sách tài khoản người dùng</li>
                </ol>
            </nav>
            <button type="button" class="btn btn-primary" data-toggle="modal" data-target="#addUserModal">
                Thêm tài khoản mới
            </button>
        </div>

        <section class="section dashboard">
            <div class="row">
                <!-- Table with stripped rows -->
                <table class="table datatable">
                    <thead>
                        <tr>
                            <th>STT</th>
                            <th>Tên</th>
                            <th>Email</th>
                            <th>Giới tính</th>
                            <th>Địa chỉ</th>
                            <th>Số điện thoại</th>
                            <th>Vai trò</th>
                            <th>Trạng thái</th>
                            <th>Chức năng</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach items="${users}" var="user">
                            <tr>
                                <th scope="row">${user.id}</th>
                                <td>${user.userName}</td>
                                <td>${user.email}</td>
                                <td>${user.gender}</td>
                                <td>${user.address}</td>
                                <td>${user.phoneNumber}</td>
                                <td>
								    <c:set var="roleOrder" value="ROLE_USER,ROLE_DOCTOR,ROLE_ADMIN" />
								    <c:forEach var="orderRole" items="${roleOrder.split(',')}" varStatus="status">
								        <c:forEach var="role" items="${user.accountRoles}">
								            <c:if test="${role.role eq orderRole}">
								                <a class="role-btn ${role.role}">${role.role}</a>
								                
								            </c:if>
								        </c:forEach>
								    </c:forEach>
								</td>
								<td>${user.status}</td>
                                <td>
                                    <a class="btn btn-warning btn-sm" href="${contextPath}/admin/quan-ly-tai-khoan/update/${user.id}">
									    <i class="fa fa-edit"></i> Update
									</a>
                                    <a class="btn btn-danger btn-sm"  onclick="showConfirmModal('${contextPath}/admin/quan-ly-tai-khoan/delete/${user.id}'); return false;">
                                        <i class="fa fa-trash"></i> Xóa
                                    </a>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
                <!-- End Table with stripped rows -->
            </div>
        </section>
    </main>

    <!-- Modal Add -->
        <div class="modal fade" id="addUserModal" tabindex="-1" role="dialog" aria-labelledby="addUserModalLabel" aria-hidden="true">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="addUserModalLabel">Thêm tài khoản mới</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <form action="${contextPath}/admin/quan-ly-tai-khoan/add" method="post">
                            <div class="form-group">
                                <label for="userName">Tên:</label>
                                <input type="text" id="userName" name="userName" class="form-control" required />
                            </div>
                            <div class="form-group">
                                <label for="email">Email:</label>
                                <input type="email" id="email" name="email" class="form-control" required />
                            </div>
                            <div class="form-group">
                                <label for="password">Password:</label>
                                <input type="password" id="password" name="password" class="form-control" required />
                            </div>
                            <div class="form-group">
                                <label for="role">Vai trò:</label>
                                <select id="role" name="role" class="form-control" required>
                                    <option value="ROLE_USER">User</option>
                                    <option value="ROLE_ADMIN">Admin</option>
                                    <option value="ROLE_DOCTOR">Doctor</option>
                                </select>
                            </div>
                            <button type="submit" class="btn btn-primary">Thêm tài khoản</button>
                            <button type="button" class="btn btn-secondary" data-dismiss="modal">Hủy</button>
                        </form>
                    </div>
                </div>
            </div>
        </div>

        

        <!-- Modal Delete -->
        <div class="modal fade" id="confirmModal" tabindex="-1" role="dialog" aria-labelledby="confirmModalLabel" aria-hidden="true">
		    <div class="modal-dialog" role="document">
		        <div class="modal-content">
		            <div class="modal-header">
		                <h5 class="modal-title" id="confirmModalLabel">Xác nhận hành động</h5>
		                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
		                    <span aria-hidden="true">&times;</span>
		                </button>
		            </div>
		            <div class="modal-body">
		                Bạn có chắc chắn muốn thực hiện hành động này không?
		            </div>
		            <div class="modal-footer">
		                <a id="deleteAction" class="btn btn-danger" href="#">Xóa</a>
		                <button type="button" class="btn btn-secondary" data-dismiss="modal">Hủy</button>
		            </div>
		        </div>
		    </div>
		</div>
	<div class="toast-container">
        <!-- Success Toast -->
        <div class="toast bg-success text-white" id="successToast" role="alert" aria-live="assertive" aria-atomic="true">
            <div class="toast-header">
                <strong class="mr-auto">Thành công</strong>
                <button type="button" class="ml-2 mb-1 close" data-dismiss="toast" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="toast-body">
                ${successMessage}
            </div>
        </div>

        <!-- Error Toast -->
        <div class="toast bg-danger text-white" id="errorToast" role="alert" aria-live="assertive" aria-atomic="true">
            <div class="toast-header">
                <strong class="mr-auto">Lỗi</strong>
                <button type="button" class="ml-2 mb-1 close" data-dismiss="toast" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="toast-body">
                ${errorMessage}
            </div>
        </div>
    </div>
        
       
   
    
    <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    <jsp:include page="/WEB-INF/views/Admin/layout/footer.jsp" />
    <jsp:include page="/WEB-INF/views/Admin/layout/script.jsp" />
    <script>
    $(document).ready(function() {
        
        <c:if test="${not empty successMessage}">
            $('#successToast .toast-body').text("${successMessage}");
            $('#successToast').toast({ delay: 2000 }).toast('show');
        </c:if>
        
        <c:if test="${not empty errorMessage}">
            $('#errorToast .toast-body').text("${errorMessage}");
            $('#errorToast').toast({ delay: 2000 }).toast('show');
        </c:if>
    });

        function showConfirmModal(actionUrl) {
            $('#confirmModal').modal('show');
            $('#deleteAction').attr('href', actionUrl);
        }
    </script>
</body>
</html>

