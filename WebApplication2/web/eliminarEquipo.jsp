<%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    int id = Integer.parseInt(request.getParameter("id"));

    String url = "jdbc:mysql://localhost:3306/bdexaReynosois175";
    String dbUser = "root";
    String dbPassword = "";

    Connection conn = null;
    PreparedStatement stmt = null;

    try {
        // Establecer la conexión a la base de datos
        conn = DriverManager.getConnection(url, dbUser, dbPassword);
        
        // Preparar la sentencia SQL para eliminar el equipo
        String sql = "DELETE FROM Equipo WHERE idEquipo = ?";
        stmt = conn.prepareStatement(sql);
        stmt.setInt(1, id);
        
        // Ejecutar la actualización
        int rowsAffected = stmt.executeUpdate();

        if (rowsAffected > 0) {
            // Redirigir a la página de gestión de equipos si la eliminación fue exitosa
            response.sendRedirect("index.jsp");
        } else {
            out.println("Error al eliminar el equipo.");
        }
    } catch (SQLException e) {
        out.println("Error de base de datos: " + e.getMessage());
    } finally {
        // Cerrar los recursos
        try {
            if (stmt != null) stmt.close();
            if (conn != null) conn.close();
        } catch (SQLException e) {
            out.println("Error al cerrar recursos: " + e.getMessage());
        }
    }
%>
