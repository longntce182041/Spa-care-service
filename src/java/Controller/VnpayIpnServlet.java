package Controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.*;

@WebServlet("/VnpayIpnServlet")
public class VnpayIpnServlet extends HttpServlet {

    private static final String VNP_HASHSECRET = "8RJFQ4F0G4MFSYGVYYA27XOABX8RJEW4";

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Map<String, String> fields = new HashMap<>();
        for (Map.Entry<String, String[]> entry : request.getParameterMap().entrySet()) {
            fields.put(entry.getKey(), entry.getValue()[0]);
        }

        String vnp_SecureHash = fields.remove("vnp_SecureHash");
        String hashData = VnpayUtils.createHashData(fields);
        String calculatedHash = VnpayUtils.hmacSHA256(VNP_HASHSECRET, hashData);

        if (calculatedHash.equals(vnp_SecureHash)) {
            // Xử lý trạng thái giao dịch
            String transactionStatus = fields.get("vnp_TransactionStatus");
            if ("00".equals(transactionStatus)) {
                // Giao dịch thành công
                response.getWriter().write("success");
            } else {
                // Giao dịch thất bại
                response.getWriter().write("fail");
            }
        } else {
            // Chữ ký không hợp lệ
            response.getWriter().write("invalid signature");
        }
    }
}