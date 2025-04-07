package Controller;

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

        // Check if username or password is empty
        if (username == null || username.isEmpty() || password == null || password.isEmpty()) {
            request.setAttribute("errorMessage", "Tên đăng nhập và mật khẩu không được để trống!");
            request.getRequestDispatcher("login.jsp").forward(request, response);
            return;
        }

        // Hash the password
        String hashedPassword = Integer.toHexString(password.hashCode());
        System.out.println("🔍 [DEBUG] Username: " + username);
        System.out.println("🔍 [DEBUG] Mật khẩu mã hóa: " + hashedPassword);

        // Check login information
        String sql = "SELECT user_id, role, username, user_fullname, user_phone, user_email, user_address FROM users WHERE username = ? AND password = ?";

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
                // Login successful -> Save session
                String userId = rs.getString("user_id");
                String role = rs.getString("role");
                username = rs.getString("username"); // Sử dụng lại biến username đã khai báo
                String fullname = rs.getString("user_fullname");
                String phone = rs.getString("user_phone");
                String email = rs.getString("user_email");
                String address = rs.getString("user_address");

                HttpSession session = request.getSession();
                session.setAttribute("user_id", userId);
                session.setAttribute("role", role);
                session.setAttribute("username", username);
                session.setAttribute("user_fullname", fullname);
                session.setAttribute("user_phone", phone);
                session.setAttribute("user_email", email);
                session.setAttribute("user_address", address);
                session.setMaxInactiveInterval(60 * 60); // 1 tiếng (giây)

                System.out.println("✅ [DEBUG] Đăng nhập thành công! Role: " + role);
                System.out.println("✅ [DEBUG] Session created successfully for user_id: " + userId);
                if ("admin".equalsIgnoreCase(role)) {
                    response.sendRedirect("admin_Dashboard.jsp"); // Redirect to admin dashboard
                } else if ("staff".equalsIgnoreCase(role)) {
                    response.sendRedirect("Staffdashboard.jsp");// Redirect to staff dashboard
                } else {
                    response.sendRedirect("homepage.jsp"); // Redirect to customer home page
                }
                return; // Exit method
            } else {
                // Incorrect username or password
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
