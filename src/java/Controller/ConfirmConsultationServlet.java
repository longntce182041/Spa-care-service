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

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/plain");
        response.setCharacterEncoding("UTF-8");

        try {
            int consultationId = Integer.parseInt(request.getParameter("consultationId"));
            String status = request.getParameter("status");

            // Cập nhật trạng thái tư vấn
            consultationDAO.updateConsultationStatus(consultationId, status);

            // Trả về thông báo thành công
            response.getWriter().write("Consultation status updated to: " + status);
        } catch (Exception e) {
            e.printStackTrace();
            // Trả về thông báo lỗi
            response.getWriter().write("Failed to update consultation status.");
        }
    }
}