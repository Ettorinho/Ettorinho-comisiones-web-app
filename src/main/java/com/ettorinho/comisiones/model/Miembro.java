package com.ettorinho.comisiones.model;

import java.time.LocalDate;

/**
 * Represents a member of a commission or working group
 */
public class Miembro {
    
    private Long id;
    private String nombre;
    private String apellidos;
    private String dni;
    private String email;
    private LocalDate fechaIncorporacion;
    private String cargo; // RESPONSABLE or MIEMBRO
    
    // Default constructor
    public Miembro() {
    }
    
    // Constructor with basic fields
    public Miembro(String nombre, String apellidos, String dni, String email) {
        this.nombre = nombre;
        this.apellidos = apellidos;
        this.dni = dni;
        this.email = email;
        this.fechaIncorporacion = LocalDate.now();
        this.cargo = "MIEMBRO";
    }
    
    // Getters and setters
    public Long getId() {
        return id;
    }
    
    public void setId(Long id) {
        this.id = id;
    }
    
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
    
    public String getEmail() {
        return email;
    }
    
    public void setEmail(String email) {
        this.email = email;
    }
    
    public LocalDate getFechaIncorporacion() {
        return fechaIncorporacion;
    }
    
    public void setFechaIncorporacion(LocalDate fechaIncorporacion) {
        this.fechaIncorporacion = fechaIncorporacion;
    }
    
    public String getCargo() {
        return cargo;
    }
    
    public void setCargo(String cargo) {
        this.cargo = cargo;
    }
    
    public boolean isResponsable() {
        return "RESPONSABLE".equals(cargo);
    }
    
    @Override
    public String toString() {
        return "Miembro{" +
                "id=" + id +
                ", nombre='" + nombre + '\'' +
                ", apellidos='" + apellidos + '\'' +
                ", dni='" + dni + '\'' +
                ", email='" + email + '\'' +
                ", fechaIncorporacion=" + fechaIncorporacion +
                ", cargo='" + cargo + '\'' +
                '}';
    }
    
    @Override
    public boolean equals(Object obj) {
        if (this == obj) return true;
        if (obj == null || getClass() != obj.getClass()) return false;
        Miembro miembro = (Miembro) obj;
        return dni != null && dni.equals(miembro.dni);
    }
    
    @Override
    public int hashCode() {
        return dni != null ? dni.hashCode() : 0;
    }
}