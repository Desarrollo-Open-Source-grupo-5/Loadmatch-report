# Conclusiones y Recomendaciones

# Conclusiones

## AV1

A partir del análisis del perfil de CargoLink Labs y de la problemática relacionada con el transporte terrestre de mercadería, se concluye que existe una necesidad concreta de facilitar la conexión entre emprendimientos y MIPYME que requieren trasladar productos y transportistas que cuentan con capacidad disponible. La fragmentación de la búsqueda de proveedores, la dificultad para evaluar su confiabilidad y la limitada trazabilidad del servicio representan puntos de fricción relevantes para los usuarios analizados. En este contexto, LoadMatch plantea una propuesta orientada a centralizar la publicación de solicitudes, la búsqueda de transporte compatible, la validación de transportistas y el seguimiento de los servicios dentro de un mismo entorno digital.

El proceso de investigación y validación desarrollado durante el AV1 permitió identificar necesidades recurrentes en ambos segmentos objetivo. En el caso de los negocios, destacaron principalmente la confianza, la validación del transportista y la puntualidad como factores relevantes al momento de contratar un servicio de carga. Por parte de los transportistas, se identificaron preocupaciones relacionadas con la informalidad del sector, la necesidad de diferenciarse mediante documentación validada y el interés por acceder a clientes formales y oportunidades de trabajo más estables. Estos hallazgos permitieron orientar las User Stories y el Product Backlog hacia funcionalidades relacionadas directamente con las necesidades observadas durante las entrevistas.

Finalmente, se concluye que los artefactos de diseño elaborados durante el AV1 permitieron establecer una base coherente para la evolución de LoadMatch. Las Style Guidelines, la arquitectura de información, los wireframes, mock-ups, flujos de usuario y modelos de arquitectura permiten mantener consistencia entre las necesidades identificadas y la solución propuesta. Asimismo, la implementación y despliegue de la primera versión de la Landing Page permitió materializar la propuesta de valor de LoadMatch, presentar sus principales beneficios a empresas y transportistas y consolidar un primer incremento funcional sobre el cual continuar el desarrollo de la Web Application y los servicios backend en los siguientes sprints.

## TB1

A partir del trabajo desarrollado durante el TB1, se concluye que LoadMatch avanzó desde una propuesta sustentada principalmente en investigación, requisitos y artefactos de diseño hacia una primera versión funcional de su Web Application. Durante el Sprint 2 se implementó una aplicación con Angular organizada por bounded contexts, utilizando Angular Material para la interfaz, internacionalización en inglés y español y una API simulada mediante json-server para representar los recursos necesarios mientras los servicios backend permanecen en desarrollo. Esta implementación permitió comprobar en un entorno funcional la correspondencia entre las necesidades identificadas durante el AV1, las User Stories definidas en el Product Backlog y los principales flujos diseñados para empresas y transportistas.

La implementación del Sprint 2 permitió validar diversos flujos centrales de LoadMatch. Para las empresas se desarrollaron funcionalidades como la publicación, consulta, edición y cancelación de solicitudes de carga, la visualización del transportista y vehículo asignados, el dashboard de operaciones y el seguimiento del estado de una carga mediante una línea de tiempo. Para los transportistas se incorporaron la búsqueda de fletes disponibles, filtros avanzados, consulta del detalle de una carga, visualización de viajes, historial de servicios y estado de validación de documentos. Estos incrementos permitieron transformar varios de los escenarios definidos en las User Stories en interacciones verificables dentro de la aplicación y comprobar que la separación de responsabilidades planteada en el diseño puede trasladarse a una estructura de implementación mantenible.

Finalmente, el TB1 permitió identificar con mayor precisión tanto las capacidades actuales como las limitaciones de esta primera versión de la Web Application. La utilización de una API simulada permitió desarrollar y validar el frontend sin depender todavía de los servicios backend, mientras que el uso de GitFlow, ramas por funcionalidad, Pull Requests, Conventional Commits y compilaciones previas a la integración facilitó el trabajo colaborativo del equipo durante el Sprint 2. Al mismo tiempo, permanecen para los siguientes incrementos funcionalidades como la autenticación real, la persistencia mediante una API desplegada, la aceptación y actualización de viajes, el seguimiento con información geográfica en tiempo real, los pagos, las calificaciones y otras operaciones que requieren lógica de backend. En consecuencia, el Sprint 2 consolida una base funcional sobre la cual continuar evolucionando LoadMatch sin perder la trazabilidad entre investigación, requisitos, diseño e implementación.

