<%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Resultado de Inicio de Sesión</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;700&display=swap" rel="stylesheet">
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
        .success, .error {
            background-color: white;
            padding: 2.5rem;
            border-radius: 12px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.08);
            display: flex;
            flex-direction: column;
            text-align: center;
        }
        .success {
            color: #2ecc71;
        }
        .error {
            color: #e74c3c;
        }
        .redirect-message {
            margin-top: 1rem;
            font-size: 0.9rem;
            color: #7f8c8d;
        }
        @media (max-width: 600px) {
            .container {
                width: 90%;
                padding: 1rem;
            }
            .success, .error {
                padding: 1.5rem;
            }
        }
    </style>
</head>
<body>
    <div class="container">
<%
    String usuarioIngresado = request.getParameter("usuario");
    String contrasenaIngresada = request.getParameter("contrasena");
    
    // Declarar variables fuera del try
    Connection conn = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;

    try {
        // Establecer conexión
        Class.forName("com.mysql.jdbc.Driver");
        conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/bdexaReynosois175", "root", "");

        // Crear declaración preparada
        String query = "SELECT * FROM usuario WHERE usuario = ? AND contrasena = ?";
        pstmt = conn.prepareStatement(query);
        pstmt.setString(1, usuarioIngresado);
        pstmt.setString(2, contrasenaIngresada);

        // Ejecutar consulta
        rs = pstmt.executeQuery();

        // Validar si se encontró el usuario
        if (rs.next()) {
            String usuario = rs.getString("usuario");
%>
            <!-- Mostrar mensaje de bienvenida -->
            <h1>Bienvenido, <%= usuario %>!</h1>
            
            <!-- Redirigir después de 4 segundos -->
            <script type="text/javascript">
                setTimeout(function() {
                    window.location.href = "index.jsp"; // Redirigir a registrarEquipo.jsp
                }, 4000); // 4000 milisegundos = 4 segundos
            </script>
<%
        } else {
            out.println("Usuario o contraseña incorrectos.");
        }

    } catch (ClassNotFoundException e) {
        out.println("Error al cargar el driver: " + e.getMessage());
    } catch (SQLException e) {
        out.println("Error de base de datos: " + e.getMessage());
    } finally {
        // Cerrar recursos manualmente
        if (rs != null) {
            try {
                rs.close();
            } catch (SQLException e) {
                /* ignorar */
            }
        }
        if (pstmt != null) {
            try {
                pstmt.close();
            } catch (SQLException e) {
                /* ignorar */
            }
        }
        if (conn != null) {
            try {
                conn.close();
            } catch (SQLException e) {
                /* ignorar */
            }
        }
    }
%>

   </div>
</body>
</html>
