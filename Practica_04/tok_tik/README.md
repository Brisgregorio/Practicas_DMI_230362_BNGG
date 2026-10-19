# Práctica 04: TokTik - Clon de TikTok con Clean Architecture



**Materia:** Desarrollo Móvil Integral (DMI)  

**Estudiante:** Bruno Gregorio (230362)  

**Proyecto:** TokTik App  

**Framework:** Flutter (Dart)  

**Plataformas Soportadas:** Android, iOS, Web, Windows, macOS, Linux  



---



## Evidencias de Funcionamiento

Los siguientes videos muestran el funcionamiento de TokTik y la sincronización de los iconos según la temporada. Puedes reproducirlos desde la vista previa o abrirlos directamente en Google Drive.

### 1. Video de iconos y temas estacionales

<p align="center">
  <a href="https://drive.google.com/file/d/1pktKYKD_96SOT14M8g2yRO8dK22xWaOl/view?usp=drive_link">Abrir video de iconos en Google Drive</a>
</p>

<div align="center">
  <iframe src="https://drive.google.com/file/d/1pktKYKD_96SOT14M8g2yRO8dK22xWaOl/preview" width="640" height="360" allow="autoplay" allowfullscreen></iframe>
</div>

### 2. Video de funcionamiento de la aplicación

<p align="center">
  <a href="https://drive.google.com/file/d/1LMcr7uFxUAw2bBKPkDPzLeyVZGv8ncGF/view?usp=drive_link">Abrir video de la aplicación en Google Drive</a>
</p>

<div align="center">
  <iframe src="https://drive.google.com/file/d/1LMcr7uFxUAw2bBKPkDPzLeyVZGv8ncGF/preview" width="640" height="360" allow="autoplay" allowfullscreen></iframe>
</div>

> **Nota:** Las vistas previas de Google Drive mediante `iframe` pueden no mostrarse dentro de un README alojado en GitHub, porque GitHub restringe ciertos elementos HTML. En ese caso, los enlaces anteriores permiten abrir cada video directamente en Drive. Para que el reproductor aparezca integrado de forma fiable en GitHub, será necesario alojar los archivos de video en un servicio compatible con la reproducción incrustada o adjuntarlos en una plataforma de GitHub que admita videos.

---



## 1. Descripción de la Práctica



Esta práctica consiste en el desarrollo de una aplicación móvil que simula las funcionalidades clave de la red social **TikTok**, centrada en la reproducción continua de videos verticales (formato 9:16) con desplazamiento fluido (*swipe* vertical), navegación lateral entre secciones temáticas, reproducción multimedia con control de audio interactivo, gestión reactiva del estado mediante **Provider**, y persistencia local de datos (*Local Storage*) con `SharedPreferences`.



El proyecto fue desarrollado aplicando estrictamente los principios de **Clean Code** y **Clean Architecture**, dividiendo la solución en capas desacopladas (*Domain*, *Infrastructure*, *Presentation* y *Shared*), integrando **3 APIs/Datasources externos independientes** y garantizando un diseño limpio sin emojis en la interfaz.



---



## 2. Diagramas de Arquitectura (Codex & Archify)



Los siguientes diagramas han sido diseñados con las herramientas **Codex** y **Archify**, estructurados para su visualización tanto en GitHub como en **GitHub Pages**.



---



### Diagrama 1: Arquitectura con Provider Local (Esquema Inicial / Acoplado)



En este modelo elemental, la capa de presentación y el `DiscoverProvider` dependen directamente de una fuente de datos estática local sin abstracción de repositorio ni inversión de dependencias:



#### Enlaces al Diagrama:

