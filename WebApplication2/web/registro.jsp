<%@page import="java.sql.Connection"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.SQLException"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Registro de Usuario</title>
    <style>
      body {
    font-family: 'Inter', -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, Oxygen, Ubuntu, Cantarell, 'Open Sans', 'Helvetica Neue', sans-serif;
    background-color: #f4f6f7;
    color: #2c3e50;
    line-height: 1.6;
    margin: 0;
    padding: 0;
    display: flex;
    justify-content: center;
    align-items: center;
    min-height: 100vh;
}

.container {
    width: 100%;
    max-width: 400px;
    padding: 2rem;
    text-align: center;
}

h1 {
    display: inline-block;
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

form {
    background-color: white;
    padding: 2.5rem;
    border-radius: 12px;
    box-shadow: 0 10px 30px rgba(0, 0, 0, 0.08);
    display: flex;
    flex-direction: column;
    text-align: left;
}

label {
    margin-top: 1rem;
    color: #2c3e50;
    font-weight: 500;
}

input {
    width: 100%;
    padding: 0.8rem;
    margin-top: 0.5rem;
    border: 1px solid #e9ecef;
    border-radius: 6px;
    transition: all 0.3s ease;
    box-sizing: border-box;
}

input:focus {
    outline: none;
    border-color: #000;
    box-shadow: 0 0 0 3px rgba(0, 0, 0, 0.1);
}

button {
    background-color: #000;
    color: white;
    border: none;
    padding: 0.8rem 1rem;
    border-radius: 6px;
    cursor: pointer;
    font-weight: 500;
    margin-top: 1.5rem;
    transition: all 0.3s ease;
    box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
}

button:hover {
    background-color: #333;
    transform: translateY(-2px);
    box-shadow: 0 6px 8px rgba(0, 0, 0, 0.15);
}

.error {
    color: #e74c3c;
    text-align: center;
    background-color: #fff;
    padding: 1rem;
    border-radius: 8px;
    box-shadow: 0 4px 6px rgba(0, 0, 0, 0.05);
    margin-bottom: 1rem;
}

.success {
    color: #2ecc71;
    text-align: center;
    background-color: #fff;
    padding: 1rem;
    border-radius: 8px;
    box-shadow: 0 4px 6px rgba(0, 0, 0, 0.05);
    margin-bottom: 1rem;
}

@media (max-width: 600px) {
    .container {
        width: 90%;
        padding: 1rem;
    }

    form {
        padding: 1.5rem;
    }
}
    </style>
</head>
<body>
    
    
    <%
    // Procesar el registro si se envía el formulario
    if ("POST".equalsIgnoreCase(request.getMethod())) {
        String usuario = request.getParameter("usuario");
        String nombre = request.getParameter("nombre");
        String contrasena = request.getParameter("contrasena");
        
        // Configuración de la conexión a la base de datos
        String url = "jdbc:mysql://localhost:3306/bdexaReynosois175";
        String dbUser = "root";
        String dbPassword = "";
        
        Connection conn = null;
        PreparedStatement stmt = null;
        
        try {
            // Cargar el driver de MySQL
            Class.forName("com.mysql.jdbc.Driver");
            
            // Establecer la conexión
            conn = DriverManager.getConnection(url, dbUser, dbPassword);
            stmt = conn.prepareStatement("INSERT INTO Usuario (usuario, nombre, contrasena) VALUES (?, ?, ?)");
            
            // Establecer los parámetros
            stmt.setString(1, usuario);
            stmt.setString(2, nombre);
            stmt.setString(3, contrasena);
            
            // Ejecutar la inserción
            int rowsAffected = stmt.executeUpdate();
            
            if (rowsAffected > 0) {
                // Registro exitoso
                %>
                <p class="success">Usuario registrado exitosamente.</p>
                <%
            } else {
                // Error en el registro
                %>
                <p class="error">Error al registrar el usuario.</p>
                <%
            }
        } catch (ClassNotFoundException e) {
            %>
            <p class="error">Error: Driver de base de datos no encontrado - <%= e.getMessage() %></p>
            <%
        } catch (SQLException e) {
            %>
            <p class="error">Error de base de datos: <%= e.getMessage() %></p>
            <%
        } finally {
            // Cerrar recursos
            try {
                if (stmt != null) stmt.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                %>
                <p class="error">Error al cerrar la conexión: <%= e.getMessage() %></p>
                <%
            }
        }
    }
    %>
     <div class="container">
        <h1>Registro de Usuario</h1>
    <form action="registro.jsp" method="POST">
        <label for="usuario">Usuario:</label>
        <input type="text" id="usuario" name="usuario" required>
        
        <label for="nombre">Nombre:</label>
        <input type="text" id="nombre" name="nombre" required>
        
        <label for="contrasena">Contraseña:</label>
        <input type="password" id="contrasena" name="contrasena" required>
        
        <button type="submit">Registrar</button>
    </form>
     </div>
</body>
</html>