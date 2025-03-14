<%@ page import="java.sql.*, java.util.*, DAO.ConsultationDAO, Model.Consultation" %>
<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>Customer Service Management</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <link href="https://fonts.googleapis.com/css?family=Montserrat:200,300,400,500,600,700,800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
    <link rel="stylesheet" href="css/animate.css">
    <link rel="stylesheet" href="css/owl.carousel.min.css">
    <link rel="stylesheet" href="css/owl.theme.default.min.css">
    <link rel="stylesheet" href="css/magnific-popup.css">
    <link rel="stylesheet" href="css/bootstrap-datepicker.css">
    <link rel="stylesheet" href="css/jquery.timepicker.css">
    <link rel="stylesheet" href="css/flaticon.css">
    <link rel="stylesheet" href="css/style.css">
    <link rel="stylesheet" href="css/staffdashboard.css">
</head>
<body>
    <div class="container mt-5">
        <h2 class="text-center mb-4">Customer Service Management</h2>
        <div class="text-right mb-3">
            <button id="viewAppointmentBtn" class="btn btn-primary">View Appointment</button>
            <button id="backBtn" class="btn btn-secondary" style="display: none;">Back</button>
        </div>
        
        <div id="consultationTableContainer">
            <table class="consultation-table table table-striped table-hover">
                <thead class="thead-dark">
                    <tr>
                        <th>ID</th>
                        <th>Message</th>
                        <th>Name</th>
                        <th>Phone Number</th>
                        <th>Date</th>
                        <th>Time</th>
                    </tr>
                </thead>
                <tbody id="consultationTableBody">
                    <%
                        ConsultationDAO dao = new ConsultationDAO();
                        List<Consultation> consultationList = dao.getAllConsultations();
                        for (Consultation consultation : consultationList) {
                    %>
                    <tr>
                        <td><%= consultation.getConsultationId()%></td>
                        <td><%= consultation.getMessage()%></td>
                        <td><%= consultation.getName()%></td>
                        <td><%= consultation.getPhoneNumber()%></td>
                        <td><%= consultation.getDate()%></td>
                        <td><%= consultation.getTime()%></td>
                    </tr>
                    <% } %>
                </tbody>
            </table>
        </div>
        <div id="appointmentTableContainer" style="display: none;">
            <!-- Appointment data will be loaded here -->
        </div>
    </div>

    <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.4/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    <script src="js/jquery.min.js"></script>
    <script src="js/jquery-migrate-3.0.1.min.js"></script>
    <script src="js/popper.min.js"></script>
    <script src="js/bootstrap.min.js"></script>
    <script src="js/jquery.easing.1.3.js"></script>
    <script src="js/jquery.waypoints.min.js"></script>
    <script src="js/jquery.stellar.min.js"></script>
    <script src="js/jquery.animateNumber.min.js"></script>
    <script src="js/bootstrap-datepicker.js"></script>
    <script src="js/jquery.timepicker.min.js"></script>
    <script src="js/owl.carousel.min.js"></script>
    <script src="js/jquery.magnific-popup.min.js"></script>
    <script src="js/scrollax.min.js"></script>
    <script src="js/main.js"></script>
    <script>
        $(document).ready(function() {
            $('#viewAppointmentBtn').click(function() {
                $.ajax({
                    url: 'appointment.jsp',
                    method: 'GET',
                    success: function(data) {
                        $('#consultationTableContainer').hide();
                        $('#appointmentTableContainer').html(data).show();
                        $('#viewAppointmentBtn').hide();
                        $('#backBtn').show();
                    }
                });
            });

            $('#backBtn').click(function() {
                $('#appointmentTableContainer').hide();
                $('#consultationTableContainer').show();
                $('#backBtn').hide();
                $('#viewAppointmentBtn').show();
            });
        });
    </script>
</body>
</html>