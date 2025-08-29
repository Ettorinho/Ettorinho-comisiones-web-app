# 📋 Ettorinho Comisiones Web App

Aplicación web Maven para gestión de comisiones y grupos de trabajo desarrollada con tecnologías Java EE modernas.

## 🚀 Características Principales

- ✅ **Interfaz moderna y responsive** con Bootstrap 5
- ✅ **Validación completa de datos** (cliente y servidor)
- ✅ **Gestión dinámica de miembros** con JavaScript
- ✅ **Validación de DNI español** con dígito de control
- ✅ **Formularios intuitivos** con validación en tiempo real
- ✅ **Compatible con NetBeans IDE**
- ✅ **Arquitectura Maven estándar**
- ✅ **Páginas de éxito y error personalizadas**

## 🛠️ Tecnologías Utilizadas

- **Backend**: Java 11, Servlets 4.0, JSP 2.3, JSTL 1.2
- **Frontend**: HTML5, CSS3, JavaScript ES6, Bootstrap 5.3
- **Build**: Maven 3.x
- **Servidor**: Tomcat 9+ o GlassFish 5+
- **IDE**: NetBeans 12+ (compatible)

## 📊 Estructura de Datos

### Información de la Comisión
- Nombre de la comisión o grupo
- Fecha de constitución (obligatoria)
- Fecha fin (opcional)

### Información de los Miembros
- Nombre y apellidos
- DNI/NIF (con validación española)
- Correo electrónico
- Fecha de incorporación
- Cargo: **RESPONSABLE** o **MIEMBRO**

## 🏗️ Estructura del Proyecto

```
Ettorinho-comisiones-web-app/
├── pom.xml                                 # Configuración Maven
├── src/main/java/com/ettorinho/comisiones/
│   ├── model/
│   │   ├── TipoCargo.java                  # Enum para cargos
│   │   ├── Miembro.java                    # Modelo de miembro
│   │   └── Comision.java                   # Modelo de comisión
│   └── servlet/
│       └── ComisionServlet.java            # Servlet principal
├── src/main/webapp/
│   ├── WEB-INF/
│   │   └── web.xml                         # Configuración web
│   ├── css/
│   │   └── styles.css                      # Estilos personalizados
│   ├── js/
│   │   └── script.js                       # JavaScript funcional
│   ├── index.jsp                           # Formulario principal
│   ├── exito.jsp                           # Página de éxito
│   └── error.jsp                           # Página de error
└── README.md                               # Documentación
```

## ⚡ Instalación Rápida

### Prerrequisitos
- Java 11+
- Maven 3.6+
- Tomcat 9+ o GlassFish 5+
- NetBeans IDE (recomendado)

### Paso a Paso

1. **Clonar el repositorio**
   ```bash
   git clone https://github.com/Ettorinho/Ettorinho-comisiones-web-app.git
   cd Ettorinho-comisiones-web-app
   ```

2. **Compilar el proyecto**
   ```bash
   mvn clean package
   ```

3. **Importar en NetBeans**
   - File → Open Project
   - Seleccionar la carpeta del proyecto
   - NetBeans detectará automáticamente el proyecto Maven

4. **Configurar servidor**
   - Click derecho en el proyecto → Properties
   - Run → Server: Seleccionar Tomcat o GlassFish
   - Context Path: `/Ettorinho-comisiones-web-app`

5. **Ejecutar aplicación**
   - Click derecho → Run
   - O usar F6
   - Acceder a: `http://localhost:8080/Ettorinho-comisiones-web-app`

## 🔧 Configuración Avanzada

### Variables de Entorno
```properties
# En caso de usar base de datos (futuro)
DB_URL=jdbc:mysql://localhost:3306/comisiones
DB_USER=usuario
DB_PASS=contraseña
```

### Configuración de Servidor
```xml
<!-- En server.xml de Tomcat -->
<Context path="/Ettorinho-comisiones-web-app" 
         docBase="Ettorinho-comisiones-web-app" 
         reloadable="true" />
```

## 🧪 Validaciones Implementadas

### 🔍 Validaciones de Datos
- **Campos obligatorios**: Todos los campos marcados con asterisco (*)
- **Formato de email**: Validación con expresiones regulares
- **DNI español**: 8 dígitos + letra con validación de dígito de control
- **Fechas**: Validación de formato y lógica temporal
- **Nombres y apellidos**: Solo caracteres alfabéticos y espacios
- **Al menos un responsable**: La comisión debe tener mínimo un responsable

### ⚙️ Validaciones de Negocio
- La fecha fin debe ser posterior a la fecha de constitución
- No se permiten DNIs duplicados en la misma comisión
- No se permiten emails duplicados en la misma comisión
- Los nombres deben tener al menos 2 caracteres
- Validación en tiempo real con feedback visual

## 🎨 Características de la Interfaz

