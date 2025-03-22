<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Chi Tiết Khách Sạn</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
        <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;700&display=swap" rel="stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
        <link rel="stylesheet" href="https://unpkg.com/leaflet@1.9.4/dist/leaflet.css" />
        <style>
            * { margin: 0; padding: 0; box-sizing: border-box; }
            body {
                font-family: 'Poppins', Arial, sans-serif;
                background-color: #FFF8E1; /* Trắng kem làm nền */
                color: #333; /* Màu chữ tối để dễ đọc */
                line-height: 1.6;
                overflow-x: hidden;
            }
            header {
                background-color: #D32F2F; /* Đỏ đậm cho header */
                position: relative;
                z-index: 10;
            }
            .overlay {
                position: fixed;
                top: 0;
                left: 0;
                width: 100%;
                height: 100%;
                background-color: rgba(31, 42, 68, 0.6);
                z-index: 5;
                animation: fadeIn 0.5s ease-in;
            }
            h1 {
                font-size: 2rem; /* 32px */
                text-align: center;
                margin: 2.5rem 0;
                color: #D32F2F; /* Đỏ đậm cho tiêu đề chính */
                animation: slideInFromTop 0.8s ease-out;
            }
            .search-overlay {
                background-color: #ffffff;
                border-radius: 10px;
                box-shadow: 0 6px 25px rgba(0, 0, 0, 0.1);
                padding: 1.875rem; /* 30px */
                position: sticky;
                top: 1.25rem; /* 20px */
                z-index: 10;
                max-width: 62.5rem; /* 1000px */
                margin: 1.25rem auto; /* 20px */
                animation: slideInFromTop 0.6s ease-out;
            }
            .search-overlay.static { position: static; box-shadow: none; }
            .search-overlay form {
                display: flex;
                gap: 1.5625rem; /* 25px */
                align-items: center;
                justify-content: center;
                flex-wrap: wrap;
            }
            .search-overlay label { font-size: 1rem; /* 16px */ font-weight: 500; color: #333; }
            .search-overlay input[type="date"] {
                padding: 0.75rem; /* 12px */
                border: 1px solid #ccc;
                border-radius: 6px;
                font-size: 1rem; /* 16px */
                width: 13.75rem; /* 220px */
                background-color: #FFF8E1; /* Trắng kem */
                color: #333;
                transition: border-color 0.3s ease;
            }
            .search-overlay input[type="date"]:focus { border-color: #D32F2F; outline: none; }
            .search-overlay button {
                background-color: #D32F2F; /* Đỏ đậm */
                color: #fff;
                padding: 0.75rem 2.1875rem; /* 12px 35px */
                border: none;
                border-radius: 6px;
                font-size: 1rem; /* 16px */
                cursor: pointer;
                transition: background-color 0.3s ease, transform 0.2s ease;
            }
            .search-overlay button:hover { background-color: #B71C1C; /* Đỏ đậm hơn */ transform: translateY(-2px); }

            /* Layout chính */
            .main-container {
                display: flex;
                max-width: 75rem; /* 1200px */
                margin: 2.5rem auto; /* 40px */
                gap: 1.25rem; /* 20px */
            }
            .left-section { flex: 1 1 30%; display: flex; flex-direction: column; gap: 1.25rem; /* 20px */ }
            .right-section { flex: 1 1 70%; display: flex; flex-direction: column; gap: 1.25rem; /* 20px */ }

            /* Bản đồ nhỏ */
            .map-section { flex: 1; }
            #map { height: 12.5rem; /* 200px */ width: 100%; border-radius: 10px; box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1); background-color: #333; }
            .rating-section {
                margin-top: 0.9375rem; /* 15px */
                background-color: #fff; /* Trắng */
                padding: 0.9375rem; /* 15px */
                border-radius: 10px;
                box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
                text-align: center;
            }
            .rating-section p { margin: 0; font-size: 1rem; /* 16px */ color: #666; display: flex; justify-content: center; align-items: center; gap: 0.625rem; /* 10px */ }
            .rating-section p i { color: #D32F2F; /* Đỏ đậm */ }
            .rating-section p span.stars { color: #FFD700; /* Vàng */ }

            /* Thông tin khách sạn */
            .hotel-info {
                background-color: #fff; /* Trắng */
                border-radius: 10px;
                box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
                padding: 1.875rem; /* 30px */
                animation: fadeInUp 0.8s ease-out;
            }
            .hotel-info img { width: 100%; max-height: 12.5rem; /* 200px */ object-fit: cover; border-radius: 8px; margin-bottom: 0.9375rem; /* 15px */ }
            .hotel-info h2 { font-size: 1.75rem; /* 28px */ color: #D32F2F; /* Đỏ đậm */ margin-bottom: 0.9375rem; /* 15px */ }
            .hotel-info p { font-size: 1rem; /* 16px */ margin: 0.625rem 0; /* 10px */ display: flex; align-items: center; gap: 0.625rem; /* 10px */ color: #666; }
            .hotel-info p strong { color: #333; min-width: 7.5rem; /* 120px */ }
            .hotel-info p i { color: #D32F2F; /* Đỏ đậm */ }

            /* Phòng */
            .room {
                background-color: #fff; /* Trắng */
                border-radius: 10px;
                box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
                padding: 1.25rem; /* 20px */
                animation: fadeInUp 1s ease-out;
                transition: transform 0.3s ease;
            }
            .room:hover { transform: translateY(-5px); }
            .room h4 { font-size: 1.25rem; /* 20px */ color: #D32F2F; /* Đỏ đậm */ margin-bottom: 0.625rem; /* 10px */ }
            .room p { font-size: 0.9375rem; /* 15px */ color: #666; margin: 0.5rem 0; /* 8px */ display: flex; align-items: center; gap: 0.625rem; /* 10px */ }
            .room p i { color: #D32F2F; /* Đỏ đậm */ }
            .room button {
                background: linear-gradient(45deg, #D32F2F, #FF6659); /* Gradient đỏ */
                color: #fff;
                padding: 0.625rem 1.5625rem; /* 10px 25px */
                border: none;
                border-radius: 6px;
                font-size: 0.9375rem; /* 15px */
                cursor: pointer;
                transition: background 0.3s ease, transform 0.2s ease;
            }
            .room button:hover { background: linear-gradient(45deg, #B71C1C, #E53935); transform: translateY(-2px); }

            /* Tiện ích và chính sách */
            .extra-info, .policy-section {
                background-color: #fff; /* Trắng */
                border-radius: 10px;
                box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
                padding: 1.25rem; /* 20px */
                animation: fadeInUp 0.8s ease-out;
            }
            .extra-info h4, .policy-section h4 { font-size: 1.25rem; /* 20px */ color: #D32F2F; /* Đỏ đậm */ margin-bottom: 0.9375rem; /* 15px */ }
            .extra-info ul { list-style: none; padding: 0; }
            .extra-info ul li, .policy-section p { font-size: 0.9375rem; /* 15px */ color: #666; margin: 0.625rem 0; /* 10px */ display: flex; align-items: center; gap: 0.625rem; /* 10px */ }
            .extra-info ul li i, .policy-section p i { color: #D32F2F; /* Đỏ đậm */ }

            h3 { font-size: 1.5rem; /* 24px */ text-align: center; margin: 2.5rem 0 1.25rem; /* 40px 0 20px */ color: #D32F2F; animation: fadeIn 0.8s ease-out; }
            .message { color: #D32F2F; /* Đỏ đậm */ text-align: center; font-size: 1rem; /* 16px */ margin: 1.25rem 0; /* 20px */ animation: fadeIn 0.5s ease-out; }

            /* Đặt câu hỏi */
            .question-section {
                background-color: #fff; /* Trắng */
                border-radius: 10px;
                box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
                padding: 1.25rem; /* 20px */
                max-width: 56.25rem; /* 900px */
                margin: 1.25rem auto; /* 20px */
                animation: fadeInUp 0.8s ease-out;
            }
            .question-section h4 { font-size: 1.25rem; /* 20px */ color: #D32F2F; /* Đỏ đậm */ margin-bottom: 0.9375rem; /* 15px */ }
            .question-section form { display: flex; flex-direction: column; gap: 0.9375rem; /* 15px */ }
            .question-section input, .question-section textarea {
                padding: 0.625rem; /* 10px */
                border: 1px solid #ccc;
                border-radius: 6px;
                background-color: #FFF8E1; /* Trắng kem */
                color: #333;
                font-size: 0.9375rem; /* 15px */
                resize: none;
            }
            .question-section button {
                background: linear-gradient(45deg, #D32F2F, #FF6659); /* Gradient đỏ */
                color: #fff;
                padding: 0.625rem 1.5625rem; /* 10px 25px */
                border: none;
                border-radius: 6px;
                font-size: 0.9375rem; /* 15px */
                cursor: pointer;
                transition: background 0.3s ease, transform 0.2s ease;
                align-self: flex-start;
            }
            .question-section button:hover { background: linear-gradient(45deg, #B71C1C, #E53935); transform: translateY(-2px); }

            @keyframes fadeIn { from { opacity: 0; } to { opacity: 1; } }
            @keyframes fadeInUp { from { opacity: 0; transform: translateY(20px); } to { opacity: 1; transform: translateY(0); } }
            @keyframes slideInFromTop { from { opacity: 0; transform: translateY(-50px); } to { opacity: 1; transform: translateY(0); } }
        </style>
    </head>
    <body>
        <header>
            <%@ include file="/includes/header.jsp" %>
        </header>

        <c:if test="${empty danhSachPhong && empty message}">
            <div class="overlay" id="overlay"></div>
        </c:if>

        <div class="search-overlay" id="searchOverlay">
            <form id="searchForm" action="datphong" method="post">
                <input type="hidden" name="idKhachSan" value="${khachSan.id}">
                <label><i class="fas fa-calendar-alt"></i> Ngày nhận phòng:</label>
                <input type="date" name="ngayDen" id="ngayDen" value="${ngayDen}" required>
                <label><i class="fas fa-calendar-alt"></i> Ngày trả phòng:</label>
                <input type="date" name="ngayTra" id="ngayTra" value="${ngayTra}" required>
                <button type="submit"><i class="fas fa-search"></i> Kiểm tra phòng</button>
            </form>
            <p id="dateError" class="message" style="display: none;"></p> <!-- Thêm phần tử hiển thị lỗi -->
            <c:if test="${not empty message}">
                <p class="message"><i class="fas fa-exclamation-circle"></i> ${message}</p>
            </c:if>
        </div>

        <h1><i class="fas fa-hotel"></i> Chi Tiết Khách Sạn</h1>

        <c:if test="${empty khachSan}">
            <p class="message"><i class="fas fa-exclamation-triangle"></i> Không tìm thấy khách sạn.</p>
        </c:if>

        <c:if test="${not empty khachSan}">
            <div class="main-container">
                <!-- Bên trái: Tiện ích, chính sách, bản đồ -->
                <div class="left-section">
                    <div class="map-section">
                        <div id="map"></div>
                        <div class="rating-section">
                            <p><i class="fas fa-star"></i> <strong>Đánh giá:</strong> <span class="stars"><c:forEach begin="1" end="${khachSan.danhGia}">⭐</c:forEach></span> (${khachSan.danhGia}/5)</p>
                        </div>
                    </div>
                    <div class="extra-info">
                        <h4><i class="fas fa-info-circle"></i> Tiện ích khách sạn</h4>
                        <ul>
                            <li><i class="fas fa-wifi"></i> Wi-Fi miễn phí</li>
                            <li><i class="fas fa-swimming-pool"></i> Hồ bơi ngoài trời</li>
                            <li><i class="fas fa-parking"></i> Bãi đỗ xe miễn phí</li>
                            <li><i class="fas fa-concierge-bell"></i> Dịch vụ lễ tân 24/7</li>
                            <li><i class="fas fa-dumbbell"></i> Phòng gym</li>
                            <li><i class="fas fa-spa"></i> Spa thư giãn</li>
                        </ul>
                    </div>
                    <div class="policy-section">
                        <h4><i class="fas fa-file-alt"></i> Chính sách khách sạn</h4>
                        <p><i class="fas fa-clock"></i> <strong>Nhận phòng:</strong> Từ 14:00</p>
                        <p><i class="fas fa-clock"></i> <strong>Trả phòng:</strong> Trước 12:00</p>
                        <p><i class="fas fa-ban"></i> <strong>Hủy phòng:</strong> Miễn phí nếu hủy trước 48 giờ</p>
                        <p><i class="fas fa-paw"></i> <strong>Thú cưng:</strong> Không cho phép</p>
                        <p><i class="fas fa-smoking-ban"></i> <strong>Hút thuốc:</strong> Cấm hút thuốc trong khuôn viên</p>
                    </div>
                </div>

                <!-- Bên phải: Thông tin khách sạn và phòng -->
                <div class="right-section">
                    <div class="hotel-info">
                        <h2>${khachSan.ten}</h2>
                        <img src="Content/Images/KhachSan/${khachSan.id}.jpg" alt="${khachSan.ten}">
                        <p><i class="fas fa-map-marker-alt"></i> <strong>Địa chỉ:</strong> 79 Trần Cung, Quận Từ Liêm, Hà Nội</p>
                        <p><i class="fas fa-phone"></i> <strong>Số điện thoại:</strong> 0366918587</p>
                        <p><i class="fas fa-ruler"></i> <strong>Cách trung tâm:</strong> ${khachSan.cachTrungTam != null ? khachSan.cachTrungTam : 5} km</p>
                        <p><i class="fas fa-utensils"></i> <strong>Bữa ăn:</strong> 
                            <c:choose>
                                <c:when test="${khachSan.buaAn == 1}">Chỉ phòng</c:when>
                                <c:when test="${khachSan.buaAn == 2}">Bao ăn sáng</c:when>
                                <c:when test="${khachSan.buaAn == 3}">Full board</c:when>
                                <c:otherwise>Không rõ</c:otherwise>
                            </c:choose>
                        </p>
                    </div>

                    <c:if test="${not empty danhSachPhong}">
                        <h3><i class="fas fa-bed"></i> Danh Sách Phòng Trống</h3>
                        <c:forEach var="phong" items="${danhSachPhong}">
                            <div class="room">
                                <h4>${phong.ten}</h4>
                                <p><i class="fas fa-money-bill-wave"></i> <strong>Giá thuê:</strong> ${phong.giaThue} VNĐ</p>
                                <p><i class="fas fa-couch"></i> <strong>Tiện nghi:</strong> ${phong.tienNghi}</p>
                                <p><i class="fas fa-users"></i> <strong>Sức chứa:</strong> 2-4 người</p>
                                <p><i class="fas fa-ruler-combined"></i> <strong>Diện tích:</strong> ${phong.dienTich} m²</p>
                                <p><i class="fas fa-bed"></i> <strong>Loại giường:</strong> 
                                    <c:choose>
                                        <c:when test="${phong.loaiGiuong == 0}">Giường đơn</c:when>
                                        <c:when test="${phong.loaiGiuong == 1}">Giường đôi</c:when>
                                        <c:otherwise>Không rõ</c:otherwise>
                                    </c:choose>
                                </p>
                                <form action="xacnhandatphong" method="get">
                                    <input type="hidden" name="giaThue" value="${phong.giaThue}">
                                    <input type="hidden" name="idPhong" value="${phong.id}">
                                    <input type="hidden" name="tenPhong" value="${phong.ten}">
                                    <input type="hidden" name="ngayDen" value="${ngayDen}">
                                    <input type="hidden" name="ngayTra" value="${ngayTra}">
                                    <button type="submit"><i class="fas fa-bookmark"></i> Đặt phòng</button>
                                </form>
                            </div>
                        </c:forEach>
                    </c:if>
                </div>
            </div>

            <!-- Đặt câu hỏi -->
            <div class="question-section">
                <h4><i class="fas fa-question-circle"></i> Đặt câu hỏi với chúng tôi</h4>
                <form action="submitQuestion" method="post">
                    <input type="text" name="name" placeholder="Họ và tên" required>
                    <input type="email" name="email" placeholder="Email" required>
                    <textarea name="question" rows="4" placeholder="Câu hỏi của bạn..." required></textarea>
                    <button type="submit"><i class="fas fa-paper-plane"></i> Gửi câu hỏi</button>
                </form>
            </div>
        </c:if>

        <script src="https://unpkg.com/leaflet@1.9.4/dist/leaflet.js"></script>
        <script>
            const today = new Date().toISOString().split('T')[0];
            const ngayDenInput = document.getElementById('ngayDen');
            const ngayTraInput = document.getElementById('ngayTra');
            const dateError = document.getElementById('dateError');

            if (!ngayDenInput.value) ngayDenInput.value = today;
            if (!ngayTraInput.value) ngayTraInput.value = today;

            document.getElementById('searchForm').addEventListener('submit', function(event) {
                const ngayDen = new Date(ngayDenInput.value);
                const ngayTra = new Date(ngayTraInput.value);
                const todayDate = new Date();
                todayDate.setHours(0, 0, 0, 0);

                const overlay = document.getElementById('overlay');
                const searchOverlay = document.getElementById('searchOverlay');

                // Kiểm tra nếu ngày nhận và ngày trả trùng nhau
                if (ngayDen.getTime() === ngayTra.getTime()) {
                    event.preventDefault();
                    dateError.style.display = 'block';
                    dateError.innerHTML = '<i class="fas fa-exclamation-circle"></i> Ngày nhận phòng và ngày trả phòng không được trùng nhau.';
                    if (overlay) overlay.style.display = 'block';
                } 
                // Kiểm tra các điều kiện khác
                else if (ngayDen < todayDate || ngayTra <= ngayDen) {
                    event.preventDefault();
                    dateError.style.display = 'block';
                    dateError.innerHTML = '<i class="fas fa-exclamation-circle"></i> Vui lòng kiểm tra lại ngày nhận phòng và trả phòng.';
                    if (overlay) overlay.style.display = 'block';
                } 
                else {
                    dateError.style.display = 'none'; // Ẩn thông báo lỗi nếu không có vấn đề
                    if (overlay) {
                        overlay.style.display = 'none';
                        overlay.removeAttribute('style');
                        overlay.classList.remove('overlay');
                    }
                    if (searchOverlay) searchOverlay.classList.add('static');
                    localStorage.setItem('searchCompleted', 'true');
                }
            });

            if (localStorage.getItem('searchCompleted') === 'true' && '${not empty danhSachPhong}' === 'true') {
                const overlay = document.getElementById('overlay');
                const searchOverlay = document.getElementById('searchOverlay');
                if (overlay) overlay.parentNode.removeChild(overlay);
                if (searchOverlay) searchOverlay.classList.add('static');
            }

            // Khởi tạo bản đồ với Leaflet.js
            var map = L.map('map').setView([21.027763, 105.834160], 15);
            L.tileLayer('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {
                attribution: '© <a href="https://www.openstreetmap.org/copyright">OpenStreetMap</a> contributors'
            }).addTo(map);
            L.marker([21.027763, 105.834160]).addTo(map)
                .bindPopup("The Light Hotel - 79 Trần Cung, Quận Từ Liêm, Hà Nội")
                .openPopup();
        </script>
    </body>
</html>