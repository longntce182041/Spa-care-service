package Controller;

import DAO.ConsultationDAO;
import Model.Consultation;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Date;
import java.sql.Time;
import java.text.ParseException;
import java.text.SimpleDateFormat;

@WebServlet("/AddConsultationServlet")
public class AddConsultationServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private ConsultationDAO consultationDAO = new ConsultationDAO();

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String message = request.getParameter("message");
        String name = request.getParameter("name");
        String phoneNumber = request.getParameter("phoneNumber");
        String dateString = request.getParameter("date");
        String timeString = request.getParameter("time");

        Date date = null;
        Time time = null;

        try {
            SimpleDateFormat dateFormat = new SimpleDateFormat("MM/dd/yyyy");
            java.util.Date parsedDate = dateFormat.parse(dateString);
            date = new Date(parsedDate.getTime());

            SimpleDateFormat timeFormat = new SimpleDateFormat("HH:mm");
            java.util.Date parsedTime = timeFormat.parse(timeString);
            time = new Time(parsedTime.getTime());
        } catch (ParseException e) {
            e.printStackTrace();
            response.sendRedirect("index.jsp?error=Invalid date or time format");
            return;
        }

        Consultation consultation = new Consultation(0, message, name, phoneNumber, date, time);
        consultationDAO.addConsultation(consultation);

        response.sendRedirect("index.jsp");
    }
}