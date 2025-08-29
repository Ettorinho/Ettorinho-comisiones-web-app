<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@page import="com.ettorinho.comisiones.model.*"%>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Comisión Creada Exitosamente - Ettorinho</title>
    
    <!-- Bootstrap 5 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Bootstrap Icons -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.0/font/bootstrap-icons.css">
    <!-- Estilos personalizados -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/styles.css">
</head>
<body>
    <div class="main-container">
        <div class="container">
            <div class="content-wrapper fade-in">
                <!-- Mensaje de éxito -->
                <div class="alert alert-success text-center mb-4" role="alert">
                    <h2><i class="bi bi-check-circle-fill"></i> ¡Comisión Creada Exitosamente!</h2>
                    <p class="mb-0">La comisión ha sido registrada correctamente en el sistema.</p>
                </div>

                <c:if test="${not empty sessionScope.comision}">
                    <c:set var="comision" value="${sessionScope.comision}"/>
                    
                    <!-- Resumen de la Comisión -->
                    <div class="comision-summary">
                        <h2><i class="bi bi-building"></i> ${comision.nombre}</h2>
                        <p class="mb-0">
                            <c:if test="${not empty comision.fechaConstitucion}">
                                <strong>Constituida:</strong> 
                                <fmt:formatDate value="${comision.fechaConstitucion}" pattern="dd/MM/yyyy" var="fechaConstitucionStr"/>
                                ${comision.fechaConstitucion}
                            </c:if>
                            <c:if test="${not empty comision.fechaFin}">
                                | <strong>Finaliza:</strong> 
                                <fmt:formatDate value="${comision.fechaFin}" pattern="dd/MM/yyyy" var="fechaFinStr"/>
                                ${comision.fechaFin}
                            </c:if>
                        </p>
                        
                        <!-- Estadísticas -->
                        <div class="summary-stats">
                            <div class="stat-item">
                                <span class="stat-number">${comision.numeroMiembros}</span>
                                <span class="stat-label">Miembros Totales</span>
                            </div>
                            <div class="stat-item">
                                <span class="stat-number">${comision.numeroResponsables}</span>
                                <span class="stat-label">Responsables</span>
                            </div>
                            <div class="stat-item">
                                <span class="stat-number">${comision.numeroMiembros - comision.numeroResponsables}</span>
                                <span class="stat-label">Miembros</span>
                            </div>
                        </div>
                    </div>

                    <!-- Lista de Miembros -->
                    <div class="miembros-table">
                        <h4 class="text-center p-3 mb-0 bg-primary text-white">
                            <i class="bi bi-people-fill"></i> Lista de Miembros
                        </h4>
                        
                        <table class="table table-hover mb-0">
                            <thead>
                                <tr>
                                    <th>#</th>
                                    <th>Nombre Completo</th>
                                    <th>DNI/NIF</th>
                                    <th>Correo Electrónico</th>
                                    <th>Fecha Incorporación</th>
                                    <th>Cargo</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="miembro" items="${comision.miembros}" varStatus="status">
                                    <tr>
                                        <td><strong>${status.count}</strong></td>
                                        <td>
                                            <i class="bi bi-person-circle"></i>
                                            <strong>${miembro.nombreCompleto}</strong>
                                        </td>
                                        <td>
                                            <code>${miembro.dni}</code>
                                        </td>
                                        <td>
                                            <a href="mailto:${miembro.correo}" class="text-decoration-none">
                                                <i class="bi bi-envelope"></i> ${miembro.correo}
                                            </a>
                                        </td>
                                        <td>
                                            <i class="bi bi-calendar-event"></i>
                                            ${miembro.fechaIncorporacion}
                                        </td>
                                        <td>
                                            <c:choose>
                                                <c:when test="${miembro.cargo == 'RESPONSABLE'}">
                                                    <span class="badge badge-responsable">
                                                        <i class="bi bi-star-fill"></i> Responsable
                                                    </span>
                                                </c:when>
                                                <c:otherwise>
                                                    <span class="badge badge-miembro">
                                                        <i class="bi bi-person"></i> Miembro
                                                    </span>
                                                </c:otherwise>
                                            </c:choose>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>

                    <!-- Información adicional -->
                    <div class="row mt-4">
                        <div class="col-md-6">
                            <div class="card h-100">
                                <div class="card-header bg-info text-white">
                                    <i class="bi bi-info-circle"></i> Información General
                                </div>
                                <div class="card-body">
                                    <ul class="list-unstyled mb-0">
                                        <li><strong>Nombre:</strong> ${comision.nombre}</li>
                                        <li><strong>Fecha de Constitución:</strong> ${comision.fechaConstitucion}</li>
                                        <c:if test="${not empty comision.fechaFin}">
                                            <li><strong>Fecha de Finalización:</strong> ${comision.fechaFin}</li>
                                        </c:if>
                                        <li><strong>Estado:</strong> 
                                            <span class="badge bg-success">Activa</span>
                                        </li>
                                    </ul>
                                </div>
                            </div>
                        </div>
                        
                        <div class="col-md-6">
                            <div class="card h-100">
                                <div class="card-header bg-warning text-dark">
                                    <i class="bi bi-graph-up"></i> Estadísticas
                                </div>
                                <div class="card-body">
                                    <div class="row text-center">
                                        <div class="col-4">
                                            <div class="fw-bold text-primary" style="font-size: 1.5rem;">
                                                ${comision.numeroMiembros}
                                            </div>
                                            <small class="text-muted">Total</small>
                                        </div>
                                        <div class="col-4">
                                            <div class="fw-bold text-warning" style="font-size: 1.5rem;">
                                                ${comision.numeroResponsables}
                                            </div>
                                            <small class="text-muted">Responsables</small>
                                        </div>
                                        <div class="col-4">
                                            <div class="fw-bold text-info" style="font-size: 1.5rem;">
                                                ${comision.numeroMiembros - comision.numeroResponsables}
                                            </div>
                                            <small class="text-muted">Miembros</small>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Acciones -->
                    <div class="text-center mt-5">
                        <div class="btn-group" role="group">
                            <button type="button" class="btn btn-primary" onclick="window.print()">
                                <i class="bi bi-printer"></i> Imprimir Resumen
                            </button>
                            <button type="button" class="btn btn-secondary" 
                                    onclick="navigator.clipboard.writeText(document.getElementById('resumen-texto').textContent)">
                                <i class="bi bi-clipboard"></i> Copiar Resumen
                            </button>
                            <a href="${pageContext.request.contextPath}/" class="btn btn-success">
                                <i class="bi bi-plus-circle"></i> Crear Nueva Comisión
                            </a>
                        </div>
                    </div>

                    <!-- Texto para copiar (oculto) -->
                    <div id="resumen-texto" class="d-none">
