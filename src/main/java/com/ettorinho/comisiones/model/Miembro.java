package com.ettorinho.comisiones.model;

import java.time.LocalDate;
import java.util.Objects;

/**
 * Clase que representa un miembro de la comisión
 */
public class Miembro {
    private String nombre;
    private String apellidos;
    private String dni;
    private String correo;
    private LocalDate fechaIncorporacion;
    private TipoCargo cargo;
    
    public Miembro() {}
    
    public Miembro(String nombre, String apellidos, String dni, String correo, 
                   LocalDate fechaIncorporacion, TipoCargo cargo) {
        this.nombre = nombre;
        this.apellidos = apellidos;
        this.dni = dni;
        this.correo = correo;
        this.fechaIncorporacion = fechaIncorporacion;
        this.cargo = cargo;
    }
    
    // Getters y Setters
    public String getNombre() {
        return nombre;
    }
    
    public void setNombre(String nombre) {
        this.nombre = nombre;
    }
    
    public String getApellidos() {
        return apellidos;
    }
    
    public void setApellidos(String apellidos) {
        this.apellidos = apellidos;
    }
    
    public String getDni() {
        return dni;
    }
    
    public void setDni(String dni) {
        this.dni = dni;
    }
    
    public String getCorreo() {
        return correo;
    }
    
    public void setCorreo(String correo) {
        this.correo = correo;
    }
    
    public LocalDate getFechaIncorporacion() {
        return fechaIncorporacion;
    }
    
    public void setFechaIncorporacion(LocalDate fechaIncorporacion) {
        this.fechaIncorporacion = fechaIncorporacion;
    }
    
    public TipoCargo getCargo() {
        return cargo;
    }
    
    public void setCargo(TipoCargo cargo) {
        this.cargo = cargo;
    }
    
    public String getNombreCompleto() {
        return nombre + " " + apellidos;
    }
    
    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        Miembro miembro = (Miembro) o;
        return Objects.equals(dni, miembro.dni);
    }
    
    @Override
    public int hashCode() {
        return Objects.hash(dni);
    }
    
    @Override
    public String toString() {
        return "Miembro{" +
                "nombre='" + nombre + '\'' +
                ", apellidos='" + apellidos + '\'' +
                ", dni='" + dni + '\'' +
                ", correo='" + correo + '\'' +
                ", fechaIncorporacion=" + fechaIncorporacion +
                ", cargo=" + cargo +
                '}';
    }
}