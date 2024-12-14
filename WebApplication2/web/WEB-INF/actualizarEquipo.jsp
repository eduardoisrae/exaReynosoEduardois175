<%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    int id = Integer.parseInt(request.getParameter("id"));
    String nombre = request.getParameter("nombre");
    String marca = request.getParameter("marca");
    String modelo = request.getParameter("modelo");
    int existencia = Integer.parseInt(request.getParameter("existencia"));
    double precio = Double.parseDouble(request.getParameter("precio"));

    String url = "jdbc:mysql://localhost:3306/bdexaReynosois175";
    String dbUser = "root";
    String dbPassword = "";

    try (Connection conn = DriverManager.getConnection(url, dbUser, dbPassword);
         PreparedStatement stmt = conn.prepareStatement("UPDATE Equipo SET nombreEquipo = ?, marca = ?, modelo = ?, existencia = ?, precio = ? WHERE idEquipo = ?")) {
        stmt.setString(1, nombre);
        stmt.setString(2, marca);
        stmt.setString(3, modelo);
        stmt.setInt(4, existencia);
        stmt.setDouble(5, precio);
        stmt.setInt(6, id);
        int rowsAffected = stmt.executeUpdate();

        if (rowsAffected > 0) {
            // Redireccionar a la página de gestión de equipos
            response.sendRedirect("index.jsp");
        } else {
            out.println("Error al actualizar el equipo.");
        }
    } catch (SQLException e) {
        out.println("Error de base de datos: " + e.getMessage());
    }
%>