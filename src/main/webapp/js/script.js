/**
 * Script JavaScript para la gestión dinámica del formulario de comisiones
 */

// Variables globales
let contadorMiembros = 1;
let miembrosData = [];

// Inicialización cuando el DOM esté listo
document.addEventListener('DOMContentLoaded', function() {
    console.log('Aplicación de Comisiones cargada');
    inicializarFormulario();
    configurarValidaciones();
    configurarEventos();
});

/**
 * Inicializa el formulario con el primer miembro
 */
function inicializarFormulario() {
    // Si ya hay miembros (por ejemplo, después de un error), no añadir uno nuevo
    const miembrosExistentes = document.querySelectorAll('.miembro-card');
    if (miembrosExistentes.length === 0) {
        agregarMiembro();
    }
    
    // Configurar fecha mínima como hoy
    const fechaConstitucion = document.getElementById('fechaConstitucion');
    const fechaFin = document.getElementById('fechaFin');
    const hoy = new Date().toISOString().split('T')[0];
    
    if (fechaConstitucion) {
        fechaConstitucion.setAttribute('min', hoy);
    }
    
    // Configurar validación de fechas
    if (fechaConstitucion && fechaFin) {
        fechaConstitucion.addEventListener('change', function() {
            fechaFin.setAttribute('min', this.value);
            if (fechaFin.value && fechaFin.value < this.value) {
                fechaFin.value = '';
                mostrarMensaje('La fecha fin debe ser posterior a la fecha de constitución', 'warning');
            }
        });
    }
}

/**
 * Configura las validaciones en tiempo real
 */
function configurarValidaciones() {
    // Validación del nombre de la comisión
    const nombreComision = document.getElementById('nombreComision');
    if (nombreComision) {
        nombreComision.addEventListener('blur', function() {
            validarCampoRequerido(this, 'El nombre de la comisión es obligatorio');
        });
    }
    
    // Validación de fechas
    const fechaConstitucion = document.getElementById('fechaConstitucion');
    if (fechaConstitucion) {
        fechaConstitucion.addEventListener('blur', function() {
            validarCampoRequerido(this, 'La fecha de constitución es obligatoria');
        });
    }
}

/**
 * Configura los eventos del formulario
 */
function configurarEventos() {
    // Botón para agregar miembro
    const btnAgregarMiembro = document.getElementById('btnAgregarMiembro');
    if (btnAgregarMiembro) {
        btnAgregarMiembro.addEventListener('click', function(e) {
            e.preventDefault();
            agregarMiembro();
        });
    }
    
    // Validación antes de enviar
    const formulario = document.getElementById('formComision');
    if (formulario) {
        formulario.addEventListener('submit', function(e) {
            if (!validarFormulario()) {
                e.preventDefault();
                mostrarMensaje('Por favor, corrija los errores antes de enviar el formulario', 'danger');
            }
        });
    }
}

/**
 * Añade un nuevo miembro al formulario
 */
