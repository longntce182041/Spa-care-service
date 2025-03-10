<%-- 
    Document   : addStaff
    Created on : Mar 2, 2025, 12:32:58 PM
    Author     : Admin
--%>

<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<html>
<head>
    <title>Add Staff</title>
    <link rel="stylesheet" type="text/css" href="css/staffForm.css">
</head>
<body>
    <div class="container">
        <h2>Add Staff</h2>

        <form action="AddStaffServlet" method="post">
            <label for="admin_id">Admin ID:</label>
            <input type="number" id="admin_id" name="admin_id" required> <br>

            <label for="full_name">Full Name:</label>
            <input type="text" id="full_name" name="full_name" required> <br>

            <label for="position">Position:</label>
            <input type="text" id="position" name="position" required> <br>

            <label for="phone">Phone Number:</label>
            <input type="text" id="phone" name="phone" required> <br>

            <label for="user_id">User ID:</label>
            <input type="number" id="user_id" name="user_id" required> <br>

            <input type="submit" value="Thêm Nhân viên">
            <a href="manageStaff.jsp">Cancel</a>
        </form>
    </div>
</body>
</html>
