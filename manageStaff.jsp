<%-- 
    Document   : manageStaff
    Created on : Mar 2, 2025, 12:30:30 PM
    Author     : Admin
--%>

<%-- 
    Document   : manageStaff
    Created on : Mar 2, 2025, 12:30:30 PM
    Author     : Admin
--%>

<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="Model.Staff" %>
<html>
<head>
    <title>Manage Staff</title>
    <link rel="stylesheet" href="./css/manageStaff.css">
</head>

<body>
    <h2>Staff Management</h2>

    <div style="width:90%; margin: 0 auto;">
        <a href="addStaff.jsp" class="btn-add">Add Staff</a>

        <table>
            <tr>
                <th>Staff ID</th>
                <th>Full Name</th>
                <th>Position</th>
                <th>Phone</th>
                <th>User ID</th>
                <th>Role</th>
                <th>Email</th>
                <th>Password</th>
                <th>Image</th>
                <th>Action</th>
            </tr>

            <%
                List<Staff> staffList = (List<Staff>) request.getAttribute("staffList");

                if (staffList != null && !staffList.isEmpty()) {
                    for (Staff staff : staffList) {
            %>
            <tr>
                <td><%= staff.getStaffId() %></td>
                <td><%= staff.getFullName() %></td>
                <td><%= staff.getPosition() %></td>
                <td><%= staff.getPhone() %></td>
                <td><%= staff.getUserId() %></td>
                <td><%= staff.getRole() %></td>
                <td><%= staff.getEmail() %></td>
                <td><%= staff.getPassword() %></td>
                <td>
                    <img class="staff-img" src="<%= staff.getImg() %>" alt="Staff Image">
                </td>

                <td>
                    <a href="ManageStaffServlet?action=update&id=<%= staff.getStaffId() %>" class="btn">Update</a>
                    <a href="ManageStaffServlet?action=delete&id=<%= staff.getStaffId() %>" class="btn delete" onclick="return confirm('Confirm delete?')">Delete</a>
                </td>
            </tr>
            <%
                    }
                } else {
            %>
                <tr>
                    <td colspan="10">No staff found.</td>
                </tr>
            <%
                }
            %>
        </table>
    </div>
</body>
</html>
