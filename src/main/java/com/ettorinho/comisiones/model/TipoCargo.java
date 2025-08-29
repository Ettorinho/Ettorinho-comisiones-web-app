package com.ettorinho.comisiones.model;

/**
 * Enumeración para los tipos de cargo de los miembros de la comisión
 */
public enum TipoCargo {
    RESPONSABLE("Responsable"),
    MIEMBRO("Miembro");
    
    private final String descripcion;
    
    TipoCargo(String descripcion) {
        this.descripcion = descripcion;
    }
    
    public String getDescripcion() {
        return descripcion;
    }
    
    @Override
    public String toString() {
        return descripcion;
    }
}