## TB2

A partir del trabajo realizado durante el TB2, se concluye que LoadMatch logró avanzar hacia una solución con mayor integración entre sus componentes de software. Durante el Sprint 3, el equipo CargoLink Labs concentró sus esfuerzos en el desarrollo de los Web Services y su conexión con la Web Application, superando la dependencia inicial de una API simulada utilizada en el incremento anterior. La implementación de servicios RESTful mediante Spring Boot y la persistencia de información en PostgreSQL permitieron establecer una base para gestionar operaciones de transporte mediante recursos y datos persistentes.

El desarrollo del Sprint 3 permitió integrar funcionalidades relacionadas con la autenticación de usuarios, la gestión de perfiles de empresas y transportistas, la publicación y consulta de solicitudes de carga, la administración de vehículos y la gestión de viajes. Asimismo, la documentación de los endpoints mediante Swagger facilitó la comprensión de los contratos de los servicios y su utilización durante la integración con el frontend. El despliegue de los componentes en Render, Vercel y GitHub Pages permitió disponer de entornos accesibles para realizar demostraciones y validar los principales flujos implementados.

Por otro lado, las entrevistas de validación permitieron obtener retroalimentación de representantes de los segmentos Shippers y Carriers. En total, se realizaron cuatro entrevistas, tres correspondientes a personas que requieren servicios de transporte y una a una transportista. Los participantes destacaron aspectos positivos relacionados con la organización visual de LoadMatch, la facilidad para publicar solicitudes y la utilidad potencial de centralizar la gestión de servicios logísticos. Sin embargo, también identificaron oportunidades de mejora relacionadas con la verificación de usuarios, las condiciones especiales de transporte, la recuperación de información ante fallos de conexión, la claridad de las condiciones comerciales y el seguimiento de las cargas.

Los hallazgos obtenidos durante las entrevistas constituyeron la base para una evaluación preliminar de la experiencia de usuario según principios de usabilidad, arquitectura de información y diseño inclusivo. Este análisis permitió reconocer la importancia de ofrecer información clara, prevenir errores y fortalecer la confianza entre los participantes de una operación logística. Asimismo, evidenció que el desarrollo de una solución funcional debe complementarse con actividades de validación continua para responder adecuadamente a las necesidades de los usuarios.

En relación con el trabajo colaborativo, el equipo utilizó GitHub, Jira y Microsoft Teams para organizar responsabilidades, coordinar actividades y mantener la trazabilidad de los avances. El uso de ramas por funcionalidad, Pull Requests y revisiones de integración contribuyó a distribuir el trabajo entre los integrantes y gestionar las dependencias existentes entre los módulos del sistema. Las actividades del Sprint 3 permitieron fortalecer competencias vinculadas con el desarrollo de servicios backend, la integración de aplicaciones, el despliegue de software y la colaboración en proyectos de ingeniería de software.

Finalmente, el desarrollo de LoadMatch durante el ciclo académico 2026-2 permitió aplicar de manera progresiva las distintas etapas de un proyecto de software, desde la investigación de necesidades y el diseño inicial hasta la implementación, integración, despliegue y validación de la solución. Aunque el producto todavía presenta oportunidades de mejora y funcionalidades pendientes de evolución, los incrementos desarrollados constituyen una base técnica y funcional para continuar fortaleciendo la plataforma y su propuesta de valor.

# Recomendaciones

A partir de los resultados obtenidos durante el desarrollo de LoadMatch, se plantean las siguientes recomendaciones para futuras iteraciones del producto:

1. **Fortalecer los mecanismos de confianza y verificación.** Ampliar la información disponible sobre empresas y transportistas, incorporando mecanismos claros de validación de identidad, documentación y reputación que permitan reducir la incertidumbre durante la contratación de servicios.

2. **Mejorar la gestión de cargas especiales.** Incorporar categorías y campos que permitan especificar condiciones particulares de transporte, como mercancía frágil, alimentos delicados, restricciones de manipulación y requerimientos especiales del vehículo.

