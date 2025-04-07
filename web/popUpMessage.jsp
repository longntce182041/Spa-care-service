<%-- 
    Document   : popUpMessage
    Created on : Nov 1, 2024, 3:09:58 AM
    Author     : TruongMinhDan CE181520
--%>

<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<div id="toast"></div>

<script src="./js/popUpScript.js"></script>

<script>
    <%
        String message = (String) request.getSession().getAttribute("success");
        if (message != null && message != "") {
            out.println("showSuccessToast(\"" + message + "\");");
            request.getSession().removeAttribute("success");
        }
        message = (String) request.getSession().getAttribute("error");
        if (message != null && message != "") {
            out.println("showErrorToast(\"" + message + "\");");
            request.getSession().removeAttribute("error");
        }
    %>
</script>
