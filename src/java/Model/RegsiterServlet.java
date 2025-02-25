/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Model;

import ConnectDB.DBConnect;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;


/**
 *
 * @author Nguyen Thanh Long - CE182041
 */
@WebServlet(name = "RegsiterServlet", urlPatterns = {"/RegsiterServlet"})
public class RegsiterServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");

        Connection conn = null;
        PreparedStatement pstmt = null;

        try {
            DBConnect dbConnect = new DBConnect();
            conn = dbConnect.getConnection();

            if (conn == null) {
                response.sendRedirect("register.jsp?error=connection_failed");
                return;
            }

            // Mã hóa mật khẩu (Bcrypt nên được dùng thay thế)
            String hashedPassword = Integer.toHexString(password.hashCode());

            String sql = "INSERT INTO Users (username, password, email, phone) VALUES (?, ?, ?, ?)";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, username);
            pstmt.setString(2, hashedPassword);
            pstmt.setString(3, email);
            pstmt.setString(4, phone);

            int rowsInserted = pstmt.executeUpdate();
            if (rowsInserted > 0) {
                response.sendRedirect("verification.jsp");
            } else {
                response.sendRedirect("register.jsp?error=registration_failed");
            }
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("register.jsp?error=sql_error");
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
}
