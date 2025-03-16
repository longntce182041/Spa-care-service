package Controller;

import DAO.PetDAO;
import DAO.UserDAO;
import Model.User;
import Model.Pet;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.List;

@WebServlet("/ProfileServlet")
public class ProfileServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Lấy session
        HttpSession session = request.getSession(false);

        // Kiểm tra session có tồn tại không
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect("login.jsp?error=not_logged_in");
            return;
        }

        // Lấy username từ session
        String username = (String) session.getAttribute("user");

        // Gọi UserDAO để lấy thông tin user
        User user_profile = UserDAO.getUserByUsername(username);
        String userId = UserDAO.getUserIdByUsername(username);

        if (user_profile != null) {
            // Lưu thông tin user vào session để sử dụng trong profile.jsp
            session.setAttribute("user_profile", user_profile);
            
            List<Pet> pets = PetDAO.getPetsByUserId(userId);
            session.setAttribute("user_pets", pets);
            // Chuyển hướng sang profile.jsp mà không làm mất session
            request.getRequestDispatcher("profile.jsp").forward(request, response);
        } else {
            response.sendRedirect("error.jsp"); // Chuyển hướng đến trang lỗi nếu không tìm thấy user
        }
    }
}
