<%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Registrar Equipo</title>
</head>
<body>
    <%
    // Recuperar parámetros del formulario
    String nombre = request.getParameter("nombre");
    String marca = request.getParameter("marca");
    String modelo = request.getParameter("modelo");
    int existencia = Integer.parseInt(request.getParameter("existencia"));
    double precio = Double.parseDouble(request.getParameter("precio"));

    // Configuración de la conexión
    String url = "jdbc:mysql://localhost:3306/bdexareynosois175";
    String usuario = "root";
    String contrasena = "";

    // Variables para la conexión
    Connection conexion = null;
    PreparedStatement pstmt = null;

    try {
        // Cargar el driver de MySQL
        Class.forName("com.mysql.jdbc.Driver");
        
        // Establecer la conexión
        conexion = DriverManager.getConnection(
            url + "?useUnicode=true&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=UTC", 
            usuario, 
            contrasena
        );
        
        // Preparar la consulta SQL de inserción
        String consultaSQL = "INSERT INTO Equipo (nombreEquipo, marca, modelo, existencia, precio) VALUES (?, ?, ?, ?, ?)";
        pstmt = conexion.prepareStatement(consultaSQL);
        
        // Establecer los parámetros
        pstmt.setString(1, nombre);
        pstmt.setString(2, marca);
        pstmt.setString(3, modelo);
        pstmt.setInt(4, existencia);
        pstmt.setDouble(5, precio);
        
        // Ejecutar la inserción
        int filasAfectadas = pstmt.executeUpdate();
        
        // Mostrar mensaje de resultado
        if (filasAfectadas > 0) {
    %>
        <div style="color: green;">
            <h2>Equipo registrado exitosamente</h2>
            <p>Detalles del equipo:</p>
            <ul>
                <li>Nombre: <%= nombre %></li>
                <li>Marca: <%= marca %></li>
                <li>Modelo: <%= modelo %></li>
                <li>Existencia: <%= existencia %></li>
                <li>Precio: <%= precio %></li>
            </ul>
            <a href="index.jsp">Volver a la lista de equipos</a>
        </div>
    <%
        } else {
    %>
        <div style="color: red;">
            <h2>Error al registrar el equipo</h2>
            <p>No se pudo insertar el registro en la base de datos.</p>
            <a href="index.jsp">Volver</a>
        </div>
    <%
        }
    } catch (SQLException e) {
    %>
        <div style="color: red;">
            <h2>Error de base de datos</h2>
            <p>Ocurrió un error al intentar registrar el equipo:</p>
            <p><%= e.getMessage() %></p>
            <a href="index.jsp">Volver</a>
        </div>
    <%
    } catch (NumberFormatException e) {
    %>
        <div style="color: red;">
            <h2>Error de formato</h2>
            <p>Los valores de existencia o precio no son válidos.</p>
            <a href="index.jsp">Volver</a>
        </div>
    <%
    } finally {
        // Cerrar recursos
        try {
            if (pstmt != null) pstmt.close();
            if (conexion != null) conexion.close();
        } catch (SQLException e) {
            out.println("Error al cerrar la conexión: " + e.getMessage());
        }
    }
    %>
</body>
</html>