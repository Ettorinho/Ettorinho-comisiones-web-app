package com.ettorinho.comisiones.model;

import org.junit.Test;
import static org.junit.Assert.*;
import java.util.List;

/**
 * Test class to verify Java 8 compatibility and stream operations
 */
public class ComisionTest {

    @Test
    public void testStreamOperationsWithJava8() {
        // Create a test commission
        Comision comision = new Comision("Test Commission");
        
        // Add test members
        Miembro responsable1 = new Miembro("Juan", "Perez", "12345678A", "juan@test.com");
        responsable1.setCargo("RESPONSABLE");
        
        Miembro responsable2 = new Miembro("Maria", "Garcia", "87654321B", "maria@test.com");
        responsable2.setCargo("RESPONSABLE");
        
        Miembro miembro1 = new Miembro("Carlos", "Lopez", "11111111C", "carlos@test.com");
        miembro1.setCargo("MIEMBRO");
        
        Miembro miembro2 = new Miembro("Ana", "Martinez", "22222222D", "ana@test.com");
        miembro2.setCargo("MIEMBRO");
        
        comision.addMiembro(responsable1);
        comision.addMiembro(responsable2);
        comision.addMiembro(miembro1);
        comision.addMiembro(miembro2);
        
        // Test getResponsables() method (uses stream.collect(Collectors.toList()))
        List<Miembro> responsables = comision.getResponsables();
        assertNotNull("Responsables list should not be null", responsables);
        assertEquals("Should have 2 responsables", 2, responsables.size());
        assertTrue("Should contain responsable1", responsables.contains(responsable1));
        assertTrue("Should contain responsable2", responsables.contains(responsable2));
        
        // Test getMiembrosRegulares() method (uses stream.collect(Collectors.toList()))
        List<Miembro> miembrosRegulares = comision.getMiembrosRegulares();
        assertNotNull("Regular members list should not be null", miembrosRegulares);
        assertEquals("Should have 2 regular members", 2, miembrosRegulares.size());
        assertTrue("Should contain miembro1", miembrosRegulares.contains(miembro1));
        assertTrue("Should contain miembro2", miembrosRegulares.contains(miembro2));
        
        // Test total count
        assertEquals("Total members should be 4", 4, comision.getTotalMiembros());
        assertTrue("Commission should have responsables", comision.hasResponsables());
    }
    
    @Test
    public void testEmptyStreamOperations() {
        // Test with empty commission
        Comision comision = new Comision("Empty Commission");
        
        List<Miembro> responsables = comision.getResponsables();
        assertNotNull("Responsables list should not be null", responsables);
        assertTrue("Responsables list should be empty", responsables.isEmpty());
        
        List<Miembro> miembrosRegulares = comision.getMiembrosRegulares();
        assertNotNull("Regular members list should not be null", miembrosRegulares);
        assertTrue("Regular members list should be empty", miembrosRegulares.isEmpty());
        
        assertFalse("Commission should not have responsables", comision.hasResponsables());
        assertEquals("Total members should be 0", 0, comision.getTotalMiembros());
    }
}