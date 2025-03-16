/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller;

import ConnectDB.DBConnect;
import Model.Revenue;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;



/**
 *
 * @author Admin
 */
@WebServlet("/RevenueReportServlet")
public class RevenueReportServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        List<Revenue> revenues = new ArrayList<>();
        Connection conn = null;

        try {
            // Khởi tạo kết nối
            DBConnect dbConnect = new DBConnect();
            conn = dbConnect.getConnection();

            // Câu lệnh SQL đã chỉnh sửa (group theo năm và tháng)
            String sql = "SELECT " +
                         "YEAR(order_date) AS order_year, " +
                         "MONTH(order_date) AS order_month, " +
                         "SUM(total_price) AS total_revenue " +
                         "FROM Orders " +
                         "WHERE status = 'Pending' " + // hoặc 'Completed' nếu muốn
                         "GROUP BY YEAR(order_date), MONTH(order_date) " +
                         "ORDER BY YEAR(order_date), MONTH(order_date)";

            PreparedStatement stmt = conn.prepareStatement(sql);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                Revenue revenue = new Revenue();

                // Gán năm và tháng vào revenue (nhớ sửa class Revenue cho phù hợp)
                revenue.setOrderYear(rs.getInt("order_year"));
                revenue.setOrderMonth(rs.getInt("order_month"));
                revenue.setTotalRevenue(rs.getDouble("total_revenue"));

                revenues.add(revenue);
            }

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            // Đóng connection nếu cần thiết
            try {
                if (conn != null) conn.close();
            } catch (Exception ex) {
                ex.printStackTrace();
            }
        }

        // Trả kết quả về JSP
        request.setAttribute("revenues", revenues);
        request.getRequestDispatcher("revenueReport.jsp").forward(request, response);
    }
}

