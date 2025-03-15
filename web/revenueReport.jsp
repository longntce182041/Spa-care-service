<%-- 
    Document   : revenueReport
    Created on : Mar 11, 2025, 9:29:33 PM
    Author     : Admin
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="Model.Revenue" %>
<html>
<head>
    <title>Revenue Report</title>
    <link rel="stylesheet" type="text/css" href="css/revenue.css">
</head>
<body>
    <div class="container">
        <h2>Revenue Report</h2>
        <table border="1" cellpadding="10">
            <tr>
                <th>Year</th>
                <th>Month</th>
                <th>Total Revenue</th>
            </tr>
            <%
                List<Revenue> revenues = (List<Revenue>) request.getAttribute("revenues");
                if (revenues != null && !revenues.isEmpty()) {
                    for (Revenue revenue : revenues) {
            %>
            <tr>
                <td><%= revenue.getOrderYear() %></td>
                <td><%= revenue.getOrderMonth() %></td>
                <td>$<%= String.format("%.2f", revenue.getTotalRevenue()) %></td>
            </tr>
            <%
                    }
                } else {
            %>
            <tr>
                <td colspan="3">No data available.</td>
            </tr>
            <%
                }
            %>
        </table>
    </div>
</body>
</html>