3. **Ampliar las funcionalidades de seguimiento.** Evaluar la integración de mapas interactivos, información de ubicación y estimaciones de llegada para ofrecer mayor visibilidad sobre el recorrido y el estado de los envíos.

4. **Optimizar la recuperación ante errores de conexión.** Considerar mecanismos de guardado temporal de formularios, recuperación de borradores y mensajes de error comprensibles que permitan mantener la continuidad de las operaciones.

5. **Incrementar la cobertura de pruebas y validación.** Realizar pruebas funcionales, de integración y de experiencia de usuario con una muestra más amplia de participantes, especialmente del segmento Carriers, para comprobar la confiabilidad de los servicios y validar las mejoras propuestas.

6. **Continuar mejorando la arquitectura y el despliegue.** Mantener la separación de responsabilidades entre frontend, backend y persistencia de datos, complementándola progresivamente con pruebas automatizadas, monitoreo y mecanismos de integración y despliegue continuo.

7. **Mantener las prácticas de trabajo colaborativo.** Continuar utilizando GitFlow, Pull Requests, Jira y reuniones de seguimiento, procurando que las tareas cuenten con responsables, estimaciones y criterios de aceptación claramente establecidos.

Estas recomendaciones buscan orientar la evolución de LoadMatch hacia una solución más confiable, accesible y alineada con las necesidades de sus segmentos objetivo.

# Video About-the-Team

Como parte de la presentación final del proyecto, el equipo **CargoLink Labs** elaboró el video *About-the-Team*, en el que se presenta una retrospectiva del proceso de desarrollo de LoadMatch durante el ciclo académico 2026-2.

El material audiovisual reúne una narración en voz en off acompañada de evidencias del trabajo colaborativo, incluyendo actividades de planificación, coordinación mediante Microsoft Teams, organización de sprints y gestión de cambios a través de GitHub.

Asimismo, el video incorpora testimonios individuales de los cinco integrantes del equipo, quienes comparten sus principales contribuciones, desafíos y aprendizajes durante el desarrollo del proyecto.

El objetivo de este material es presentar la experiencia de colaboración de CargoLink Labs y reflexionar sobre las competencias técnicas y profesionales fortalecidas durante la implementación de LoadMatch.

## Información del video

| Campo | Información |
|---|---|
| Título | LoadMatch — About the Team |
| Startup | CargoLink Labs |
| Proyecto | LoadMatch |
| Periodo académico | UPC 2026-2 |
| Duración | 9 minutos y 46 segundos |
| Plataforma | YouTube y Microsoft Stream |
| YouTube | [Ver About-the-Team](https://youtu.be/CdHa-KjOC9o) |
| Microsoft Stream | [Ver About-the-Team](https://upcedupe-my.sharepoint.com/:v:/g/personal/u201823468_upc_edu_pe/IQDoN4oHT31tR7PuLh3cFiMpAZlybMLIPaC76_2MyweXqH4?nav=eyJyZWZlcnJhbEluZm8iOnsicmVmZXJyYWxBcHAiOiJPbmVEcml2ZUZvckJ1c2luZXNzIiwicmVmZXJyYWxBcHBQbGF0Zm9ybSI6IldlYiIsInJlZmVycmFsTW9kZSI6IldlYiIsInJlZmVycmFsTW9kZSI6InZpZXciLCJyZWZlcnJhbFZpZXciOiJNeUZpbGVzTGlua0NvcHkifX0&e=dVGCCi) |

**Evidencia audiovisual:**

[![LoadMatch — About the Team](https://img.youtube.com/vi/CdHa-KjOC9o/hqdefault.jpg)](https://youtu.be/CdHa-KjOC9o)

**Integrantes participantes:**

- Harold Fauskorp Benigno Montero.
- Jean Fabio Noriega Collado.
- Marco Antonio Collantes Artola.
- Christoper Steven Rivas Castillo.
- Ismael Sebastian Simon Calderon.

El video permite complementar la documentación técnica del proyecto mediante una perspectiva del proceso de colaboración, la organización del trabajo y la experiencia de los integrantes durante el desarrollo de LoadMatch.
