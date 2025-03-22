<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Nice Dream Hotel</title>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
        <link href="https://fonts.googleapis.com/css2?family=Allison&display=swap" rel="stylesheet">
        <style>
            .container, .container-fluid, .container-lg, .container-md, .container-sm, .container-xl, .container-xxl {
    --bs-gutter-x: 1.5rem;
    --bs-gutter-y: 0;
    width: 100%;
    /* padding-right: calc(var(--bs-gutter-x)* .5); */
    /* padding-left: calc(var(--bs-gutter-x)* .5); */
    margin-right: auto;
    margin-left: auto;
}
            .content {
                width: 1200px; /* Tăng nhẹ chiều rộng để thoáng hơn */
                margin: 0 auto; /* Căn giữa */
            }

            * {
                padding: 0;
                margin: 0;
                box-sizing: border-box;
            }

            body {
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

            .img-header {
                height: calc(100vh - 80px);
                background-image: url('${pageContext.request.contextPath}/Content/Images/header-img.jpg');
                background-size: cover;
                background-position: center center;
                background-repeat: no-repeat;
            }

            .img-header img {
                width: 100%;
                height: 100%;
                object-fit: cover;
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
                top: 15px; /* Tăng khoảng cách từ trên */
                left: 15px;
                background: rgba(0, 0, 0, 0.6);
                padding: 10px 15px; /* Tăng padding cho rộng rãi hơn */
                border-radius: 8px;
            }

            .row .col-md-6, .row .col-md-4 {
                padding: 20px; /* Tăng padding cho các cột */
            }

            /* Slider */
            .carousel-item img {
                height: 300px;
                object-fit: contain;
                border-radius: 10px;
            }

            .search-container {
                margin: -50px auto 60px; /* Tăng margin dưới để cách xa nội dung bên dưới */
                padding: 30px; /* Tăng padding cho thoáng */
                border-radius: 12px;
                box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
                max-width: 750px; /* Tăng chiều rộng nhẹ */
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
                width: 50px; /* Tăng kích thước nút điều hướng */
                height: 50px;
                border: none;
                border-radius: 50%;
                cursor: pointer;
                transition: background 0.3s;
                margin: 0 -50px; /* Tăng margin để nút cách xa nội dung */
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
                gap: 30px; /* Tăng khoảng cách giữa các thẻ khách sạn */
                padding: 30px; /* Tăng padding xung quanh */
            }

            .hotel-card {
                width: 24%; /* Tăng nhẹ chiều rộng mỗi thẻ */
                background: #FFFFFF;
                border-radius: 12px;
                overflow: hidden;
                box-shadow: 0px 4px 10px rgba(0, 0, 0, 0.1);
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
                height: 220px; /* Tăng chiều cao ảnh */
                object-fit: cover;
                border-radius: 12px 12px 0 0;
            }

            .rating-badge {
                position: absolute;
                top: 15px; /* Tăng khoảng cách từ trên */
                right: 15px;
                background: #2A7A6D;
                color: #F5E8C7;
                padding: 6px 12px; /* Tăng padding */
                font-weight: bold;
                border-radius: 6px;
            }

            .hotel-info {
                padding: 15px 20px; /* Tăng padding cho thoáng */
                color: #333;
            }

            .hotel-info h2 {
                font-size: 1.3rem; /* Tăng nhẹ kích thước chữ tiêu đề */
                margin-bottom: 10px; /* Tăng khoảng cách dưới */
            }

            .stars span {
                color: gold;
            }

            .location, .distance, .meal {
                font-size: 14px;
                color: #666;
                margin: 5px 0; /* Tăng khoảng cách giữa các dòng */
            }

            .highlight {
                font-size: 14px;
                color: #2A7A6D;
                font-weight: bold;
                margin: 5px 0;
            }

            .carousel-control-prev, .carousel-control-next {
                width: 5%;
            }

            .carousel-control-prev-icon, .carousel-control-next-icon {
                filter: invert(1);
            }

            a {
                text-decoration: none;
            }

            .search-container {
                background: #F5F6F5;
                color: #333;
                padding: 30px;
                margin: -50px auto 60px;
                border-radius: 12px;
                box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
                max-width: 750px;
                position: relative;
                z-index: 1;
            }

            .search-title {
                font-size: 24px; /* Tăng kích thước chữ */
                font-weight: 600;
                margin-bottom: 20px; /* Tăng khoảng cách dưới */
                text-align: center;
                color: #2A7A6D;
            }

            .search-form {
                display: flex;
                justify-content: center;
            }

            .search-box {
                display: flex;
                align-items: center;
                background: #FFFFFF;
                border-radius: 25px;
                padding: 8px; /* Tăng padding */
                width: 100%;
                max-width: 500px; /* Tăng chiều rộng */
                border: 2px solid #2A7A6D;
            }

            .search-icon {
                background: #2A7A6D;
                color: #F5E8C7;
                width: 40px; /* Tăng kích thước biểu tượng */
                height: 40px;
                display: flex;
                align-items: center;
                justify-content: center;
                border-radius: 50%;
                margin: 0 10px; /* Tăng margin */
            }

            .search-input {
                flex: 1;
                border: none;
                outline: none;
                padding: 12px; /* Tăng padding */
                font-size: 16px; /* Tăng kích thước chữ */
                color: #333;
            }

            .search-input::placeholder {
                color: #888;
                font-size: 15px;
            }

            .search-btn {
                background: #2A7A6D;
                color: #F5E8C7;
                border: none;
                padding: 12px 25px; /* Tăng padding */
                border-radius: 25px;
                font-size: 16px; /* Tăng kích thước chữ */
                cursor: pointer;
                transition: all 0.3s ease;
            }

            .search-btn:hover {
                background: #F5E8C7;
                color: #2A7A6D;
                border: 1px solid #2A7A6D;
            }

            .decor-letter {
                padding-top: 180px; /* Tăng padding trên */
                text-align: center;
                height: 220px; /* Tăng chiều cao */
            }

            .decor-letter h1 {
                font-family: "Allison", handwriting, sans-serif;
                font-size: 130px; /* Tăng kích thước chữ */
                font-weight: 400;
                letter-spacing: 0px;
                text-transform: none;
                color: #F5E8C7;
                transform: rotate(-2.4deg);
                margin-bottom: 15px; /* Tăng khoảng cách dưới */
            }

            .decor-letter span {
                font-size: 22px; /* Tăng kích thước chữ */
                font-weight: 400;
                text-transform: none;
                color: #F5E8C7;
                margin-bottom: 20px;
            }

            
            .view {
                margin-top: 60px; /* Tăng margin trên */
                text-align: center;
            }

            .title-view {
                margin-bottom: 40px; /* Tăng khoảng cách dưới */
            }

            .title-view h2 {
                font-size: 34px; /* Tăng kích thước chữ */
                font-weight: 700;
                color: #333;
                margin-bottom: 15px; /* Tăng khoảng cách dưới */
            }

            .title-view p {
                color: #666;
                font-weight: 300;
                max-width: 750px; /* Tăng chiều rộng tối đa */
                margin: 0 auto;
                font-size: 16px; /* Tăng kích thước chữ */
            }

            .view-list {
                display: flex;
                flex-wrap: wrap;
                gap: 30px; /* Tăng khoảng cách giữa các mục */
                justify-content: center;
            }

            .view-item {
                width: 32%;
                height: 320px; /* Tăng chiều cao */
                overflow: hidden;
                position: relative;
                border-radius: 10px;
                box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
            }

            .view-item img {
                width: 100%;
                height: 100%;
                object-fit: cover;
                border-radius: 10px;
                transition: transform 0.3s ease-in-out;
            }

            .view-item:hover img {
                transform: scale(1.05);
            }

            .view-item2 {
                width: 100%;
                margin-top: 30px; /* Tăng margin trên */
            }

            @media (max-width: 768px) {
                .view-item {
                    width: 48%;
                }

                .view-item2 {
                    width: 100%;
                }
            }

            @media (max-width: 480px) {
                .view-item {
                    width: 100%;
                }
            }

            .top-hotel, .search-hotel-title, .search-city {
                font-weight: 600;
                font-size: 34px; /* Tăng kích thước chữ */
                margin: 0 0 30px; /* Tăng margin trên và dưới */
            }

            .review-section {
                width: 100%;
                display: flex;
                justify-content: space-between;
                align-items: center;
                padding: 80px 120px; /* Tăng padding */
                background-color: black;
                color: #F5E8C7;
                margin: 0;
            }

            .review-left {
                flex: 1;
                padding: 30px; /* Tăng padding */
            }

            .review-left h2 {
                font-size: 38px; /* Tăng kích thước chữ */
                font-weight: bold;
                margin-bottom: 15px; /* Tăng khoảng cách dưới */
            }

            .review-left h3 {
                font-size: 34px; /* Tăng kích thước chữ */
                font-weight: 700;
                color: #2A7A6D;
                margin-bottom: 20px; /* Tăng khoảng cách dưới */
            }

            .review-left h3 span {
                color: #F5E8C7;
            }

            .review-left p {
                font-size: 18px;
                max-width: 650px; /* Tăng chiều rộng tối đa */
                margin: 0 auto 40px; /* Tăng margin dưới */
            }

            .review-right {
                width: 50%;
                flex: 1;
                padding: 30px; /* Tăng padding */
                display: flex;
                justify-content: center;
                align-items: center;
                background-image: url('${pageContext.request.contextPath}/Content/Images/reviewbg.jpg');
                background-size: cover;
                background-position: center;
                border-radius: 10px;
            }

            .review-card {
                display: flex;
                flex-direction: column;
                align-items: center;
                background-color: rgba(0, 0, 0, 0.5);
                padding: 25px; /* Tăng padding */
                border-radius: 10px;
                box-shadow: 0 4px 8px rgba(255, 255, 255, 0.1);
                max-width: 400px; /* Tăng chiều rộng tối đa */
                width: 100%;
                text-align: center;
            }

            .review-img img {
                width: 110px; /* Tăng kích thước ảnh */
                height: 110px;
                border-radius: 50%;
                object-fit: cover;
                margin-bottom: 15px; /* Tăng khoảng cách dưới */
            }

            .review-text p {
                font-size: 16px;
                line-height: 1.6; /* Tăng khoảng cách dòng */
            }

            .review-author {
                font-weight: bold;
                color: #2A7A6D;
                margin-top: 15px; /* Tăng khoảng cách trên */
            }

            .review-location {
                font-size: 14px;
                color: #ccc;
                margin-top: 5px; /* Tăng khoảng cách trên */
            }

            .view-more {
                margin-top: 40px; /* Tăng margin trên */
                text-align: center;
            }

            .view-more button {
                margin-left: 0; /* Xóa margin trái thừa */
                background-color: #2A7A6D;
                color: #F5E8C7;
                border: none;
                padding: 14px 30px; /* Tăng padding */
                font-size: 18px;
                border-radius: 50px;
                cursor: pointer;
                transition: background-color 0.3s;
            }

            .view-more button:hover {
                background-color: #1F5C51;
            }

            main {
                display: flex;
                flex-direction: column;
                align-items: center;
            }
        </style>
    </head>
    <body>

        <%@ include file="/includes/header.jsp" %>

        <!-- Slider -->
        <div class="img-header">
            <div class="decor-letter">
                <h1>
                    Book Your Vacation
                </h1>
            </div> 
        </div>

        <div class="search-container">
            <h2 class="search-title">🔍 Tìm kiếm ưu đãi khách sạn, chỗ nghỉ ...</h2>
            <form action="khachsan" method="POST" class="search-form">
                <div class="search-box">
                    <span class="search-icon"><i class="fas fa-search"></i></span>
                    <input type="text" name="keyword" class="search-input" placeholder="Nhập thành phố hoặc khách sạn..." required>
                    <button type="submit" class="search-btn">Tìm kiếm</button>
                </div>
            </form>
        </div>

                <main class="container-fluid">
            <div class="content">
                <h3>Khám phá Việt Nam</h3>
                <p>Các điểm đến phổ biến này có nhiều điều thú vị đang chờ đón bạn</p>

                <div class="row">
                    <c:forEach items="${listThanhPho}" var="tp" begin="0" end="1">
                        <div class="col-md-6">
                            <a href="${pageContext.request.contextPath}/khachsan?thanhPho=${tp.id}" class="city-link">
                                <div class="div-zoom">
                                    <img class="img-zoom" src="${tp.urlHinhAnh}" alt="${tp.ten}">
                                    <div class="chu-goc-trai">
                                        <span style="font-size: 20px; font-weight: 600;">${tp.ten}</span>
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
                                        <span style="font-size: 20px; font-weight: 600;">${tp.ten}</span>
                                        <img src="Content/Images/vietnam.png" width="20">
                                        <br>
                                        <span style="font-size: 14px;">${tp.soKhachSan} chỗ ở</span>
                                    </div>
                                </div>
                            </a>
                        </div>
                    </c:forEach>
                </div>

                <h3 class="search-hotel-title mt-5">TÌM THEO LOẠI KHÁCH SẠN</h3>

                <div id="hotelCategoryCarousel" class="carousel slide" data-bs-interval="false">
                    <div class="carousel-inner">
                        <div class="carousel-item active">
                            <div class="d-flex justify-content-center">
                                <c:forEach items="${listLoaiKhachSan}" var="loai" varStatus="loop">
                                    <div style="overflow: hidden; border-radius: 15px; position: relative;
                                         box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
                                         transition: transform 0.3s ease-in-out;
                                         background: #F5F6F5;
                                         padding: 15px; /* Tăng padding */
                                         border: 1px solid #E0E0E0;
                                         width: 19%; /* Tăng nhẹ chiều rộng */
                                         margin: 0 10px; /* Tăng khoảng cách giữa các mục */
                                         text-align: center;"
                                         onmouseover="this.style.transform = 'scale(1.05)';"
                                         onmouseout="this.style.transform = 'scale(1)';">
                                        <a href="${pageContext.request.contextPath}/khachsan?loaiKhachSan=${loai.id}" class="city-link">
                                            <img src="${loai.urlHinhAnh}" alt="${loai.ten}" style="width: 100%; height: 160px; /* Tăng chiều cao ảnh */
                                                 object-fit: cover;
                                                 border-radius: 10px; transition: transform 0.4s ease-in-out;"
                                                 onmouseover="this.style.transform = 'scale(1.1)';"
                                                 onmouseout="this.style.transform = 'scale(1)';">
                                            <div style="margin-top: 15px;"> <!-- Tăng margin trên -->
                                                <span style="font-size: 18px; font-weight: bold; color: #2A7A6D;">${loai.ten}</span>
                                                <br>
                                                <span style="font-size: 14px; color: #666;">Gồm ${loai.soKhachSan*103} khách sạn</span>
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
                        <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                    </button>
                    <!-- Nút Next -->
                    <button class="carousel-control-next slide-btn" type="button" data-bs-target="#hotelCategoryCarousel" data-bs-slide="next"
                            style="background: none; border: none;">
                        <span class="carousel-control-next-icon" aria-hidden="true"></span>
                    </button>
                </div>
            </div>
            <!--View-->
            <div class="view">
                <div class="content">
                    <div class="title-view">
                        <h2>Cảnh đẹp tại khách sạn</h2>
                        <p>Khám phá những góc cảnh tuyệt đẹp và không gian sang trọng tại khách sạn của chúng tôi. Mỗi góc đều mang đến sự thư giãn và kỳ nghỉ đáng nhớ.</p>
                    </div>
                    <div class="view-list">
                        <div class="row">
                            <div class="view-item">
                                <img src="${pageContext.request.contextPath}/Content/Images/gallery1.jpg" alt="alt"/>
                            </div>
                            <div class="view-item">
                                <img src="${pageContext.request.contextPath}/Content/Images/gallery16.jpg" alt="alt"/>
                            </div>
                            <div class="view-item">
                                <img src="${pageContext.request.contextPath}/Content/Images/gallery3.jpg" alt="alt"/>
                            </div>
                        </div>
                        <div class="row">
                            <div class="view-item">
                                <img src="${pageContext.request.contextPath}/Content/Images/gallery15.jpg" alt="alt"/>
                            </div>
                            <div class="view-item">
                                <img src="${pageContext.request.contextPath}/Content/Images/gallery5.jpg" alt="alt"/>
                            </div>
                            <div class="view-item">
                                <img src="${pageContext.request.contextPath}/Content/Images/gallery17.jpg" alt="alt"/>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <h3 class="top-hotel mt-5 ">🏨 Khách sạn nổi bật</h3>

            <div id="featuredHotelCarousel" class="carousel slide" data-bs-ride="carousel" data-bs-interval="3000">
                <div class="content">
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
                                                <div class="rating-badge">${ks.danhGia}⭐</div>
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
            <div class="review-section">
                <div class="review-left">
                    <h2>Ý kiến khách hàng</h2>
                    <h3>Đánh giá từ <span>Du khách</h3>
                    <p>Khách hàng chia sẻ những trải nghiệm tuyệt vời và khoảnh khắc đáng nhớ của họ. Khám phá lý do họ yêu thích lưu trú cùng chúng tôi.</p>
                </div>

                <div class="review-right">
                    <div class="review-card">
                        <div class="review-img">
                            <img src="${pageContext.request.contextPath}/Content/Images/avt-review.png" alt="Reviewer Image">
                        </div>
                        <div class="review-text">
                            <p>"Tôi đã có một kỳ nghỉ tuyệt vời! Nhân viên rất thân thiện và tiện nghi thì đẳng cấp. Rất đáng để giới thiệu!""</p>
                            <p class="review-author">Micheal Clordy</p>
                            <p class="review-location">Germany</p>
                        </div>
                    </div>
                </div>

            </div>
        </div>
    </main>

    <%@ include file="/includes/footer.jsp" %>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>