ACTUALIZACIÓN DE REQUISITOS - BASE DE DATOS POSTGRESQL:

Los datos del formulario han de guardarse en una base de datos PostgreSQL con las siguientes especificaciones:

📊 MODELO DE DATOS RELACIONAL:
- Una comisión/grupo puede tener varios miembros (1:N)
- Un miembro puede pertenecer a diferentes comisiones/grupos (N:M) 
- Las comisiones/grupos no pueden estar duplicados (UNIQUE constraint)

🗄️ ESTRUCTURA DE TABLAS REQUERIDA:
1. TABLA 'comisiones': ID, nombre (UNIQUE), fecha_constitucion, fecha_fin
2. TABLA 'miembros': ID, nombre, apellidos, dni (UNIQUE), email, fecha_incorporacion
3. TABLA 'comision_miembro' (relación N:M): comision_id, miembro_id, cargo (RESPONSABLE/MIEMBRO)

⚙️ TECNOLOGÍAS A INCLUIR:
- Driver PostgreSQL en pom.xml
- Conexión JDBC 
- DAO pattern para acceso a datos
- Pool de conexiones (HikariCP)
- Scripts SQL para crear tablas
- Manejo de transacciones
- Validaciones de duplicados

🔧 ARCHIVOS ADICIONALES NECESARIOS:
- database.sql: Scripts de creación de tablas
- DatabaseConnection.java: Configuración de conexión
- ComisionDAO.java y MiembroDAO.java: Acceso a datos
- database.properties: Configuración BD
- Actualización del servlet para usar BD

Por favor, actualiza la implementación para incluir toda la funcionalidad de base de datos PostgreSQL.