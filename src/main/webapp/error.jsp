<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page isErrorPage="true"%>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Error - Ettorinho Comisiones</title>
    
    <!-- Bootstrap 5 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Bootstrap Icons -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.0/font/bootstrap-icons.css">
    <!-- Estilos personalizados -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/styles.css">
    
    <style>
        .error-container {
            min-height: 80vh;
            display: flex;
            align-items: center;
            justify-content: center;
        }
        
        .error-icon {
            font-size: 5rem;
            color: #dc3545;
            animation: pulse 2s infinite;
        }
        
        @keyframes pulse {
            0% { transform: scale(1); }
            50% { transform: scale(1.05); }
            100% { transform: scale(1); }
        }
        
        .error-code {
            font-size: 4rem;
            font-weight: bold;
            color: #6c757d;
            text-shadow: 2px 2px 4px rgba(0,0,0,0.1);
        }
        
        .error-details {
            background: #f8f9fa;
            border: 1px solid #dee2e6;
            border-radius: 0.5rem;
            padding: 1rem;
            margin-top: 2rem;
        }
        
        .btn-home {
            background: linear-gradient(45deg, #0d6efd, #0b5ed7);
            border: none;
            color: white;
            font-weight: 600;
            padding: 0.75rem 2rem;
            border-radius: 0.5rem;
            transition: all 0.3s ease;
        }
        
        .btn-home:hover {
            transform: translateY(-2px);
            box-shadow: 0 0.5rem 1rem rgba(13, 110, 253, 0.3);
            color: white;
        }
    </style>
</head>
<body>
    <div class="error-container">
        <div class="container">
            <div class="row justify-content-center">
                <div class="col-md-8 col-lg-6">
                    <div class="text-center">
                        <!-- Icono de error -->
                        <div class="error-icon mb-4">
                            <i class="bi bi-exclamation-triangle-fill"></i>
                        </div>
                        
                        <!-- Código de error -->
                        <c:choose>
                            <c:when test="${pageContext.errorData != null}">
                                <div class="error-code mb-3">
                                    Error ${pageContext.errorData.statusCode}
                                </div>
                                
                                <c:choose>
                                    <c:when test="${pageContext.errorData.statusCode == 404}">
                                        <h2 class="text-danger mb-3">Página No Encontrada</h2>
                                        <p class="lead mb-4">
                                            Lo sentimos, la página que está buscando no existe o ha sido movida.
                                        </p>
                                    </c:when>
                                    <c:when test="${pageContext.errorData.statusCode == 500}">
                                        <h2 class="text-danger mb-3">Error Interno del Servidor</h2>
                                        <p class="lead mb-4">
                                            Ha ocurrido un error interno en el servidor. Nuestro equipo técnico ha sido notificado.
                                        </p>
                                    </c:when>
                                    <c:when test="${pageContext.errorData.statusCode == 403}">
                                        <h2 class="text-danger mb-3">Acceso Prohibido</h2>
                                        <p class="lead mb-4">
                                            No tiene permisos para acceder a este recurso.
                                        </p>
                                    </c:when>
                                    <c:otherwise>
                                        <h2 class="text-danger mb-3">Error del Servidor</h2>
                                        <p class="lead mb-4">
                                            Ha ocurrido un error inesperado. Por favor, inténtelo nuevamente.
                                        </p>
                                    </c:otherwise>
                                </c:choose>
                            </c:when>
                            <c:otherwise>
                                <div class="error-code mb-3">Error</div>
                                <h2 class="text-danger mb-3">Ha Ocurrido un Error</h2>
                                <p class="lead mb-4">
                                    Se ha producido un error inesperado al procesar su solicitud.
                                </p>
                            </c:otherwise>
                        </c:choose>
                        
                        <!-- Mostrar errores específicos si los hay -->
                        <c:if test="${not empty errores}">
                            <div class="alert alert-danger text-start">
                                <h5><i class="bi bi-bug-fill"></i> Detalles del Error:</h5>
                                <ul class="mb-0">
                                    <c:forEach var="error" items="${errores}">
                                        <li><c:out value="${error}"/></li>
                                    </c:forEach>
                                </ul>
                            </div>
                        </c:if>
                        
                        <!-- Información adicional para desarrolladores -->
                        <c:if test="${pageContext.errorData != null and pageContext.errorData.throwable != null}">
                            <div class="error-details text-start">
                                <h6><i class="bi bi-code-slash"></i> Información Técnica:</h6>
                                <p class="mb-1"><strong>URL Solicitada:</strong> ${pageContext.errorData.requestURI}</p>
                                <p class="mb-1"><strong>Servlet:</strong> ${pageContext.errorData.servletName}</p>
                                <c:if test="${not empty pageContext.errorData.throwable.message}">
                                    <p class="mb-0"><strong>Mensaje:</strong> 
                                        <code>${pageContext.errorData.throwable.message}</code>
                                    </p>
                                </c:if>
                            </div>
                        </c:if>
                        
                        <!-- Botones de acción -->
                        <div class="mt-4">
                            <div class="btn-group" role="group">
                                <button type="button" class="btn btn-outline-secondary" onclick="window.history.back()">
                                    <i class="bi bi-arrow-left"></i> Volver Atrás
                                </button>
                                <a href="${pageContext.request.contextPath}/" class="btn btn-home">
                                    <i class="bi bi-house-fill"></i> Inicio
                                </a>
                                <button type="button" class="btn btn-outline-primary" onclick="window.location.reload()">
                                    <i class="bi bi-arrow-clockwise"></i> Reintentar
                                </button>
                            </div>
                        </div>
                        
                        <!-- Información de contacto -->
                        <div class="mt-5 p-4 bg-light rounded">
                            <h6><i class="bi bi-headset"></i> ¿Necesita Ayuda?</h6>
                            <p class="mb-2">
                                Si el problema persiste, puede contactar con nuestro equipo de soporte técnico.
                            </p>
                            <div class="d-flex justify-content-center gap-3">
                                <a href="mailto:soporte@ettorinho.com" class="btn btn-sm btn-outline-primary">
                                    <i class="bi bi-envelope"></i> Email
                                </a>
                                <button type="button" class="btn btn-sm btn-outline-info" onclick="reportarError()">
                                    <i class="bi bi-flag"></i> Reportar Error
                                </button>
                            </div>
                        </div>
                        
                        <!-- Sugerencias útiles -->
                        <div class="mt-4">
                            <h6><i class="bi bi-lightbulb"></i> Sugerencias:</h6>
                            <ul class="list-unstyled text-muted">
                                <li>• Verifique que la URL esté escrita correctamente</li>
                                <li>• Asegúrese de que tiene una conexión estable a internet</li>
                                <li>• Intente limpiar la caché de su navegador</li>
                                <li>• Si el problema continúa, contacte con soporte técnico</li>
                            </ul>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Pie de página -->
    <footer class="text-center py-4 border-top bg-light">
        <div class="container">
            <p class="text-muted mb-0">
                <i class="bi bi-code-square"></i> 
                Sistema de Gestión de Comisiones - Ettorinho &copy; 2025
            </p>
        </div>
    </footer>

    <!-- Scripts -->
    <!-- Bootstrap 5 JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    
    <script>
        // Reportar error automáticamente (opcional)
        function reportarError() {
            const errorInfo = {
                url: window.location.href,
                userAgent: navigator.userAgent,
                timestamp: new Date().toISOString(),
                error: '${pageContext.errorData != null ? pageContext.errorData.statusCode : "Unknown"}',
                message: '${pageContext.errorData != null and pageContext.errorData.throwable != null ? pageContext.errorData.throwable.message : ""}'
            };
            
            // Simular envío de reporte de error
            console.log('Reporte de error:', errorInfo);
            
            // Mostrar confirmación
            const toast = document.createElement('div');
            toast.className = 'alert alert-success position-fixed top-0 start-50 translate-middle-x';
            toast.style.zIndex = '9999';
            toast.style.marginTop = '20px';
            toast.innerHTML = '<i class="bi bi-check-circle"></i> Reporte enviado correctamente. Gracias por su colaboración.';
            
            document.body.appendChild(toast);
            
            setTimeout(() => {
                toast.style.opacity = '0';
                setTimeout(() => {
                    if (toast.parentNode) {
                        toast.parentNode.removeChild(toast);
                    }
                }, 300);
            }, 3000);
        }
        
        // Efecto de animación al cargar
        document.addEventListener('DOMContentLoaded', function() {
            const elements = document.querySelectorAll('.error-icon, .error-code, h2, p, .btn-group');
            elements.forEach((element, index) => {
                element.style.opacity = '0';
                element.style.transform = 'translateY(20px)';
                
                setTimeout(() => {
                    element.style.transition = 'all 0.5s ease';
                    element.style.opacity = '1';
                    element.style.transform = 'translateY(0)';
                }, index * 100);
            });
        });
        
        // Tecla de acceso rápido para volver al inicio
        document.addEventListener('keydown', function(e) {
            if (e.key === 'Escape') {
                window.location.href = '${pageContext.request.contextPath}/';
            }
        });
    </script>
</body>
</html>