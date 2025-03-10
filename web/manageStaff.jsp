<%-- 
    Document   : manageStaff
    Created on : Mar 2, 2025, 12:30:30 PM
    Author     : Admin
--%>

<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="Model.Staff" %>
<html>
<head>
    <title>List Staff</title>
    <link rel="stylesheet" type="text/css" href="css/manageStaff.css">
</head>
<body>
    <h2>List Staff</h2>
    <a href="addStaff.jsp" class="btn-add">Add Staff</a>
    
    <table border="1">
        <tr>
            <th>ID</th>
            <th>Admin ID</th>
            <th>Full Name</th>
            <th>Position</th>
            <th>Phone Number</th>
            <th>User ID</th>
            <th>Active</th>
        </tr>
<%
    List<Staff> staffList = (List<Staff>) request.getAttribute("staffList");
    if (staffList != null) {
        for (Staff staff : staffList) {
%>
<tr>
    <td><%= staff.getStaffId() %></td>
    <td><%= staff.getAdminId() %></td>
    <td><%= staff.getFullName() %></td>
    <td><%= staff.getPosition() %></td>
    <td><%= staff.getPhone() %></td>
    <td><%= staff.getUserId() %></td>
    <td>
        <a href="UpdateStaffServlet?id=<%= staff.getStaffId() %>">Update</a> |
        <a href="DeleteStaffServlet?id=<%= staff.getStaffId() %>" onclick="return confirm('Xác nhận xóa?');">Delete</a>
    </td>
</tr>
<%
        }
    }
%>
    </table>
</body>
</html>
