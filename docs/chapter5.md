
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

### 5.2.1. Sprint 1

Durante esta primera iteración, el equipo se enfoca en el desarrollo de la primera versión del Landing Page de LoadMatch. Para su implementación se utiliza una estructura basada en HTML5, CSS3 y Vanilla JavaScript, manteniendo una organización clara del Document Object Model (DOM), estilos responsivos y componentes interactivos orientados a comunicar la propuesta de valor de la plataforma.

#### 5.2.1.1. Sprint Planning 1

| Sprint # | Sprint 1 |
| --- | --- |
| **Sprint Planning Background** |  |
| **Date** | 2026-09-01 |
| **Time** | 08:30 PM |
| **Location** | Microsoft Teams |
| **Prepared By** | Christoper Rivas |
| **Attendees (to planning meeting)** | Equipo de Desarrollo LoadMatch |
| **Sprint 0 Review Summary** | N/A — Es el primer Sprint del proyecto. |
| **Sprint 0 Retrospective Summary** | N/A — Es el primer Sprint del proyecto. |
| **Sprint Goal & User Stories** |  |
| **Sprint 1 Goal** | Desarrollar y desplegar la versión inicial del Landing Page de LoadMatch utilizando HTML5, CSS3 y Vanilla JavaScript, con el propósito de comunicar claramente la propuesta de valor y captar usuarios potenciales de empresas y transportistas. El objetivo se considerará cumplido cuando las User Stories US12, US13 y US14 estén implementadas y el Landing Page se encuentre desplegado y accesible públicamente. |
| **Sprint 1 Velocity** | 7 |
| **Sum of Story Points** | 7 |

#### 5.2.1.2. Leadership-and-Collaboration Matrix (LACX)

La distribución de responsabilidades del Sprint 1 considera los principales aspectos técnicos involucrados en el desarrollo del Landing Page. En la matriz, `L` representa al responsable principal (Leader) del aspecto y `C` a los integrantes que participan como colaboradores (Collaborators).

| Team Member | GitHub Username | HTML5 (Structure & SEO) | CSS3 (Styles & Responsiveness) | Vanilla JS (Interactivity) |
| --- | --- | --- | --- | --- |
| Rivas Castillo, Christoper Steven | [usuario real] | L/C | L/C | L/C |
| Benigno Montero, Harold Fauskorp | Harold-11 | L/C | L/C | L/C |
| Simon Calderon, Ismael Sebastian | [usuario real] | L/C | L/C | L/C |

#### 5.2.1.3. Sprint Backlog 1

El Sprint 1 se enfoca en la implementación inicial del Landing Page de LoadMatch y comprende las User Stories correspondientes a la visualización de la propuesta de valor, la consulta de tipos de vehículos y el formulario de contacto. Las tareas técnicas asociadas fueron organizadas y estimadas en Jira para facilitar el seguimiento del trabajo durante la iteración.

<p align="center">
  <img src="../assets/Chapter5/Sprint1/sprint1-board.png" alt="Sprint Board 1 de LoadMatch" width="850"><br>
  <i>Nota. Sprint Board correspondiente al Sprint 1 del proyecto LoadMatch.</i>
</p>

**Sprint Board:** https://upc-team-m57tll9j.atlassian.net/jira/software/projects/US/boards/2?sprintStarted=true&filter=&groupBy=none

Este Sprint cubre las siguientes User Stories y tareas:

| User Story Id | User Story Title | Task Id | Task Title | Description | Estimation | Assigned To | Status |
| --- | --- | --- | --- | --- | --- | --- | --- |
| **US12** | Visualización de propuesta de valor | T01 | Maquetación Semántica del Hero | Estructuración HTML5 del Hero Section y la barra de navegación, asegurando jerarquía de etiquetas y accesibilidad. | 8h | Harold Benigno Montero | To-do |
| **US13** | Consulta de tipos de vehículos | T02 | Catálogo CSS Flexbox/Grid | Diseño responsivo del catálogo de vehículos, implementando Media Queries para la adaptación entre dispositivos móviles y de escritorio. | 6h | Harold Benigno Montero | To-do |
| **US14** | Formulario de contacto | T03 | Validación DOM Vanilla JS | Captura de eventos del formulario (`submit`, `input`) mediante JavaScript nativo para validar campos requeridos y formato de correo. | 6h | Harold Benigno Montero | To-do |

