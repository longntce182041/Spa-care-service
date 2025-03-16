<%-- 
    Document   : profile
    Created on : 26 thg 2, 2025, 15:12:48
    Author     : Tran Phan Trung Kien - CE180170
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="jakarta.servlet.http.HttpSession"%>
<%@page import="jakarta.servlet.http.HttpServletRequest"%>
<%@ page import="DAO.UserDAO, Model.User" %>
<%@ page import="java.util.List, Model.Pet" %>


<%
    User user_profile = (User) session.getAttribute("user_profile");

    if (user_profile == null) { 
        response.sendRedirect("ProfileServlet"); 
        return;
    }
    
    System.out.println("🔍 [DEBUG] Session user_pets: " + session.getAttribute("user_pets"));
    List<Pet> pets = (List<Pet>) session.getAttribute("user_pets");
%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Profile Page</title>
        <!-- Link to CSS files -->
        <link href="https://fonts.googleapis.com/css?family=Montserrat:200,300,400,500,600,700,800&display=swap" rel="stylesheet">
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
        <link rel="stylesheet" href="css/bootstrap.min.css">
        <link rel="stylesheet" href="css/Style_profile.css">
    </head>
    <body>
        <div class="container-fluid">
            <div class="row">
                <!-- Sidebar -->
                <nav id="sidebar" class="col-md-3 col-lg-2 d-md-block bg-light sidebar">
                    <div class="position-sticky">
                        <ul class="nav flex-column">
                            <li class="nav-item">
                                <a class="nav-link active" aria-current="page" href="HomePage.jsp">
                                    <i class="fa fa-home"></i>
                                    Home
                                </a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" href="profile.jsp">
                                    <i class="fa fa-user"></i>
                                    Profile
                                </a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" href="services.jsp">
                                    <i class="fa fa-cogs"></i>
                                    Services
                                </a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" href="contact.jsp">
                                    <i class="fa fa-envelope"></i>
                                    Contact
                                </a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" href="index.jsp">
                                    <i class="fa fa-sign-out"></i>
                                    Logout
                                </a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" href="changePassword.jsp">
                                    <i class="fa fa-user"></i>
                                    Change Password
                                </a>
                            </li>
                        </ul>
                    </div>
                </nav>

                <!-- Main content -->
                <main class="col-md-9 ms-sm-auto col-lg-10 px-md-4 main-content">
                    <div class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 mb-3 border-bottom">
                        <h1 class="h2">Profile</h1>
                    </div>

                    <div class="container">
                        <div class="row">
                            <div class="col-md-8">
                                <div class="card">
                                    <div class="card-header">
                                        <h4>Customer Information</h4>
                                    </div>
                                    <div class="card-body">
                                        <p><strong>Full name:</strong> <%= user_profile.getFullname() != null ? user_profile.getFullname() : "N/A" %></p>
                                        <p><strong>Username:</strong> <%= user_profile.getUsername() != null ? user_profile.getUsername() : "N/A" %></p>
                                        <p><strong>Email:</strong> <%= user_profile.getEmail() != null ? user_profile.getEmail() : "N/A" %></p>
                                        <p><strong>Phone:</strong> <%= user_profile.getPhone() != null ? user_profile.getPhone() : "N/A" %></p>
                                        <p><strong>Address:</strong> <%= user_profile.getAddress() != null ? user_profile.getAddress() : "N/A" %></p>
                                    </div>
                                </div>
                            </div>
                        </div>


                        <div class="card">
                            <div class="card-header">
                                <h4>Your Pet Information</h4>
                            </div>
                            <div class="card-body p-0">
                                <% if (pets != null && !pets.isEmpty()) { %>
                                <table class="table table-bordered m-0">
                                    <thead class="table-dark">
                                        <tr>
                                            <th>Name</th>
                                            <th>Type</th>
                                            <th>Age</th>
                                            <th>Weight (kg)</th>
                                            <th>Note</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <% for (Pet pet : pets) { %>
                                        <tr>
                                            <td><%= pet.getName_pet() %></td>
                                            <td><%= pet.getType() %></td>
                                            <td><%= pet.getAge() %></td>
                                            <td><%= pet.getWeight_kg() %></td>
                                            <td><%= pet.getNote() != null ? pet.getNote() : "N/A" %></td>
                                        </tr>
                                        <% } %>
                                    </tbody>
                                </table>
                                <% } else { %>
                                <p class="text-muted">No pets found for your account.</p>
                                <% } %>
                            </div>
                        </div>
                    </div>
                </main>
            </div>
        </div>

        <!-- Link to JS files -->
        <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    </body>
</html>
