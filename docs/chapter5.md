
# Capítulo V: Product Implementation, Validation & Deployment

LoadMatch es el producto de CargoLink Labs orientado a conectar empresas que necesitan trasladar mercadería con transportistas que disponen de vehículos compatibles. Este capítulo establece la configuración del desarrollo, la implementación por sprints y los mecanismos de validación y despliegue, manteniendo trazabilidad con los segmentos del Capítulo I, las necesidades del Capítulo II, las User Stories del Capítulo III y el diseño del Capítulo IV.

La presente versión desarrolla el alcance de AV1: Software Configuration Management y Sprint 1 de la Landing Page. 

## 5.1. Software Configuration Management

La Gestión de Configuración de Software (SCM) en el proyecto LoadMatch establece las herramientas, convenciones y prácticas utilizadas para organizar el desarrollo colaborativo de los productos de software. Durante esta fase inicial, el trabajo se enfoca en el desarrollo de la presencia digital estática mediante el Landing Page, utilizando una estructura basada en HTML5, CSS3 y JavaScript, preparada para evolucionar e integrarse con los servicios de la plataforma en sprints posteriores. Su propósito es permitir que cada integrante reproduzca el entorno de trabajo y que cada entrega pueda vincularse con el código, las pruebas y la documentación que la sustentan.

### 5.1.1. Software Development Environment Configuration

Para mantener la consistencia en el entorno de desarrollo y evitar discrepancias de configuración entre los ingenieros de software, se ha estandarizado el siguiente ecosistema de herramientas nativas y de gestión:

| Dominio | Herramienta / Estándar | Propósito Técnico | Tipo de Acceso / Ruta | Imagen |
| --- | --- | --- | --- | --- |
| **Project Management** | Jira Software | Gestión del Product Backlog, Sprints y estimación en Story Points para el seguimiento ágil. | https://www.atlassian.com/es/software/jira | <img src="../assets/images/logos/LOGOJIRA.png" width="100" height="50"> |
| **Product UX/UI Design** | Figma | Creación de wireframes, prototipos interactivos y diseño del sistema de componentes visuales. | https://www.figma.com/es-la/ | <img src="../assets/images/logos/LOGOFIGMA.png" width="100" height="50"> |
| **Frontend Structure** | Semantic HTML5 | Estructuración semántica del Document Object Model (DOM) para optimización de accesibilidad y SEO. | Estándar W3C | <img src="../assets/images/logos/LOGOHTML5.png" width="100" height="50"> |
| **Frontend Styling** | CSS3 (Grid/Flexbox) | Diseño responsivo (Mobile-First), animaciones y maquetación sin dependencias de frameworks externos. | Estándar W3C | <img src="../assets/images/logos/LOGOCSS3.png" width="100" height="50"> |
| **Frontend Logic** | Vanilla JavaScript (ES6+) | Manipulación del DOM, validación de formularios asíncrona y control de eventos interactivos. | Estándar ECMAScript | <img src="../assets/images/logos/LOGOJS.png" width="100" height="50"> |
| **IDE** | Visual Studio Code | Edición de código con extensiones de formateo (Prettier) y análisis estático de JS (ESLint). | https://code.visualstudio.com/ | <img src="../assets/images/logos/VSLOGO.png" width="100" height="50"> |
| **Version Control** | Git + GitHub | Gestión distribuida del código fuente, flujos de integración y revisión de pares (Pull Requests). | https://github.com/ | <img src="../assets/images/logos/GITLOGO.png" width="100" height="50"> |
| **Comunicación** | Google Meet | Videollamadas para coordinación de equipo, reuniones remotas y presentaciones en tiempo real. | https://meet.google.com/ | <img src="../assets/images/logos/GMEETLOGO.png" width="100" height="50"> |

### 5.1.2. Source Code Management

La gestión del código fuente de LoadMatch se realiza mediante **Git** como sistema de control de versiones distribuido y **GitHub** como plataforma de almacenamiento, colaboración y revisión del código. Los productos de software se mantienen en repositorios independientes dentro de la organización `Desarrollo-Open-Source-grupo-5`, permitiendo separar el Landing Page, la Frontend Web Application, los Web Services y la documentación del proyecto.

Los repositorios utilizados por el equipo son los siguientes:

| Repositorio | Producto |
| --- | --- |
| https://github.com/Desarrollo-Open-Source-grupo-5/Loadmatch-landing-page | Landing Page |
| https://github.com/Desarrollo-Open-Source-grupo-5/Loadmatch-frontend-application | Frontend Web Application |
| https://github.com/Desarrollo-Open-Source-grupo-5/Loadmatch-backend-application | Web Services (RESTful API) |
| https://github.com/Desarrollo-Open-Source-grupo-5/Loadmatch-report | Informe y documentación del proyecto |