RESUMEN DE COMISIÓN CREADA

Nombre: ${comision.nombre}
Fecha de Constitución: ${comision.fechaConstitucion}
<c:if test="${not empty comision.fechaFin}">Fecha de Finalización: ${comision.fechaFin}</c:if>
Total de Miembros: ${comision.numeroMiembros}
Responsables: ${comision.numeroResponsables}

LISTA DE MIEMBROS:
<c:forEach var="miembro" items="${comision.miembros}" varStatus="status">
${status.count}. ${miembro.nombreCompleto} - ${miembro.dni} - ${miembro.correo} - ${miembro.cargo}
</c:forEach>

---
Generado por Sistema de Gestión de Comisiones - Ettorinho
                    </div>

                    <!-- Limpiar sesión -->
                    <c:remove var="comision" scope="session"/>
                </c:if>

                <c:if test="${empty sessionScope.comision}">
                    <div class="alert alert-warning text-center" role="alert">
                        <h4><i class="bi bi-exclamation-triangle"></i> No hay información de comisión</h4>
                        <p>No se encontró información de la comisión creada.</p>
                        <a href="${pageContext.request.contextPath}/" class="btn btn-primary">
                            <i class="bi bi-arrow-left"></i> Volver al Formulario
                        </a>
                    </div>
                </c:if>
            </div>
        </div>
    </div>

    <!-- Pie de página -->
    <footer class="text-center mt-5 py-4 border-top">
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
    
    <!-- Script para funcionalidades adicionales -->
    <script>
        // Mostrar notificación de éxito
        document.addEventListener('DOMContentLoaded', function() {
            // Reproducir sonido de éxito (si está permitido)
            try {
                const audio = new Audio('data:audio/wav;base64,UklGRvIAAABXQVZFZm10IAAAAAAQAAEAAMD9AQCSAAEAIAAAAFABAABVVQABAAAAABAAAQAAAAAAAAAAAAAAAAAAAAAAA==');
                audio.volume = 0.1;
                audio.play().catch(e => console.log('Audio not allowed'));
            } catch (e) {
                console.log('Audio not supported');
            }
            
            // Animación de celebración
            setTimeout(() => {
                document.body.style.background = 'linear-gradient(45deg, #f0f8ff 25%, transparent 25%, transparent 75%, #f0f8ff 75%, #f0f8ff)';
                document.body.style.backgroundSize = '20px 20px';
                
                setTimeout(() => {
                    document.body.style.background = '';
                }, 3000);
            }, 500);
        });
        
        // Función para copiar al portapapeles con feedback
        async function copiarResumen() {
            const texto = document.getElementById('resumen-texto').textContent;
            try {
                await navigator.clipboard.writeText(texto);
                mostrarToast('Resumen copiado al portapapeles', 'success');
            } catch (err) {
                console.error('Error copiando al portapapeles: ', err);
                mostrarToast('Error copiando al portapapeles', 'error');
            }
        }
        
        // Función para mostrar toast
        function mostrarToast(mensaje, tipo) {
            const toast = document.createElement('div');
            toast.className = `alert alert-${tipo === 'success' ? 'success' : 'danger'} position-fixed top-0 start-50 translate-middle-x`;
            toast.style.zIndex = '9999';
            toast.style.marginTop = '20px';
            toast.innerHTML = mensaje;
            
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
    </script>
</body>
</html>