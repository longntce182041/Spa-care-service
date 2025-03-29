package Controller;

import DAO.ConsultationDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/ConfirmConsultationServlet")
public class ConfirmConsultationServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private ConsultationDAO consultationDAO = new ConsultationDAO();

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int consultationId = Integer.parseInt(request.getParameter("consultationId"));
        consultationDAO.updateConsultationStatus(consultationId, "Confirm");
        response.setContentType("text/plain");
        response.getWriter().write("Confirmed");
    }
}