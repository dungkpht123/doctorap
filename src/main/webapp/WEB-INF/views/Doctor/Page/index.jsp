<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Trang chủ người dùng</title>
<jsp:include page="/WEB-INF/views/Doctor/layout/header.jsp" />
    <link rel="stylesheet" href="${contextPath}/resources/asset/css/fix.css">
<script type="module" src="https://unpkg.com/ionicons@7.1.0/dist/ionicons/ionicons.esm.js"></script>
<script nomodule src="https://unpkg.com/ionicons@7.1.0/dist/ionicons/ionicons.js"></script>
<style>

</style>
</head>
<body>
    <jsp:include page="/WEB-INF/views/Doctor/layout/navbar.jsp" />
 <!-- Header Start -->
 <!-- test -->
<div class="slider-container">
 <!-- test -->
 <ul class='slider'>
          <li class='item' style="background-image: url('https://cdn.mos.cms.futurecdn.net/dP3N4qnEZ4tCTCLq59iysd.jpg')">
            <div class='content'>
              <h2 class='title'>"Lossless Youths"</h2>
              <p class='description'> Lorem ipsum, dolor sit amet consectetur
              adipisicing elit. Tempore fuga voluptatum, iure corporis inventore
              praesentium nisi. Id laboriosam ipsam enim.  </p>
              <button>Read More</button>
            </div>
          </li>
          <li class='item' style="background-image: url('https://i.redd.it/tc0aqpv92pn21.jpg')">
            <div class='content'>
              <h2 class='title'>"Estrange Bond"</h2>
              <p class='description'> Lorem ipsum, dolor sit amet consectetur
              adipisicing elit. Tempore fuga voluptatum, iure corporis inventore
              praesentium nisi. Id laboriosam ipsam enim.  </p>
              <button>Read More</button>
            </div>
          </li>
          <li class='item' style="background-image: url('https://wharferj.files.wordpress.com/2015/11/bio_north.jpg')">
            <div class='content'>
              <h2 class='title'>"The Gate Keeper"</h2>
              <p class='description'> Lorem ipsum, dolor sit amet consectetur
              adipisicing elit. Tempore fuga voluptatum, iure corporis inventore
              praesentium nisi. Id laboriosam ipsam enim.  </p>
              <button>Read More</button>
            </div>
          </li>
          <li class='item' style="background-image: url('https://images7.alphacoders.com/878/878663.jpg')">
            <div class='content'>
              <h2 class='title'>"Last Trace Of Us"</h2>
              <p class='description'>
                Lorem ipsum, dolor sit amet consectetur adipisicing elit. Tempore fuga voluptatum, iure corporis inventore praesentium nisi. Id laboriosam ipsam enim.
              </p>
              <button>Read More</button>
            </div>
          </li>
          <li class='item' style="background-image: url('https://theawesomer.com/photos/2017/07/simon_stalenhag_the_electric_state_6.jpg')">
            <div class='content'>
              <h2 class='title'>"Urban Decay"</h2>
              <p class='description'>
                Lorem ipsum, dolor sit amet consectetur adipisicing elit. Tempore fuga voluptatum, iure corporis inventore praesentium nisi. Id laboriosam ipsam enim.
              </p>
              <button>Read More</button>
            </div>
          </li>
          <li class='item' style="background-image: url('https://da.se/app/uploads/2015/09/simon-december1994.jpg')">
            <div class='content'>
              <h2 class='title'>"The Migration"</h2>
              <p class='description'> Lorem ipsum, dolor sit amet consectetur
              adipisicing elit. Tempore fuga voluptatum, iure corporis inventore
              praesentium nisi. Id laboriosam ipsam enim.  </p>
              <button>Read More</button>
            </div>
          </li>
        </ul>
        <nav class='nav'>
          <ion-icon class='btn prev' name="arrow-back-outline"></ion-icon>
          <ion-icon class='btn next' name="arrow-forward-outline"></ion-icon>
        </nav>
