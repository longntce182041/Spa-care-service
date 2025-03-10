/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller;

import ConnectDB.DBConnect;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

/**
 *
 * @author
 */
@WebServlet(name = "ChangePasswordServlet", urlPatterns = {"/ChangePasswordServlet"})
public class ChangePasswordServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try ( PrintWriter out = response.getWriter()) {
            HttpSession session = request.getSession(false);
            String username = (session != null) ? (String) session.getAttribute("username") : null;
            if (username == null) {
                response.sendRedirect("Login.jsp");
                return;
            }

            String currentPassword = request.getParameter("currentPassword");
            String newPassword = request.getParameter("newPassword");
            String confirmPassword = request.getParameter("confirmPassword");

            if (!newPassword.equals(confirmPassword)) {
                response.sendRedirect("changePassword.jsp?error=password_mismatch");
                return;
            }

            Connection conn = null;
            PreparedStatement pstmt = null;
            ResultSet rs = null;

            try {
                conn = DBConnect.getConnection();
                String sql = "SELECT password FROM Users WHERE username = ?";
                pstmt = conn.prepareStatement(sql);
                pstmt.setString(1, username);
                rs = pstmt.executeQuery();

                if (rs.next()) {
                    String dbPassword = rs.getString("password");
                    if (!dbPassword.equals(currentPassword)) {
                        response.sendRedirect("changePassword.jsp?error=incorrect_current_password");
                        return;
                    }

                    sql = "UPDATE Users SET password = ? WHERE username = ?";
                    pstmt = conn.prepareStatement(sql);
                    pstmt.setString(1, newPassword);
                    pstmt.setString(2, username);
                    pstmt.executeUpdate();

                    response.sendRedirect("profile.jsp?message=password_changed");
                } else {
                    response.sendRedirect("changePassword.jsp?error=user_not_found");
                }
            } catch (SQLException e) {
                e.printStackTrace();
                response.sendRedirect("changePassword.jsp?error=database_error");
            } finally {
                if (rs != null) {
                    try {
                        rs.close();
                    } catch (SQLException e) {
                        e.printStackTrace();
                    }
                }
                if (pstmt != null) {
                    try {
                        pstmt.close();
                    } catch (SQLException e) {
                        e.printStackTrace();
                    }
                }
                if (conn != null) {
                    DBConnect.closeConnection(conn);
                }
            }
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }
}