Estos enlaces identifican los repositorios declarados.

#### GitFlow Workflow

El equipo utiliza **GitFlow** como estrategia de ramificación para organizar el desarrollo colaborativo. Las funcionalidades son desarrolladas de manera aislada y posteriormente integradas mediante Pull Requests, permitiendo revisar los cambios antes de incorporarlos a las ramas compartidas.

La estructura de ramas definida es la siguiente:

**GitFlow Workflow**

| Rama | Propósito | Origen e integración |
| --- | --- | --- |
| `main` | Contiene las versiones estables y aprobadas del proyecto. | Recibe integraciones desde `develop` cuando se valida una entrega final. |
| `develop` | Rama de integración donde se consolidan las funcionalidades de los capítulos. | Recibe las ramas `feature/*` y se integra en `main` al finalizar un ciclo. |
| `feature/Chapter1` | Implementación de entregables e imágenes del Capítulo I (carpeta `assets/images`). | Se crea como rama independiente y apunta a `develop` mediante Pull Request. |
| `feature/Chapter2` | Implementación de entregables e imágenes del Capítulo II (carpeta `assets/images`). | Se crea como rama independiente y apunta a `develop` mediante Pull Request. |
| `feature/Chapter3` | Implementación de entregables e imágenes del Capítulo III (carpeta `assets/images`). | Se crea como rama independiente y apunta a `develop` mediante Pull Request. |
| `feature/Chapter4` | Implementación de entregables e imágenes del Capítulo IV (carpeta `assets/images`). | Se crea como rama independiente y apunta a `develop` mediante Pull Request. |
| `feature/Chapter5` | Implementación de entregables e imágenes del Capítulo V (carpeta `assets/images`). | Se crea como rama independiente y apunta a `develop` mediante Pull Request. |

El GitFlow Workflow es una estrategia de organización de ramas en Git que define cómo se crean, nombran y fusionan las ramas dentro de un proyecto.