- **[Ver Diagrama Interactivo en GitHub Pages](https\://brisgregorio.github.io/Practicas_DMI_230362_BNGG/Practica_04/tok_tik/architecture/diagrama_provider_local.html)**

- **[Ver Archivo Fuente en GitHub](https\://github.com/Brisgregorio/Practicas_DMI_230362_BNGG/blob/main/Practica_04/tok_tik/architecture/diagrama_provider_local.html)**



<p align="center">

  <img *src*="architecture/diagrama_provider_local.png" *alt*="Diagrama 1 - Arquitectura Provider Local" *width*="850">

</p>



#### Descripción Técnica del Diagrama 1:

- **Flujo de Datos:** El `DiscoverProvider` accede de manera directa a la fuente de datos local `local_video_posts.dart` mediante el modelo `LocalVideoModel`.

- **Acoplamiento:** No existe una capa de dominio intermedia. Si se cambia la fuente de datos o la estructura de los videos, el Provider y la UI se ven afectados directamente.

- **Manejo de Estado:** Centralizado en un único Provider que notifica a las vistas mediante `notifyListeners()`.



---



### Diagrama 2: Arquitectura Clean Code con Provider, Repositorio y Múltiples Datasources (Implementación Oficial)



En esta arquitectura profesional, el **Provider** interactúa exclusivamente con el **Dominio** mediante contratos abstractos (`VideoPostRepository`). La infraestructura implementa dichos contratos y conecta **3 APIs/Datasources externos** independientes junto con el servicio de **Local Storage**:



#### Enlaces al Diagrama:

- **[Ver Diagrama Interactivo en GitHub Pages](https\://brisgregorio.github.io/Practicas_DMI_230362_BNGG/Practica_04/tok_tik/architecture/diagrama_clean_code.html)**

- **[Ver Archivo Fuente en GitHub](https\://github.com/Brisgregorio/Practicas_DMI_230362_BNGG/blob/main/Practica_04/tok_tik/architecture/diagrama_clean_code.html)**



<p align="center">

  <img *src*="architecture/diagrama_clean_code.png" *alt*="Diagrama 2 - Arquitectura Clean Code con Múltiples Datasources" *width*="850">

</p>



#### Descripción Técnica del Diagrama 2:

- **Inversión de Dependencias (DIP):** La capa de presentación no conoce las implementaciones concretas de las APIs. Solo conoce la interfaz abstracta `VideoPostRepository` del Dominio.

- **Desacoplamiento de Fuentes:** Cada una de las 3 secciones se conecta a un datasource independiente:

  1. **Cloudinary CDN (`CloudinaryVideoDatasource`):** Sección *"Para ti"*, videos verticales con pista de audio real y sonido estéreo activo.

  2. **Pixabay CDN (`PixabayVideoDatasource`):** Sección *"Cerca de ti"*, videos sobre vida urbana, cafeterías y comunidad local.

  3. **Pexels CDN (`PexelsVideoDatasource`):** Sección *"Descubrir"*, videos de tendencias, movimiento, patinaje y estilo de vida.

- **Local Storage Desacoplado (`LocalStorageService`):** Persiste el historial de videos vistos y la lista de videos favoritos mediante `SharedPreferences` con caché en memoria.



---



## 3. Matriz de Cumplimiento de Requerimientos



| # | Requerimiento de la Práctica | Estado | Detalle de Implementación / Archivos |

|---|-----------------------------|:------:|--------------------------------------|

| **1** | **Widgets Stateless y Stateful** | Cumplido | `DiscoverScreen` (Stateful), `FullScreenPlayer` (Stateful), `VideoButtons` (Stateful), `SeasonalBottomNavigation` (Stateless), `VideoBackground` (Stateless), `FavoritesView` (Stateless). |

| **2** | **Gestión de Estado con Provider** | Cumplido | `DiscoverProvider` maneja de forma reactiva las 4 secciones (`forYouVideos`, `nearYouVideos`, `discoverVideos`, `favoriteVideos`), la paginación infinita y el estado de refresco. |

| **3** | **Manejo de Assets** | Cumplido | Videos MP4 en `assets/videos/`, logotipos estacionales en `assets/images/`, y audios festivos en `assets/sounds/` registrados en `pubspec.yaml`. |

| **4** | **Paquetes Externos** | Cumplido | `video_player`, `audioplayers`, `provider`, `shared_preferences`, `dio`, `animate_do` e `intl`. |

| **5** | **GestureDetector** | Cumplido | Control táctil para: Play/Pause, dar like, mutear/desmutear en el disco vinilo, expandir descripción con `( ... más )`, y selector de temporadas. |

| **6** | **Posicionamiento de Widgets** | Cumplido | `Positioned` dentro de `Stack`, `Align`, `FittedBox` con `BoxFit.cover` para pantalla completa inmersiva sin bordes negros. |

| **7** | **Mappers y Modelos** | Cumplido | `LocalVideoModel` convierte mapas a entidades `VideoPost`, con serializadores `VideoPost.fromJson` y `toJson`. |

| **8** | **Gradientes** | Cumplido | `VideoBackground` con `LinearGradient` vertical oscuro para contraste de textos; `_RotatingDiscButton` con `RadialGradient` para el disco vinilo. |

| **9** | **Loops** | Cumplido | `controller.setLooping(true)`, animación rotatoria infinita en disco de vinilo, y mapeo de colecciones de datos. |

| **10** | **Aserciones y Lógica Coherente** | Cumplido | `RandomVideoMetrics` asegura estrictamente que `likes <= views < 1000` con pruebas unitarias automatizadas. |

| **11** | **Stacks** | Cumplido | Superposición de capas: VideoPlayer base, gradiente protector, icono central de pausa/mute, botones laterales y textos inferiores. |

| **12** | **Controladores de Video** | Cumplido | `VideoPlayerController` inicializado de forma asíncrona una sola vez en `initState()` evitando fugas de memoria y eliminando pantallas de carga al pausar. |

| **13** | **Temas Visuales y Auditivos por Temporada** | Cumplido | `SeasonConfig` detecta fecha (Halloween, Navidad, San Valentín, Normal). Incluye modal interactivo para probar temporadas, audio estacional y sincronización del icono de la app en Android con `syncAppIcon()`. |

| **14** | **Secciones Discover / For You / Favorites** | Cumplido | 4 secciones con navegación lateral por gestos (*swipe*) y barra inferior. Cada sección conectada a su respectivo datasource / local storage. |

| **15** | **Función Mute / Unmute con Icono en Columna** | Cumplido | Disco vinilo en `VideoButtons`. Al tocarlo: silencia (`volume = 0.0`), detiene giro, muestra badge rojo y notifica *"Audio silenciado"*. Al volver a tocarlo: reactiva sonido (`volume = 1.0`), reanuda giro y notifica *"Audio activado"*. |

| **16** | **Persistencia de Me Gustas (Local Storage)** | Cumplido | Al dar tap al corazón: suma 1 me gusta y persiste en `SharedPreferences` con `LocalStorageService`. Al desmarcarlo: resta 1 me gusta y actualiza. Los datos persisten al cerrar y reabrir la app. |

| **17** | **Descripción Extensa con `( ... más )` y Scroll Vertical** | Cumplido | Si la descripción excede 2 líneas, muestra ` ( ... más )`. Al tocarlo, se despliega verticalmente dentro de un contenedor con scroll (`SingleChildScrollView`) limitado a 110px para leer el texto completo sin tapar controles, con opción `( ... menos )`. |

| **18** | **Consumo de 3 Datasources Diferentes (APIs)** | Cumplido | 3 datasources desacoplados respetando Clean Code: Cloudinary (audio activo en "Para ti"), Pixabay (vida urbana/comunidad en "Cerca de ti"), y Pexels (tendencias/lifestyle en "Descubrir"). |

| **19** | **Scroll Continuo (10+ Scrolls y Paginación Infinita)** | Cumplido | Cada sección arranca con 12 videos verificados para scroll inmediato, y al acercarse al final (`index >= length - 3`), `VideoScrollableView` carga más videos dinámicamente. |

| **20** | **Función de Actualización del Feed (Refresh)** | Cumplido | Implementado vía *Pull-to-refresh* (`RefreshIndicator`) y botón dedicado de refresco en el encabezado superior con aviso flotante en pantalla. |

| **21** | **Regla del Primer Video (0 Likes y 0 Vistas)** | Cumplido | Al abrir la app en cualquier sección (excepto favoritos), el primer video (`index == 0`) se presenta siempre con 0 likes y 0 vistas, protegiendo los registros del Local Storage. |

| **22** | **Interfaz Libre de Emojis** | Cumplido | Todos los textos, etiquetas de sección, notificaciones flotantes y descripciones se encuentran completamente limpios de caracteres emoji. |



---



## 4. Estructura del Proyecto



```text

tok_tik/

├── android/                         # Configuracion nativa Android e iconos de temporada

├── assets/

│   ├── images/                      # Logotipos estacionales (Halloween, Navidad, San Valentin, Normal)

│   ├── sounds/                      # Efectos sonoros festivos

│   └── videos/                      # Videos MP4 de respaldo local

├── architecture/                    # Diagramas generados con Codex y Archify

│   ├── diagrama_provider_local.html # Diagrama interactivo de Provider Local (GitHub Pages)

│   ├── diagrama_provider_local.png  # Render PNG de alta resolucion

│   ├── diagrama_clean_code.html     # Diagrama interactivo Clean Code (GitHub Pages)

│   └── diagrama_clean_code.png      # Render PNG de alta resolucion

├── lib/

│   ├── config/

│   │   ├── helpers/

│   │   │   ├── human_formats.dart        # Formato de numeros legibles (ej: 1.2K, 3.4M)

│   │   │   └── random_video_metrics.dart # Generador aleatorio coherente (likes <= views < 1000)

│   │   └── theme/

│   │       ├── app_theme.dart            # Paleta de colores Dark Mode

│   │       └── season_config.dart        # Motor de temporadas, festividades y cambio de icono

│   ├── domain/

│   │   ├── datasources/

│   │   │   └── video_posts_datasource.dart # Contrato de fuentes de datos

│   │   ├── entities/

│   │   │   └── video_post.dart             # Entidad pura con userName, description y likes

│   │   └── repositories/

│   │       └── video_posts_repository.dart # Contrato de repositorio

│   ├── infrastructure/

│   │   ├── datasources/

│   │   │   ├── cloudinary_video_datasource_impl.dart # API 1: Para ti (con audio real)

│   │   │   ├── pixabay_video_datasource_impl.dart    # API 2: Cerca de ti (urbano/local)

│   │   │   ├── pexels_video_datasource_impl.dart     # API 3: Descubrir (tendencias)

│   │   │   └── local_storage_service.dart            # Persistencia en SharedPreferences

│   │   ├── models/

│   │   │   └── local_video_model.dart                # Mapper de datos locales

│   │   └── repositories/

│   │       └── video_posts_repository_impl.dart      # Implementacion del repositorio

│   ├── presentation/

│   │   ├── providers/

│   │   │   └── discover_provider.dart    # Gestor de estado reactivo y feeds

│   │   ├── screens/

│   │   │   ├── discover/

│   │   │   │   └── discover_screen.dart  # Pantalla principal con PageView horizontal

│   │   │   └── splash/

│   │   │       └── splash_screen.dart    # Pantalla de carga con audio de bienvenida

│   │   └── widgets/

│   │       ├── favorites/

│   │       │   └── favorites_view\.dart   # Feed de favoritos o estado vacio festivo

│   │       ├── shared/

│   │       │   ├── seasonal_bottom_navigation.dart # Menu inferior estilizado

│   │       │   ├── video_buttons.dart              # Corazon, vistas y disco de mute

│   │       │   └── video_scrollable_view\.dart      # Scroll vertical con paginacion

│   │       └── video/

│   │           ├── fullscreen_player.dart          # Reproductor inmersivo con '( ... mas )'

│   │           └── video_background.dart           # Gradiente oscuro para legibilidad

│   └── main.dart                        # Punto de entrada e inicializacion de servicios

├── test/

│   └── widget_test.dart                 # Pruebas unitarias automatizadas

└── pubspec.yaml                         # Dependencias y configuracion de assets

```



---



## 5. Guía de Ejecución y Pruebas



```bash

*# 1. Instalar dependencias*

flutter pub get



*# 2. Analisis estatico de codigo (0 advertencias)*

flutter analyze



*# 3. Ejecutar pruebas unitarias automatizadas (4/4 suites aprobadas)*

flutter test



*# 4. Compilar APK en modo Debug*

flutter build apk --debug



*# 5. Ejecutar la aplicacion*

flutter run

```
