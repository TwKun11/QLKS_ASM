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
        <button class="carousel-control-prev" type="button" data-bs-target="#voucherCarousel" data-bs-slide="prev">
            <span class="carousel-control-prev-icon" aria-hidden="true"></span>
        </button>
        <button class="carousel-control-next" type="button" data-bs-target="#voucherCarousel" data-bs-slide="next">
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
                    <div class="div-zoom">
                        <img class="img-zoom" src="${tp.urlHinhAnh}" alt="${tp.ten}">
                        <div class="chu-goc-trai">
                            <span style="font-size: 20px; font-weight: bold;">${tp.ten}</span>
                            <img src="Content/Images/vietnam.png" width="20">
                            <br>
                            <span style="font-size: 14px;">${tp.soKhachSan} chỗ ở</span>
                        </div>
                    </div>
                </div>
            </c:forEach>
        </div>

        <div class="row">
            <c:forEach items="${listThanhPho}" var="tp" begin="2" end="4">
                <div class="col-md-4 mb-4">
                    <div class="div-zoom">
                        <img class="img-zoom" src="${tp.urlHinhAnh}" alt="${tp.ten}">
                        <div class="chu-goc-trai">
                            <span style="font-size: 20px; font-weight: bold;">${tp.ten}</span>
                            <img src="Content/images/vietnam-flag.png" width="20">
                            <br>
                            <span style="font-size: 14px;">${tp.soKhachSan} chỗ ở</span>
                        </div>
                    </div>
                </div>
            </c:forEach>
        </div>
    </main>
    
    <footer class="bg-dark text-white text-center py-4 mt-5">
        <p>&copy; 2025 Nice Dream Hotel. All rights reserved.</p>
    </footer>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
