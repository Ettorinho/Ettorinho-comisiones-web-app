package com.ettorinho.comisiones.test;

import com.ettorinho.comisiones.model.Comision;
import com.ettorinho.comisiones.model.Miembro;
import com.ettorinho.comisiones.model.TipoCargo;
import org.junit.Test;
import static org.junit.Assert.*;

import java.time.LocalDate;

/**
 * Tests básicos para los modelos de la aplicación
 */
public class ModelTest {
    
    @Test
    public void testCrearComision() {
        Comision comision = new Comision();
        comision.setNombre("Comisión de Prueba");
        comision.setFechaConstitucion(LocalDate.now());
        
        assertEquals("Comisión de Prueba", comision.getNombre());
        assertEquals(LocalDate.now(), comision.getFechaConstitucion());
        assertEquals(0, comision.getNumeroMiembros());
        assertFalse(comision.tieneResponsables());
    }
    
    @Test
    public void testCrearMiembro() {
        Miembro miembro = new Miembro();
        miembro.setNombre("Juan");
        miembro.setApellidos("Pérez García");
        miembro.setDni("12345678Z");
        miembro.setCorreo("juan@example.com");
        miembro.setFechaIncorporacion(LocalDate.now());
        miembro.setCargo(TipoCargo.RESPONSABLE);
        
        assertEquals("Juan", miembro.getNombre());
        assertEquals("Pérez García", miembro.getApellidos());
        assertEquals("Juan Pérez García", miembro.getNombreCompleto());
        assertEquals("12345678Z", miembro.getDni());
        assertEquals("juan@example.com", miembro.getCorreo());
        assertEquals(TipoCargo.RESPONSABLE, miembro.getCargo());
    }
    
    @Test
    public void testAgregarMiembroAComision() {
        Comision comision = new Comision("Comisión Test", LocalDate.now(), null);
        
        Miembro responsable = new Miembro("Ana", "López", "87654321X", 
                                        "ana@example.com", LocalDate.now(), TipoCargo.RESPONSABLE);
        
        Miembro miembro = new Miembro("Carlos", "Martín", "11111111H", 
                                    "carlos@example.com", LocalDate.now(), TipoCargo.MIEMBRO);
        
        comision.addMiembro(responsable);
        comision.addMiembro(miembro);
        
        assertEquals(2, comision.getNumeroMiembros());
        assertEquals(1, comision.getNumeroResponsables());
        assertTrue(comision.tieneResponsables());
        
        assertEquals(1, comision.getResponsables().size());
        assertEquals(1, comision.getMiembrosSimples().size());
    }
    
    @Test
    public void testTipoCargo() {
        assertEquals("Responsable", TipoCargo.RESPONSABLE.getDescripcion());
        assertEquals("Miembro", TipoCargo.MIEMBRO.getDescripcion());
        assertEquals("Responsable", TipoCargo.RESPONSABLE.toString());
    }
}