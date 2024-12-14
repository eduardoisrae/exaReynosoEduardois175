<%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
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
