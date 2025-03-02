<%@ page import="java.sql.*, java.util.*, DAO.AppointmentDAO, Model.Appointment" %>
<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <title>Appointment Management</title>
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
        <link rel="stylesheet" href="css/Appointment.css"> <!-- Liên kết tệp CSS mới -->
    </head>
    <body>
        <div class="container">
            <h2>Appointment Management</h2>
            <h3>View Appointment Schedule</h3>
            <table class="appointment-table table table-striped table-hover">
                <thead class="thead-dark">
                    <tr>
                        <th>Appointment ID</th>
                        <th>Customer ID</th>
                        <th>Pet ID</th>
                        <th>Service ID</th>
                        <th>Staff ID</th>
                        <th>Date</th>
                        <th>Status</th>
                        <th>Action</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        AppointmentDAO dao = new AppointmentDAO();
                        List<Appointment> appointmentList = dao.getAllAppointments();
                        for (Appointment appointment : appointmentList) {
                    %>
                    <tr>
                        <td><%= appointment.getAppointmentId()%></td>
                        <td><%= appointment.getCustomerId()%></td>
                        <td><%= appointment.getPetId()%></td>
                        <td><%= appointment.getServiceId()%></td>
                        <td><%= appointment.getStaffId()%></td>
                        <td><%= appointment.getAppointmentDate()%></td>
                        <td><%= appointment.getStatus()%></td>
                        <td class="action-buttons">
                            <button class="btn btn-primary" onclick="confirmAppointment('<%= appointment.getAppointmentId()%>')">Confirm</button>
                            <button class="btn btn-secondary" onclick="cancelAppointment('<%= appointment.getAppointmentId()%>')">Cancel</button>
                            <i class="fa fa-trash delete-icon" onclick="deleteAppointment('<%= appointment.getAppointmentId()%>')"></i>
                        </td>
                    </tr>
                    <% }%>
                </tbody>
            </table>
            <a href="index.jsp" class="btn btn-primary">Back to Homepage</a>
        </div>

        <script>
            function confirmAppointment(appointmentId) {
                if (confirm('Are you sure you want to confirm this appointment?')) {
                    window.location.href = 'ConfirmAppointmentServlet?appointmentId=' + appointmentId;
                }
            }

            function cancelAppointment(appointmentId) {
                if (confirm('Are you sure you want to cancel this appointment?')) {
                    window.location.href = 'CancelAppointmentServlet?appointmentId=' + appointmentId;
                }
            }

            function deleteAppointment(appointmentId) {
                if (confirm('Are you sure you want to delete this appointment?')) {
                    window.location.href = 'DeleteAppointmentServlet?appointmentId=' + appointmentId;
                }
            }
        </script>

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
    </body>
</html>