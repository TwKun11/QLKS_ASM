<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Nice Dream Hotel</title>

        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
        <style>
            body {
                background-color: #121212;
                color: white;
                font-family: Arial, sans-serif;
            }

            .div-zoom {
                overflow: hidden;
                border-radius: 15px;
                position: relative;
                box-shadow: 0 4px 8px rgba(255, 255, 255, 0.1);
                transition: transform 0.3s ease-in-out;
            }
            .div-zoom:hover {
                transform: scale(1.05);
            }

            .img-zoom {
                width: 100%;
                height: 250px;
                object-fit: cover;
                transition: transform 0.4s ease-in-out;
            }
            .div-zoom:hover .img-zoom {
                transform: scale(1.1);
            }

            .chu-goc-trai {
                position: absolute;
                top: 10px;
                left: 15px;
                background: rgba(0, 0, 0, 0.6);
                padding: 8px 12px;
                border-radius: 8px;
            }

            .row .col-md-6, .row .col-md-4 {
                padding: 15px;
            }

            /* Slider */
            .carousel-item img {
                height: 300px;
                object-fit: contain;
                border-radius: 10px;
            }

            .search-container {
                margin: 20px auto;
                padding: 20px;
                border-radius: 10px;
                box-shadow: 0 4px 8px rgba(255, 255, 255, 0.1);
            }

            button {
                transition: background-color 0.3s ease;
            }
            button:hover {
                background-color: #0056b3;
            }
            .slide-btn {
                position: absolute;
                top: 50%;
                transform: translateY(-50%);
                width: 40px;
                height: 40px;
                background: rgba(0, 0, 0, 0.5);
                border: none;
                border-radius: 50%;
                cursor: pointer;
                transition: background 0.3s;
            }

            /* Hover đổi màu nền */
            .slide-btn:hover {
                background: rgba(255, 255, 255, 0.3);
            }
            .custom-btn {
                filter: brightness(0) invert(1);
            }
            .custom-btn:focus,
            .custom-btn:active {
                outline: none;
                box-shadow: none;
            }
            .hotel-container {
                display: flex;
                justify-content: center;
                gap: 20px;
                padding: 20px;
            }

            .hotel-card {
                width: 23%; /* 4 cái trên 1 hàng */
                background: #222;
                border-radius: 12px;
                overflow: hidden;
                box-shadow: 0px 4px 10px rgba(255, 255, 255, 0.1);
                transition: transform 0.3s ease-in-out;
            }

            .hotel-card:hover {
                transform: scale(1.05);
            }

            .hotel-image {
                position: relative;
                width: 100%;
            }

            .hotel-image img {
                width: 100%;
                height: 200px;
                object-fit: cover;
                border-radius: 12px 12px 0 0;
            }

            .rating-badge {
                position: absolute;
                top: 10px;
                right: 10px;
                background: blue;
                color: white;
                padding: 5px 10px;
                font-weight: bold;
                border-radius: 6px;
            }

            .hotel-info {
                padding: 10px;
                color: white;
            }

            .stars span {
                color: gold;
            }

            .location, .distance, .meal {
                font-size: 14px;
                color: #ccc;
            }

            .highlight {
                font-size: 14px;
                color: lightblue;
                font-weight: bold;
            }

            /* Tùy chỉnh nút điều hướng */
            .carousel-control-prev, .carousel-control-next {
                width: 5%;
            }

            .carousel-control-prev-icon, .carousel-control-next-icon {
                filter: invert(1);
            }

            a {
                text-decoration: none;
            }
        </style>
    </head>
    <body>

        <%@ include file="/includes/header.jsp" %>

        <!-- Slider -->
        <div id="voucherCarousel" class="carousel slide" data-bs-ride="carousel" data-bs-interval="3000">
            <div class="carousel-inner">
                <div class="carousel-item active">
                    <img src="Content/Images/voucher1.png" class="d-block w-100" alt="Voucher 1">
                </div>
                <div class="carousel-item">
                    <img src="Content/Images/voucher2.png" class="d-block w-100" alt="Voucher 2">
                </div>
                <div class="carousel-item">
                    <img src="Content/Images/voucher3.png" class="d-block w-100" alt="Voucher 3">
                </div>
                <div class="carousel-item">
                    <img src="Content/Images/voucher4.png" class="d-block w-100" alt="Voucher 4">
                </div>
            </div>
            <button class="carousel-control-prev slide-btn"  type="button" data-bs-target="#voucherCarousel" data-bs-slide="prev">
                <span class="carousel-control-prev-icon" aria-hidden="true" ></span>
            </button>
            <button class="carousel-control-next slide-btn"  type="button" data-bs-target="#voucherCarousel" data-bs-slide="next">
                <span class="carousel-control-next-icon" aria-hidden="true"></span>
            </button>
        </div>

        <div class="search-container text-center bg-dark">
            <h2>Tìm kiếm ưu đãi khách sạn, chỗ nghỉ ...</h2>
            <form action="search.jsp" method="GET">
                <input type="text" name="city" placeholder="Nhập thành phố" required>
                <input type="date" name="checkin">
                <input type="date" name="checkout">
                <button type="submit" class="btn btn-primary">Tìm</button>
            </form>
        </div>

        <main class="container mt-5">
            <h3 class="text-white">Tìm theo Thành phố</h3>

            <div class="row">
                <c:forEach items="${listThanhPho}" var="tp" begin="0" end="1">
                    <div class="col-md-6">
                        <a href="${pageContext.request.contextPath}/khachsan?thanhPho=${tp.id}" class="city-link">
                            <div class="div-zoom">
                                <img class="img-zoom" src="${tp.urlHinhAnh}" alt="${tp.ten}">
                                <div class="chu-goc-trai">
                                    <span style="font-size: 20px; font-weight: bold;">${tp.ten}</span>
                                    <img src="Content/Images/vietnam.png" width="20">
                                    <br>
                                    <span style="font-size: 14px;">${tp.soKhachSan} chỗ ở</span>
                                </div>
                            </div>
                        </a>
                    </div>
                </c:forEach>
            </div>

            <div class="row">
                <c:forEach items="${listThanhPho}" var="tp" begin="2" end="4">
                    <div class="col-md-4 mb-4">
                        <a href="${pageContext.request.contextPath}/khachsan?thanhPho=${tp.id}" class="city-link">
                            <div class="div-zoom">
                                <img class="img-zoom" src="${tp.urlHinhAnh}" alt="${tp.ten}">
                                <div class="chu-goc-trai">
                                    <span style="font-size: 20px; font-weight: bold;">${tp.ten}</span>
                                    <img src="Content/Images/vietnam.png" width="20">
                                    <br>
                                    <span style="font-size: 14px;">${tp.soKhachSan} chỗ ở</span>
                                </div>
                            </div>
                        </a>
                    </div>
                </c:forEach>
            </div>

            <h3 class="text-white mt-5">Tìm theo Loại khách sạn</h3>

            <div id="hotelCategoryCarousel" class="carousel slide" data-bs-interval="false">
                <div class="carousel-inner">
                    <div class="carousel-item active">
                        <div class="d-flex justify-content-center">
                            <c:forEach items="${listLoaiKhachSan}" var="loai" varStatus="loop">
                                <div style="overflow: hidden; border-radius: 15px; position: relative;
                                     box-shadow: 0 4px 8px rgba(255, 255, 255, 0.1); transition: transform 0.3s ease-in-out;
                                     background: #1e1e1e; padding: 10px; border: 1px solid #2a2a2a; width: 18%; margin: 0 5px;
                                     text-align: center;"
                                     onmouseover="this.style.transform = 'scale(1.05)';"
                                     onmouseout="this.style.transform = 'scale(1)';">
                                    <a href="${pageContext.request.contextPath}/khachsan?thanhPho=${loai.id}" class="city-link">

                                        <img src="${loai.urlHinhAnh}" alt="${loai.ten}" style="width: 100%; height: 150px; object-fit: cover;
                                             border-radius: 10px; transition: transform 0.4s ease-in-out;"
                                             onmouseover="this.style.transform = 'scale(1.1)';"
                                             onmouseout="this.style.transform = 'scale(1)';">

                                        <div style="margin-top: 10px;">
                                            <span style="font-size: 18px; font-weight: bold; color: #0d6efd;">${loai.ten}</span>
                                            <br>
                                            <span style="font-size: 14px;">Gồm ${loai.soKhachSan*103} khách sạn</span>
                                        </div>
                                </div>
                                </a>
                                <c:if test="${loop.index % 5 == 4 and not loop.last}">
                                </div></div><div class="carousel-item"><div class="d-flex justify-content-center">
                            </c:if>
                        </c:forEach>
                        </div>
                    </div>
                </div>

                <!-- Nút Previous -->
                <button class="carousel-control-prev slide-btn " type="button" data-bs-target="#hotelCategoryCarousel" data-bs-slide="prev"
                        style="background: none; border: none;">
                    <span class="carousel-control-prev-icon" aria-hidden="true" 
                          ></span>
                </button>
                <!-- Nút Next -->
                <button class="carousel-control-next slide-btn" type="button" data-bs-target="#hotelCategoryCarousel" data-bs-slide="next"
                        style="background: none; border: none;">
                    <span class="carousel-control-next-icon" aria-hidden="true" 
                          ></span>
                </button>
            </div>
            <h3 class="text-white mt-5 ">🏨 Khách sạn nổi bật</h3>

            <div id="featuredHotelCarousel" class="carousel slide" data-bs-ride="carousel" data-bs-interval="3000">
                <div class="carousel-inner">
                    <c:forEach items="${khachSanNoiBac}" var="ks" varStatus="loop">
                        <c:if test="${loop.index % 4 == 0}">
                            <div class="carousel-item ${loop.index == 0 ? 'active' : ''}">
                                <div class="hotel-container">
                                </c:if>
                                <!-- Thẻ khách sạn -->
                                <div class="hotel-card">
                                    <a href="${pageContext.request.contextPath}/datphong?id=${ks.id}" class="city-link">
                                        <div class="hotel-image">
                                            <img src="Content/Images/KhachSan/${ks.id}.jpg" alt="${ks.ten}">
                                            <div class="rating-badge">${ks.danhGia}</div>
                                        </div>
                                        <div class="hotel-info">
                                            <h2>${ks.ten}</h2>
                                            <div class="stars">
                                                <c:forEach begin="1" end="${ks.danhGia}">
                                                    <span>⭐</span>
                                                </c:forEach>
                                            </div>
                                            <p class="location">📍 ${ks.tenThanhPho}</p>
                                            <c:if test="${ks.giapBien}">
                                                <p class="highlight">🌊 Giáp biển</p>
                                            </c:if>
                                            <p class="distance">🚕 Cách trung tâm: ${ks.cachTrungTam} km</p>
                                            <p class="meal">🍽 Bữa ăn: 
                                                <c:choose>
                                                    <c:when test="${ks.buaAn == 1}">Chỉ phòng</c:when>
                                                    <c:when test="${ks.buaAn == 2}">Bao ăn sáng</c:when>
                                                    <c:when test="${ks.buaAn == 3}">Full board</c:when>
                                                    <c:otherwise>Không rõ</c:otherwise>
                                                </c:choose>
                                            </p>
                                        </div>
                                </div>
                                </a>
                                <c:if test="${loop.index % 4 == 3 or loop.last}">
                                </div>
                            </div>
                        </c:if>
                    </c:forEach>
                </div>

                <!-- Nút điều hướng slide -->
                <button class="carousel-control-prev slide-btn " type="button" data-bs-target="#featuredHotelCarousel" data-bs-slide="prev">
                    <span class="carousel-control-prev-icon"></span>
                </button>

                <button class="carousel-control-next slide-btn" type="button" data-bs-target="#featuredHotelCarousel" data-bs-slide="next">
                    <span class="carousel-control-next-icon"></span>
                </button>
            </div>
        </div>
    </main>

    <footer class="bg-dark text-white text-center py-4 mt-5">
        <p>&copy; 2025 Nice Dream Hotel. All rights reserved.</p>
    </footer>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
