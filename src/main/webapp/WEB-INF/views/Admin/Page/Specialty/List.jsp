<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>

<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Admin</title>
    <jsp:include page="/WEB-INF/views/Admin/layout/header.jsp" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <style>
        .input-group {
            position: relative;
            display: flex;
            align-items: center;
        }

        #search-input {
            transition: width 0.3s ease-in-out;
            width: 200px; /* Chiều rộng ngắn hơn của trường nhập liệu */
            padding-right: 40px;
        }

        .search-btn {
            position: absolute;
            right: 0;
            top: 50%;
            transform: translateY(-50%);
            border: none;
            background: none;
            cursor: pointer;
            display: none; /* Ẩn nút tìm kiếm theo mặc định */
        }

        .search-btn i {
            font-size: 20px;
        }

        .input-group.active #search-input {
            width: 300px; /* Chiều rộng khi trường nhập liệu được kích hoạt */
        }

        .no-results {
            color: red;
            font-weight: bold;
        }
    </style>
</head>
<body>
    <jsp:include page="/WEB-INF/views/Admin/layout/navbar.jsp" />
    <jsp:include page="/WEB-INF/views/Admin/layout/sidebar.jsp" />
    <main id="main" class="main">

        <div class="pagetitle">
            <h1>General Tables</h1>
            <nav>
                <ol class="breadcrumb">
                    <li class="breadcrumb-item"><a href="index.html">Admin</a></li>
                    <li class="breadcrumb-item">Bảng</li>
                    <li class="breadcrumb-item active">Danh sách chuyên khoa</li>
                </ol>
            </nav>
        </div>
        <!-- End Page Title -->

        <section class="section">
            <div class="card">
                <div class="card-body">
                    <h5 class="card-title">Danh sách chuyên khoa</h5>
                    <!-- Form Tìm kiếm -->
                    <form action="${contextPath}/SpecialtyList" method="get" class="mb-3">
                        <div class="input-group" id="search-group">
                            <input type="text" name="search" id="search-input" class="form-control" placeholder="Tìm kiếm chuyên khoa" value="${param.search}">
                            <button class="search-btn" id="search-btn" type="submit">
                                <i class="fas fa-search"></i>
                            </button>
                        </div>
                    </form>

                    <!-- Hiển thị thông báo nếu không có kết quả -->
                    <c:if test="${noResults}">
                        <div class="no-results">Không có tên chuyên khoa nào khớp với tìm kiếm của bạn.</div>
                    </c:if>

                    <!-- Table with hoverable rows -->
                    <table class="table table-hover">
                        <thead>
                            <tr>
                                <th scope="col">#</th>
                                <th scope="col">Tên chuyên khoa</th>
                                <th>Ảnh</th>
                                <th scope="col">Chức năng</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach items="${specialtyList}" var="item">
                                <tr>
                                    <th scope="row">${item.id}</th>
                                    <td><i class="${item.icon}"></i> ${item.name}</td>
                                    <td><img src="${contextPath}${item.image}" style="width: 80px; height: 50px; text-align:center;" /></td>
                                    <td style="width:400px;">
                                        <a class="btn btn-primary" href="SpecialtyEdit?id=${item.id}">Sửa</a>
                                        <a class="btn btn-warning" href="SpecialtyDelete?id=${item.id}">Xoá</a>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                    <!-- End Table with hoverable rows -->

                    <!-- Pagination Controls -->
                    <nav aria-label="Page navigation example">
                        <ul class="pagination justify-content-center">
                            <!-- Nút Previous -->
                            <li class="page-item ${pageList.first ? 'disabled' : ''}">
                                <a class="page-link" href="${contextPath}/admin/SpecialtyList?page=${pageList.number}&size=${pageList.size}&search=${param.search}" aria-label="Previous">
                                    <span aria-hidden="true">&laquo;</span>
                                </a>
                            </li>

                            <!-- Các trang -->
                            <c:forEach var="i" begin="1" end="${pageList.totalPages}">
                                <li class="page-item ${i == pageList.number + 1 ? 'active' : ''}">
                                    <a class="page-link" href="${contextPath}/admin/SpecialtyList?page=${i}&size=${pageList.size}&search=${param.search}">${i}</a>
                                </li>
                            </c:forEach>

                            <!-- Nút Next -->
                            <li class="page-item ${pageList.last ? 'disabled' : ''}">
                                <a class="page-link" href="${contextPath}/admin/SpecialtyList?page=${pageList.number + 2}&size=${pageList.size}&search=${param.search}" aria-label="Next">
                                    <span aria-hidden="true">&raquo;</span>
                                </a>
                            </li>
                        </ul>
                    </nav>

                </div>
            </div>
        </section>

    </main>
    <!-- End #main -->

    <jsp:include page="/WEB-INF/views/Admin/layout/footer.jsp" />
    <jsp:include page="/WEB-INF/views/Admin/layout/script.jsp" />
    <script>
        document.addEventListener('DOMContentLoaded', function() {
            var searchInput = document.getElementById('search-input');
            var searchButton = document.getElementById('search-btn');
            var searchGroup = document.getElementById('search-group');

            function toggleSearchButton() {
                if (searchInput.value.trim().length > 0) {
                    searchButton.style.display = 'inline-block';
                    searchGroup.classList.add('active'); // Thay đổi kích thước trường nhập liệu
                } else {
                    searchButton.style.display = 'none';
                    searchGroup.classList.remove('active'); // Khôi phục kích thước trường nhập liệu
                }
            }

            searchInput.addEventListener('input', toggleSearchButton);

            // Set initial state
            toggleSearchButton();
        });
    </script>
</body>
</html>
