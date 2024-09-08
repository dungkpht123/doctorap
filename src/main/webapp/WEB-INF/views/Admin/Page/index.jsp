<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Admin Dashboard</title>
<jsp:include page="/WEB-INF/views/Admin/layout/header.jsp" />
</head>
<body>
	<jsp:include page="/WEB-INF/views/Admin/layout/navbar.jsp" />
	<jsp:include page="/WEB-INF/views/Admin/layout/sidebar.jsp" />
	<main id="main" class="main">
		<div class="pagetitle">
			<h1>Dashboard</h1>
			<nav>
				<ol class="breadcrumb">
					<li class="breadcrumb-item"><a href="${contextPath}/index.html">Home</a></li>
					<li class="breadcrumb-item active">Dashboard</li>
				</ol>
			</nav>
			<section class="section dashboard">
				<div class="row">
					<!-- Left side columns -->
					<div class="col-lg-12">
						<div class="row">
							<!-- Revenue Card -->
							<div class="col-xxl-6 col-md-6">
								<div class="card info-card revenue-card">
									<div class="filter">
										<a class="icon" href="#" data-bs-toggle="dropdown"><i class="bi bi-three-dots"></i></a>
										<ul class="dropdown-menu dropdown-menu-end dropdown-menu-arrow">
											<li class="dropdown-header text-start">
												<h6>Filter</h6>
											</li>
											<li><a class="dropdown-item" href="#">Today</a></li>
											<li><a class="dropdown-item" href="#">This Month</a></li>
											<li><a class="dropdown-item" href="#">This Year</a></li>
										</ul>
									</div>
									<div class="card-body">
										<h5 class="card-title">Tổng số Bác sĩ</h5>
										<div class="d-flex align-items-center">
											<div class="card-icon rounded-circle d-flex align-items-center justify-content-center">
												<i class="bi bi-heart-pulse-fill"></i>
											</div>
											<div class="ps-3">
												<h6>${totalDoctors}</h6>
												<span>Bác sĩ</span>
											</div>
										</div>
									</div>
								</div>
							</div>
							<!-- End Revenue Card -->
							<!-- Customers Card -->
							<div class="col-xxl-6 col-xl-12">
								<div class="card info-card customers-card">
									<div class="filter">
										<a class="icon" href="#" data-bs-toggle="dropdown" aria-expanded="false"><i class="bi bi-three-dots"></i></a>
										<ul class="dropdown-menu dropdown-menu-end dropdown-menu-arrow">
											<li class="dropdown-header text-start">
												<h6>Filter</h6>
											</li>
											<li><a class="dropdown-item" href="#">Today</a></li>
											<li><a class="dropdown-item" href="#">This Month</a></li>
											<li><a class="dropdown-item" href="#">This Year</a></li>
										</ul>
									</div>
									<div class="card-body">
										<h5 class="card-title">Tổng số lượng Khách hàng</h5>
										<div class="d-flex align-items-center">
											<div class="card-icon rounded-circle d-flex align-items-center justify-content-center">
												<i class="bi bi-people"></i>
											</div>
											<div class="ps-3">
												<h6>${totalUsersByRoleUser}</h6>
												<span class="text-danger small pt-1 fw-bold">${percentageToday}%</span> <span class="text-muted small pt-2 ps-1"> lượng đăng ký hôm nay là ${totaltoday} người</span>
											</div>
										</div>
									</div>
								</div>
							</div>
							<!-- End Customers Card -->

							<!-- Reports -->
							<div class="col-12">
								<div class="card">
									<div class="filter">
										<a class="icon" href="#" data-bs-toggle="dropdown"><i class="bi bi-three-dots"></i></a>
										<ul class="dropdown-menu dropdown-menu-end dropdown-menu-arrow">
											<li class="dropdown-header text-start">
												<h6>Filter</h6>
											</li>
											<li><a class="dropdown-item" href="#" onclick="updateReport('today')">Today</a></li>
											<li><a class="dropdown-item" href="#" onclick="updateReport('month')">This Month</a></li>
											<li><a class="dropdown-item" href="#" onclick="updateReport('year')">This Year</a></li>
										</ul>
									</div>
									<div class="card-body">
										<h5 class="card-title">Reports <span id="reportTitle">/Today</span></h5>
										<div id="reportsChart"></div>
									</div>
								</div>
							</div>
							<!-- End Reports -->
						</div>
					</div>
					<!-- End Left side columns -->
				</div>
			</section>
		</div>
	</main>
	<jsp:include page="/WEB-INF/views/Admin/layout/footer.jsp" />
	<jsp:include page="/WEB-INF/views/Admin/layout/script.jsp" />
	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
	
	<script src="https://cdn.jsdelivr.net/npm/apexcharts"></script>
	<script type="text/javascript">
    function updateReport(filter) {
        let apiUrl = '';
        let categories = [];
        let seriesData = [];

        const titleMap = {
            'week': 'This Week',
            'month': 'This Month',
            'year': 'This Year'
        };
        document.querySelector("#reportTitle").innerText = titleMap[filter];

        const today = new Date();
        const year = today.getFullYear();
        const month = String(today.getMonth() + 1).padStart(2, '0');
        let startDate, endDate;

        if (filter === 'week') {
            // Calculate start and end date for the week
            const firstDayOfWeek = new Date(today.setDate(today.getDate() - today.getDay() + 1)); // Monday as first day
            startDate = firstDayOfWeek.toISOString().split('T')[0];
            const lastDayOfWeek = new Date(today.setDate(firstDayOfWeek.getDate() + 6)); // Sunday as last day
            endDate = lastDayOfWeek.toISOString().split('T')[0];
        } else if (filter === 'month') {
            // Calculate start and end date for the month
            startDate = `${year}-${month}-01`;
            endDate = new Date(year, today.getMonth() + 1, 0).toISOString().split('T')[0];
        } else if (filter === 'year') {
            // Calculate start and end date for the year
            startDate = `${year}-01-01`;
            endDate = `${year}-12-31`;
        }

        // Debugging: Check if dates are correctly assigned
        console.log('Start Date:', startDate);
        console.log('End Date:', endDate);

        // Constructing the API URL correctly
         apiUrl = '/DoctorAppointment/api/reports/dailyByRole?startDate='+ startDate+'&endDate='+endDate;

        console.log('API URL:', apiUrl); // For debugging

        // Using jQuery's ajax method
        $.ajax({
            url: apiUrl,
            type: 'GET',
            dataType: 'json',
            success: function (data) {
                const dailyCounts = data.dailyUserCounts;
                categories = Object.keys(dailyCounts).sort(); // Sort the dates

                // Debugging: Print the sorted categories and counts
                console.log('Categories:', categories);
                console.log('Counts:', categories.map(date => dailyCounts[date]));

                seriesData = [{
                    name: 'Registrations',
                    data: categories.map(date => dailyCounts[date]) // Get the counts in the order of sorted dates
                }];

                // Clear previous chart instance (if any)
                document.querySelector("#reportsChart").innerHTML = '';

                // Render the chart using ApexCharts
                new ApexCharts(document.querySelector("#reportsChart"), {
                    series: seriesData,
                    chart: {
                        height: 350,
                        type: 'line',
                        toolbar: {
                            show: false
                        },
                    },
                    xaxis: {
                        categories: categories,
                        type: 'datetime',
                        labels: {
                            format: 'dd/MM/yy'
                        }
                    },
                    yaxis: {
                        title: {
                            text: 'Number of Registrations'
                        }
                    },
                    tooltip: {
                        x: {
                            format: 'dd/MM/yy'
                        },
                    }
                }).render();
            },
            error: function (error) {
                console.error('Error fetching data:'+error);
            }
        });
    }

    // Initialize with default filter (e.g., 'week')
    updateReport('week');
</script>




</body>
</html>
