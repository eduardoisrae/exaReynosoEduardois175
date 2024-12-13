<%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Gestión de Equipos</title>
</head>
<body>
    <div class="container">
        <h1>Gestión de Equipos</h1>
        
        <!-- Tabla de equipos -->
        <table border="1">
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Nombre</th>
                    <th>Marca</th>
                    <th>Modelo</th>
                    <th>Existencia</th>
                    <th>Precio</th>
                </tr>
            </thead>
            <tbody>
                <%
                // Configuración de la conexión
                String url = "jdbc:mysql://localhost:3306/bdexareynosois175";
                String usuario = "root";
                String contrasena = "";

                // Variables para la conexión y consulta
                Connection conexion = null;
                PreparedStatement pstmt = null;
                ResultSet rs = null;

                try {
                    // Cargar el driver de MySQL
                    // CAMBIO: Usa el driver correcto
                    Class.forName("com.mysql.jdbc.Driver");
                    
                    // Establecer la conexión
                    conexion = DriverManager.getConnection(
                        url + "?useUnicode=true&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=UTC", 
                        usuario, 
                        contrasena
                    );
                    
                    // Preparar la consulta
                    String consultaSQL = "SELECT * FROM Equipo";
                    pstmt = conexion.prepareStatement(consultaSQL);
                    
                    // Ejecutar la consulta
                    rs = pstmt.executeQuery();
                    
                    // Iterar sobre los resultados
                    while (rs.next()) {
                %>
                <tr>
                    <td><%= rs.getInt("idEquipo") %></td>
                    <td><%= rs.getString("nombreEquipo") %></td>
                    <td><%= rs.getString("marca") %></td>
                    <td><%= rs.getString("modelo") %></td>
                    <td><%= rs.getInt("existencia") %></td>
                    <td><%= rs.getDouble("precio") %></td>
                </tr>
                <%
                    }
                } catch (ClassNotFoundException e) {
                    out.println("<tr><td colspan='6' style='color:red;'>Error de driver: " + e.getMessage() + "</td></tr>");
                    e.printStackTrace();
                } catch (SQLException e) {
                    out.println("<tr><td colspan='6' style='color:red;'>Error de base de datos: " + e.getMessage() + "</td></tr>");
                    e.printStackTrace();
                } finally {
                    // Cerrar recursos
                    try {
                        if (rs != null) rs.close();
                        if (pstmt != null) pstmt.close();
                        if (conexion != null) conexion.close();
                    } catch (SQLException e) {
                        out.println("<tr><td colspan='6' style='color:red;'>Error al cerrar recursos: " + e.getMessage() + "</td></tr>");
                        e.printStackTrace();
                    }
                }
                %>
            </tbody>
        </table>

        <!-- Formulario para registrar nuevos equipos -->
        <h2>Registrar Nuevo Equipo</h2>
        <form action="RegistrarEquipo.jsp" method="POST">
            <label>Nombre: <input type="text" name="nombre" required></label><br>
            <label>Marca: <input type="text" name="marca" required></label><br>
            <label>Modelo: <input type="text" name="modelo" required></label><br>
            <label>Existencia: <input type="number" name="existencia" required></label><br>
            <label>Precio: <input type="number" step="0.01" name="precio" required></label><br>
            <button type="submit">Registrar Equipo</button>
        </form>
    </div>
</body>
</html>