</div>
    <!-- About Start -->
    <div class="container-xxl py-5">
        <div class="container">
            <div class="row g-5">
                <div class="col-lg-6 wow fadeIn" data-wow-delay="0.1s">
                    <div class="d-flex flex-column">
                        <img class="img-fluid rounded w-75 align-self-end" src="${contextPath }/resources/asset/img/about-1.jpg" alt="">
                        <img class="img-fluid rounded w-50 bg-white pt-3 pe-3" src="${contextPath }/resources/asset/img/about-2.jpg" alt="" style="margin-top: -25%;">
                    </div>
                </div>
                <div class="col-lg-6 wow fadeIn" data-wow-delay="0.5s">
                    <p class="d-inline-block border rounded-pill py-1 px-4">Về chúng tôi</p>
                    <h1 class="mb-4">Tại sao bạn nên tin tưởng chúng tôi? Hãy tìm hiểu về chúng tôi!</h1>
                    <p>${post.shortDescription}</p>
                   
                    <p><i class="far fa-check-circle text-primary me-3"></i>Chăm sóc sức khỏe chất lượng</p>
                    <p><i class="far fa-check-circle text-primary me-3"></i>Chỉ có bác sĩ đủ tiêu chuẩn</p>
                    <p><i class="far fa-check-circle text-primary me-3"></i>Chuyên gia nghiên cứu y khoa</p>
                   <a class="btn btn-primary rounded-pill py-3 px-5 mt-3" href="#" data-bs-toggle="modal" data-bs-target="#readMoreModal">Xem thêm</a>
                </div>
            </div>
        </div>
    </div>
    <!-- About End -->
			
   <!-- Service Start -->
    <div class="container-xxl py-5">
        <div class="container">
            <div class="text-center mx-auto mb-5 wow fadeInUp" data-wow-delay="0.1s" style="max-width: 600px;">
                <p class="d-inline-block border rounded-pill py-1 px-4">Chuyên khoa</p>
                <h1>Chuyên khoa tiêu biểu</h1>
            </div>
            <div class="row g-4">
            <div class="col-lg-4 col-md-6 wow fadeInUp" data-wow-delay="0.3s">
                    <div class="service-item rounded h-100 p-5">
                        
                        <h2 class="mb-3 text-primary">Chuyên khoa</h2>
                        <p class="mb-4">Chúng tôi cung cấp một loạt các dịch vụ và chuyên khoa lâm sàng toàn diện, kết hợp chuyên môn y khoa với công nghệ tiên tiến để mang lại dịch vụ chăm sóc chất lượng cao nhất cho bệnh nhân.</p>
                        <a class="" href="SpecialtyList-all"><i class="fa fa-arrow-right text-primary me-3"></i>Xem tất cả chuyên khoa</a>
                    </div>
                </div>
            <c:forEach items="${specialtyList }" var="item">
            	<div class="col-lg-4 col-md-6 wow fadeInUp"  data-wow-delay="0.1s">
                    <div class="service-item rounded h-100 p-5" style="background-image:linear-gradient(rgba(0, 0, 0, 0.3), rgba(0, 0, 0, 0.5)), url('${contextPath}${item.image}');background-size: cover;">
                        <div class="d-inline-flex align-items-center justify-content-center bg-white rounded-circle mb-4" style="width: 65px; height: 65px;">
                            <i class="${item.icon } text-primary fs-4"></i>
                        </div>
                        <h4 class="mb-3" style="color: white;">${item.name }</h4>
                        <p class="mb-4" style="color: white;width: 311px; height:120px;overflow: hidden;text-overflow: ellipsis;">${item.description }</p>
                        <a class="btn" href="doctorlist?specialtyid=${item.id }"><i class="fa fa-plus text-primary me-3"></i>Đọc thêm</a>
                    </div>
                </div>
            </c:forEach>
                
                
                    
                
            </div>
        </div>
    </div>
    <!-- Service End -->




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
            <p class="d-inline-block border rounded-pill py-1 px-4">Bác sĩ</p>
            <h1>Bác sĩ tiêu biểu</h1>
        </div>
        <div class="row g-4">
            <c:forEach var="doctor" items="${doctors}">
                <div class="col-lg-3 col-md-6 wow fadeInUp" data-wow-delay="0.3s">
                    <div class="team-item position-relative rounded overflow-hidden">
                        <div class="overflow-hidden">
                            <img class="img-fluid" src="${contextPath}${doctor.account.avatar != null ? doctor.account.avatar : '/resources/img/profile-img.jpg'}" alt="${doctor.account.userName}">
                        </div>
                        <div class="team-text bg-light text-center p-4">
                            <a href="appointment/booking?doctorid=${doctor.id}">
                                <h5>${doctor.account.userName}</h5>
                                <p class="text-primary">
                                    ${doctor.specialty != null ? doctor.specialty.name : ''}
                                </p>
                                <div class="team-social text-center">
                                    <h5 class="text-primary">Bác sĩ</h5>
                                </div>
                            </a>
                        </div>
                    </div>
                </div>
            </c:forEach>
        </div>
    </div>
