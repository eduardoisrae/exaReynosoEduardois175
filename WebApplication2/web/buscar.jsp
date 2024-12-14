<%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Buscar Equipos</title>
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
            max-width: 800px;
            padding: 2rem;
            background-color: white;
            border-radius: 12px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.08);
        }
        h1 {
            display: inline-block;
            color: #000;
            font-weight: 700;
            margin-bottom: 2rem;
            position: relative;
            padding-bottom: 0.5rem;
            text-align: center;
            width: 100%;
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
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 2rem;
            background-color: white;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.08);
        }
        th, td {
            border: 1px solid #e9ecef;
            padding: 0.75rem;
            text-align: left;
        }
        th {
            background-color: #f4f6f7;
            font-weight: 600;
        }
        .no-results {
            text-align: center;
            color: #7f8c8d;
            margin-top: 2rem;
        }
        @media (max-width: 600px) {
            .container {
                width: 90%;
                padding: 1rem;
            }
            form {
                padding: 1.5rem;
            }
            table {
                font-size: 0.9rem;
            }
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>Buscar Equipos</h1>
        
        <!-- Formulario de búsqueda -->
        <form action="buscar.jsp" method="GET">
            <label>Nombre de Equipo: 
                <input type="text" name="nombre" value="<%= request.getParameter("nombre") != null ? request.getParameter("nombre") : "" %>">
            </label>
            <label>Marca: 
                <input type="text" name="marca" value="<%= request.getParameter("marca") != null ? request.getParameter("marca") : "" %>">
            </label>
            <button type="submit">Buscar</button>
        </form>

        <%
            // Obtener los parámetros de búsqueda
            String nombre = request.getParameter("nombre");
            String marca = request.getParameter("marca");
            // Conexión a la base de datos
            String url = "jdbc:mysql://localhost:3306/bdexaReynosois175";
            String dbUser = "root";
            String dbPassword = "";
            
            // Construir la consulta con filtros si es necesario
            StringBuilder query = new StringBuilder("SELECT * FROM Equipo WHERE 1=1");
            
            if (nombre != null && !nombre.trim().isEmpty()) {
                query.append(" AND nombreEquipo LIKE ?");
            }
            if (marca != null && !marca.trim().isEmpty()) {
                query.append(" AND marca LIKE ?");
            }
            // Intentar ejecutar la consulta con los filtros
            Connection conn = null;
            PreparedStatement stmt = null;
            ResultSet rs = null;
            try {
                conn = DriverManager.getConnection(url, dbUser, dbPassword);
                stmt = conn.prepareStatement(query.toString());
                int paramIndex = 1;
                // Asignar los valores de los parámetros si existen
                if (nombre != null && !nombre.trim().isEmpty()) {
                    stmt.setString(paramIndex++, "%" + nombre + "%");
                }
                if (marca != null && !marca.trim().isEmpty()) {
                    stmt.setString(paramIndex++, "%" + marca + "%");
                }
                rs = stmt.executeQuery();
                // Verificar si hay resultados
                if (rs.next()) {
        %>
        <table>
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
                    do {
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
                    } while (rs.next());
                %>
            </tbody>
        </table>
        <%
                } else {
        %>
            <p class="no-results">No se encontraron resultados para los criterios de búsqueda.</p>
        <%
                }
            } catch (SQLException e) {
        %>
            <p class="no-results">Error de base de datos: <%= e.getMessage() %></p>
        <%
            } finally {
                try {
                    if (rs != null) rs.close();
                    if (stmt != null) stmt.close();
                    if (conn != null) conn.close();
                } catch (SQLException e) {
        %>
            <p class="no-results">Error al cerrar los recursos: <%= e.getMessage() %></p>
        <%
                }
            }
        %>
    </div>
</body>
</html>