package com.ettorinho.comisiones.model;

import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;
import java.util.Objects;

/**
 * Clase que representa una comisión o grupo de trabajo
 */
public class Comision {
    private String nombre;
    private LocalDate fechaConstitucion;
    private LocalDate fechaFin;
    private List<Miembro> miembros;
    
    public Comision() {
        this.miembros = new ArrayList<>();
    }
    
    public Comision(String nombre, LocalDate fechaConstitucion, LocalDate fechaFin) {
        this.nombre = nombre;
        this.fechaConstitucion = fechaConstitucion;
        this.fechaFin = fechaFin;
        this.miembros = new ArrayList<>();
    }
    
    // Getters y Setters
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
    
    // Métodos auxiliares
    public void addMiembro(Miembro miembro) {
        if (miembro != null && !this.miembros.contains(miembro)) {
            this.miembros.add(miembro);
        }
    }
    
    public void removeMiembro(Miembro miembro) {
        this.miembros.remove(miembro);
    }
    
    public int getNumeroMiembros() {
        return miembros.size();
    }
    
    public long getNumeroResponsables() {
        return miembros.stream()
                .mapToLong(m -> m.getCargo() == TipoCargo.RESPONSABLE ? 1 : 0)
                .sum();
    }
    
    public List<Miembro> getResponsables() {
        return miembros.stream()
                .filter(m -> m.getCargo() == TipoCargo.RESPONSABLE)
                .toList();
    }
    
    public List<Miembro> getMiembrosSimples() {
        return miembros.stream()
                .filter(m -> m.getCargo() == TipoCargo.MIEMBRO)
                .toList();
    }
    
    public boolean tieneResponsables() {
        return getNumeroResponsables() > 0;
    }
    
    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        Comision comision = (Comision) o;
        return Objects.equals(nombre, comision.nombre) && 
               Objects.equals(fechaConstitucion, comision.fechaConstitucion);
    }
    
    @Override
    public int hashCode() {
        return Objects.hash(nombre, fechaConstitucion);
    }
    
    @Override
    public String toString() {
        return "Comision{" +
                "nombre='" + nombre + '\'' +
                ", fechaConstitucion=" + fechaConstitucion +
                ", fechaFin=" + fechaFin +
                ", numeroMiembros=" + getNumeroMiembros() +
                ", numeroResponsables=" + getNumeroResponsables() +
                '}';
    }
}