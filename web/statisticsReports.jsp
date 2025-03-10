<%-- 
    Document   : statisticsReports
    Created on : Mar 5, 2025, 1:28:15 PM
    Author     : Admin
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="Model.Rating" %>
<html>
<head>
    <title>Statistics and Reports</title>
    <link rel="stylesheet" type="text/css" href="css/styleRating.css">
</head>
<body>
    <div class="container">
        <h2>Customer Ratings Summary</h2>
        <table>
            <tr>
                <th>ID</th>
                <th>Customer Name</th>
                <th>Service Name</th>
                <th>Rating (Stars)</th>
                <th>Comment</th>
            </tr>
            <%
                try {
                    List<Rating> ratings = (List<Rating>) request.getAttribute("ratings");
                    if (ratings != null && !ratings.isEmpty()) {
                        for (Rating rating : ratings) {
            %>
            <tr>
                <td><%= rating.getRatingId() %></td>
                <td><%= (rating.getUserName() != null) ? rating.getUserName() : "Unknown" %></td>
                <td><%= (rating.getServiceName() != null) ? rating.getServiceName() : "Unknown" %></td>
                <td><%= rating.getRatingStar() %> ⭐</td>
                <td><%= (rating.getComment() != null) ? rating.getComment() : "No comment" %></td>
            </tr>
            <%
                        }
                    } else {
            %>
            <tr>
                <td colspan="5" class="no-data">No ratings available.</td>
            </tr>
            <%
                    }
                } catch (Exception e) {
                    e.printStackTrace();
            %>
            <tr>
                <td colspan="5" class="error">Error loading data. Please try again later.</td>
            </tr>
            <%
                }
            %>
        </table>
    </div>
</body>
</html>
