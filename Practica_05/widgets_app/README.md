# Práctica 05 – Widgets App

Aplicación móvil desarrollada con Flutter y Dart para explorar e implementar componentes interactivos de Material Design 3, navegación declarativa y gestión reactiva del estado.

**Datos de la alumna:**

- **Nombre:** Brisa Nallely García Gregorio
- **Matrícula:** 230362
- **Identificador:** BNGG

---

## Descripción

Widgets App reúne ejemplos interactivos de widgets de Material Design 3 en módulos navegables. Incluye botones, tarjetas, indicadores de progreso, controles, animaciones, un tutorial, una lista con carga progresiva y pantallas para experimentar con estado y temas.

La aplicación utiliza GoRouter para la navegación, Riverpod para el contador y la configuración del tema, y Animate Do en algunas transiciones.

## Objetivo

Practicar el desarrollo de interfaces móviles con Flutter mediante la implementación de componentes Material 3, navegación entre pantallas con GoRouter, gestión reactiva del estado con Riverpod y animaciones. La aplicación permite observar y probar estos conceptos en ejemplos funcionales.

## Tecnologías utilizadas

Las dependencias y versiones indicadas corresponden a `pubspec.yaml`.

| Tecnología o dependencia | Versión / configuración | Uso |
|---|---|---|
| Flutter | SDK | Framework de la aplicación |
| Dart | `^3.13.3` | Lenguaje y restricción del SDK |
| Material Design 3 | `useMaterial3: true` | Sistema visual configurado en el tema |
| `go_router` | `^18.0.2` | Navegación declarativa |
| `flutter_riverpod` | `^2.6.1` | Estado del contador y tema |
| `animate_do` | `^5.1.0` | Animaciones de entrada |
| `cupertino_icons` | `^1.0.8` | Iconos Cupertino |
| `flutter_test` | SDK de Flutter | Pruebas |
| `flutter_lints` | `^6.0.0` | Reglas de análisis para Dart |

## Estructura del proyecto

```text
widgets_app/
├── architecture/
│   └── index.html
├── imagenes/                         # Capturas de pantalla disponibles
├── lib/
│   ├── assets/
│   │   └── images/                   # Imágenes del tutorial y GIF de carga
│   ├── config/
│   │   ├── menu/
│   │   ├── router/
│   │   └── theme/
│   ├── presentation/
│   │   ├── providers/
│   │   ├── screens/
│   │   └── widgets/
│   └── main.dart
├── test/
│   └── widget_test.dart
├── pubspec.yaml
└── pubspec.lock
```

---

## Capturas de pantalla de la aplicación

Las 11 capturas reales de `imagenes/` están distribuidas en celdas individuales. Cada imagen usa el mismo ancho para mantener la galería ordenada.

<table>
  <thead>
    <tr>
      <th colspan="3">Galería de evidencias</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td align="center"><img src="./imagenes/WhatsApp%20Image%202026-10-30%20at%2012.17.44%20PM.jpeg" alt="Pantalla principal de Widgets App" width="145"><br><sub>Inicio y navegación</sub></td>
      <td align="center"><img src="./imagenes/WhatsApp%20Image%202026-10-30%20at%2012.17.45%20PM.jpeg" alt="Pantalla de botones" width="145"><br><sub>Botones</sub></td>
      <td align="center"><img src="./imagenes/WhatsApp%20Image%202026-10-30%20at%2012.17.45%20PM%20%281%29.jpeg" alt="Pantalla de tarjetas" width="145"><br><sub>Tarjetas</sub></td>
    </tr>
    <tr>
      <td align="center"><img src="./imagenes/WhatsApp%20Image%202026-10-30%20at%2012.17.45%20PM%20%282%29.jpeg" alt="Indicadores de progreso" width="145"><br><sub>Indicadores de progreso</sub></td>
      <td align="center"><img src="./imagenes/WhatsApp%20Image%202026-10-30%20at%2012.17.45%20PM%20%283%29.jpeg" alt="Snackbars y diálogos" width="145"><br><sub>Snackbars y diálogos</sub></td>
      <td align="center"><img src="./imagenes/WhatsApp%20Image%202026-10-30%20at%2012.17.45%20PM%20%284%29.jpeg" alt="Contenedor animado" width="145"><br><sub>Animaciones</sub></td>
    </tr>
    <tr>
      <td align="center"><img src="./imagenes/WhatsApp%20Image%202026-10-30%20at%2012.17.45%20PM%20%285%29.jpeg" alt="Controles interactivos" width="145"><br><sub>Controles interactivos</sub></td>
      <td align="center"><img src="./imagenes/WhatsApp%20Image%202026-10-30%20at%2012.17.45%20PM%20%286%29.jpeg" alt="Tutorial introductorio" width="145"><br><sub>Tutorial</sub></td>
      <td align="center"><img src="./imagenes/WhatsApp%20Image%202026-10-30%20at%2012.17.44%20PM%20%281%29.jpeg" alt="Contador con Riverpod" width="145"><br><sub>Contador con Riverpod</sub></td>
    </tr>
    <tr>
      <td align="center"><img src="./imagenes/WhatsApp%20Image%202026-10-30%20at%2012.17.45%20PM%20%287%29.jpeg" alt="Selector de colores y tema claro" width="145"><br><sub>Selector de colores y modo claro</sub></td>
      <td align="center" colspan="2"><img src="./imagenes/WhatsApp%20Image%202026-10-30%20at%2012.17.46%20PM.jpeg" alt="Selector de colores y tema oscuro" width="145"><br><sub>Selector de colores y modo oscuro</sub></td>
    </tr>
  </tbody>
