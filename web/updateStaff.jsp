<%-- 
    Document   : updateStaff
    Created on : Mar 2, 2025, 1:06:45 PM
    Author     : Admin
--%>

<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="Controller.Staff" %>
<%
    Staff staff = (Staff) request.getAttribute("staff");
    if (staff == null) {
        response.sendRedirect("manageStaff.jsp?error=notfound");
        return;
    }
%>
<html>
<head>
    <title>Update Staff</title>
    <link rel="stylesheet" type="text/css" href="css/staffForm.css">
</head>
<body>
    <div class="container">
        <h2>Update Staff</h2>

        <form action="UpdateStaffServlet" method="post">
            <input type="hidden" name="staff_id" value="<%= staff.getStaffId() %>">
            
            <label for="admin_id">ID Staff:</label>
            <input type="number" id="admin_id" name="admin_id" value="<%= staff.getAdminId() %>" required> <br>

            <label for="full_name">Full Name:</label>
            <input type="text" id="full_name" name="full_name" value="<%= staff.getFullName() %>" required> <br>

            <label for="position">Position:</label>
            <input type="text" id="position" name="position" value="<%= staff.getPosition() %>" required> <br>

            <label for="phone">Phone Number:</label>
            <input type="text" id="phone" name="phone" value="<%= staff.getPhone() %>" required> <br>

            <label for="user_id">ID User:</label>
            <input type="number" id="user_id" name="user_id" value="<%= staff.getUserId() %>" required> <br>

            <input type="submit" value="Cập Nhật" class="btn btn-update">
            <a href="manageStaff.jsp" class="btn btn-cancel">Cancel</a>
        </form>
    </div>
</body>
</html>