function agregarMiembro() {
    contadorMiembros++;
    const contenedorMiembros = document.getElementById('contenedorMiembros');
    
    const miembroCard = document.createElement('div');
    miembroCard.className = 'miembro-card slide-in';
    miembroCard.id = `miembro-${contadorMiembros}`;
    
    miembroCard.innerHTML = `
        <div class="miembro-header">
            <span class="miembro-numero">👤 Miembro #${contadorMiembros}</span>
            <button type="button" class="btn-eliminar-miembro" onclick="eliminarMiembro(${contadorMiembros})" 
                    title="Eliminar miembro">
                ✕
            </button>
        </div>
        
        <div class="row">
            <div class="col-md-6 mb-3">
                <label for="miembro_nombre_${contadorMiembros}" class="form-label">
                    Nombre <span class="required">*</span>
                </label>
                <input type="text" class="form-control" 
                       name="miembro_nombre" 
                       id="miembro_nombre_${contadorMiembros}"
                       required maxlength="50"
                       pattern="^[a-zA-ZáéíóúÁÉÍÓÚñÑ\\s]+$"
                       title="Solo se permiten letras y espacios">
                <div class="invalid-feedback"></div>
            </div>
            
            <div class="col-md-6 mb-3">
                <label for="miembro_apellidos_${contadorMiembros}" class="form-label">
                    Apellidos <span class="required">*</span>
                </label>
                <input type="text" class="form-control" 
                       name="miembro_apellidos" 
                       id="miembro_apellidos_${contadorMiembros}"
                       required maxlength="100"
                       pattern="^[a-zA-ZáéíóúÁÉÍÓÚñÑ\\s]+$"
                       title="Solo se permiten letras y espacios">
                <div class="invalid-feedback"></div>
            </div>
        </div>
        
        <div class="row">
            <div class="col-md-6 mb-3">
                <label for="miembro_dni_${contadorMiembros}" class="form-label">
                    DNI/NIF <span class="required">*</span>
                </label>
                <input type="text" class="form-control" 
                       name="miembro_dni" 
                       id="miembro_dni_${contadorMiembros}"
                       required maxlength="9" 
                       pattern="^[0-9]{8}[TRWAGMYFPDXBNJZSQVHLCKE]$"
                       title="Formato: 12345678A (8 números + letra)"
                       placeholder="12345678A"
                       style="text-transform: uppercase">
                <div class="invalid-feedback"></div>
            </div>
            
            <div class="col-md-6 mb-3">
                <label for="miembro_correo_${contadorMiembros}" class="form-label">
                    Correo Electrónico <span class="required">*</span>
                </label>
                <input type="email" class="form-control" 
                       name="miembro_correo" 
                       id="miembro_correo_${contadorMiembros}"
                       required maxlength="100"
                       placeholder="ejemplo@correo.com">
                <div class="invalid-feedback"></div>
            </div>
        </div>
        
        <div class="row">
            <div class="col-md-6 mb-3">
                <label for="miembro_fecha_incorporacion_${contadorMiembros}" class="form-label">
                    Fecha de Incorporación <span class="required">*</span>
                </label>
                <input type="date" class="form-control" 
                       name="miembro_fecha_incorporacion" 
                       id="miembro_fecha_incorporacion_${contadorMiembros}"
                       required>
                <div class="invalid-feedback"></div>
            </div>
            
            <div class="col-md-6 mb-3">
                <label for="miembro_cargo_${contadorMiembros}" class="form-label">
                    Cargo <span class="required">*</span>
                </label>
                <select class="form-select" 
                        name="miembro_cargo" 
                        id="miembro_cargo_${contadorMiembros}"
                        required>
                    <option value="">Seleccione un cargo</option>
                    <option value="RESPONSABLE">👑 Responsable</option>
                    <option value="MIEMBRO">👤 Miembro</option>
                </select>
                <div class="invalid-feedback"></div>
            </div>
        </div>
    `;
    
    contenedorMiembros.appendChild(miembroCard);
    
    // Configurar validaciones para el nuevo miembro
    configurarValidacionesMiembro(contadorMiembros);
    
    // Actualizar contador visual
    actualizarContadorMiembros();
    
    // Scroll suave al nuevo miembro
    miembroCard.scrollIntoView({ behavior: 'smooth', block: 'nearest' });
    
    // Focus en el primer campo
    document.getElementById(`miembro_nombre_${contadorMiembros}`).focus();
    
    mostrarMensaje('Nuevo miembro añadido', 'success');
}

/**
 * Elimina un miembro del formulario
 */
function eliminarMiembro(numeroMiembro) {
    const totalMiembros = document.querySelectorAll('.miembro-card').length;
    
    if (totalMiembros <= 1) {
        mostrarMensaje('Debe mantener al menos un miembro en la comisión', 'warning');
        return;
    }
    
    const miembro = document.getElementById(`miembro-${numeroMiembro}`);
    if (miembro) {
        // Animación de salida
        miembro.style.transition = 'all 0.3s ease-out';
        miembro.style.transform = 'translateX(-100%)';
        miembro.style.opacity = '0';
        
        setTimeout(() => {
            miembro.remove();
            actualizarContadorMiembros();
            renumerarMiembros();
            mostrarMensaje('Miembro eliminado', 'info');
        }, 300);
    }
}

/**
 * Configura las validaciones específicas para un miembro
 */
