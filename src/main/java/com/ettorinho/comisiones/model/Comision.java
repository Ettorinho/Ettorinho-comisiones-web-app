package com.ettorinho.comisiones.model;

import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;
import java.util.stream.Stream;

/**
 * Represents a commission or working group
 */
public class Comision {
    
    private Long id;
    private String nombre;
    private LocalDate fechaConstitucion;
    private LocalDate fechaFin;
    private List<Miembro> miembros;
    
    // Default constructor
    public Comision() {
        this.miembros = new ArrayList<>();
        this.fechaConstitucion = LocalDate.now();
    }
    
    // Constructor with name
    public Comision(String nombre) {
        this();
        this.nombre = nombre;
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
    
    public LocalDate getFechaConstitucion() {
        return fechaConstitucion;
    }
    
    public void setFechaConstitucion(LocalDate fechaConstitucion) {
        this.fechaConstitucion = fechaConstitucion;
    }
    
    public LocalDate getFechaFin() {
        return fechaFin;
    }
    
    public void setFechaFin(LocalDate fechaFin) {
        this.fechaFin = fechaFin;
    }
    
    public List<Miembro> getMiembros() {
        return miembros;
    }
    
    public void setMiembros(List<Miembro> miembros) {
        this.miembros = miembros != null ? miembros : new ArrayList<>();
    }
    
    // Business methods
    public void addMiembro(Miembro miembro) {
        if (miembro != null && !miembros.contains(miembro)) {
            miembros.add(miembro);
        }
    }
    
    public void removeMiembro(Miembro miembro) {
        miembros.remove(miembro);
    }
    
    public boolean isActive() {
        return fechaFin == null || fechaFin.isAfter(LocalDate.now());
    }
    
    public int getTotalMiembros() {
        return miembros.size();
    }
    
    /**
     * Gets all responsible members (RESPONSABLE role)
     * Line 85: Fixed to use .collect(Collectors.toList()) for Java 8 compatibility
     */
    public List<Miembro> getResponsables() {
        return miembros.stream()
                .filter(Miembro::isResponsable)
                .collect(Collectors.toList());  // Fixed for Java 8 compatibility
    }
    
    /**
     * Gets all regular members (MIEMBRO role) 
     * Line 91: Fixed to use .collect(Collectors.toList()) for Java 8 compatibility
     */
    public List<Miembro> getMiembrosRegulares() {
        return miembros.stream()
                .filter(m -> !m.isResponsable())
                .collect(Collectors.toList());  // Fixed for Java 8 compatibility
    }
    
    public boolean hasResponsables() {
        return miembros.stream().anyMatch(Miembro::isResponsable);
    }
    
    @Override
    public String toString() {
        return "Comision{" +
                "id=" + id +
                ", nombre='" + nombre + '\'' +
                ", fechaConstitucion=" + fechaConstitucion +
                ", fechaFin=" + fechaFin +
                ", totalMiembros=" + getTotalMiembros() +
                '}';
    }
    
    @Override
    public boolean equals(Object obj) {
        if (this == obj) return true;
        if (obj == null || getClass() != obj.getClass()) return false;
        Comision comision = (Comision) obj;
        return nombre != null && nombre.equals(comision.nombre);
    }
    
    @Override
    public int hashCode() {
        return nombre != null ? nombre.hashCode() : 0;
    }
}