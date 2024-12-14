<%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Gestión de Equipos</title>
    <style>
        body {
    font-family: 'Inter', -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, Oxygen, Ubuntu, Cantarell, 'Open Sans', 'Helvetica Neue', sans-serif;
    background-color: #f4f6f7;
    color: #2c3e50;
    line-height: 1.6;
    margin: 0;
    padding: 0;
}

.container {
    max-width: 1200px;
    margin: 0 auto;
    padding: 2rem;
}

h1 {
    text-align: center;
    color: #000;
    font-weight: 700;
    margin-bottom: 2rem;
    position: relative;
    padding-bottom: 0.5rem;
}

h1::after {
    content: '';
    position: absolute;
    bottom: 0;
    left: 50%;
    transform: translateX(-50%);
    width: 100px;
    height: 4px;
    background: linear-gradient(to right, #000, #000);
}

table {
    width: 100%;
    border-collapse: separate;
    border-spacing: 0;
    background-color: white;
    box-shadow: 0 10px 30px rgba(0, 0, 0, 0.08);
    border-radius: 12px;
    overflow: hidden;
}

thead {
    background-color: #000;
    color: white;
}

th, td {
    padding: 1rem;
    text-align: left;
    border-bottom: 1px solid #e9ecef;
}

th {
    font-weight: 600;
    text-transform: uppercase;
    letter-spacing: 0.5px;
}

tbody tr:hover {
    background-color: rgba(0, 0, 0, 0.05);
    transition: background-color 0.3s ease;
}

button {
    background-color: #000;
    color: white;
    border: none;
    padding: 0.6rem 1rem;
    margin: 0.2rem;
    border-radius: 6px;
    cursor: pointer;
    font-weight: 500;
    transition: all 0.3s ease;
    box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
}

button:hover {
    background-color: #333;
    transform: translateY(-2px);
    box-shadow: 0 6px 8px rgba(0, 0, 0, 0.15);
}

h2 {
    color: #2c3e50;
    margin-top: 2rem;
    margin-bottom: 1rem;
    text-align: center;
}

form {
    background-color: white;
    padding: 2rem;
    border-radius: 12px;
    box-shadow: 0 10px 30px rgba(0, 0, 0, 0.08);
    max-width: 500px;
    margin: 0 auto;
}

form label {
    display: block;
    margin-bottom: 1rem;
    color: #2c3e50;
    font-weight: 500;
}

form input {
    width: 100%;
    padding: 0.8rem;
    border: 1px solid #e9ecef;
    border-radius: 6px;
    transition: border-color 0.3s ease;
    margin-top: 0.5rem;
}

form input:focus {
    outline: none;
    border-color: #000;
    box-shadow: 0 0 0 3px rgba(0, 0, 0, 0.2);
}

form button {
    width: 100%;
    margin-top: 1rem;
}

@media (max-width: 768px) {
    .container {
        padding: 1rem;
    }

    table {
        font-size: 0.9rem;
    }

    th, td {
        padding: 0.6rem;
    }

    form {
        padding: 1rem;
    }
}
    </style>
</head>
<body>
    
    
    <div class="container">
        <button onclick="window.location.href='logout.jsp'">Cerrar Sesion</button>
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
                    <th>Acciones</th> <!-- Columna para los botones -->
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
                    // Cargar el driver de MySQL (versión tradicional)
                    Class.forName("com.mysql.jdbc.Driver");  // Para versiones antiguas
                    
                    // Establecer la conexión
                    conexion = DriverManager.getConnection(url, usuario, contrasena);
                    
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
                    <td>
                        <!-- Botones de edición y eliminación -->
                        <button onclick="window.location.href='editarEquipo.jsp?id=<%= rs.getInt("idEquipo") %>';">Editar Equipo</button>
                        <button onclick="window.location.href='eliminarEquipo.jsp?id=<%= rs.getInt("idEquipo") %>';">Eliminar Equipo</button>
                    </td>
                </tr>
                
                
                <%
                    }
                } catch (ClassNotFoundException e) {
                    out.println("<tr><td colspan='7' style='color:red;'>Error de driver: " + e.getMessage() + "</td></tr>");
                    e.printStackTrace();
                } catch (SQLException e) {
                    out.println("<tr><td colspan='7' style='color:red;'>Error de base de datos: " + e.getMessage() + "</td></tr>");
                    e.printStackTrace();
                } finally {
                    // Cerrar recursos
                    try {
                        if (rs != null) rs.close();
                        if (pstmt != null) pstmt.close();
                        if (conexion != null) conexion.close();
                    } catch (SQLException e) {
                        out.println("<tr><td colspan='7' style='color:red;'>Error al cerrar recursos: " + e.getMessage() + "</td></tr>");
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
        
        
        <button onclick="window.location.href='buscar.jsp'">Buscar</button>
        
    </div>
</body>
</html>
