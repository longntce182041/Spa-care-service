/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller;

import ConnectDB.DBConnect;
import Model.Rating;
import jakarta.servlet.RequestDispatcher;
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
@WebServlet("/StatisticsServlet")
public class StatisticsServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<Rating> ratings = new ArrayList<>();
        Connection conn = null;
        try {
            DBConnect dbConnect = new DBConnect();
            conn = dbConnect.getConnection();          
            String sql = "SELECT r.rating_id, u.username, s.name AS service_name, r.rating_star, r.comment " +
                 "FROM Ratings r " +
                 "JOIN Users u ON r.user_id = u.user_id " +
                 "JOIN Services s ON r.service_id = s.service_id";
    PreparedStatement stmt = conn.prepareStatement(sql);
    ResultSet rs = stmt.executeQuery();
    
    while (rs.next()) {
        int ratingId = rs.getInt("rating_id");
        String userName = rs.getString("username");
        String serviceName = rs.getString("service_name");
        int ratingStar = rs.getInt("rating_star");
        String comment = rs.getString("comment");
        
        ratings.add(new Rating(ratingId, userName, serviceName, ratingStar, comment));
    }
    conn.close();
} catch (Exception e) {
    e.printStackTrace();
}
request.setAttribute("ratings", ratings);
RequestDispatcher dispatcher = request.getRequestDispatcher("statisticsReports.jsp");
dispatcher.forward(request, response);
    }
}