Las ramas **feature/** se usan para desarrollar funcionalidades específicas o capítulos, y apuntan a develop para integrarse.

La rama **develop** es la rama de integración, donde se consolidan los cambios antes de pasar a main.

La rama **main** contiene las versiones estables y finales del proyecto.

Los Pull Requests deben documentar la historia relacionada, los cambios realizados, validaciones y evidencia visual, asegurando que otro integrante revise antes de integrar.

**Semantic Versioning 2.0.0**

Cada producto mantendrá su propia numeración `MAJOR.MINOR.PATCH`: `MAJOR` para cambios incompatibles en su contrato público, `MINOR` para nuevas funcionalidades compatibles y `PATCH` para correcciones compatibles. Durante el desarrollo inicial se podrán utilizar versiones `0.y.z`. Los tags, por ejemplo `v1.0.0`, identificarán el commit publicado; no se registrará un tag como existente hasta verificarlo. Referencia: [Semantic Versioning 2.0.0](https://semver.org/spec/v2.0.0.html).

**Conventional Commits**

Los mensajes se redactarán en inglés con el formato `type(scope): description`. Se utilizarán `feat` para funcionalidades, `fix` para correcciones, `docs` para documentación, `refactor` para reorganización interna y `chore` para mantenimiento. `style` se reservará para formato del código; un cambio visual que agrega o corrige comportamiento se clasificará según su finalidad. Los cambios incompatibles se identificarán con `!` o con un pie `BREAKING CHANGE:`. Referencia: [Conventional Commits 1.0.0](https://www.conventionalcommits.org/en/v1.0.0/).

Ejemplos de mensajes propuestos:

```text
feat(hero): explain benefits for shippers and carriers
feat(fleet): display supported vehicle capacities
fix(contact): reject invalid email addresses
docs(sprint1): add execution evidence
```

### 5.1.3. Source Code Style Guide & Conventions

El equipo establece las convenciones de codificación que se aplicarán durante el desarrollo de **LoadMatch** para mantener un código legible, consistente y fácil de mantener. Estas directrices comprenden **HTML, CSS y JavaScript vanilla** para la Landing Page, **TypeScript con Angular** para la Web Application y **Java con Spring Boot** para los Web Services, en correspondencia con el stack tecnológico del curso y la arquitectura definida en el Capítulo IV.

Como regla transversal, los identificadores y comentarios del código se redactarán en **inglés**, manteniendo correspondencia con el *Ubiquitous Language* del Capítulo II. Los textos visibles para los usuarios respetarán el idioma y el tono de comunicación definidos para el producto.

Las convenciones se documentarán en los repositorios correspondientes. Se utilizará **.editorconfig** para establecer reglas comunes de indentación y codificación, **Prettier** para el formato de los archivos compatibles y **ESLint** para el análisis estático de JavaScript y TypeScript. Las configuraciones deberán mantenerse bajo control de versiones para que puedan ser utilizadas por todos los integrantes.

---

#### Convenciones por lenguaje

| Lenguaje | Convenciones del proyecto |
| --- | --- |
| **HTML5** | Utilizar elementos semánticos como `header`, `nav`, `main`, `section` y `footer`. Mantener jerarquía coherente de encabezados, asociar etiquetas con controles de formulario e incluir textos alternativos apropiados para imágenes. Declarar idioma con `lang`. Identificadores descriptivos en `kebab-case`. |
| **CSS3** | Aplicar metodología **BEM** para nombrar clases (ej. `contact-form__input`, `contact-form__button--disabled`). Centralizar colores, tipografías y espaciados mediante variables CSS. Usar **Flexbox/Grid** y media queries para adaptación. Evitar estilos duplicados y selectores excesivamente específicos. |
| **JavaScript vanilla** | Usar `const` por defecto y `let` cuando exista reasignación. Variables y funciones en `camelCase`. Comparación estricta (`===`). Eventos con `addEventListener`. Separar lógica de HTML y manejar estados de carga, éxito y error en operaciones asíncronas. |
| **TypeScript con Angular** | Definir tipos para datos del dominio y contratos de API. Evitar `any` sin justificación. Clases e interfaces en `PascalCase`; propiedades y métodos en `camelCase`. Organizar interfaz en componentes y concentrar acceso a servicios externos en servicios inyectables. Gestionar eventos mediante mecanismos de Angular. |
| **Java con Spring Boot** | Clases e interfaces en `PascalCase`, métodos y atributos en `camelCase`, constantes en `UPPER_SNAKE_CASE`, paquetes en minúsculas. Usar inyección de dependencias por constructores. Separar responsabilidades entre dominio, aplicación, infraestructura e interfaces. Evitar reglas de negocio en controladores REST. |

---

#### Indentación y formato
- **HTML, CSS, JavaScript, TypeScript** → 2 espacios.  
- **Java** → 4 espacios.  
- Usar espacios en lugar de tabulaciones.  
- Guardar archivos en **UTF-8**.  
- Eliminar espacios al final de las líneas y mantener una nueva línea al final de cada archivo.  
- Configuraciones versionadas para asegurar formato uniforme.  

Los comentarios deberán explicar decisiones, restricciones o comportamientos no evidentes. Se evitarán comentarios redundantes que repitan la instrucción.

---

#### Consistencia con el diseño

| Elemento | Convención |
| --- | --- |
| Tipografía principal | **Inter**, con pesos y jerarquías del diseño. |
| Tipografía complementaria | **Liberation Serif**, limitada a títulos y elementos de identidad. |
| Color principal | Primary Orange: `#FE6B00`. |
| Color de interacción | Orange Pressed: `#A04100`. |
| Color estructural oscuro | Dark Navy: `#0B1C30`. |
| Fondo claro | Background Light: `#F8FAFC`. |

- Botones con fondo **Primary Orange** → texto oscuro (contraste).  
- Mensajes de error → texto descriptivo + indicador visual (no solo color).  
- Tokens visuales centralizados para reutilización.  
- En Angular, configuración de **Angular Material** deberá conservar identidad visual de LoadMatch.  
- Adaptación a dispositivos → preservar legibilidad, navegación y accesibilidad.  
- Controles interactivos → etiquetas comprensibles y estado de foco visible para navegación con teclado.  

---

#### Organización de la aplicación y los servicios
La organización del código mantendrá correspondencia con los contextos definidos en el Capítulo IV:  
**IAM, Profiles, Fleet, Document Validation, Freight Publishing, Matching, Trip Execution, Payment, Rating y Contact.**

- En **Angular**: archivos agrupados por funcionalidad/contexto. Componentes → presentación e interacción. Servicios → acceso a API y lógica compartida.  
- En **Spring Boot**: separación clara de responsabilidades:  
  - **Dominio** → entidades, objetos de valor, reglas de negocio.  
  - **Aplicación** → coordinación de casos de uso.  
  - **Infraestructura** → persistencia e integración con servicios externos.  
  - **Interfaces** → controladores REST y contratos de entrada/salida.  

La validación en formularios del navegador facilita la interacción, pero no sustituye las validaciones del backend. Los servicios deberán verificar datos y reglas de negocio antes de modificar el estado de la aplicación.  

Los contratos de entrada/salida de la API se mantendrán separados de las entidades persistentes. Los nombres en español del diseño deberán mapearse a identificadores en inglés en la implementación. Esta correspondencia se documentará y actualizará en el Capítulo IV para conservar trazabilidad.

#### Guías de referencia

El equipo utilizará las siguientes fuentes como apoyo para definir y mantener sus convenciones. Las decisiones específicas adoptadas para LoadMatch quedarán documentadas en cada repositorio.

- **HTML y CSS:** [Google HTML/CSS Style Guide](https://google.github.io/styleguide/htmlcssguide.html).
- **JavaScript:** [Google JavaScript Style Guide](https://google.github.io/styleguide/jsguide.html).
- **TypeScript:** [TypeScript Handbook](https://www.typescriptlang.org/docs/handbook/intro.html).
- **Angular:** [Angular Coding Style Guide](https://angular.dev/style-guide).
- **Java:** [Google Java Style Guide](https://google.github.io/styleguide/javaguide.html), como referencia complementaria; para la indentación prevalece la regla de cuatro espacios del proyecto.
- **Configuración de formato:** [EditorConfig](https://editorconfig.org/) y [Prettier](https://prettier.io/docs/).
- **Análisis estático de JavaScript y TypeScript:** [ESLint](https://eslint.org/docs/latest/) y [typescript-eslint](https://typescript-eslint.io/).

**Landing Page**

Se propone GitHub Pages como alojamiento de la Landing Page. La configuración prevista consiste en seleccionar `Settings > Pages > Deploy from a branch`, con `main` y la carpeta raíz como fuente de publicación, siempre que allí se encuentre `index.html`. Si la estructura cambia, deberá ajustarse la fuente. GitHub Pages requiere esta configuración; integrar cambios en `main` no basta cuando aún no se ha seleccionado una fuente. Referencia: [Configuración de la fuente de publicación de GitHub Pages](https://docs.github.com/en/pages/getting-started-with-github-pages/configuring-a-publishing-source-for-your-github-pages-site).

Antes de publicar se revisarán rutas de recursos, navegación, comportamiento móvil, formulario y ausencia de errores de consola. Después de publicar se abrirá la URL asignada y se registrarán commit, fecha y ejecución del despliegue. La compresión de imágenes o minificación solo se declarará realizada cuando exista evidencia del proceso.

**Web Application, API y persistencia**

El alojamiento de los productos posteriores está **[PENDIENTE DE DEFINICIÓN]**. La configuración deberá contemplar construcción de Angular, resolución de sus rutas, URL de la API, ejecución de Java 17, conexión a PostgreSQL/PostGIS y aplicación controlada de cambios del esquema. La API deberá configurar los orígenes autorizados de la Landing Page y Web Application cuando exista acceso desde el navegador.

Mapbox, PayPal, almacenamiento de archivos y correo son integraciones previstas en el Capítulo IV. Sus credenciales, entornos y disponibilidad deben verificarse antes de documentar una integración operativa. La consulta automática al MTC también permanece condicionada al acceso real a una fuente adecuada, conforme a las restricciones del Capítulo I.

---

## 5.2. Landing Page, Services & Applications Implementation

La implementación de LoadMatch se desarrolla mediante incrementos que permiten transformar los requisitos y diseños del proyecto en productos de software. El presente registro describe la Landing Page del Sprint 1 a partir de la inspección de sus archivos HTML, CSS, JavaScript y documentación.

Se distingue entre funcionalidades presentes en el código, resultados de ejecución y aceptación de historias. La existencia de una interfaz no acredita la operación de la Web Application ni de sus servicios. Los campos [PENDIENTE] corresponden a evidencias o datos que no se encuentran en la copia proporcionada.

### 5.2.1. Sprint 1

Durante el Sprint 1 se implementó la Landing Page de LoadMatch, producto de CargoLink Labs que propone conectar empresas que necesitan trasladar mercadería con transportistas con capacidad disponible. La página utiliza HTML5, CSS3 y JavaScript vanilla, sin framework de interfaz ni proceso de compilación obligatorio.

La implementación contiene navegación, propuesta de valor, indicadores del contexto logístico, explicación del funcionamiento por segmento, información de confianza, beneficios para empresas y transportistas, testimonios ilustrativos, precios por comisión, preguntas frecuentes, espacios para videos y un pie de página con enlaces de contacto y documentación informativa. También incorpora código para alternar entre español e inglés, adaptar la navegación y controlar pestañas, acordeón y carrusel.

El alcance efectivamente implementado difiere del backlog inicial de US12, US13 y US14. La propuesta de valor de US12 está presente en el código y requiere aceptación funcional documentada. No se identifica un catálogo de tipos de vehículos con capacidades que complete US13 ni un formulario de contacto que satisfaga US14. Los enlaces de correo y teléfono del pie de página no sustituyen este último requisito.

#### 5.2.1.1. Sprint Planning 1

| Sprint # | Sprint 1 |
| --- | --- |
| **Sprint Planning Background** | |
| Date | 01/09/2026, según el borrador inicial; pendiente de corroborar con el acta. |
| Time | 08:30 p. m., según el borrador inicial. |
| Location | Microsoft Teams. |
| Prepared By | Christoper Steven Rivas Castillo, según el borrador inicial. |
| Attendees (to planning meeting) | [PENDIENTE: asistentes reales]. |
| Sprint 0 Review Summary | No aplica. No se documenta una revisión anterior. |
| Sprint 0 Retrospective Summary | No aplica. No se documenta una retrospectiva anterior. |
| **Sprint Goal & User Stories** | |
| Sprint 1 Goal | Implementar y publicar, antes del cierre del Sprint 1 para AV1, la Landing Page de LoadMatch para comunicar su propuesta de valor a empresas y transportistas, permitir la consulta de tipos de vehículos y recibir consultas comerciales, verificando los criterios de US12, US13 y US14 en móvil y escritorio. |
| Fecha de inicio y cierre | [PENDIENTE: incorporar fechas para completar el plazo del objetivo SMART]. |
| Sprint 1 Velocity | [PENDIENTE: sumar únicamente historias formalmente aceptadas al cierre]. |
| Sum of Story Points | 7 puntos planificados: US12 = 3, US13 = 2 y US14 = 2. |

*Nota. Se conserva el objetivo planificado para mostrar la diferencia con el incremento recibido. No se modifica retrospectivamente la planificación para presentar como cumplidas las historias que no aparecen implementadas. Si el equipo acordó un cambio de alcance, deberá adjuntar ese acuerdo y actualizar la trazabilidad del Capítulo III.*

La revisión del código evidencia un avance centrado en la comunicación de la propuesta de valor y la interacción informativa. No permite declarar alcanzado el objetivo completo ni registrar siete puntos de velocidad. Si US12 fuera aceptada y las otras dos historias permanecieran pendientes, la velocidad sería tres puntos; este cálculo es condicional, no un resultado de cierre acreditado.

#### 5.2.1.2. Aspect Leaders and Collaborators

La matriz LACX identifica al líder (L) y a los colaboradores (C) de cada aspecto del sprint. Los archivos no permiten atribuir autoría individual, por lo que las asignaciones deben completarse con los acuerdos del equipo y el historial de contribuciones.

| Team Member | GitHub Username | Landing Page | Diseño UI/UX | Validación y despliegue | Documentación |
| --- | --- | --- | --- | --- | --- |
| Noriega Collado, Jean Fabio | [PENDIENTE] | [PENDIENTE] | [PENDIENTE] | [PENDIENTE] | [PENDIENTE] |
| Rivas Castillo, Christoper Steven | [PENDIENTE] | [PENDIENTE] | [PENDIENTE] | [PENDIENTE] | [PENDIENTE] |
| Simon Calderon, Ismael Sebastian | [PENDIENTE] | [PENDIENTE] | [PENDIENTE] | [PENDIENTE] | [PENDIENTE] |
| Collantes Artola, Marco Antonio | [PENDIENTE] | [PENDIENTE] | [PENDIENTE] | [PENDIENTE] | [PENDIENTE] |
| Emilia [apellidos pendientes en Capítulo I] | [PENDIENTE] | [PENDIENTE] | [PENDIENTE] | [PENDIENTE] | [PENDIENTE] |
| Benigno Montero, Harold Fauskorp | Harold-11, según borrador inicial | [PENDIENTE] | [PENDIENTE] | [PENDIENTE] | [PENDIENTE] |

*Nota. La matriz incluye a los seis integrantes del Capítulo I. La asignación previa de tareas a un integrante no demuestra por sí sola su ejecución ni permite atribuirle todo el contenido de los archivos.*

#### 5.2.1.3. Sprint Backlog 1

El backlog inicial comprendía las siguientes tareas. Su estado se actualiza según lo observable en la copia de código, manteniendo las estimaciones originales como datos de planificación.

| User Story Id | User Story Title | Work Item/Task Id | Work Item/Task Title | Description | Estimation | Assigned To | Status |
| --- | --- | --- | --- | --- | --- | --- | --- |
| US12 | Visualización de propuesta de valor | T01 | Estructura del Hero y navegación | Presentar la conexión entre empresas y transportistas, beneficios y accesos por perfil. | 8 h, según borrador | Harold Benigno Montero, asignación del borrador | Implementación presente; aceptación pendiente |
| US13 | Consulta de tipos de vehículos | T02 | Catálogo de vehículos | Mostrar tipos y capacidades de carga soportadas. | 6 h, según borrador | Harold Benigno Montero, asignación del borrador | No identificado en la versión recibida |
| US14 | Formulario de contacto | T03 | Formulario y validación | Recoger consultas mediante formulario; completar almacenamiento y notificación exigidos por la historia. | 6 h, según borrador | Harold Benigno Montero, asignación del borrador | No implementado en la versión recibida |

**Tablero declarado:** [Sprint Board de LoadMatch en Jira](https://upc-team-m57tll9j.atlassian.net/jira/software/projects/US/boards/2?sprintStarted=true&filter=&groupBy=none).

**Captura del tablero y estados al cierre:** [PENDIENTE].

Además de T01, el código contiene trabajo que debe vincularse con las tareas reales del tablero. El siguiente inventario no asigna nuevos identificadores de historia ni estimaciones retrospectivas.

| Trabajo identificado | Archivos principales | Relación con el alcance |
| --- | --- | --- |
| Indicadores logísticos y beneficios por segmento | `index.html`, diccionarios de idioma | Contenido de apoyo a US12. |
| Pestañas «Cómo funciona» para empresas y transportistas | `index.html`, `assets/js/main.js` | Explicación de la propuesta de valor; no ejecuta operaciones de transporte. |
| Tarjetas de confianza, precios y testimonios ilustrativos | `index.html` | Contenido informativo; no acredita clientes, pagos ni validación documental real. |
| Preguntas frecuentes con acordeón | `index.html`, `assets/js/main.js` | Orientación del visitante; no sustituye US14. |
| Internacionalización español/inglés | `assets/js/i18n.js`, `assets/i18n/en.json`, `assets/i18n/es.json` | Funcionalidad transversal por asociar a un ítem real del backlog. |
| Estilos adaptables y navegación móvil | `assets/css/responsive.css`, `assets/js/main.js` | Soporte de presentación móvil y escritorio. |
| Configuración de CTA hacia la futura Web Application | `assets/js/config.js`, `assets/js/main.js` | Integración preparada; URL base todavía vacía. |
| Documentación y configuración del proyecto | `README.md`, `.editorconfig`, `.gitignore`, `.nojekyll`, `LICENSE` | Preparación y mantenimiento del producto. |

*Nota. Las horas de tareas no se suman con los Story Points. La internacionalización y los contenidos adicionales no permiten dar por completadas US13 o US14 sin satisfacer sus criterios.*

#### 5.2.1.4. Development Evidence for Sprint Review

La evidencia disponible consiste en los archivos fuente de la Landing Page. La copia recibida no contiene un directorio `.git` en la carpeta `landing` ni en su carpeta contenedora inmediata, por lo que no permite recuperar commits, ramas, revisores o fechas de integración.

| Repository | Branch | Commit Id | Commit Message | Commit Message Body | Committed on |
| --- | --- | --- | --- | --- | --- |
| Desarrollo-Open-Source-grupo-5/Loadmatch-landing-page | [PENDIENTE] | [PENDIENTE] | [PENDIENTE: mensaje literal] | [PENDIENTE] | [PENDIENTE] |

**Repositorio declarado:** [Loadmatch-landing-page](https://github.com/Desarrollo-Open-Source-grupo-5/Loadmatch-landing-page).

Se agregarán tantas filas como commits relevantes tenga el incremento. Cada identificador deberá enlazar con el commit real. Los ejemplos de Conventional Commits del README son convenciones, no registros históricos.

**Artefactos de desarrollo comprobados**

| Artefacto | Contenido comprobado |
| --- | --- |
| `index.html` | Estructura semántica, metadatos, secciones informativas, controles de interfaz y ocho CTA configurables. |
| `assets/css/main.css` | Tokens de color, tipografía Inter, espaciado, tamaños y estilos base. |
| `assets/css/components.css` | Hoja de estilos de componentes referenciada por la página. |
| `assets/css/responsive.css` | Media queries de 1359, 1023, 767 y 389 px, además de reglas de impresión y reducción de movimiento. |
| `assets/js/main.js` | Inicialización de CTA, menú móvil, pestañas, acordeón y carrusel. |
| `assets/js/i18n.js` | Carga de traducciones con `fetch`, actualización de textos y almacenamiento de preferencia de idioma. |
| `.editorconfig` | UTF-8, finales de línea LF, dos espacios, salto final y eliminación de espacios sobrantes. |
| `.gitignore` | Exclusión de archivos del sistema, configuración local de editores, registros y `.env`. |
| `.nojekyll` | Archivo presente como preparación para alojamiento estático en GitHub Pages. |
| `LICENSE` | Licencia MIT incluida. |

#### 5.2.1.5. Execution Evidence for Sprint Review

La inspección permite identificar qué componentes están implementados, pero la evidencia visual de ejecución debe completarse con capturas y un video de la página servida mediante HTTP. En esta revisión se comprobaron referencias locales y estructura del código; no se realizó una prueba interactiva en navegador.

**1. Inicio e indicadores del contexto logístico**

El Hero presenta la propuesta de encontrar transporte sin disponer de flota propia y diferencia los CTA de empresa y transportista. La sección de indicadores muestra cifras de contexto atribuidas al MTC, relacionadas con espera para conseguir un vehículo, tercerización y costo logístico. Estas cifras se presentan como antecedentes del problema, no como resultados alcanzados por LoadMatch.

**Captura de inicio en escritorio y móvil:** [PENDIENTE].

**2. Funcionamiento y beneficios por segmento**

La sección «Cómo funciona» contiene pestañas para empresas y transportistas, con imágenes y pasos explicativos. El código contempla selección mediante clic y navegación con flechas, Home y End. Las imágenes ilustran la aplicación prevista; no demuestran que las operaciones transaccionales estén implementadas.

Las tarjetas posteriores explican los beneficios para ambos segmentos y presentan información sobre confianza, perfiles, historial y calificaciones. Las afirmaciones sobre verificación oficial y seguimiento deberán corresponderse con los servicios disponibles cuando estos se implementen.

**Capturas de ambos paneles y beneficios:** [PENDIENTE].

**3. Testimonios y modelo de precios**

Se incluyen tres testimonios en un componente con controles y contador. La página los identifica como contenido de muestra, por lo que no constituyen entrevistas de validación ni opiniones de clientes reales.

La sección de precios describe publicación gratuita, comisión por servicio y ausencia de membresía mensual. También está identificada como contenido de muestra. No corresponde a planes de suscripción ni acredita integración de una pasarela de pago.

**Capturas de testimonios y precios:** [PENDIENTE].

**4. Preguntas frecuentes y contacto**

El acordeón incluye cinco preguntas sobre costos, cobertura, validación de transportistas, incidencias y tipos de carga. La pregunta sobre mercancías admitidas no constituye un catálogo de vehículos con capacidades.

El pie de página contiene enlaces `mailto:` y `tel:`, además de información de ubicación y horario. No existe un elemento `<form>` ni lógica para recibir, almacenar o notificar consultas. Tampoco se ha verificado la operatividad de la dirección de correo y teléfono mostrados.

**Capturas del acordeón y pie de página:** [PENDIENTE].

**5. Idiomas, adaptación y accesibilidad**

La página contiene diccionarios en inglés y español. La selección inicial prioriza la preferencia guardada, luego el idioma compatible del navegador y finalmente inglés. La carga de traducciones requiere un servidor HTTP local o alojamiento web.

Se identifican un enlace para saltar al contenido principal, atributos ARIA, controles de pestañas y reglas adaptables. El README declara verificaciones de contraste y ausencia de desbordamiento en distintas resoluciones, pero no incluye en los archivos revisados los resultados de ejecución necesarios para reproducir esas conclusiones. Por ello, no se presenta esta inspección como certificación de conformidad WCAG.

**Capturas en español e inglés y registro de pruebas:** [PENDIENTE].

**6. CTA y espacios de video**

Existen ocho enlaces con `data-app-path`. La variable `APP_BASE_URL` está vacía; por ese motivo, el código los dirige a secciones internas mediante `data-app-fallback`. Las rutas de registro por perfil e inicio de sesión están preparadas, pero no conectadas a una aplicación publicada.

Los dos espacios de video contienen la dirección base de inserción de YouTube sin identificador. Son contenedores preparados para About-the-Product y About-the-Team, no videos publicados.

**Registro de comprobaciones**

| Verificación | Resultado de inspección | Evidencia de ejecución pendiente |
| --- | --- | --- |
| Recursos locales de `index.html` | No se encontraron archivos faltantes entre las referencias `assets/` y `docs/` revisadas. | Carga HTTP y consola del navegador. |
| Propuesta de valor, US12 | Presente en estructura y textos. | Capturas y aceptación del escenario. |
| Catálogo, US13 | No identificado. | Implementación y prueba. |
| Formulario, US14 | Cero elementos `<form>`; solo contacto mediante enlaces. | Implementación, recepción, almacenamiento y notificación. |
| Idiomas | Dos diccionarios y lógica de selección presentes. | Alternancia y persistencia de preferencia. |
| Interactividad | Código de menú, pestañas, acordeón y carrusel presente. | Interacción con ratón y teclado. |
| CTA externos | Ocho enlaces preparados; URL base vacía. | Integración futura con la Web Application. |
| Videos | Dos inserciones sin ID. | URLs definitivas y reproducción. |

**Video de navegación del Sprint Review:** [PENDIENTE: Microsoft Stream y archivo `.mp4`, de 3 a 5 minutos conforme al enunciado].

#### 5.2.1.6. Services Documentation Evidence for Sprint Review

La versión revisada es un sitio estático y no contiene una API RESTful propia. El uso de `fetch` se limita en el código revisado a cargar los diccionarios de traducción; no representa un Web Service de negocio.

En consecuencia, no existe documentación OpenAPI/Swagger que pueda atribuirse a esta entrega. Las explicaciones sobre transportistas, seguimiento, incidencias y pagos describen la propuesta de la plataforma y no acreditan servicios operativos.

La implementación posterior de la API deberá incluir las operaciones reales, métodos HTTP, rutas, parámetros, autenticación, solicitudes y respuestas, junto con la URL de Swagger y capturas de ejecución. El contexto Contact deberá resolver la recepción de consultas requerida por US14.

**Repositorio backend declarado:** [Loadmatch-backend-application](https://github.com/Desarrollo-Open-Source-grupo-5/Loadmatch-backend-application).

**Evidencia OpenAPI/Swagger de Sprint 1:** no disponible en el alcance recibido.

#### 5.2.1.7. Software Deployment Evidence for Sprint Review

El README identifica GitHub Pages como plataforma de alojamiento y describe la publicación desde `main` y la raíz del repositorio. La copia incluye `.nojekyll` y una estructura estática que no requiere compilación.

Estos archivos documentan la preparación de publicación, pero no permiten verificar la configuración remota ni confirmar que la copia local coincide con una versión desplegada. Además, la carpeta entregada se llama `landing`: la publicación desde la raíz solo corresponde si su contenido se encuentra efectivamente en la raíz de la rama publicada.

| Evidencia | Estado |
| --- | --- |
| Repositorio declarado | [Loadmatch-landing-page](https://github.com/Desarrollo-Open-Source-grupo-5/Loadmatch-landing-page) |
| Plataforma documentada | GitHub Pages. |
| Archivos estáticos y `.nojekyll` | Presentes en la copia revisada. |
| Configuración `Settings > Pages` | [PENDIENTE: captura de la configuración real]. |
| URL pública | [PENDIENTE: URL obtenida de GitHub Pages y verificación de acceso]. |
| Commit y tag publicados | [PENDIENTE]. |
| Ejecución de despliegue | [PENDIENTE: enlace y resultado]. |
| Fecha de publicación | [PENDIENTE]. |
| Prueba posterior al despliegue | [PENDIENTE: recursos, navegación, traducciones e interacción]. |

No se acredita un pipeline propio de integración continua mediante el README. Para documentar publicación automática se requiere evidencia de la configuración y de una ejecución satisfactoria. La disponibilidad del sitio estático tampoco implica el despliegue de la Web Application o el backend.

#### 5.2.1.8. Team Collaboration Insights during Sprint

La organización de archivos separa contenido, estilos base, componentes, adaptación, configuración de enlaces y traducciones. Esta separación facilita distribuir el trabajo y revisar cambios por responsabilidad. El README define GitFlow, Conventional Commits y Semantic Versioning como prácticas del proyecto.

La existencia de estas convenciones no demuestra su aplicación histórica. Para describir la colaboración ejecutada se requiere incorporar los commits, Pull Requests y acuerdos reales del sprint.

| Aspecto | Evidencia disponible | Evidencia pendiente |
| --- | --- | --- |
| Organización técnica | Separación de HTML, CSS, JavaScript y diccionarios. | Autoría y tareas asociadas. |
| Uniformidad de formato | `.editorconfig` con reglas comunes. | Revisiones y aplicación efectiva de las convenciones. |
| Flujo de colaboración | GitFlow y convenciones documentados en README. | Ramas, Pull Requests, comentarios e integraciones reales. |
| Participación individual | No recuperable de esta copia sin historial Git. | Contribuciones de los seis integrantes. |
| Coordinación y retrospectiva | No se proporcionó acta de cierre. | Acuerdos, bloqueos y acciones de mejora. |

**Historial de commits por integrante:** [PENDIENTE].

**Gráficos de colaboradores y actividad durante el sprint:** [PENDIENTE].

**Pull Requests revisados y observaciones resueltas:** [PENDIENTE].

Como propuesta para la retrospectiva, se plantea revisar la diferencia entre las historias planificadas y el producto construido, acordar cómo completar US13 y US14 y registrar explícitamente las tareas de internacionalización y contenido adicional. También corresponde preparar la integración de CTA y sustituir los espacios de video por publicaciones reales en sus hitos respectivos. Estas acciones son propuestas de seguimiento y no acuerdos ya celebrados por el equipo.
