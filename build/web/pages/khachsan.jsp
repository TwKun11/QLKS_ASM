<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
    <head>
        <title>Các Khách Sạn Tìm Thấy</title>
        <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
        <link href="https://fonts.googleapis.com/css2?family=Allison&display=swap" rel="stylesheet">
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css" rel="stylesheet">
        <style>
            /* Tổng thể giao diện */
            body {
                font-family: 'Arial', sans-serif;
                background-color: #F5F6F5; /* Nền sáng nhẹ */
                color: #333;
                line-height: 1.6;
            }

            /* Container chính */
            .container {
                max-width: 1200px;
                margin-top: 50px;
                padding: 0 15px;
            }

            h1.text-center {
                font-size: 2.5rem;
                font-weight: 700;
                color: #2A7A6D; /* Màu xanh ngọc */
                margin-bottom: 40px;
            }

            /* Layout khách sạn */
            .hotel-item {
                display: flex;
                align-items: center;
                background-color: #fff;
                border-radius: 12px;
                margin-bottom: 25px;
                padding: 20px;
                box-shadow: 0 6px 12px rgba(0, 0, 0, 0.08);
                transition: transform 0.3s ease, box-shadow 0.3s ease;
                position: relative;
                overflow: hidden;
            }

            .hotel-item:hover {
                transform: translateY(-8px);
                box-shadow: 0 12px 24px rgba(0, 0, 0, 0.15);
            }

            /* Hình ảnh khách sạn */
            .hotel-image img {
                width: 220px;
                height: 180px;
                object-fit: cover;
                border-radius: 10px;
                transition: transform 0.3s ease;
            }

            .hotel-item:hover .hotel-image img {
                transform: scale(1.05);
            }

            /* Chi tiết khách sạn */
            .hotel-details {
                margin-left: 25px;
                width: calc(100% - 250px);
                position: relative;
            }

            .hotel-details h5 {
                font-size: 1.5rem;
                color: #2A7A6D; /* Màu xanh ngọc */
                font-weight: 600;
                margin-bottom: 12px;
                transition: color 0.3s ease;
            }

            .hotel-item:hover .hotel-details h5 {
                color: #1F5C51; /* Tông xanh đậm hơn khi hover */
            }

            .hotel-details p {
                margin: 6px 0;
                font-size: 1rem;
                color: #555;
            }

            .hotel-details .location {
                color: #28a745;
                font-weight: 500;
            }

            .hotel-details .description {
                font-size: 0.95rem;
                color: #777;
                margin-top: 10px;
                line-height: 1.5;
            }

            .hotel-details .rating {
                position: absolute;
                top: -5px;
                right: 15px;
                font-size: 1.2rem;
                font-weight: 700;
                color: #F5E8C7; /* Màu kem nhạt */
                background-color: #2A7A6D; /* Màu xanh ngọc */
                padding: 5px 12px;
                border-radius: 20px;
                box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
            }

            .hotel-details .rating span:first-child {
                color: gold;
            }

            /* Bộ lọc */
            .card.bg-light {
                background-color: #fff !important;
                border-radius: 12px;
                box-shadow: 0 6px 12px rgba(0, 0, 0, 0.08);
                padding: 20px;
            }

            .card.bg-light .card-title {
                font-size: 1.6rem;
                color: #2A7A6D; /* Màu xanh ngọc */
                font-weight: 600;
                margin-bottom: 20px;
            }

            .card.bg-light label {
                color: #333;
                font-weight: 500;
            }

            .filter-option {
                display: flex;
                align-items: center;
                margin-bottom: 12px;
            }

            .filter-option input[type="checkbox"],
            .filter-option input[type="radio"] {
                margin-right: 10px;
                accent-color: #2A7A6D; /* Màu checkbox/radio */
            }

            .filter-option label {
                font-size: 1rem;
                cursor: pointer;
                transition: color 0.3s ease;
            }

            .filter-option:hover label {
                color: #2A7A6D; /* Màu xanh ngọc khi hover */
            }

            .card.bg-light button,
            .card.bg-light a.btn {
                background-color: #2A7A6D; /* Màu xanh ngọc */
                color: #F5E8C7; /* Màu kem nhạt */
                border: none;
                padding: 12px;
                font-size: 1.1rem;
                border-radius: 8px;
                transition: background-color 0.3s ease, transform 0.2s ease;
            }

            .card.bg-light button:hover,
            .card.bg-light a.btn:hover {
                background-color: #1F5C51; /* Tông xanh đậm hơn */
                transform: translateY(-2px);
            }

            .card.bg-light a.btn-secondary {
                background-color: #6c757d;
            }

            .card.bg-light a.btn-secondary:hover {
                background-color: #5a6268;
            }

            /* Phân trang */
            .pagination {
                display: flex;
                justify-content: center;
                align-items: center;
                margin-top: 30px;
            }

            .pagination a {
                padding: 10px 18px;
                text-decoration: none;
                color: #F5E8C7; /* Màu kem nhạt */
                background-color: #2A7A6D; /* Màu xanh ngọc */
                border-radius: 8px;
                margin: 0 8px;
                font-size: 1rem;
                transition: background-color 0.3s ease, transform 0.2s ease;
            }

            .pagination a:hover {
                background-color: #1F5C51; /* Tông xanh đậm hơn */
                transform: translateY(-2px);
            }

            .pagination span {
                font-size: 1.1rem;
                color: #555;
            }

            /* Thông báo khi không tìm thấy */
            .alert-warning {
                background-color: #fff3cd;
                border: none;
                border-radius: 12px;
                padding: 20px;
                text-align: center;
                box-shadow: 0 6px 12px rgba(0, 0, 0, 0.08);
            }

            .alert-warning h4 {
                color: #856404;
                font-weight: 600;
            }

            /* Footer */
            
        </style>
    </head>
    <body>
        <!-- Header -->
        <%@ include file="/includes/header.jsp" %>

        <div class="container mt-5">
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
                                <div class="hotel-item" style="position: relative;">
                                    <a href="${pageContext.request.contextPath}/datphong?id=${ks.id}" style="position: absolute; width: 100%; height: 100%; top: 0; left: 0; z-index: 1;"></a>

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
        <%@ include file="/includes/footer.jsp" %>

        <!-- Bootstrap JS -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>