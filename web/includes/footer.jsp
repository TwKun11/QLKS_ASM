<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<footer>
    <div class="footer-container">
        <div class="footer-section">
            <h4>Nice Dream Hotel</h4>
            <p>Trải nghiệm nghỉ dưỡng tuyệt vời với dịch vụ đẳng cấp.</p>
        </div>
        <div class="footer-section">
            <h4>Liên hệ</h4>
            <p>Email: contact@nicedreamhotel.com</p>
            <p>Hotline: 0123 456 789</p>
            <p>Địa chỉ: 123 Đường Giấc Mơ, TP. HCM</p>
        </div>
        <div class="footer-section">
            <h4>Theo dõi chúng tôi</h4>
            <div class="social-links">
                <a href="#" target="_blank"><i class="fab fa-facebook-f"></i></a>
                <a href="#" target="_blank"><i class="fab fa-instagram"></i></a>
                <a href="#" target="_blank"><i class="fab fa-twitter"></i></a>
            </div>
        </div>
    </div>
    <div class="footer-bottom">
        <p>© 2025 Nice Dream Hotel. All rights reserved.</p>
    </div>
</footer>

<style>
    footer {
        background-color: #36383b; /* Xanh dương nhạt */
        color: white;
        padding: 40px 0 20px;
        width: 100%;
        font-family: 'Poppins', sans-serif;
    }

    .footer-container {
        max-width: 1200px;
        margin: 0 auto;
        display: flex;
        justify-content: space-between;
        flex-wrap: wrap;
        padding: 0 20px;
    }

    .footer-section {
        flex: 1;
        min-width: 200px;
        margin-bottom: 20px;
    }

    .footer-section h4 {
        font-size: 18px;
        font-weight: 600;
        margin-bottom: 15px;
        color: #F5A623; /* Vàng nhạt */
    }

    .footer-section p {
        font-size: 14px;
        margin: 5px 0;
        line-height: 1.5;
    }

    .social-links {
        display: flex;
        gap: 15px;
    }

    .social-links a {
        color: white;
        font-size: 18px;
        text-decoration: none;
        transition: color 0.3s ease;
    }

    .social-links a:hover {
        color: #F5A623; /* Vàng nhạt khi hover */
    }

    .footer-bottom {
        text-align: center;
        padding-top: 20px;
        border-top: 1px solid rgba(255, 255, 255, 0.2);
        margin-top: 20px;
        font-size: 14px;
    }

    /* Responsive */
    @media (max-width: 768px) {
        .footer-container {
            flex-direction: column;
            text-align: center;
        }
        .footer-section {
            margin-bottom: 30px;
        }
        .social-links {
            justify-content: center;
        }
    }
</style>

<!-- Font Awesome cho biểu tượng mạng xã hội -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">