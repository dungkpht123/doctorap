<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
  <!-- ======= Sidebar ======= -->
  <aside id="sidebar" class="sidebar">

    <ul class="sidebar-nav" id="sidebar-nav">

     
      <li class="nav-item">
        <a class="nav-link collapsed" href="Appointmentlist-current">
           <i class="bi bi-calendar-day"></i>
          <span>Lịch khám hôm nay</span>
        </a>
      </li>
      <li class="nav-item">
        <a class="nav-link collapsed" href="Appointmentlist-upcoming">
        <i class="bi bi-calendar-event"></i>
          <span>Lịch khám sắp tới</span>
        </a>
      </li>
	
		<li class="nav-item">
        <a class="nav-link collapsed" href="Appointmentlist-all">
        <i class="bi bi-calendar-fill"></i>
          <span>Danh sách lịch khám</span>
        </a>
      </li>

    </ul>

  </aside><!-- End Sidebar-->