package com.ettorinho.comisiones.servlet;

import com.ettorinho.comisiones.model.Comision;
import com.ettorinho.comisiones.model.Miembro;
import com.ettorinho.comisiones.model.TipoCargo;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.time.format.DateTimeParseException;
import java.util.ArrayList;
import java.util.List;
import java.util.regex.Pattern;

/**
 * Servlet para procesar los datos de creación de comisiones
 */
@WebServlet("/ComisionServlet")
public class ComisionServlet extends HttpServlet {
    
    private static final String EMAIL_REGEX = "^[A-Za-z0-9+_.-]+@([A-Za-z0-9.-]+\\.[A-Za-z]{2,})$";
    private static final String DNI_REGEX = "^[0-9]{8}[TRWAGMYFPDXBNJZSQVHLCKE]$";
    private static final Pattern EMAIL_PATTERN = Pattern.compile(EMAIL_REGEX);
    private static final Pattern DNI_PATTERN = Pattern.compile(DNI_REGEX);
    private static final String DNI_LETTERS = "TRWAGMYFPDXBNJZSQVHLCKE";
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        
        List<String> errores = new ArrayList<>();
        
        try {
            // Obtener datos de la comisión
            String nombreComision = request.getParameter("nombreComision");
            String fechaConstitucionStr = request.getParameter("fechaConstitucion");
            String fechaFinStr = request.getParameter("fechaFin");
            
            // Validar datos de la comisión
            if (nombreComision == null || nombreComision.trim().isEmpty()) {
                errores.add("El nombre de la comisión es obligatorio");
            }
            
            LocalDate fechaConstitucion = null;
            LocalDate fechaFin = null;
            
            if (fechaConstitucionStr == null || fechaConstitucionStr.trim().isEmpty()) {
                errores.add("La fecha de constitución es obligatoria");
            } else {
                try {
                    fechaConstitucion = LocalDate.parse(fechaConstitucionStr);
                } catch (DateTimeParseException e) {
                    errores.add("La fecha de constitución no es válida");
                }
            }
            
            if (fechaFinStr != null && !fechaFinStr.trim().isEmpty()) {
                try {
                    fechaFin = LocalDate.parse(fechaFinStr);
                    if (fechaConstitucion != null && fechaFin.isBefore(fechaConstitucion)) {
                        errores.add("La fecha fin debe ser posterior a la fecha de constitución");
                    }
                } catch (DateTimeParseException e) {
                    errores.add("La fecha fin no es válida");
                }
            }
            
            // Crear la comisión
            Comision comision = new Comision(nombreComision, fechaConstitucion, fechaFin);
            
            // Procesar miembros
            String[] nombres = request.getParameterValues("miembro_nombre");
            String[] apellidos = request.getParameterValues("miembro_apellidos");
            String[] dnis = request.getParameterValues("miembro_dni");
            String[] correos = request.getParameterValues("miembro_correo");
            String[] fechasIncorporacion = request.getParameterValues("miembro_fecha_incorporacion");
            String[] cargos = request.getParameterValues("miembro_cargo");
            
            if (nombres == null || nombres.length == 0) {
                errores.add("Debe agregar al menos un miembro a la comisión");
            } else {
                boolean tieneResponsable = false;
                
                for (int i = 0; i < nombres.length; i++) {
                    String nombre = nombres[i];
                    String apellido = apellidos[i];
                    String dni = dnis[i];
                    String correo = correos[i];
                    String fechaIncorporacionStr = fechasIncorporacion[i];
                    String cargoStr = cargos[i];
                    
                    // Validar datos del miembro
                    List<String> erroresMiembro = validarMiembro(nombre, apellido, dni, correo, 
                                                                fechaIncorporacionStr, cargoStr, i + 1);
                    errores.addAll(erroresMiembro);
                    
                    if (erroresMiembro.isEmpty()) {
                        try {
                            LocalDate fechaIncorporacion = LocalDate.parse(fechaIncorporacionStr);
                            TipoCargo cargo = TipoCargo.valueOf(cargoStr);
                            
                            if (cargo == TipoCargo.RESPONSABLE) {
                                tieneResponsable = true;
                            }
                            
                            Miembro miembro = new Miembro(nombre, apellido, dni, correo, 
                                                        fechaIncorporacion, cargo);
                            comision.addMiembro(miembro);
                            
                        } catch (Exception e) {
                            errores.add("Error al procesar el miembro " + (i + 1) + ": " + e.getMessage());
                        }
                    }
                }
                
                if (!tieneResponsable) {
                    errores.add("La comisión debe tener al menos un responsable");
                }
            }
            
            if (errores.isEmpty()) {
                // Éxito - redirigir a página de confirmación
                request.getSession().setAttribute("comision", comision);
                response.sendRedirect("exito.jsp");
            } else {
                // Errores - volver al formulario con errores
                request.setAttribute("errores", errores);
                request.setAttribute("nombreComision", nombreComision);
                request.setAttribute("fechaConstitucion", fechaConstitucionStr);
                request.setAttribute("fechaFin", fechaFinStr);
                
                // Preservar datos de miembros para no perder el trabajo
                if (nombres != null) {
                    List<MiembroForm> miembrosForm = new ArrayList<>();
                    for (int i = 0; i < nombres.length; i++) {
                        MiembroForm mf = new MiembroForm();
                        mf.nombre = nombres[i];
                        mf.apellidos = apellidos[i];
                        mf.dni = dnis[i];
                        mf.correo = correos[i];
                        mf.fechaIncorporacion = fechasIncorporacion[i];
                        mf.cargo = cargos[i];
                        miembrosForm.add(mf);
                    }
                    request.setAttribute("miembrosForm", miembrosForm);
                }
                
                request.getRequestDispatcher("index.jsp").forward(request, response);
            }
            
        } catch (Exception e) {
            e.printStackTrace();
            errores.add("Error interno del servidor: " + e.getMessage());
            request.setAttribute("errores", errores);
            request.getRequestDispatcher("error.jsp").forward(request, response);
        }
    }
    
    private List<String> validarMiembro(String nombre, String apellidos, String dni, String correo,
                                       String fechaIncorporacionStr, String cargoStr, int numeroMiembro) {
        List<String> errores = new ArrayList<>();
        
        if (nombre == null || nombre.trim().isEmpty()) {
            errores.add("El nombre del miembro " + numeroMiembro + " es obligatorio");
        } else if (!nombre.matches("^[a-zA-ZáéíóúÁÉÍÓÚñÑ\\s]+$")) {
            errores.add("El nombre del miembro " + numeroMiembro + " contiene caracteres no válidos");
        }
        
        if (apellidos == null || apellidos.trim().isEmpty()) {
            errores.add("Los apellidos del miembro " + numeroMiembro + " son obligatorios");
        } else if (!apellidos.matches("^[a-zA-ZáéíóúÁÉÍÓÚñÑ\\s]+$")) {
            errores.add("Los apellidos del miembro " + numeroMiembro + " contienen caracteres no válidos");
        }
        
        if (dni == null || dni.trim().isEmpty()) {
            errores.add("El DNI del miembro " + numeroMiembro + " es obligatorio");
        } else if (!validarDNI(dni.trim().toUpperCase())) {
            errores.add("El DNI del miembro " + numeroMiembro + " no es válido");
        }
        
        if (correo == null || correo.trim().isEmpty()) {
            errores.add("El correo del miembro " + numeroMiembro + " es obligatorio");
        } else if (!EMAIL_PATTERN.matcher(correo.trim()).matches()) {
            errores.add("El correo del miembro " + numeroMiembro + " no es válido");
        }
        
        if (fechaIncorporacionStr == null || fechaIncorporacionStr.trim().isEmpty()) {
            errores.add("La fecha de incorporación del miembro " + numeroMiembro + " es obligatoria");
        } else {
            try {
                LocalDate.parse(fechaIncorporacionStr);
            } catch (DateTimeParseException e) {
                errores.add("La fecha de incorporación del miembro " + numeroMiembro + " no es válida");
            }
        }
        
        if (cargoStr == null || cargoStr.trim().isEmpty()) {
            errores.add("El cargo del miembro " + numeroMiembro + " es obligatorio");
        } else {
            try {
                TipoCargo.valueOf(cargoStr);
            } catch (IllegalArgumentException e) {
                errores.add("El cargo del miembro " + numeroMiembro + " no es válido");
            }
        }
        
        return errores;
    }
    
    /**
     * Valida un DNI español con su dígito de control
     */
    private boolean validarDNI(String dni) {
        if (dni == null || !DNI_PATTERN.matcher(dni).matches()) {
            return false;
        }
        
        try {
            int numero = Integer.parseInt(dni.substring(0, 8));
            char letra = dni.charAt(8);
            char letraEsperada = DNI_LETTERS.charAt(numero % 23);
            return letra == letraEsperada;
        } catch (NumberFormatException e) {
            return false;
        }
    }
    
    /**
     * Clase auxiliar para mantener los datos del formulario en caso de error
     */
    public static class MiembroForm {
        public String nombre;
        public String apellidos;
        public String dni;
        public String correo;
        public String fechaIncorporacion;
        public String cargo;
    }
}