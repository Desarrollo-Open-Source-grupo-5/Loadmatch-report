<p align="center">
  <img src="https://upload.wikimedia.org/wikipedia/commons/f/fc/UPC_logo_transparente.png" alt="Logo de la Universidad" width="300">
</p>

<div align="center">

# UNIVERSIDAD PERUANA DE CIENCIAS APLICADAS
### Facultad de Ingeniería
### Carrera de Ingeniería de Software

<br>
<br>

**1ASI0729** 
<br>
**Desarrollo de Aplicaciones Open-Source** 
<br>
NRC
<br>
**7729**
<br>
**Informe del Trabajo AV1**  
<br>
Docente
<br>
**Hugo Allan Mori Paiva**

<br>
<br>

Equipo
<br>
**CargoLink Labs**  
Proyecto
<br>
**LoadMatch**  


<br>
<br>
<br>

<div align="center">

## INTEGRANTES

| Código de estudiante | Apellidos y nombres |
| :---: | :--- |
| U202310342 | Noriega Collado, Jean Fabio |
| U202323551 | Rivas Castillo, Christoper Steven |
| U201823468 | Simon Calderon, Ismael Sebastian |
| U201410183 | Collantes Artola, Marco Antonio |
| U202321086 | Benigno Montero, Harold Fauskorp |

</div>

<br>
<br>
<br>

**Período 202620**

**Septiembre 2026**

</div>

<div style="page-break-before: always;"></div>

<a id="registro-de-versiones"></a>

# Registro de versiones del informe

<table border="1" cellspacing="0" cellpadding="5">
<thead>
<tr>
<th>Versión</th>
<th>Fecha</th>
<th>Autor/es</th>
<th>Descripción</th>
</tr>
</thead>
<tbody>
<tr>
<td align="center">1.0<br>(AV1)</td>
<td align="center">17/09/2026</td>
<td>
Noriega Collado, Jean Fabio<br>
Rivas Castillo, Christoper Steven<br>
Simon Calderon, Ismael Sebastian<br>
Collantes Artola, Marco Antonio<br>
Benigno Montero, Harold Fauskorp
</td>
<td>
Primera versión del Project Report correspondiente a AV1.<br>
Desarrollo de los Capítulos I, II, III y IV.<br>
Desarrollo del Capítulo V hasta la sección 5.2.1.8 correspondiente al Sprint 1.<br>
Elaboración de artefactos de Requirements Elicitation, Needfinding, Requirements Specification y Product Design.<br>
Configuración de repositorios, GitFlow, Conventional Commits y Semantic Versioning.<br>
Implementación y despliegue de la primera versión de la Landing Page de LoadMatch en GitHub Pages.<br>
Incorporación de evidencias de colaboración y Student Outcome de AV1.
</td>
</tr>
</tbody>
</table>

<div style="page-break-after: always;"></div>


<!-- Si el repositorio solo contiene una versión documentada, conservar una sola fila. No crear fechas ni versiones retrospectivas para completar la tabla. -->

<div style="page-break-before: always;"></div>

<a id="project-report-collaboration-insights"></a>


## Project Report Collaboration Insights

Para el desarrollo del **Project Report de LoadMatch**, el equipo utiliza un repositorio dentro de la organización en GitHub. A continuación, se presenta la evidencia de colaboración correspondiente al **AV1**, en coherencia con el Registro de Versiones del Informe.

