package Model;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import ConnectDB.DBConnect;

@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        // ✅ Kiểm tra nếu username hoặc password bị rỗng
        if (username == null || username.isEmpty() || password == null || password.isEmpty()) {
            request.setAttribute("errorMessage", "Tên đăng nhập và mật khẩu không được để trống!");
            request.getRequestDispatcher("login.jsp").forward(request, response);
            return;
        }

        // ✅ Mã hóa mật khẩu giống với cách đã làm trong đăng ký
        String hashedPassword = Integer.toHexString(password.hashCode());
        System.out.println("🔍 [DEBUG] Username: " + username);
        System.out.println("🔍 [DEBUG] Mật khẩu mã hóa: " + hashedPassword);

        // ✅ Kiểm tra thông tin đăng nhập
        String sql = "SELECT username FROM users WHERE username = ? AND password = ?";

        try (Connection conn = DBConnect.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql)) {

            if (conn == null) {
                request.setAttribute("errorMessage", "Không thể kết nối đến database!");
                request.getRequestDispatcher("login.jsp").forward(request, response);
                return;
            }

            stmt.setString(1, username);
            stmt.setString(2, hashedPassword);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                // ✅ Đăng nhập thành công -> Lưu session
                HttpSession session = request.getSession();
                session.setAttribute("user", username); // Sử dụng "user" thay vì "fullname"

                System.out.println("✅ [DEBUG] Đăng nhập thành công!");
                response.sendRedirect("HomePage.jsp"); // Chuyển hướng đến home.jsp
                return; // Thoát phương thức
            } else {
                // ❌ Sai tài khoản hoặc mật khẩu
                request.setAttribute("errorMessage", "Sai tài khoản hoặc mật khẩu!");
                request.getRequestDispatcher("login.jsp").forward(request, response);
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Lỗi hệ thống! Vui lòng thử lại sau.");
            request.getRequestDispatcher("login.jsp").forward(request, response);
        }
    }
}
