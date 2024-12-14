<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Iniciar Sesión</title>
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
    margin-bottom: 1rem;
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
    margin-top: 0.5rem;
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
    margin-top: 1rem;
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
    <div class="container">
        <h1>Iniciar Sesión</h1>
    <form action="validarLogin.jsp" method="POST">
        <label for="usuario">Usuario:</label>
        <input type="text" id="usuario" name="usuario" required>
        <br>
        <label for="contrasena">Contraseña:</label>
        <input type="password" id="contrasena" name="contrasena" required>
        <br>
        <button type="submit">Iniciar Sesión</button>
        <button onclick="window.location.href='registro.jsp'">Regístrate</button>

    </form>
    </div>
    <% if (request.getParameter("error") != null) { %>
        <p style="color: red;">Usuario o contraseña incorrectos.</p>
    <% } %>
</body>
</html>