</div>
<!-- Team End -->




<!-- Testimonial Start -->
<div class="container-xxl py-5">
    <div class="container">
        <div class="text-center mx-auto mb-5 wow fadeInUp" data-wow-delay="0.1s" style="max-width: 600px;">
            <p class="d-inline-block border rounded-pill py-1 px-4">Đánh Giá</p>
            <h1>Khách Hàng Nói Gì Về Chúng Tôi!</h1>
        </div>
        <div class="owl-carousel testimonial-carousel wow fadeInUp" data-wow-delay="0.1s">
            <div class="testimonial-item text-center">
                <img class="img-fluid bg-light rounded-circle p-2 mx-auto mb-4" src="${contextPath}/resources/asset/img/testimonial-1.jpg" alt="Khách hàng 1" style="width: 100px; height: 100px;">
                <div class="testimonial-text rounded text-center p-4">
                    <p>"Dịch vụ đặt lịch hẹn trực tuyến rất dễ sử dụng và tiện lợi. Tôi không còn phải chờ đợi lâu để có được lịch hẹn với bác sĩ. Trang web hoạt động rất mượt mà và nhanh chóng."</p>
                    <h5 class="mb-1">Nguyễn Văn A</h5>
                    <span class="fst-italic">Kỹ sư</span>
                </div>
            </div>
            <div class="testimonial-item text-center">
                <img class="img-fluid bg-light rounded-circle p-2 mx-auto mb-4" src="${contextPath}/resources/asset/img/testimonial-2.jpg" alt="Khách hàng 2" style="width: 100px; height: 100px;">
                <div class="testimonial-text rounded text-center p-4">
                    <p>"Tôi rất hài lòng với dịch vụ hỗ trợ khách hàng trên trang web. Đặt lịch hẹn dễ dàng và nhận được thông tin xác nhận ngay lập tức. Thật tuyệt vời!"</p>
                    <h5 class="mb-1">Trần Thị B</h5>
                    <span class="fst-italic">Nhân viên văn phòng</span>
                </div>
            </div>
            <div class="testimonial-item text-center">
                <img class="img-fluid bg-light rounded-circle p-2 mx-auto mb-4" src="${contextPath}/resources/asset/img/testimonial-3.jpg" alt="Khách hàng 3" style="width: 100px; height: 100px;">
                <div class="testimonial-text rounded text-center p-4">
                    <p>"Một trải nghiệm tuyệt vời! Tôi dễ dàng đặt lịch hẹn với bác sĩ yêu thích mà không gặp phải bất kỳ vấn đề nào. Trang web hoạt động rất tốt và tôi rất hài lòng."</p>
                    <h5 class="mb-1">Lê Văn C</h5>
                    <span class="fst-italic">Giáo viên</span>
                </div>
            </div>
        </div>
    </div>
</div>
<!-- Testimonial End -->
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
	
   	<jsp:include page="/WEB-INF/views/Doctor/layout/footer.jsp" />
   	<jsp:include page="/WEB-INF/views/Doctor/layout/script.jsp" />
 	<script type="text/javascript">
 	const slider = document.querySelector('.slider');

    // Hàm để điều khiển chuyển slide
    function moveSlide(next = true) {
        const items = document.querySelectorAll('.item');
        if (next) {
            slider.append(items[0]); // Di chuyển slide hiện tại xuống cuối
        } else {
            slider.prepend(items[items.length - 1]); // Di chuyển slide cuối lên đầu
        }
    }

    // Điều khiển bằng nút bấm
    function activate(e) {
        if (e.target.matches('.next')) moveSlide(true);  // Chuyển qua slide tiếp theo
        if (e.target.matches('.prev')) moveSlide(false); // Quay lại slide trước đó
    }

    // Thiết lập tự động chuyển slide mỗi 200 giây (200.000ms)
    setInterval(() => {
        moveSlide(true); // Chuyển sang slide tiếp theo
    }, 21000); // 200 giây = 200.000ms

    // Lắng nghe sự kiện click để điều khiển thủ công
    document.addEventListener('click', activate, false);
 	</script>
   </body>
</html>