function configurarValidacionesMiembro(numeroMiembro) {
    const campos = [
        { id: `miembro_nombre_${numeroMiembro}`, validator: validarNombre },
        { id: `miembro_apellidos_${numeroMiembro}`, validator: validarApellidos },
        { id: `miembro_dni_${numeroMiembro}`, validator: validarDNI },
        { id: `miembro_correo_${numeroMiembro}`, validator: validarEmail },
        { id: `miembro_fecha_incorporacion_${numeroMiembro}`, validator: validarFecha },
        { id: `miembro_cargo_${numeroMiembro}`, validator: validarCargo }
    ];
    
    campos.forEach(campo => {
        const elemento = document.getElementById(campo.id);
        if (elemento) {
            elemento.addEventListener('blur', function() {
                campo.validator(this);
            });
            
            elemento.addEventListener('input', function() {
                if (this.classList.contains('is-invalid')) {
                    campo.validator(this);
                }
            });
        }
    });
    
    // Convertir DNI a mayúsculas automáticamente
    const dniField = document.getElementById(`miembro_dni_${numeroMiembro}`);
    if (dniField) {
        dniField.addEventListener('input', function() {
            this.value = this.value.toUpperCase();
        });
    }
}

/**
 * Actualiza el contador visual de miembros
 */
function actualizarContadorMiembros() {
    const totalMiembros = document.querySelectorAll('.miembro-card').length;
    const contador = document.getElementById('contadorMiembros');
    if (contador) {
        contador.textContent = totalMiembros;
    }
}

/**
 * Renumera los miembros después de eliminar uno
 */
function renumerarMiembros() {
    const miembros = document.querySelectorAll('.miembro-card');
    miembros.forEach((miembro, index) => {
        const numeroMiembro = index + 1;
        const titulo = miembro.querySelector('.miembro-numero');
        if (titulo) {
            titulo.textContent = `👤 Miembro #${numeroMiembro}`;
        }
    });
}

/**
 * Validaciones específicas
 */
function validarNombre(campo) {
    const valor = campo.value.trim();
    const regex = /^[a-zA-ZáéíóúÁÉÍÓÚñÑ\s]+$/;
    
    if (!valor) {
        mostrarError(campo, 'El nombre es obligatorio');
        return false;
    }
    
    if (valor.length < 2) {
        mostrarError(campo, 'El nombre debe tener al menos 2 caracteres');
        return false;
    }
    
    if (!regex.test(valor)) {
        mostrarError(campo, 'Solo se permiten letras y espacios');
        return false;
    }
    
    mostrarExito(campo);
    return true;
}

function validarApellidos(campo) {
    const valor = campo.value.trim();
    const regex = /^[a-zA-ZáéíóúÁÉÍÓÚñÑ\s]+$/;
    
    if (!valor) {
        mostrarError(campo, 'Los apellidos son obligatorios');
        return false;
    }
    
    if (valor.length < 2) {
        mostrarError(campo, 'Los apellidos deben tener al menos 2 caracteres');
        return false;
    }
    
    if (!regex.test(valor)) {
        mostrarError(campo, 'Solo se permiten letras y espacios');
        return false;
    }
    
    mostrarExito(campo);
    return true;
}

function validarDNI(campo) {
    const dni = campo.value.trim().toUpperCase();
    const regex = /^[0-9]{8}[TRWAGMYFPDXBNJZSQVHLCKE]$/;
    const letras = "TRWAGMYFPDXBNJZSQVHLCKE";
    
    if (!dni) {
        mostrarError(campo, 'El DNI es obligatorio');
        return false;
    }
    
    if (!regex.test(dni)) {
        mostrarError(campo, 'Formato de DNI incorrecto (8 números + letra)');
        return false;
    }
    
    // Validar dígito de control
    const numero = parseInt(dni.substr(0, 8));
    const letra = dni.charAt(8);
    const letraCorrecta = letras[numero % 23];
    
    if (letra !== letraCorrecta) {
        mostrarError(campo, `La letra del DNI debe ser ${letraCorrecta}`);
        return false;
    }
    
    // Verificar DNI duplicado
    if (verificarDNIDuplicado(dni, campo)) {
        mostrarError(campo, 'Este DNI ya está registrado en otro miembro');
        return false;
    }
    
    mostrarExito(campo);
    return true;
}

