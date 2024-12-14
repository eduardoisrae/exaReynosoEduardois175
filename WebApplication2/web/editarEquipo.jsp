<%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Editar Equipo</title>
    
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

form {
    background-color: white;
    padding: 2.5rem;
    border-radius: 12px;
    box-shadow: 0 10px 30px rgba(0, 0, 0, 0.08);
    width: 100%;
    max-width: 500px;
    margin: 0 auto;
}

form label {
    display: block;
    margin-bottom: 1.2rem;
    color: #2c3e50;
    font-weight: 500;
}

form input {
    width: 100%;
    padding: 0.8rem;
    border: 1px solid #e9ecef;
    border-radius: 6px;
    transition: all 0.3s ease;
    margin-top: 0.5rem;
    box-sizing: border-box;
}

form input:focus {
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
    width: 100%;
    margin-top: 1rem;
    transition: all 0.3s ease;
    box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
}

button:hover {
    background-color: #333;
    transform: translateY(-2px);
    box-shadow: 0 6px 8px rgba(0, 0, 0, 0.15);
}

p {
    text-align: center;
    color: #e74c3c;
    margin-top: 1rem;
    padding: 1rem;
    background-color: #fff;
    border-radius: 8px;
    box-shadow: 0 4px 6px rgba(0, 0, 0, 0.05);
}

@media (max-width: 600px) {
    form {
        width: 90%;
        padding: 1.5rem;
    }
}
    </style>
</head>
<body>
    <%
        // Obtener el parámetro 'id' de la solicitud
        String idParam = request.getParameter("id");
        
        if (idParam != null && !idParam.isEmpty()) {
            try {
                // Intentar convertir el parámetro a un número
                int id = Integer.parseInt(idParam);

                String url = "jdbc:mysql://localhost:3306/bdexaReynosois175";
                String dbUser = "root";
                String dbPassword = "";

                Connection conn = null;
                PreparedStatement stmt = null;
                ResultSet rs = null;

                try {
                    // Establecer la conexión con la base de datos
                    conn = DriverManager.getConnection(url, dbUser, dbPassword);
                    stmt = conn.prepareStatement("SELECT * FROM Equipo WHERE idEquipo = ?");
                    stmt.setInt(1, id);
                    rs = stmt.executeQuery();

                    // Verificar si se encontró un equipo con ese id
                    if (rs.next()) {
        %>
                    <div class="container">
                     <h1>Edita tu Equipo</h1>
                    <form action="actualizarEquipo.jsp" method="POST">
                        <input type="hidden" name="id" value="<%= id %>">
                        <label>Nombre: <input type="text" name="nombre" value="<%= rs.getString("nombreEquipo") %>" required></label><br>
                        <label>Marca: <input type="text" name="marca" value="<%= rs.getString("marca") %>" required></label><br>
                        <label>Modelo: <input type="text" name="modelo" value="<%= rs.getString("modelo") %>" required></label><br>
                        <label>Existencia: <input type="number" name="existencia" value="<%= rs.getInt("existencia") %>" required></label><br>
                        <label>Precio: <input type="number" step="0.01" name="precio" value="<%= rs.getDouble("precio") %>" required></label><br>
                        <button type="submit">Actualizar Equipo</button>
                    </form>
                    </div>
        <%
                    } else {
                        out.println("<p>Error: No se encontró un equipo con el ID proporcionado.</p>");
                    }
                } catch (SQLException e) {
                    out.println("Error de base de datos: " + e.getMessage());
                } finally {
                    // Cerrar recursos de la base de datos
                    try {
                        if (rs != null) rs.close();
                        if (stmt != null) stmt.close();
                        if (conn != null) conn.close();
                    } catch (SQLException e) {
                        out.println("Error al cerrar los recursos: " + e.getMessage());
                    }
                }
            } catch (NumberFormatException e) {
                out.println("<p>Error: El parámetro ID no es un número válido.</p>");
            }
        } else {
            out.println("<p>Error: No se ha proporcionado un ID válido.</p>");
        }
    %>
</body>
</html>
