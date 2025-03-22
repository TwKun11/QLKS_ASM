<%@page contentType="text/html" pageEncoding="UTF-8"%>   
<!-- Navbar-->

<link rel="stylesheet" type="text/css" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
<header class="app-header">
    <!-- Sidebar toggle button--><a class="app-sidebar__toggle" href="#" data-toggle="sidebar"
                                    aria-label="Hide Sidebar"></a>
    <!-- Navbar Right Menu-->
    <ul class="app-nav">
        <!-- User Menu-->
        <li><a class="app-nav__item" href="DispatchServlet"><i class='bx bx-log-out bx-rotate-180'></i></a></li>
    </ul>
</header>

<!-- Sidebar menu-->
<div class="app-sidebar__overlay" data-toggle="sidebar"></div>
<aside class="app-sidebar">
    <div class="app-sidebar__user">
        <img class="app-sidebar__user-avatar" src="${sessionScope.account.avatar}" alt="User Image">
        <div>
            <p class="app-sidebar__user-name"><b>${sessionScope.account.firstName} ${sessionScope.account.lastName}</b></p>
            <p class="app-sidebar__user-designation">Chào mừng bạn trở lại</p>
        </div>
    </div>
    <hr>
    <ul class="app-menu">
        <li><a class="app-menu__item ${requestScope.CURRENTSERVLET == "Home" ? "active" : ""}" href="home">
                <i class='app-menu__icon bx bx-home'></i><span class="app-menu__label">Trang chủ</span></a></li>

        <li><a class="app-menu__item ${requestScope.CURRENTSERVLET == "User" ? "active" : ""}" href="ManageUserServlet">
                <i class='app-menu__icon bx bx-user-voice'></i><span class="app-menu__label">Quản lý khách hàng</span></a></li>

        <li><a class="app-menu__item ${requestScope.CURRENTSERVLET == "Product" ? "active" : ""}" href="ManageProductServlet">
                <i class='app-menu__icon bx bx-purchase-tag-alt'></i><span class="app-menu__label">Quản lý sản phẩm</span></a></li>



</aside>
