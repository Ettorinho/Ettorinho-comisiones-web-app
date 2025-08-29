<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page import="java.util.*"%>
<%@page import="com.ettorinho.comisiones.servlet.ComisionServlet.MiembroForm"%>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Gestión de Comisiones - Ettorinho</title>
    
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
                <!-- Header -->
                <div class="page-header">
                    <h1><i class="bi bi-people-fill"></i> Gestión de Comisiones</h1>
                    <p>Crear y gestionar comisiones y grupos de trabajo de forma eficiente</p>
                </div>

                <!-- Mostrar errores si los hay -->
                <c:if test="${not empty errores}">
                    <div class="alert alert-danger" role="alert">
                        <h5><i class="bi bi-exclamation-triangle-fill"></i> Se encontraron los siguientes errores:</h5>
                        <ul class="error-list">
                            <c:forEach var="error" items="${errores}">
                                <li><c:out value="${error}"/></li>
                            </c:forEach>
                        </ul>
                    </div>
                </c:if>

                <!-- Formulario Principal -->
                <form id="formComision" action="${pageContext.request.contextPath}/ComisionServlet" method="post" novalidate>
                    <!-- Información de la Comisión -->
                    <div class="form-section">
                        <h3><i class="bi bi-building"></i> Información de la Comisión</h3>
                        
                        <div class="row">
                            <div class="col-md-12 mb-3">
                                <label for="nombreComision" class="form-label">
                                    Nombre de la Comisión <span class="required">*</span>
                                </label>
                                <input type="text" class="form-control" id="nombreComision" name="nombreComision" 
                                       value="${nombreComision}" required maxlength="200"
                                       placeholder="Ej: Comisión de Tecnología e Innovación"
                                       title="Ingrese el nombre completo de la comisión">
                                <div class="invalid-feedback"></div>
                                <small class="form-text text-muted">
                                    <i class="bi bi-info-circle"></i> Nombre descriptivo de la comisión o grupo de trabajo
                                </small>
                            </div>
                        </div>
                        
                        <div class="row">
                            <div class="col-md-6 mb-3">
                                <label for="fechaConstitucion" class="form-label">
                                    Fecha de Constitución <span class="required">*</span>
                                </label>
                                <input type="date" class="form-control" id="fechaConstitucion" name="fechaConstitucion" 
                                       value="${fechaConstitucion}" required
                                       title="Fecha en la que se constituye la comisión">
                                <div class="invalid-feedback"></div>
                                <small class="form-text text-muted">
                                    <i class="bi bi-calendar"></i> Fecha oficial de inicio de la comisión
                                </small>
                            </div>
                            
                            <div class="col-md-6 mb-3">
                                <label for="fechaFin" class="form-label">
                                    Fecha de Finalización <small class="text-muted">(opcional)</small>
                                </label>
                                <input type="date" class="form-control" id="fechaFin" name="fechaFin" 
                                       value="${fechaFin}"
                                       title="Fecha en la que se disuelve la comisión (opcional)">
                                <div class="invalid-feedback"></div>
                                <small class="form-text text-muted">
                                    <i class="bi bi-calendar-x"></i> Fecha de disolución o finalización (si aplica)
                                </small>
                            </div>
                        </div>
                    </div>

                    <!-- Sección de Miembros -->
                    <div class="miembros-section">
                        <div class="d-flex justify-content-between align-items-center mb-4">
                            <h3><i class="bi bi-person-plus"></i> Miembros de la Comisión</h3>
                            <div class="d-flex align-items-center gap-3">
                                <span class="badge badge-info">
                                    <i class="bi bi-people"></i> 
                                    Total: <span id="contadorMiembros">0</span> miembros
                                </span>
                                <button type="button" id="btnAgregarMiembro" class="btn btn-outline-primary">
                                    <i class="bi bi-person-plus"></i> Añadir Miembro
                                </button>
                            </div>
                        </div>
                        
                        <div class="alert alert-info" role="alert">
                            <i class="bi bi-lightbulb"></i>
                            <strong>Importante:</strong> Debe asignar al menos un <strong>Responsable</strong> a la comisión.
                            Los responsables son los encargados de liderar y coordinar las actividades del grupo.
                        </div>
                        
                        <!-- Contenedor dinámico de miembros -->
                        <div id="contenedorMiembros">
                            <!-- Los miembros se añaden dinámicamente aquí -->
                            
                            <!-- Si hay miembros del formulario previo (errores), mostrarlos -->
                            <c:if test="${not empty miembrosForm}">
                                <c:forEach var="miembro" items="${miembrosForm}" varStatus="status">
                                    <div class="miembro-card" id="miembro-${status.count}">
                                        <div class="miembro-header">
                                            <span class="miembro-numero">👤 Miembro #${status.count}</span>
                                            <button type="button" class="btn-eliminar-miembro" 
                                                    onclick="eliminarMiembro(${status.count})" 
                                                    title="Eliminar miembro">
                                                ✕
                                            </button>
                                        </div>
                                        
                                        <div class="row">
                                            <div class="col-md-6 mb-3">
                                                <label class="form-label">Nombre <span class="required">*</span></label>
                                                <input type="text" class="form-control" name="miembro_nombre" 
                                                       value="${miembro.nombre}" required maxlength="50"
                                                       pattern="^[a-zA-ZáéíóúÁÉÍÓÚñÑ\\s]+$">
                                                <div class="invalid-feedback"></div>
                                            </div>
                                            
                                            <div class="col-md-6 mb-3">
                                                <label class="form-label">Apellidos <span class="required">*</span></label>
                                                <input type="text" class="form-control" name="miembro_apellidos" 
                                                       value="${miembro.apellidos}" required maxlength="100"
                                                       pattern="^[a-zA-ZáéíóúÁÉÍÓÚñÑ\\s]+$">
                                                <div class="invalid-feedback"></div>
                                            </div>
                                        </div>
                                        
                                        <div class="row">
                                            <div class="col-md-6 mb-3">
                                                <label class="form-label">DNI/NIF <span class="required">*</span></label>
                                                <input type="text" class="form-control" name="miembro_dni" 
                                                       value="${miembro.dni}" required maxlength="9" 
                                                       pattern="^[0-9]{8}[TRWAGMYFPDXBNJZSQVHLCKE]$"
                                                       placeholder="12345678A" style="text-transform: uppercase">
                                                <div class="invalid-feedback"></div>
                                            </div>
                                            
                                            <div class="col-md-6 mb-3">
                                                <label class="form-label">Correo Electrónico <span class="required">*</span></label>
                                                <input type="email" class="form-control" name="miembro_correo" 
                                                       value="${miembro.correo}" required maxlength="100">
                                                <div class="invalid-feedback"></div>
                                            </div>
                                        </div>
                                        
                                        <div class="row">
                                            <div class="col-md-6 mb-3">
                                                <label class="form-label">Fecha de Incorporación <span class="required">*</span></label>
                                                <input type="date" class="form-control" name="miembro_fecha_incorporacion" 
                                                       value="${miembro.fechaIncorporacion}" required>
                                                <div class="invalid-feedback"></div>
                                            </div>
                                            
                                            <div class="col-md-6 mb-3">
                                                <label class="form-label">Cargo <span class="required">*</span></label>
                                                <select class="form-select" name="miembro_cargo" required>
                                                    <option value="">Seleccione un cargo</option>
                                                    <option value="RESPONSABLE" ${miembro.cargo == 'RESPONSABLE' ? 'selected' : ''}>
                                                        👑 Responsable
                                                    </option>
                                                    <option value="MIEMBRO" ${miembro.cargo == 'MIEMBRO' ? 'selected' : ''}>
                                                        👤 Miembro
                                                    </option>
                                                </select>
                                                <div class="invalid-feedback"></div>
                                            </div>
                                        </div>
                                    </div>
                                </c:forEach>
                                <script>
                                    // Actualizar contador después de cargar miembros existentes
                                    document.addEventListener('DOMContentLoaded', function() {
                                        contadorMiembros = ${not empty miembrosForm ? miembrosForm.size() : 0};
                                        actualizarContadorMiembros();
                                    });
                                </script>
                            </c:if>
                        </div>
                        
                        <!-- Información adicional -->
                        <div class="mt-4 p-3 bg-light rounded">
                            <h6><i class="bi bi-info-circle-fill"></i> Información sobre los cargos:</h6>
                            <ul class="mb-0">
                                <li><strong>👑 Responsable:</strong> Lidera y coordina las actividades de la comisión. Tiene autoridad para tomar decisiones ejecutivas.</li>
                                <li><strong>👤 Miembro:</strong> Participa activamente en las actividades y contribuye al cumplimiento de los objetivos.</li>
                            </ul>
                        </div>
                    </div>

                    <!-- Botones de acción -->
                    <div class="text-center mt-4">
                        <button type="button" class="btn btn-secondary me-3" onclick="window.location.reload()">
                            <i class="bi bi-arrow-clockwise"></i> Limpiar Formulario
                        </button>
                        <button type="submit" class="btn btn-success btn-lg">
                            <i class="bi bi-check-circle"></i> Crear Comisión
                        </button>
                    </div>
                </form>
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
    <!-- Script personalizado -->
    <script src="${pageContext.request.contextPath}/js/script.js"></script>
</body>
</html>