</table>

La carpeta `imagenes/` no contiene capturas independientes del menú desplegado ni de la pantalla de desplazamiento infinito; por eso no se muestran evidencias de esas vistas.

---

## Arquitectura de software

La aplicación está organizada por responsabilidades:

- **Configuración:** define el menú, el tema y las rutas de navegación.
- **Navegación:** GoRouter conecta la ruta inicial con las pantallas de la aplicación.
- **Presentación:** contiene las pantallas de inicio, botones, tarjetas, controles, animaciones, tutorial y demás demostraciones, además de widgets reutilizables.
- **Gestión del estado:** Riverpod administra el contador y los cambios de tema y color.
- **Recursos:** `lib/assets/images/` contiene las imágenes locales del tutorial y el GIF de carga; `imagenes/` contiene las capturas de evidencia.

## Diagrama interactivo de arquitectura

El archivo HTML está disponible en el proyecto como [`architecture/index.html`](./architecture/index.html).

### Diagrama de Arquitectura 

[Ver diagrama interactivo de Widgets App](https://brisgregorio.github.io/Practicas_DMI_230362_BNGG/Practica_05/widgets_app/architecture/index.html)

La ruta se construyó con el repositorio `Brisgregorio/Practicas_DMI_230362_BNGG` y la ubicación real del archivo. Al verificarla, GitHub Pages respondió **404**; el enlace queda preparado, pero requiere habilitar y publicar el sitio con esta estructura.

## Instalación y ejecución

Se requiere Flutter instalado, un dispositivo o emulador disponible y Dart compatible con la restricción `^3.13.3` declarada en `pubspec.yaml`. Algunas demostraciones cargan imágenes remotas y requieren conexión a Internet.

Desde la raíz del repositorio, abre una terminal en la carpeta de la aplicación y ejecuta:

```bash
cd Practica_05/widgets_app
flutter pub get
flutter run
```

## Funcionalidades implementadas

- Pantalla principal con catálogo de módulos y navegación mediante GoRouter.
- Demostración de botones Material y acciones táctiles.
- Tarjetas con distintos niveles de elevación y estilos.
- Indicadores circulares y lineales de progreso.
- Notificaciones SnackBar, diálogos y cuadro de información.
- Contenedor animado con cambios de tamaño, color y forma.
- Controles interactivos: switch, opciones de transporte, casillas y panel desplegable.
- Tutorial introductorio con páginas e imágenes locales.
- Lista de imágenes remotas con carga progresiva y actualización por gesto.
- Contador reactivo con Riverpod.
- Selector de color y alternancia entre tema claro y oscuro.

## Conclusión

El desarrollo de Widgets App permitió integrar componentes de Material Design 3 en una aplicación modular y practicar navegación declarativa, gestión reactiva del estado y animaciones. La práctica también reforzó la organización de recursos y la documentación de un proyecto Flutter mediante evidencias reales.
