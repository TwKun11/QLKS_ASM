package filter;

import jakarta.servlet.FilterChain;
import jakarta.servlet.FilterConfig;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.Arrays;
import java.util.List;
import model.TaiKhoan;

@WebFilter("/*")
public class AuthenticationFilter extends HttpFilter {

    // Danh sách các đường dẫn công khai (không cần đăng nhập)
    private static final List<String> PUBLIC_PREFIXES = Arrays.asList(
    "/products", "/assets/", "/pages/", "/home", "/khachsan", "/datphong",
    "/RegisterServlet", "/forgotPassword", "/verifyOTP", "/resetPassword", "/LoginServlet", "/logout",
    "/Content/", "/payment", "/returnPayment", "/ChangePasswordServlet" // Thêm đường dẫn đến tài nguyên tĩnh
);

    // Danh sách các đường dẫn chỉ dành cho admin
    private static final List<String> ADMIN_ONLY_PREFIXES = Arrays.asList(
        "/admin/", "/users", "/thanhphos", "/taikhoans", "/phongs", "/loaikhachsans", "/khachsans", "/datphongs"
    );

    // Danh sách các đường dẫn người dùng thông thường được phép truy cập
    private static final List<String> USER_ALLOWED_PREFIXES = Arrays.asList(
        "/cart", "/home", "/khachsan", "/datphong", "/xacnhandatphong", "/huydatphong", "/profile"
    );

    // Danh sách hậu tố người dùng được phép truy cập
    private static final List<String> USER_ALLOWED_SUFFIXES = Arrays.asList(
        "checkout"
    );

    @Override
    public void doFilter(HttpServletRequest request, HttpServletResponse response, FilterChain chain)
            throws IOException, ServletException {
        HttpSession session = request.getSession(false);
        TaiKhoan sessionAcc = (session != null) ? (TaiKhoan) session.getAttribute("user") : null;
        String path = request.getServletPath();

        // Kiểm tra xem đường dẫn có phải là admin-only trước tiên
        boolean isAdminOnlyPath = ADMIN_ONLY_PREFIXES.stream().anyMatch(path::startsWith);
        if (isAdminOnlyPath) {
            if (sessionAcc != null && sessionAcc.getIdRole() == 1) {
                chain.doFilter(request, response); // Chỉ admin được phép truy cập
            } else {
                response.sendRedirect(request.getContextPath() + "/pages/accessDenied.jsp"); // Chặn người dùng thường
            }
            return;
        }

        // Kiểm tra các đường dẫn công khai (không cần đăng nhập)
        if (PUBLIC_PREFIXES.stream().anyMatch(path::startsWith)) {
            chain.doFilter(request, response);
            return;
        }

        // Nếu chưa đăng nhập, chuyển hướng về trang đăng nhập
        if (sessionAcc == null) {
            response.sendRedirect(request.getContextPath() + "/pages/login.jsp");
            return;
        }

        int role = sessionAcc.getIdRole();
        boolean isAdmin = role == 1;
        boolean isUser = role == 2;

        // Kiểm tra các đường dẫn người dùng được phép truy cập
        boolean isUserAllowedPath = USER_ALLOWED_PREFIXES.stream().anyMatch(path::startsWith) ||
                                   USER_ALLOWED_SUFFIXES.stream().anyMatch(path::endsWith);

        if (isAdmin || (isUser && isUserAllowedPath)) {
            chain.doFilter(request, response); // Admin truy cập mọi thứ, người dùng chỉ truy cập được phần cho phép
        } else {
            response.sendRedirect(request.getContextPath() + "/pages/accessDenied.jsp");
        }
    }

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        // Không cần thiết lập thêm
    }

    @Override
    public void destroy() {
        // Không cần dọn dẹp
    }
}