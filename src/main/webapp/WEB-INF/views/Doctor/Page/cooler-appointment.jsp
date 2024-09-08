<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Đặt lịch</title>
<jsp:include page="/WEB-INF/views/Doctor/layout/header.jsp" />

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
<body>
    <jsp:include page="/WEB-INF/views/Doctor/layout/navbar.jsp" />
    

    <!-- Page Header Start -->
    <div class="container-fluid page-header py-5 mb-5 wow fadeIn" data-wow-delay="0.1s">
        <div class="container py-5">
            <h1 class="display-3 text-white mb-3 animated slideInDown text-primary">Đặt lịch khám</h1>
            <nav aria-label="breadcrumb animated slideInDown">
                <ol class="breadcrumb text-uppercase mb-0">
                    <li class="breadcrumb-item"><a class="text-white" style="text-shadow: 2px 2px #000000;" href="#"></a></li>
                    
                </ol>
            </nav>
        </div>
    </div>
    <!-- Page Header End -->
	
   <div class="container-xxl py-5">
        <div class="container">
            <div class="row g-5">
                <div class="col-lg-12 wow fadeInUp" data-wow-delay="0.1s" style="visibility: visible; animation-delay: 0.1s; animation-name: fadeInUp;">
                    <p class="d-inline-block border rounded-pill py-1 px-4">Appointment</p>
                    <h1 class="mb-4">Đặt lịch khám</h1>
                    
                </div>
                <div class="col-lg-12 wow fadeInUp" data-wow-delay="0.5s" style="visibility: visible; animation-delay: 0.5s; animation-name: fadeInUp;">
                    <div class="bg-light rounded h-100 d-flex align-items-center p-5">
                        <form:form action="appointment_with_extra_step" method="post" modelAttribute="appointment">
                        	<c:choose>
                        		<c:when test="${!empty sessionScope.account }">
                        			<form:input path="account.id" value="${sessionScope.account.id }" type="hidden" />
                        		</c:when>
                        		<c:otherwise>
                        			<form:input path="account.id" value="1" type="hidden" />
                        		</c:otherwise>
                        	</c:choose>
                        	
                            <div class="row g-3">
                                <div class="col-12 col-sm-12">
                                    <form:input path="patientName" type="text" class="form-control border-0" placeholder="Họ và tên" value="${sessionScope.account.userName }" style="height: 55px;" required="required"/>
                                </div>
                                <div class="col-12 col-sm-6">
                                    <form:input path="patientEmail" type="email" class="form-control border-0" placeholder="Email" value="${sessionScope.account.email }" style="height: 55px;" required="required"/>
                                </div>
                                <div class="col-12 col-sm-6">
                                    <form:input path="patientPhone" type="text" class="form-control border-0" placeholder="Điện thoại" value="${sessionScope.account.phoneNumber }" style="height: 55px;" required="required"/>
                                </div>
                                <div class="col-12 col-sm-6">
                                    <p class="mb-2" style="height: 10px">Chọn bác sĩ</p>
                                </div>
                                <div class="col-12 col-sm-6">
                                    <p class="mb-2" style="height: 10px">Đặt lịch khám</p>
                                </div>
                                
                                <div class="col-12 col-sm-3">
                                    <select onchange="catch_value_types()" name="specialty" id="specialty" class="form-select border-0" style="height: 55px;">
	                                    <c:forEach items="${slist }" var="item">
											<option value="${item.id }">${item.name }</option>
										</c:forEach>
									</select>
                                </div>
                                <div class="col-12 col-sm-3">
                                         <form:select path="doctor.id" class="form-select border-0" style="height: 55px;" name="doctor" id="doctor">
                                        <option selected="" disabled>Chọn bác sĩ</option>
                                        
                           	            	<c:forEach items="${dlist }" var="item">
										  		<option id="${item.specialty.id }" value="${item.id }">${item.account.userName }</option>
										 	</c:forEach>

                                       
                                        
                                    </form:select>
                                        
                                </div>
                                
                                
                                <div class="col-12 col-sm-3">
                                    <div class="date" id="date" data-target-input="nearest">
                                        <form:input path="date" type="date" min="${now }" id="date-input" class="form-control border-0" placeholder="Chọn ngày khám" data-target="#date" style="height: 55px;"/>
                                        </div>
                                </div>
                                <div class="col-12 col-sm-3">
                                         <form:select path="schedule.id" class="form-select border-0" style="height: 55px;">
                                        <option selected="" disabled>Chọn thời gian khám</option>
                                        
                                       	<c:forEach items="${scheduleList }" var="item">
                                       	
                                       		<option value="${item.id }">${item.schedule }</option>
                                       		
                                       	</c:forEach>

                                       
                                        
                                    </form:select>
                                        
                                </div>
                                <div class="col-12">
                                    <form:textarea path="description" class="form-control border-0" rows="5" placeholder="Mô tả triệu chứng"></form:textarea>
                                </div>
                                <p style="color:red;">${error }</p>
                                <div class="col-12">
                                    <button class="btn btn-primary w-100 py-3" type="submit">Đặt lịch</button>
                                </div>
                            </div>
                        </form:form>
                    </div>
                </div>
            </div>
        </div>
    </div>


   


    
        
   	<jsp:include page="/WEB-INF/views/Doctor/layout/footer.jsp" />
   	<jsp:include page="/WEB-INF/views/Doctor/layout/script.jsp" />
   	<script>
   	document.addEventListener('DOMContentLoaded', () => {
   	    const dateInput = document.getElementById('date-input');

   	    dateInput.addEventListener('input', (event) => {
   	        const selectedDate = new Date(event.target.value);
   	        if (selectedDate.getDay() === 0) { // 0 is Sunday
   	            alert('Ngày khám không hợp lệ.');
   	            dateInput.value = ''; // Clear the input field
   	        }
   	    });

   	    // Function to validate the date before submission or any other actions
   	    function validateDate(date) {
   	        return date.getDay() !== 0; // Returns true if the date is not Sunday
   	    }
   	});
   	document.addEventListener('DOMContentLoaded', () => {
   	    const timeInput = document.getElementById('time-input');

   	    // Function to check if a time is within the allowed range
   	    function isTimeAllowed(time) {
   	        const [hours, minutes] = time.split(':').map(Number);
   	        const selectedTime = hours * 60 + minutes;
   	        
   	        // Allowed time ranges in minutes from start of the day
   	        const startMorning = 7 * 60;     // 07:00
   	        const endMorning = 12 * 60;      // 12:00
   	        const startAfternoon = 13 * 60;  // 13:00
   	        const endDay = 17 * 60;          // 17:00

   	        // Check if time is within allowed ranges
   	        return (selectedTime >= startMorning && selectedTime < endMorning) ||
   	               (selectedTime >= startAfternoon && selectedTime < endDay);
   	    }

   	    timeInput.addEventListener('input', (event) => {
   	        const selectedTime = event.target.value;
   	        if (selectedTime && !isTimeAllowed(selectedTime)) {
   	            alert('Please select a time between 07:00 and 12:00 or 13:00 and 17:00.');
   	            timeInput.value = ''; // Clear the input field
   	        }
   	    });
   	});

   	
   	function catch_value_types() {
   	  const selectedValue = document.getElementById("specialty").value;
   	  const select2 = document.getElementById("doctor");  
   	  Array.from(select2.options).forEach((node) => node.style.display = node.id === selectedValue ? "block": "none");
   	}
   	</script>
   	

   </body>
</html>