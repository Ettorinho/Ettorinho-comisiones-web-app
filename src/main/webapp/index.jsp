<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Comisiones Web App</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 40px;
            background-color: #f5f5f5;
        }
        .container {
            max-width: 800px;
            margin: 0 auto;
            background: white;
            padding: 30px;
            border-radius: 8px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        }
        h1 {
            color: #2c3e50;
            border-bottom: 3px solid #3498db;
            padding-bottom: 10px;
        }
        h2 {
            color: #34495e;
            margin-top: 30px;
        }
        ul {
            list-style-type: none;
            padding: 0;
        }
        li {
            background: #ecf0f1;
            margin: 10px 0;
            padding: 15px;
            border-radius: 5px;
            border-left: 4px solid #3498db;
        }
        a {
            color: #2980b9;
            text-decoration: none;
            font-weight: bold;
        }
        a:hover {
            color: #3498db;
            text-decoration: underline;
        }
        .status {
            background: #d5f4e6;
            border-left-color: #27ae60;
            color: #2d7d32;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>🎯 Comisiones Web App</h1>
        <div class="status">
            <p><strong>✅ Estado:</strong> La aplicación está funcionando correctamente</p>
            <p><strong>📅 Fecha:</strong> <%= new java.util.Date() %></p>
        </div>
        
        <h2>🔗 Enlaces disponibles:</h2>
        <ul>
            <li><a href="/api/comisiones">📊 API Comisiones</a> - Gestión de comisiones via REST API</li>
            <li><a href="/h2-console">🗄️ Consola H2</a> - Administración de base de datos</li>
            <li><a href="/actuator/health">💚 Health Check</a> - Estado de la aplicación</li>
        </ul>
        
        <h2>📋 Información del sistema:</h2>
        <ul>
            <li><strong>Versión Java:</strong> <%= System.getProperty("java.version") %></li>
            <li><strong>Sistema:</strong> <%= System.getProperty("os.name") %></li>
            <li><strong>Usuario:</strong> <%= System.getProperty("user.name") %></li>
        </ul>
    </div>
</body>
</html>