<%-- 
    Document   : logout
    Created on : 13/12/2024, 06:05:13 PM
    Author     : cantt
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
    // Invalidar la sesión actual
    session.invalidate();
    // Redirigir al usuario a la página de inicio de sesión
    response.sendRedirect("login.jsp");
%>