function validarEmail(campo) {
    const email = campo.value.trim();
    const regex = /^[A-Za-z0-9+_.-]+@([A-Za-z0-9.-]+\.[A-Za-z]{2,})$/;
    
    if (!email) {
        mostrarError(campo, 'El correo electrónico es obligatorio');
        return false;
    }
    
    if (!regex.test(email)) {
        mostrarError(campo, 'Formato de correo electrónico incorrecto');
        return false;
    }
    
    // Verificar email duplicado
    if (verificarEmailDuplicado(email, campo)) {
        mostrarError(campo, 'Este correo ya está registrado en otro miembro');
        return false;
    }
    
    mostrarExito(campo);
    return true;
}

function validarFecha(campo) {
    const fecha = campo.value;
    
    if (!fecha) {
        mostrarError(campo, 'La fecha es obligatoria');
        return false;
    }
    
    const fechaSeleccionada = new Date(fecha);
    const hoy = new Date();
    hoy.setHours(0, 0, 0, 0);
    
    if (fechaSeleccionada > hoy) {
        mostrarError(campo, 'La fecha no puede ser futura');
        return false;
    }
    
    mostrarExito(campo);
    return true;
}

function validarCargo(campo) {
    const valor = campo.value;
    
    if (!valor) {
        mostrarError(campo, 'Debe seleccionar un cargo');
        return false;
    }
    
    if (!['RESPONSABLE', 'MIEMBRO'].includes(valor)) {
        mostrarError(campo, 'Cargo no válido');
        return false;
    }
    
    mostrarExito(campo);
    return true;
}

/**
 * Verifica si hay DNIs duplicados
 */
function verificarDNIDuplicado(dni, campoActual) {
    const todosDNIs = document.querySelectorAll('input[name="miembro_dni"]');
    let duplicado = false;
    
    todosDNIs.forEach(campo => {
        if (campo !== campoActual && campo.value.trim().toUpperCase() === dni) {
            duplicado = true;
        }
    });
    
    return duplicado;
}

/**
 * Verifica si hay emails duplicados
 */
function verificarEmailDuplicado(email, campoActual) {
    const todosEmails = document.querySelectorAll('input[name="miembro_correo"]');
    let duplicado = false;
    
    todosEmails.forEach(campo => {
        if (campo !== campoActual && campo.value.trim().toLowerCase() === email.toLowerCase()) {
            duplicado = true;
        }
    });
    
    return duplicado;
}

/**
 * Valida todo el formulario antes del envío
 */
function validarFormulario() {
    let valido = true;
    
    // Validar datos de la comisión
    const nombreComision = document.getElementById('nombreComision');
    const fechaConstitucion = document.getElementById('fechaConstitucion');
    
    if (!validarCampoRequerido(nombreComision, 'El nombre de la comisión es obligatorio')) {
        valido = false;
    }
    
    if (!validarCampoRequerido(fechaConstitucion, 'La fecha de constitución es obligatoria')) {
        valido = false;
    }
    
    // Validar que hay al menos un responsable
    const responsables = document.querySelectorAll('select[name="miembro_cargo"]');
    let tieneResponsable = false;
    
    responsables.forEach(select => {
        if (select.value === 'RESPONSABLE') {
            tieneResponsable = true;
        }
    });
    
    if (!tieneResponsable) {
        mostrarMensaje('Debe asignar al menos un responsable a la comisión', 'danger');
        valido = false;
    }
    
    // Validar todos los miembros
    const miembros = document.querySelectorAll('.miembro-card');
    miembros.forEach((miembro, index) => {
        const numeroMiembro = index + 1;
        const campos = [
            miembro.querySelector('input[name="miembro_nombre"]'),
            miembro.querySelector('input[name="miembro_apellidos"]'),
            miembro.querySelector('input[name="miembro_dni"]'),
            miembro.querySelector('input[name="miembro_correo"]'),
            miembro.querySelector('input[name="miembro_fecha_incorporacion"]'),
            miembro.querySelector('select[name="miembro_cargo"]')
        ];
        
        campos.forEach(campo => {
            if (campo && !campo.checkValidity()) {
                mostrarError(campo, `Campo inválido en miembro ${numeroMiembro}`);
                valido = false;
            }
        });
    });
    
    return valido;
}