#### 5.2.1.4. Development Evidence for Sprint Review

El desarrollo del Sprint 1 se gestiona mediante ramas independientes creadas a partir de `develop`. Cada cambio implementado será registrado mediante commits individuales y posteriormente integrado mediante Pull Requests hacia la rama de integración.

La siguiente tabla registra la evidencia de desarrollo correspondiente a las User Stories incluidas en el Sprint. Los datos pendientes serán completados conforme los cambios sean implementados y publicados en el repositorio.

| Repository | Branch | Commit Id | Commit Message | Commit Message Body | Committed on |
| --- | --- | --- | --- | --- | --- |
| Desarrollo-Open-Source-grupo-5/Loadmatch-landing-page | feature/US12-hero | (pendiente) | (pendiente) | (pendiente) | (pendiente) |
| Desarrollo-Open-Source-grupo-5/Loadmatch-landing-page | feature/US13-fleet | (pendiente) | (pendiente) | (pendiente) | (pendiente) |
| Desarrollo-Open-Source-grupo-5/Loadmatch-landing-page | feature/US14-contact | (pendiente) | (pendiente) | (pendiente) | (pendiente) |

#### 5.2.1.5. Execution Evidence for Sprint Review

Esta sección presentará la evidencia de ejecución correspondiente a las funcionalidades implementadas durante el Sprint 1. Una vez completadas las User Stories planificadas, se incluirán capturas de las principales vistas funcionales del Landing Page de LoadMatch, mostrando su comportamiento en diferentes tamaños de pantalla y las funcionalidades interactivas desarrolladas.

Las evidencias visuales serán incorporadas una vez que la implementación correspondiente al Sprint se encuentre integrada y disponible para revisión.

**Screenshots de las vistas implementadas:** (pendiente)

**Video de navegación y ejecución del producto:** (pendiente)

#### 5.2.1.6. Services Documentation Evidence for Sprint Review

Durante el Sprint 1 no se contempla la implementación de Web Services, bases de datos ni APIs RESTful, debido a que esta primera iteración se encuentra enfocada en el desarrollo y despliegue inicial del Landing Page de LoadMatch.

Por este motivo, no se presentan endpoints ni documentación de servicios para este Sprint. La implementación de los Web Services será abordada en iteraciones posteriores del proyecto.

#### 5.2.1.7. Software Deployment Evidence for Sprint Review

El Landing Page de LoadMatch será desplegado mediante **GitHub Pages** una vez completada e integrada la implementación correspondiente al Sprint 1.

**Enlace del Repositorio:** https://github.com/Desarrollo-Open-Source-grupo-5/Loadmatch-landing-page

**URL del Landing Page Desplegado:** (pendiente)

**Evidencia del proceso de despliegue:** (pendiente)

#### 5.2.1.8. Team Collaboration Insights during Sprint

La exclusión de frameworks pesados en esta fase exigió una coordinación rigurosa a nivel de archivos estáticos. El equipo implementó una estrategia colaborativa basada en la segmentación clara de la hoja de estilos y la modularización de los scripts.

* **Integración CSS Controlada:** Para evitar la sobreescritura de reglas visuales en un entorno sin preprocesadores avanzados, el equipo aplicó la metodología BEM. Los desarrolladores trabajaron en ramas locales y sometieron sus maquetas visuales a revisiones cruzadas (Pull Requests) para verificar la consistencia estética y el uso obligatorio del archivo de variables (`:root`) antes de fusionar el código.
* **Manejo del DOM en Equipo:** Las revisiones de código en JavaScript se centraron en garantizar que la manipulación del DOM no interfiriera con componentes desarrollados por otros miembros, utilizando selectores específicos e instanciando los Event Listeners de forma modular una vez que el documento estuviera completamente cargado (`DOMContentLoaded`). La fluidez de la comunicación a través de Microsoft Teams permitió resolver las discrepancias de diseño de manera inmediata.

**GitHub Collaboration Insights:** (pendiente)