**Repositorio del informe del proyecto:** [https://github.com/Launchpad-PE/LoadMatch-Report](https://github.com/Launchpad-PE/LoadMatch-Report)

**Total de commits:** 250 - 300 - 400
<br>
**Autores contribuyentes:**
- Noriega Collado, Jean Fabio (dumbaskidd)  
- Rivas Castillo, Christoper Steven (C0DERTOPH)  
- Simon Calderon, Ismael Sebastian (Mayel-dev)
- Collantes Artola, Marco Antonio (Markollantes2307)
- Benigno Montero, Harold Fauskorp (Harold-11)

La actividad se distribuyó en ramas temáticas por capítulos del informe (`feature/Chapter1` hasta `feature/Chapter5`), asegurando revisiones cruzadas mediante **Pull Requests** y manteniendo evidencia de colaboración en los comentarios y resoluciones.

---

### AV1 — Informe inicial (Semana 4)
Durante esta fase, el equipo elaboró el informe inicial, que incluyó los siguientes aspectos:

- Carátula con información institucional y de la startup.  
- Registro de Versiones del Informe, documentando los cambios realizados.  
- Contenido preliminar con tabla de contenidos, Student Outcomes y **Capítulo I (Introducción)**.  
- **Capítulo II** con los primeros avances en Requirements Elicitation & Analysis.  
- **Capítulo III** con la especificación de requisitos, User Stories e Impact Mapping.  
- **Capítulo IV** con los avances en Product Design, incluyendo Style Guidelines, Information Architecture y prototipos de la Landing Page.  
- **Capítulo V** con los avances del Product Implementation, evidencias del Sprint 1 y configuración inicial del repositorio.  
- Conclusiones preliminares, bibliografía y anexos.  

---

### Project Report Collaboration Insights AV1

| Integrante | Usuario GitHub | Commits | Adiciones | Eliminaciones |
| :--- | :--- | :---: | :---: | :---: |
| Noriega Collado, Jean Fabio | dumbaskidd | 102 | 3120 | 410 |
| Rivas Castillo, Christoper Steven | C0DERTOPH | 68 | 1985 | 230 |
| Simon Calderon, Ismael Sebastian | Mayel-dev | 41 | 1270 | 150 |
| Collantes Artola, Marco Antonio | Markollantes2307 | 20 | 640 | 95 |
| Benigno Montero, Harold Fauskorp | Harold-11 | 12 | 410 | 60 |

---

La colaboración fue activa y equitativa, con aportes sustanciales de todos los integrantes en la redacción, organización y documentación del informe. Se destacó la integración de **assets/images** en cada rama de capítulo y la correcta gestión de Pull Requests como evidencia de trabajo colaborativo.


<div style="page-break-before: always;"></div>

<a id="contenido"></a>

# Contenido

- [Carátula](#caratula)
- [Registro de Versiones del Informe](#registro-de-versiones)
- [Project Report Collaboration Insights](#project-report-collaboration-insights)
- [Contenido](#contenido)
- [Student Outcome](#student-outcome)
- [Capítulo I: Introducción](#capítulo-i-introducción)
  - [1.1. Startup Profile](#11-startup-profile)
    - [1.1.1. Descripción de la Startup](#111-descripción-de-la-startup)
    - [1.1.2. Perfiles de integrantes del equipo](#112-perfiles-de-integrantes-del-equipo)
  - [1.2. Solution Profile](#12-solution-profile)
    - [1.2.1. Antecedentes y problemática](#121-antecedentes-y-problemática)
    - [1.2.2. Lean UX Process](#122-lean-ux-process)
      - [1.2.2.1. Lean UX Problem Statements](#1221-lean-ux-problem-statements)
      - [1.2.2.2. Lean UX Assumptions](#1222-lean-ux-assumptions)
      - [1.2.2.3. Lean UX Hypothesis Statements](#1223-lean-ux-hypothesis-statements)
      - [1.2.2.4. Lean UX Canvas](#1224-lean-ux-canvas)
  - [1.3. Segmentos objetivo](#13-segmentos-objetivo)
    - [1. Segmento 1: Emprendimientos y MIPYME que requieren servicios de transporte de carga](#1-segmento-1-emprendimientos-y-mipyme-que-requieren-servicios-de-transporte-de-carga)
    - [2. Segmento 2: Transportistas independientes y pequeñas empresas de transporte de carga](#2-segmento-2-transportistas-independientes-y-pequeñas-empresas-de-transporte-de-carga)
- [Capítulo II: Requirements Elicitation & Analysis](#capítulo-ii-requirements-elicitation--analysis)
  - [2.1. Competidores](#21-competidores)
    - [2.1.1. Análisis competitivo](#211-análisis-competitivo)
    - [2.1.2. Estrategias y tácticas frente a competidores](#212-estrategias-y-tácticas-frente-a-competidores)
  - [2.2. Entrevistas](#22-entrevistas)
    - [2.2.1. Diseño de entrevistas](#221-diseño-de-entrevistas)
    - [2.2.2. Registro de entrevistas](#222-registro-de-entrevistas)
    - [2.2.3. Análisis de entrevistas](#223-análisis-de-entrevistas)
  - [2.3. Needfinding](#23-needfinding)
    - [2.3.1. User Personas](#231-user-personas)
    - [2.3.2. User Task Matrix](#232-user-task-matrix)
    - [2.3.3. User Journey Mapping](#233-user-journey-mapping)
    - [2.3.4. Empathy Mapping](#234-empathy-mapping)
  - [2.4. Big Picture Event Storming](#24-big-picture-event-storming)
  - [2.5. Ubiquitous Language](#25-ubiquitous-language)
- [Capítulo III: Requirements Specification](#capítulo-iii-requirements-specification)
  - [3.1. User Stories](#31-user-stories)
  - [3.2. Impact Mapping](#32-impact-mapping)
  - [3.3. Product Backlog](#33-product-backlog)
- [Capítulo IV: Product Design](#capítulo-iv-product-design)
  - [4.1. Style Guidelines](#41-style-guidelines)
    - [4.1.1. General Style Guidelines](#411-general-style-guidelines)
      - [4.1.1.1. Typography](#4111-typography)
      - [4.1.1.2. Colors](#4112-colors)
      - [4.1.1.3. Spacing](#4113-spacing)
      - [4.1.1.4. Iconography](#4114-iconography)
      - [4.1.1.5. Tone of Communication and Applied Language](#4115-tone-of-communication-and-applied-language)
    - [4.1.2. Web Style Guidelines](#412-web-style-guidelines)
  - [4.2. Information Architecture](#42-information-architecture)
    - [4.2.1. Organization Systems](#421-organization-systems)
    - [4.2.2. Labeling Systems](#422-labeling-systems)
    - [4.2.3. SEO Tags and Meta Tags](#423-seo-tags-and-meta-tags)
    - [4.2.4. Searching Systems](#424-searching-systems)
    - [4.2.5. Navigation Systems](#425-navigation-systems)
  - [4.3. Landing Page UI Design](#43-landing-page-ui-design)
    - [4.3.1. Landing Page Wireframe](#431-landing-page-wireframe)
    - [4.3.2. Landing Page Mock-up](#432-landing-page-mock-up)
  - [4.4. Web Applications UX/UI Design](#44-web-applications-uxui-design)
    - [4.4.1. Web Applications Wireframes](#441-web-applications-wireframes)
    - [4.4.2. Web Applications Wireflow Diagrams](#442-web-applications-wireflow-diagrams)
    - [4.4.3. Web Applications Mock-ups](#443-web-applications-mock-ups)
    - [4.4.4. Web Applications User Flow Diagrams](#444-web-applications-user-flow-diagrams)
  - [4.5. Web Applications Prototyping](#45-web-applications-prototyping)
  - [4.6. Domain-Driven Software Architecture](#46-domain-driven-software-architecture)
    - [4.6.1. Design-Level Event Storming](#461-design-level-event-storming)
    - [4.6.2. Software Architecture Context Diagram](#462-software-architecture-context-diagram)
    - [4.6.3. Software Architecture Container Diagrams](#463-software-architecture-container-diagrams)
    - [4.6.4. Software Architecture Components Diagrams](#464-software-architecture-components-diagrams)
  - [4.7. Software Object-Oriented Design](#47-software-object-oriented-design)
    - [4.7.1. Class Diagrams](#471-class-diagrams)
  - [4.8. Database Design](#48-database-design)
    - [4.8.1. Database Diagrams](#481-database-diagrams)
- [Capítulo V: Product Implementation, Validation & Deployment](#capítulo-v-product-implementation-validation--deployment)
  - [5.1. Software Configuration Management](#51-software-configuration-management)
    - [5.1.1. Software Development Environment Configuration](#511-software-development-environment-configuration)
    - [5.1.2. Source Code Management](#512-source-code-management)
    - [5.1.3. Source Code Style Guide & Conventions](#513-source-code-style-guide--conventions)
    - [5.1.4. Software Deployment Configuration](#514-software-deployment-configuration)
  - [5.2. Landing Page, Services & Applications Implementation](#52-landing-page-services--applications-implementation)
    - [5.2.1. Sprint 1](#521-sprint-1)
      - [5.2.1.1. Sprint Planning 1](#5211-sprint-planning-1)
      - [5.2.1.2. Aspect Leaders and Collaborators](#5212-aspect-leaders-and-collaborators)
      - [5.2.1.3. Sprint Backlog 1](#5213-sprint-backlog-1)
      - [5.2.1.4. Development Evidence for Sprint Review](#5214-development-evidence-for-sprint-review)
      - [5.2.1.5. Execution Evidence for Sprint Review](#5215-execution-evidence-for-sprint-review)
      - [5.2.1.6. Services Documentation Evidence for Sprint Review](#5216-services-documentation-evidence-for-sprint-review)
      - [5.2.1.7. Software Deployment Evidence for Sprint Review](#5217-software-deployment-evidence-for-sprint-review)
      - [5.2.1.8. Team Collaboration Insights during Sprint](#5218-team-collaboration-insights-during-sprint)
- [Conclusiones](#conclusiones)
- [Bibliografía](#bibliografía)
- [Anexos](#anexos)

<div style="page-break-before: always;"></div>


<a id="student-outcome"></a>

# Student Outcome

## ABET – EAC – Student Outcome 3

**Criterio: Capacidad de comunicarse efectivamente con un rango de audiencias.**

El desarrollo de LoadMatch requiere comunicar el problema del transporte de mercadería, la propuesta de solución y las decisiones de ingeniería a diferentes audiencias. Con las empresas y los transportistas se emplea un lenguaje centrado en sus necesidades y actividades; con el equipo y el docente se utilizan requisitos, modelos y evidencias técnicas para explicar el diseño y el avance del producto.

El siguiente cuadro organiza el registro de AV1 según los criterios de comunicación oral y escrita. Cada acción deberá identificar qué comunicó el integrante, a quién y cómo adaptó su explicación de acuerdo con el contexto del proyecto.

| Criterio específico | Acciones realizadas | Conclusiones |
| :--- | :--- | :--- |
| **Comunica oralmente con efectividad a diferentes rangos de audiencia.** | **Noriega Collado, Jean Fabio — AV1:** Durante las entrevistas realizadas a potenciales usuarios de LoadMatch, participó en la comunicación con dueños de negocios y transportistas para conocer cómo gestionan actualmente sus necesidades de transporte, qué dificultades encuentran y qué condiciones les generan mayor confianza. Para ello se utilizó la guía de preguntas preparada para cada segmento, manteniendo un lenguaje comprensible y orientado a obtener información útil para el análisis del proyecto.<br><br>**Rivas Castillo, Christoper Steven — AV1:** Participó en entrevistas realizadas a transportistas, donde se abordaron temas relacionados con la búsqueda de oportunidades de trabajo, los riesgos asociados al transporte de carga y la disposición a utilizar una plataforma con procesos de validación. Estas conversaciones permitieron recoger información directa del segmento y posteriormente incorporarla al análisis de necesidades del proyecto.<br><br>**Simon Calderon, Ismael Sebastian — AV1:** Durante las coordinaciones del Sprint 1, participé en la revisión e integración de las secciones del Landing Page que tenía asignadas, principalmente Cómo funciona, tarjetas de confianza, videos y enlaces CTA hacia la Web Application. Esto requirió comunicar al equipo el avance de estas secciones y coordinar su integración con el trabajo realizado por los demás integrantes.<br><br>**Collantes Artola, Marco Antonio — AV1:** Era importante tener que realizar las encuestas y coordinaciones necesarias para este proyecto en el menor tiempo posible, una cosa que ha tenido nuestro líder de equipo presente desde el inicio, pero también he buscado mantener la calma cuando se trata de entablar conversaciones tanto dentro como fuera del grupo, tal como se muestra a la hora de realizar entrevistas pues de esa forma se puede conocer mejor a los posibles clientes y a los compañeros que harán posible un proyecto como este.<br><br>**Benigno Montero, Harold Fauskorp — AV1:** Durante las coordinaciones del equipo, participó en la revisión de decisiones relacionadas con el diseño visual, la arquitectura y la organización de los datos de LoadMatch. La elaboración de wireframes, mock-ups, modelos C4, diagramas de clases y diseños de base de datos permitió apoyar estas explicaciones con artefactos visuales, facilitando que los integrantes pudieran revisar la estructura propuesta y coordinar posteriormente su implementación en el producto. | **AV1 — Reflexión preliminar:** Comunicar LoadMatch requiere distinguir las preocupaciones de quienes contratan transporte y de quienes ofrecen capacidad de carga. Para las empresas, la explicación debe vincular el servicio con el cuidado de la mercadería, la confianza y la trazabilidad. Para los transportistas, debe aclarar el acceso a solicitudes compatibles y la gestión del servicio. Ante el docente y el equipo, estas necesidades deben relacionarse con las historias de usuario, los flujos y las decisiones de arquitectura. Las evidencias de intervención permitirán evaluar la claridad de las explicaciones y la respuesta a preguntas de cada audiencia. |
| **Comunica por escrito con efectividad a diferentes rangos de audiencia.** | **Noriega Collado, Jean Fabio — AV1:** En el aspecto escrito del proyecto, participó principalmente en la elaboración y mejora del Capítulo II, incluyendo el diseño y registro de entrevistas, User Personas, User Task Matrix, Big Picture Event Storming y Ubiquitous Language. También realizó aportes posteriores en la especificación de requisitos y en artefactos de diseño, permitiendo comunicar de manera estructurada las necesidades identificadas y su relación con la solución propuesta.<br><br>**Rivas Castillo, Christoper Steven — AV1:** Participó en el registro y actualización de las entrevistas del Capítulo II, incorporando información de los entrevistados, evidencias y resúmenes de los resultados obtenidos. Asimismo, trabajó en la configuración del entorno de desarrollo documentada en el Capítulo V y en secciones del Landing Page dirigidas a los segmentos de usuarios, contribuyendo a comunicar tanto el proceso de desarrollo como la propuesta del producto.<br><br>**Simon Calderon, Ismael Sebastian — AV1:** En la documentación del proyecto, trabajé en el registro y actualización de entrevistas y evidencias del Capítulo II, así como en diferentes apartados del Capítulo IV relacionados con Style Guidelines, arquitectura de información, wireframes, wireflows y documentación de los flujos de la aplicación. También participé en la implementación del Landing Page mediante las secciones Cómo funciona, tarjetas de confianza, videos y enlaces CTA, buscando mantener coherencia entre el diseño documentado y el producto implementado.<br><br>**Collantes Artola, Marco Antonio — AV1:** En el aspecto escrito del proyecto, me centré principalmente en items donde se pudiese evidenciar mejor el perfil de personalidad que se busca en los clientes potenciales (tales como los empathy maps y las primeras versiones de los journey maps), y también busqué referenciar la experiencia promedio de nuestros usuarios en los gráficos preliminares de nuestra app (veasé los user flow diagrams y el prototipado preliminar de nuestra app).<br><br>**Benigno Montero, Harold Fauskorp — AV1:** Su perfil del Capítulo I declara aportes a wireframes, mock-ups y modelado de base de datos. Estos artefactos permiten comunicar la estructura de la interfaz y la organización de la información. Durante el desarrollo del Capítulo IV también participó en la elaboración de la arquitectura DDD, diagramas C4, diagramas de clases por bounded context y diseño de base de datos, además de wireframes y mock-ups desktop y mobile del Landing Page. Posteriormente desarrolló los diseños del catálogo de vehículos y formulario de contacto, e implementó ambas funcionalidades en el Landing Page, manteniendo coherencia entre la documentación del diseño y el producto desarrollado. | **AV1 — Reflexión preliminar:** El informe combina descripciones del problema, resultados de entrevistas, historias de usuario, glosario y diagramas para comunicar información con distintos niveles de detalle. La Landing Page presenta la propuesta de valor a visitantes, mientras que la documentación técnica explica al equipo y al docente cómo se estructura la solución. La revisión del Sprint 1 muestra la necesidad de distinguir funcionalidades propuestas, código implementado y comportamiento verificado. Mantener esa precisión evita atribuir al producto capacidades todavía pendientes y permite comunicar con claridad el avance real. |
