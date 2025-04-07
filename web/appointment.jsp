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
        <link rel="stylesheet" href="./css/toast.css">
    </head>
    <body>
        <div class="container">
            <h3>View Appointment Schedule</h3>
            <table class="appointment-table table table-striped table-hover">
                <thead class="thead-dark">
                    <tr>
                        <th>Appointment ID</th>
                        <th>User ID</th>
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
                    <tr id="appointment-<%= appointment.getAppointmentId() %>">
                        <td><%= appointment.getAppointmentId()%></td>
                        <td><%= appointment.getUserId()%></td>
                        <td><%= appointment.getPetId()%></td>
                        <td><%= appointment.getServiceId()%></td>
                        <td><%= appointment.getStaffId()%></td>
                        <td><%= appointment.getAppointmentDate()%></td>
                        <td id="status-<%= appointment.getAppointmentId() %>"><%= appointment.getStatus()%></td>
                        <td class="action-buttons">
                            <button class="btn btn-primary" onclick="confirmAppointment('<%= appointment.getAppointmentId()%>')">Confirm</button>
                            <button class="btn btn-secondary" onclick="cancelAppointment('<%= appointment.getAppointmentId()%>')">Cancel</button>
                            <i class="fa fa-trash delete-icon" onclick="deleteAppointment('<%= appointment.getAppointmentId()%>')"></i>
                        </td>
                    </tr>
                    <% }%>
                </tbody>
            </table>
        </div>

        <script>
            function confirmAppointment(appointmentId) {
                $.ajax({
                    url: 'ConfirmAppointmentServlet',
                    method: 'GET',
                    data: { appointmentId: appointmentId },
                    success: function(response) {
                        if (response === 'Confirmed') {
                            // Cập nhật trạng thái trên giao diện
                            $('#status-' + appointmentId).text('Confirmed');

                            // Hiển thị thông báo thành công
                            showSuccessToast('Appointment confirmed successfully!');
                        } else {
                            // Hiển thị thông báo lỗi
                            showErrorToast('Failed to confirm appointment.');
                        }
                    },
                    error: function() {
                        // Hiển thị thông báo lỗi nếu xảy ra lỗi kết nối
                        showErrorToast('Failed to connect to the server. Please try again.');
                    }
                });
            }

            function cancelAppointment(appointmentId) {
                $.ajax({
                    url: 'CancelAppointmentServlet',
                    method: 'GET',
                    data: { appointmentId: appointmentId },
                    success: function(response) {
                        if (response === 'Cancelled') {
                            // Cập nhật trạng thái trên giao diện
                            $('#status-' + appointmentId).text('Cancelled');

                            // Hiển thị thông báo thành công
                            showSuccessToast('Appointment cancelled successfully!');
                        } else {
                            // Hiển thị thông báo lỗi
                            showErrorToast('Failed to cancel appointment.');
                        }
                    },
                    error: function() {
                        // Hiển thị thông báo lỗi nếu xảy ra lỗi kết nối
                        showErrorToast('Failed to connect to the server. Please try again.');
                    }
                });
            }

            function deleteAppointment(appointmentId) {
                $.ajax({
                    url: 'DeleteAppointmentServlet',
                    method: 'GET',
                    data: { appointmentId: appointmentId },
                    success: function(response) {
                        if (response === 'Deleted') {
                            // Xóa dòng hẹn khỏi giao diện
                            $('#appointment-' + appointmentId).remove();

                            // Hiển thị thông báo thành công
                            showSuccessToast('Appointment deleted successfully!');
                        } else {
                            // Hiển thị thông báo lỗi
                            showErrorToast('Failed to delete appointment.');
                        }
                    },
                    error: function() {
                        // Hiển thị thông báo lỗi nếu xảy ra lỗi kết nối
                        showErrorToast('Failed to connect to the server. Please try again.');
                    }
                });
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
        <%@include file="popUpMessage.jsp" %>
    </body>
</html>