### 💻 Responsive Design
- ✅ Compatible con móviles, tablets y escritorio
- ✅ Breakpoints optimizados para diferentes pantallas
- ✅ Iconos Bootstrap y animaciones CSS

### 🎯 Experiencia de Usuario
- ✅ Formulario dinámico para agregar/eliminar miembros
- ✅ Validación en tiempo real con colores y mensajes
- ✅ Animaciones suaves y transiciones
- ✅ Mensajes de confirmación y error claros
- ✅ Auto-guardado del formulario (localStorage)

### 🎨 Componentes Visuales
- **Cards**: Para cada miembro con header y botón eliminar
- **Badges**: Para mostrar cargos y estadísticas
- **Alerts**: Para errores, éxitos y warnings
- **Tables**: Para mostrar resumen de miembros
- **Modales**: Para confirmaciones (futuro)

## 📱 Capturas de Pantalla

### Formulario Principal
![Formulario Principal](docs/screenshot-form.png)

### Página de Éxito
![Página de Éxito](docs/screenshot-success.png)

### Responsive Mobile
![Vista Móvil](docs/screenshot-mobile.png)

## 🚀 Funcionalidades Destacadas

### 🔄 Gestión Dinámica de Miembros
```javascript
// Añadir miembro dinámicamente
function agregarMiembro() {
    contadorMiembros++;
    const miembroCard = crearCardMiembro(contadorMiembros);
    contenedorMiembros.appendChild(miembroCard);
    configurarValidaciones(contadorMiembros);
}
```

### 🛡️ Validación de DNI Español
```java
private boolean validarDNI(String dni) {
    Pattern pattern = Pattern.compile("^[0-9]{8}[TRWAGMYFPDXBNJZSQVHLCKE]$");
    if (!pattern.matcher(dni).matches()) return false;
    
    int numero = Integer.parseInt(dni.substring(0, 8));
    char letra = dni.charAt(8);
    char letraEsperada = "TRWAGMYFPDXBNJZSQVHLCKE".charAt(numero % 23);
    return letra == letraEsperada;
}
```

### 📊 Resumen Visual
- Estadísticas en tiempo real
- Tabla ordenada de miembros
- Información de contacto
- Opciones de exportación (imprimir, copiar)

## 🔧 Comandos Maven Útiles

```bash
# Limpiar y compilar
mvn clean compile

# Crear WAR
mvn clean package

# Ejecutar tests
mvn test

# Saltar tests y crear WAR
mvn clean package -DskipTests

# Ejecutar con Tomcat (si está configurado)
mvn tomcat7:run

# Ver dependencias
mvn dependency:tree

# Validar proyecto
mvn validate
```

## 📋 Lista de Tareas

### ✅ Completadas
- [x] Estructura Maven del proyecto
- [x] Modelos de datos (Comision, Miembro, TipoCargo)
- [x] Servlet para procesamiento de formularios
- [x] Páginas JSP (index, éxito, error)
- [x] Validaciones cliente y servidor
- [x] Estilos CSS con Bootstrap 5
- [x] JavaScript para funcionalidad dinámica
- [x] Validación de DNI español
- [x] Interfaz responsive
- [x] Documentación completa

### 🔄 Futuras Mejoras
- [ ] Base de datos con JPA/Hibernate
- [ ] Sistema de autenticación
- [ ] Exportación a PDF/Excel
- [ ] API REST para integración
- [ ] Tests unitarios e integración
- [ ] Docker containerization
- [ ] CI/CD con GitHub Actions

## 🐛 Resolución de Problemas

### Error de Compilación
```bash
# Limpiar proyecto completamente
mvn clean
rm -rf target/
mvn compile
```

### Error de Despliegue
- Verificar que el servidor esté ejecutándose
- Comprobar que el puerto 8080 esté libre
- Revisar logs del servidor en `logs/catalina.out`

### Error de Dependencias
```bash
# Forzar descarga de dependencias
mvn dependency:purge-local-repository
mvn clean install
```

## 🤝 Contribución

1. Fork el proyecto
2. Crear branch para feature (`git checkout -b feature/nueva-funcionalidad`)
3. Commit cambios (`git commit -am 'Añadir nueva funcionalidad'`)
4. Push al branch (`git push origin feature/nueva-funcionalidad`)
5. Crear Pull Request

## 📞 Soporte

- **Email**: [soporte@ettorinho.com](mailto:soporte@ettorinho.com)
- **Issues**: [GitHub Issues](https://github.com/Ettorinho/Ettorinho-comisiones-web-app/issues)
- **Wiki**: [GitHub Wiki](https://github.com/Ettorinho/Ettorinho-comisiones-web-app/wiki)

## 📄 Licencia

Este proyecto está licenciado bajo la Licencia MIT - ver el archivo [LICENSE](LICENSE) para más detalles.

## 👨‍💻 Autor

**Ettorinho** - [GitHub Profile](https://github.com/Ettorinho)

---

⭐ **¡No olvides dar una estrella al proyecto si te ha resultado útil!** ⭐
