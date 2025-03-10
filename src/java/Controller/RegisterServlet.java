package Controller;

import ConnectDB.DBConnect;
import Model.EmailUtil;
import jakarta.mail.MessagingException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Random;
import java.util.logging.Level;
import java.util.logging.Logger;

@WebServlet("/RegisterServlet")
public class RegisterServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String fullname = request.getParameter("fullname");
        String address = request.getParameter("address");

        Connection conn = null;
        PreparedStatement pstmt = null;

        try {
            DBConnect dbConnect = new DBConnect();
            conn = dbConnect.getConnection();

            if (conn == null) {
                response.sendRedirect("register.jsp?error=connection_failed");
                return;
            }

            // Generate new user_id in the format US01
            String newUserId = generateNewUserId(conn);

            // Mã hóa mật khẩu (Bcrypt nên được dùng thay thế)
            String hashedPassword = Integer.toHexString(password.hashCode());

            String sql = "INSERT INTO Users (user_id, username, password, email, phone, fullname, address, role) VALUES (?, ?, ?, ?, ?, ?, ?,'customer')";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, newUserId);
            pstmt.setString(2, username);
            pstmt.setString(3, hashedPassword);
            pstmt.setString(4, email);
            pstmt.setString(5, phone);
            pstmt.setString(6, fullname);
            pstmt.setString(7, address);

            int rowsInserted = pstmt.executeUpdate();
            if (rowsInserted > 0) {
                // Tạo mã OTP ngẫu nhiên
                Random rand = new Random();
                int otpCode = 100000 + rand.nextInt(900000);

                // Lưu OTP vào database
                PreparedStatement updateStmt = conn.prepareStatement("UPDATE Users SET verification_code = ? WHERE email = ?");
                updateStmt.setInt(1, otpCode);
                updateStmt.setString(2, email);
                updateStmt.executeUpdate();

                // Gửi OTP qua email
                EmailUtil.sendEmail(email, String.valueOf(otpCode));

                // Điều hướng đến trang xác thực
                response.sendRedirect("verification.jsp?email=" + email);
            } else {
                response.sendRedirect("register.jsp?error=registration_failed");
            }
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("register.jsp?error=sql_error");
        } catch (MessagingException ex) {
            Logger.getLogger(RegisterServlet.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            try {
                if (pstmt != null) {
                    pstmt.close();
                }
                if (conn != null) {
                    conn.close();
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }

    private String generateNewUserId(Connection conn) throws SQLException {
        String newUserId = "US001";
        String sql = "SELECT TOP 1 user_id FROM Users ORDER BY user_id DESC";
        try (PreparedStatement stmt = conn.prepareStatement(sql); ResultSet rs = stmt.executeQuery()) {
            if (rs.next()) {
                String lastUserId = rs.getString("user_id");
                int lastIdNumber = Integer.parseInt(lastUserId.substring(2));
                int newIdNumber = lastIdNumber + 1;
                newUserId = String.format("US%03d", newIdNumber);
            }
        }
        return newUserId;
    }
}