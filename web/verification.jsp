<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page contentType="text/html; charset=UTF-8" %>
<html>
<head>
    <title>Verify OTP Code</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f8f9fa;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
        }
        .container {
            background: white;
            padding: 30px;
            border-radius: 8px;
            box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.1);
            width: 400px;
            text-align: center;
        }
        h2 {
            margin-bottom: 20px;
        }
        label {
            display: block;
            text-align: left;
            font-weight: bold;
            margin-bottom: 5px;
        }
        input[type="text"] {
            width: 100%;
            padding: 10px;
            margin-bottom: 20px;
            border: 1px solid #ced4da;
            border-radius: 5px;
            font-size: 16px;
        }
        button {
            width: 100%;
            padding: 12px;
            border: none;
            font-size: 16px;
            font-weight: bold;
            cursor: pointer;
            border-radius: 5px;
        }
        .btn-verify {
            background-color: #28a745;
            color: white;
        }
        .btn-verify:hover {
            background-color: #218838;
        }
        .btn-home {
            background-color: #6c757d;
            color: white;
            margin-top: 10px;
        }
        .btn-home:hover {
            background-color: #5a6268;
        }
        .error {
            color: red;
            margin-top: 10px;
        }
    </style>
</head>
<body>
    <div class="container">
        <h2>Verify OTP Code</h2>
        <form action="VerifyCodeServlet" method="post">
            <input type="hidden" name="email" value="<%= request.getParameter("email") %>">
            <label>Enter OTP Code:</label>
            <input type="text" name="otp" required>
            <button type="submit" class="btn-verify">Verify</button>
        </form>

        <% String error = request.getParameter("error"); %>
        <% if (error != null) { %>
            <p class="error"><%= error %></p>
        <% } %>
    </div>
</body>
</html>
