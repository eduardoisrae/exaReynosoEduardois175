<%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Actualizar Equipo</title>
</head>
<body>
    <%
        // Obtener los parámetros del formulario
        String idParam = request.getParameter("id");
        String nombre = request.getParameter("nombre");
        String marca = request.getParameter("marca");
        String modelo = request.getParameter("modelo");
        String existenciaParam = request.getParameter("existencia");
        String precioParam = request.getParameter("precio");

        if (idParam != null && !idParam.isEmpty() && nombre != null && marca != null && modelo != null && existenciaParam != null && precioParam != null) {
            try {
                // Convertir los parámetros a los tipos correctos
                int id = Integer.parseInt(idParam);
                int existencia = Integer.parseInt(existenciaParam);
                double precio = Double.parseDouble(precioParam);

                String url = "jdbc:mysql://localhost:3306/bdexaReynosois175";
                String dbUser = "root";
                String dbPassword = "";

                Connection conn = null;
                PreparedStatement stmt = null;

                try {
                    // Establecer la conexión con la base de datos
                    conn = DriverManager.getConnection(url, dbUser, dbPassword);
                    
                    // Actualizar el equipo en la base de datos
                    String sql = "UPDATE Equipo SET nombreEquipo = ?, marca = ?, modelo = ?, existencia = ?, precio = ? WHERE idEquipo = ?";
                    stmt = conn.prepareStatement(sql);
                    stmt.setString(1, nombre);
                    stmt.setString(2, marca);
                    stmt.setString(3, modelo);
                    stmt.setInt(4, existencia);
                    stmt.setDouble(5, precio);
                    stmt.setInt(6, id);

                    int rowsAffected = stmt.executeUpdate();

                    if (rowsAffected > 0) {
                        // Redirigir al usuario a la página de gestión de equipos
                        response.sendRedirect("index.jsp");
                    } else {
                        out.println("<p>Error: No se pudo actualizar el equipo.</p>");
                    }
                } catch (SQLException e) {
                    out.println("<p>Error de base de datos: " + e.getMessage() + "</p>");
                } finally {
                    // Cerrar los recursos
                    try {
                        if (stmt != null) stmt.close();
                        if (conn != null) conn.close();
                    } catch (SQLException e) {
                        out.println("<p>Error al cerrar los recursos: " + e.getMessage() + "</p>");
                    }
                }
            } catch (NumberFormatException e) {
                out.println("<p>Error: Los parámetros proporcionados no son válidos.</p>");
            }
        } else {
            out.println("<p>Error: Faltan datos para actualizar el equipo.</p>");
        }
    %>
</body>
</html>
