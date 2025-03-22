<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<c:import url="/AdminServlet"/>

<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Bảng điều khiển</title>
        <style> 
            *{
                margin: 0;
                padding: 0;
                box-sizing: border-box;
                font-family: Arial, sans-serif;
            }

            /* Tổng thể */
            body {
                background-color: #f4f6f9;
                padding: 20px;
            }

            /* Bố cục chính */
            .app-content {
                max-width: 1200px;
                margin: auto;
            }

            /* Tiêu đề */
            .app-title {
                display: flex;
                justify-content: space-between;
                align-items: center;
                padding: 15px;
                background: #fff;
                border-radius: 8px;
                box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
                margin-bottom: 20px;
            }

            /* Breadcrumb */
            .breadcrumb {
                list-style: none;
                display: flex;
                gap: 10px;
            }

            .breadcrumb a {
                text-decoration: none;
                color: #007bff;
                font-weight: bold;
            }

            .breadcrumb a:hover {
                text-decoration: underline;
            }

            /* Đồng hồ */
            #clock {
                font-size: 18px;
                font-weight: bold;
            }
            /* Widget chung */
            .widget {
                display: flex;
                align-items: center;
                padding: 20px;
                border-radius: 8px;
                background: #fff;
                box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
                transition: transform 0.2s;
            }

            .widget:hover {
                transform: translateY(-5px);
            }

            /* Icon */
            .widget .icon {
                font-size: 3rem;
                margin-right: 15px;
                padding: 10px;
                border-radius: 50%;
            }

            /* Widget màu sắc */
            .primary {
                background-color: #007bff;
            }
            .info {
                background-color: #17a2b8;
            }
            .warning {
                background-color: #ffc107;
            }
            .danger {
                background-color: #dc3545;
            }

            /* Căn chỉnh nội dung widget */
            .widget {
                display: flex;
                align-items: center;
                justify-content: space-between;
                padding: 20px;
                border-radius: 8px;
                background: #fff;
                box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
                transition: transform 0.2s, box-shadow 0.3s;
            }

            /* Hover tạo hiệu ứng nổi nhẹ */
            .widget:hover {
                transform: translateY(-5px);
                box-shadow: 0 8px 15px rgba(0, 0, 0, 0.2);
            }

            /* Biểu tượng */
            .widget .icon {
                font-size: 3rem;
                padding: 15px;
                border-radius: 50%;
                background: rgba(255, 255, 255, 0.2);
            }

            /* Căn chỉnh nội dung trong widget */
            .widget-content {
                flex: 1;
                padding-left: 15px;
            }

            /* Tiêu đề */
            .widget-content h4 {
                font-size: 20px;
                font-weight: bold;
                margin-bottom: 8px;
                color: #fff;
            }

            /* Nội dung chính */
            .widget-content p {
                font-size: 18px;
                font-weight: bold;
                margin: 5px 0;
                color: #f8f9fa;
            }

            /* Mô tả */
            .widget-content .info-desc {
                font-size: 15px;
                font-style: italic;
                color: rgba(255, 255, 255, 0.8);
            }

            /* Màu nền cho từng loại widget */
            .primary {
                background-color: #007bff;
                color: white;
            }

            .info {
                background-color: #17a2b8;
                color: white;
            }

            .warning {
                background-color: #ffc107;
                color: black;
            }

            .danger {
                background-color: #dc3545;
                color: white;
            }


            .dashboard {
                display: grid;
                grid-template-columns: repeat(2, 1fr); /* Bố cục 2 cột mặc định */
                gap: 20px;
            }

            @media (max-width: 1024px) { /* Khi màn hình nhỏ hơn 1024px */
                .dashboard {
                    grid-template-columns: repeat(auto-fit, minmax(300px, 1fr)); /* Tự co giãn */
                }
            }

            @media (max-width: 768px) { /* Khi màn hình nhỏ hơn 768px */
                .dashboard {
                    grid-template-columns: 1fr; /* Chuyển về 1 cột */
                }
            }

        </style>
    </head>
    <body>
        <main class="app-content">
            <div class="app-title">
                <ul class="breadcrumb">
                    <li><a href="#"><b>Bảng điều khiển</b></a></li>
                </ul>
                <div id="clock"></div>
            </div>

            <div class="dashboard">
                <div class="widget primary">
                    <span class="icon">👥</span>
                    <div class="widget-content">
                        <h4>Total User</h4>
                        <p><b>${requestScope.TOTALUSERS} Khách hàng</b></p>
                        <p class="info-desc">Tổng số khách hàng được quản lý.</p>
                    </div>
                </div>

                <div class="widget info">
                    <span class="icon">📦</span>
                    <div class="widget-content">
                        <h4>Best Sellers</h4>
                        <p><b>ID phòng: ${requestScope.MOSTBOOKERROOM}</b></p>
                        <p class="info-desc">Phòng được đặt nhiều nhất.</p>
                    </div>
                </div>

                <div class="widget warning">
                    <span class="icon">📈</span>
                    <div class="widget-content">
                        <h4>Revenue</h4>
                        <p><b>${requestScope.TOTALREVENUE} VNĐ</b></p>
                        <p class="info-desc">Tổng số doanh thu.</p>
                    </div>
                </div>

                <div class="widget danger">
                    <span class="icon">🛒 </span>
                    <div class="widget-content">
                        <h4>Booker Room Count</h4>
                        <p><b> ${requestScope.BOOKERROOMCOUNT} Đơn</b></p>
                        <p class="info-desc">Số lượng đơn hàng đã nhận được.</p>
                    </div>
                </div>
            </div>
        </main>
    </body>
</html>
