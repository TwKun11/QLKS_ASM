<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
    <head>
        <title>Các Khách Sạn Tìm Thấy</title>
        <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
        <style>
            /* Tổng thể giao diện */
            body {
                background-color: #1a1a1a;
                color: white;
                font-family: Arial, sans-serif;
            }

            /* Layout khách sạn */
            .hotel-item {
                display: flex;
                align-items: center;
                border: 1px solid #444;
                margin-bottom: 20px;
                padding: 15px;
                background-color: #333;
                border-radius: 8px;
                transition: transform 0.3s ease, box-shadow 0.3s ease;
                width: 887px; /* Chiều rộng cố định */
                height: 220px; /* Chiều cao cố định */
                overflow: hidden; /* Ngăn chặn nội dung tràn ra ngoài */
            }

            .hotel-item:hover {
                transform: translateY(-5px);
                box-shadow: 0 4px 10px rgba(255, 255, 255, 0.2);
            }

            /* Hình ảnh khách sạn */
            .hotel-image img {
                max-width: 100%;
                height: auto;
                border-radius: 8px;
                width: 200px; /* Chiều rộng hình ảnh */
                height: 180px; /* Chiều cao hình ảnh */
                object-fit: cover; /* Đảm bảo hình ảnh không bị méo */
            }

            /* Chi tiết khách sạn */
            .hotel-details {
                margin-left: 20px;
                line-height: 1.4; /* Giảm khoảng cách giữa các dòng */
                width: calc(100% - 220px); /* Giới hạn chiều rộng của phần chi tiết */
                position: relative; /* Để đặt đánh giá ở góc trên bên phải */
                overflow: hidden; /* Ngăn chặn nội dung tràn ra ngoài */
            }

            .hotel-details h5 {
                margin-top: 0;
                font-size: 1.2rem;
                color: #00bfff; /* Màu xanh dương cho tên khách sạn */
            }

            .hotel-details p {
                margin: 5px 0;
                font-size: 0.9rem;
                white-space: normal; /* Cho phép xuống dòng */
                display: -webkit-box;

            }

            .hotel-details .rating {
                position: absolute; /* Đặt đánh giá ở góc trên bên phải */
                top: 0;
                right: 0;
                margin-top: 0;
                font-size: 1.2rem;
                color: gold;
            }

            .hotel-details .rating span {
                margin-right: 10px;
                color: #00bfff; /* Màu xanh dương cho chữ "Xuất sắc" */
            }

            .hotel-details .location {
                color: #00ff00; /* Màu xanh lá cây cho địa chỉ */
            }

            .hotel-details .description {
                margin-top: 10px;
            }

            /* Phân trang */
            .pagination {
                display: flex;
                justify-content: center;
                margin-top: 20px;
            }

            .pagination a {
                margin: 0 5px;
                padding: 5px 10px;
                text-decoration: none;
                color: white;
                background-color: #333;
                border-radius: 5px;
                transition: background-color 0.3s ease;
            }

            .pagination a:hover {
                background-color: #007bff;
            }

            .pagination a.active {
                background-color: #007bff;
            }

            /* Bộ lọc */
            .card.bg-light {
                background-color: #333 !important;
                color: white;
            }

            .card.bg-light label,
            .card.bg-light input {
                color: white;
            }

            .card.bg-light button {
                background-color: #007bff;
                border: none;
                padding: 10px; /* Tăng kích thước nút tìm kiếm */
                font-size: 1rem; /* Font size lớn hơn */
                width: 100%; /* Nút tìm kiếm chiếm toàn bộ chiều rộng */
            }

            .card.bg-light button:hover {
                background-color: #0056b3;
            }

            /* Checkbox và radio */
            .filter-option {
                display: flex;
                align-items: center;
                margin-bottom: 8px; /* Giảm khoảng cách giữa các dòng */
            }

            .filter-option input[type="checkbox"],
            .filter-option input[type="radio"] {
                margin-right: 10px;
            }

            .filter-option label {
                cursor: pointer;
                font-size: 0.9rem; /* Giảm kích thước chữ */
            }
        </style>
    </head>
    <body>
        <!-- Header -->
        <%@ include file="/includes/header.jsp" %>

        <div class="container mt-5">
            <h1 class="text-center mb-4">Danh sách khách sạn</h1>

            <!-- Bộ lọc -->
            <div class="row mb-4">
                <div class="col-md-3">
                    <div class="card bg-light">
                        <div class="card-body">
                            <h5 class="card-title">Bộ lọc</h5>
                            <form action="${pageContext.request.contextPath}/khachsan" method="get">
                                <!-- Loại khách sạn -->
                                <div class="mb-3">
                                    <label class="form-label"><strong>Loại khách sạn:</strong></label>
                                    <c:forEach var="category" items="${listLoaiKhachSan}">
                                        <div class="filter-option">
                                            <input type="checkbox" name="loaiKhachSan" value="${category.id}" id="category-${category.id}">
                                            <label for="category-${category.id}">${category.ten}</label>
                                        </div>
                                    </c:forEach>
                                </div>

                                <!-- Đánh giá -->
                                <div class="mb-3">
                                    <label class="form-label"><strong>Đánh giá:</strong></label>
                                    <div class="filter-option">
                                        <input type="radio" name="danhGia" value="1" id="rating-1">
                                        <label for="rating-1">1 sao</label>
                                    </div>
                                    <div class="filter-option">
                                        <input type="radio" name="danhGia" value="2" id="rating-2">
                                        <label for="rating-2">2 sao</label>
                                    </div>
                                    <div class="filter-option">
                                        <input type="radio" name="danhGia" value="3" id="rating-3">
                                        <label for="rating-3">3 sao</label>
                                    </div>
                                    <div class="filter-option">
                                        <input type="radio" name="danhGia" value="4" id="rating-4">
                                        <label for="rating-4">4 sao</label>
                                    </div>
                                    <div class="filter-option">
                                        <input type="radio" name="danhGia" value="5" id="rating-5">
                                        <label for="rating-5">5 sao</label>
                                    </div>
                                </div>

                                <!-- Giáp biển -->
                                <div class="mb-3 form-check">
                                    <input type="checkbox" class="form-check-input" id="giapBien" name="giapBien" value="true" ${param.giapBien == 'true' ? 'checked' : ''}>
                                    <label class="form-check-label" for="giapBien">Giáp biển</label>
                                </div>

                                <!-- Nút tìm kiếm -->
                                <button type="submit" class="btn btn-primary w-100">Tìm kiếm</button>

                                <!-- Nút Refresh -->
                                <a href="${pageContext.request.contextPath}/khachsan" class="btn btn-secondary w-100 mt-2">Refresh</a>
                            </form>
                        </div>
                    </div>
                </div>

                <!-- Danh sách khách sạn -->
                <div class="col-md-9">
                    <c:choose>
                        <c:when test="${empty listKhachSan}">
                            <div class="alert alert-warning text-center">
                                <h4>Không tìm thấy khách sạn nào phù hợp!</h4>
                                <p>Vui lòng thử lại với các tiêu chí khác.</p>
                            </div>
                        </c:when>
                        <c:otherwise>
                            <c:forEach var="ks" items="${listKhachSan}">
                                <div class="hotel-item">
                                    <!-- Cột ảnh -->
                                    <div class="hotel-image col-md-4">
                                        <img src="Content/Images/KhachSan/${ks.id}.jpg" alt="${ks.ten}" class="img-fluid">
                                    </div>

                                    <!-- Cột thông tin -->
                                    <div class="hotel-details col-md-8">
                                        <h5>${ks.ten}</h5>
                                        <p class="location">${ks.diaChi} - Cách trung tâm ${ks.cachTrungTam}m - SDT ${ks.soDienThoai}</p>
                                        <p><strong>${ks.tenLoaiKhachSan}</strong></p>
                                        <p><strong>Giáp biển:</strong> ${ks.giapBien ? 'Có' : 'Không'}</p>
                                        <p class="description">${ks.moTa}</p>
                                        <div class="rating">
                                            <span>${ks.danhGia}★</span>
                                            <span>Xuất sắc</span>
                                        </div>
                                    </div>
                                </div>
                            </c:forEach>
                        </c:otherwise>
                    </c:choose>

                    <!-- Phân trang -->
                    <div class="pagination d-flex justify-content-center mt-4">
                        <c:if test="${currentPage > 1}">
                            <a href="${pageContext.request.contextPath}/khachsan?loaiKhachSan=${param.loaiKhachSan}&danhGia=${param.danhGia}&giapBien=${param.giapBien}&page=${currentPage - 1}" class="btn btn-outline-primary">Trước</a>
                        </c:if>
                        <span class="mx-3">Trang ${currentPage} / ${totalPages}</span>
                        <c:if test="${currentPage < totalPages}">
                            <a href="${pageContext.request.contextPath}/khachsan?loaiKhachSan=${param.loaiKhachSan}&danhGia=${param.danhGia}&giapBien=${param.giapBien}&page=${currentPage + 1}" class="btn btn-outline-primary">Sau</a>
                        </c:if>
                    </div>
                </div>
            </div>
        </div>

        <!-- Bootstrap JS -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>