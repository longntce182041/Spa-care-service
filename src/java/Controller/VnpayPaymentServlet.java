package Controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.net.URLEncoder;
import java.text.SimpleDateFormat;
import java.util.*;

@WebServlet("/VnpayPaymentServlet")
public class VnpayPaymentServlet extends HttpServlet {

    private static final String VNP_URL = "https://sandbox.vnpayment.vn/paymentv2/vpcpay.html";
    private static final String VNP_TMNCODE = "AL0QUF81";
    private static final String VNP_HASHSECRET = "8RJFQ4F0G4MFSYGVYYA27XOABX8RJEW4";
    private static final String VNP_RETURNURL = "http://localhost:8080/PetiqueSpa/VnpayReturnServlet";

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Validate and retrieve parameters
        String orderInfo = request.getParameter("orderInfo");
        String amount = request.getParameter("amount");
        String bankCode = request.getParameter("bankCode");

        if (orderInfo == null || orderInfo.trim().isEmpty()) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Order information is required.");
            return;
        }

        if (amount == null || amount.trim().isEmpty()) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Amount is required for payment.");
            return;
        }

        try {
            int amountValue = Integer.parseInt(amount); // Validate amount as a numeric value
            if (amountValue <= 0) {
                response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Amount must be greater than zero.");
                return;
            }

            // Generate unique order ID
            String orderId = UUID.randomUUID().toString();

            // Prepare VNPAY parameters
            Map<String, String> vnp_Params = new HashMap<>();
            vnp_Params.put("vnp_Version", "2.1.0");
            vnp_Params.put("vnp_Command", "pay");
            vnp_Params.put("vnp_TmnCode", VNP_TMNCODE);
            vnp_Params.put("vnp_Amount", String.valueOf(amountValue * 100)); // Convert amount to VND * 100
            vnp_Params.put("vnp_CurrCode", "VND");
            vnp_Params.put("vnp_TxnRef", orderId);
            vnp_Params.put("vnp_OrderInfo", orderInfo);
            vnp_Params.put("vnp_OrderType", "billpayment");
            vnp_Params.put("vnp_Locale", "vn");
            vnp_Params.put("vnp_ReturnUrl", VNP_RETURNURL);

            if (bankCode != null && !bankCode.trim().isEmpty()) {
                vnp_Params.put("vnp_BankCode", bankCode);
            }

            // Add timestamp
            SimpleDateFormat formatter = new SimpleDateFormat("yyyyMMddHHmmss");
            Date date = new Date();
            vnp_Params.put("vnp_CreateDate", formatter.format(date));

            // Sort parameters by key
            List<String> fieldNames = new ArrayList<>(vnp_Params.keySet());
            Collections.sort(fieldNames);

            // Build hash data and query string
            StringBuilder hashData = new StringBuilder();
            StringBuilder query = new StringBuilder();
            for (String fieldName : fieldNames) {
                String fieldValue = vnp_Params.get(fieldName);
                if (fieldValue != null && !fieldValue.isEmpty()) {
                    hashData.append(fieldName).append('=').append(fieldValue).append('&');
                    query.append(URLEncoder.encode(fieldName, "UTF-8")).append('=')
                            .append(URLEncoder.encode(fieldValue, "UTF-8")).append('&');
                }
            }

            // Remove the trailing '&' character
            hashData.deleteCharAt(hashData.length() - 1);
            query.deleteCharAt(query.length() - 1);

            // Generate secure hash
            String secureHash = VnpayUtils.hmacSHA256(VNP_HASHSECRET, hashData.toString());
            query.append("&vnp_SecureHash=").append(URLEncoder.encode(secureHash, "UTF-8"));

            // Redirect to VNPAY payment URL
            String paymentUrl = VNP_URL + "?" + query.toString();
            response.sendRedirect(paymentUrl);

        } catch (NumberFormatException e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid amount format. Please enter a valid number.");
        }
    }
}