/**
 * Validadores auxiliares
 */
function validarCampoRequerido(campo, mensaje) {
    if (!campo || !campo.value.trim()) {
        mostrarError(campo, mensaje);
        return false;
    }
    
    mostrarExito(campo);
    return true;
}

function mostrarError(campo, mensaje) {
    if (!campo) return;
    
    campo.classList.remove('is-valid');
    campo.classList.add('is-invalid');
    
    const feedback = campo.parentElement.querySelector('.invalid-feedback');
    if (feedback) {
        feedback.textContent = mensaje;
    }
}

function mostrarExito(campo) {
    if (!campo) return;
    
    campo.classList.remove('is-invalid');
    campo.classList.add('is-valid');
}

/**
 * Muestra mensajes al usuario
 */
function mostrarMensaje(mensaje, tipo = 'info') {
    // Crear o actualizar el contenedor de mensajes
    let contenedorMensajes = document.getElementById('mensajes');
    if (!contenedorMensajes) {
        contenedorMensajes = document.createElement('div');
        contenedorMensajes.id = 'mensajes';
        contenedorMensajes.className = 'mb-3';
        
        // Insertar antes del formulario
        const formulario = document.getElementById('formComision');
        if (formulario && formulario.parentNode) {
            formulario.parentNode.insertBefore(contenedorMensajes, formulario);
        }
    }
    
    const alerta = document.createElement('div');
    alerta.className = `alert alert-${tipo} fade-in`;
    alerta.innerHTML = `
        <strong>${tipo === 'danger' ? '❌' : tipo === 'success' ? '✅' : tipo === 'warning' ? '⚠️' : 'ℹ️'}</strong>
        ${mensaje}
    `;
    
    contenedorMensajes.innerHTML = '';
    contenedorMensajes.appendChild(alerta);
    
    // Auto-ocultar después de 5 segundos para mensajes de éxito/info
    if (['success', 'info'].includes(tipo)) {
        setTimeout(() => {
            if (alerta.parentNode) {
                alerta.style.opacity = '0';
                setTimeout(() => {
                    if (alerta.parentNode) {
                        alerta.parentNode.removeChild(alerta);
                    }
                }, 300);
            }
        }, 5000);
    }
    
    // Scroll suave al mensaje
    contenedorMensajes.scrollIntoView({ behavior: 'smooth', block: 'nearest' });
}

/**
 * Funciones auxiliares para mejorar la experiencia de usuario
 */

// Mostrar/ocultar spinner de carga
function mostrarSpinner(show = true) {
    const botones = document.querySelectorAll('button[type="submit"]');
    botones.forEach(boton => {
        if (show) {
            boton.disabled = true;
            const spinner = document.createElement('span');
            spinner.className = 'spinner';
            spinner.id = 'spinner-loading';
            boton.insertBefore(spinner, boton.firstChild);
        } else {
            boton.disabled = false;
            const spinner = document.getElementById('spinner-loading');
            if (spinner) {
                spinner.remove();
            }
        }
    });
}

// Guardar datos del formulario en localStorage (backup)
function guardarBorrador() {
    const formData = new FormData(document.getElementById('formComision'));
    const datos = {};
    
    for (let [key, value] of formData.entries()) {
        if (!datos[key]) {
            datos[key] = [];
        }
        datos[key].push(value);
    }
    
    localStorage.setItem('comision_borrador', JSON.stringify(datos));
}

// Cargar borrador desde localStorage
function cargarBorrador() {
    const borrador = localStorage.getItem('comision_borrador');
    if (borrador) {
        try {
            const datos = JSON.parse(borrador);
            // Implementar lógica de carga si es necesario
            console.log('Borrador disponible:', datos);
        } catch (e) {
            console.error('Error cargando borrador:', e);
        }
    }
}

// Limpiar borrador
function limpiarBorrador() {
    localStorage.removeItem('comision_borrador');
}

// Configurar auto-guardado cada 30 segundos
setInterval(() => {
    const formulario = document.getElementById('formComision');
    if (formulario && document.querySelector('input:focus, select:focus')) {
        guardarBorrador();
    }
}, 30000);