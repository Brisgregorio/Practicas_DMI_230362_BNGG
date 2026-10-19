# Documentación técnica de TokTik

Esta guía amplía el resumen del [README principal](README.md) con la organización observada en el código, las dependencias, la configuración Android, las pruebas disponibles y las limitaciones comprobadas.

## Estructura del proyecto

~~~text
tok_tik/
├── android/                 Configuración Android, Activity, receptor e iconos
├── appetize/                Instrucciones para la demo y capturas de Appetize
│   └── imagenes/            Siete capturas originales de la aplicación
├── architecture/            Diagramas PNG, HTML y JSON
├── assets/
│   ├── images/              Logotipos y recursos visuales de temporada
│   └── sounds/              Audio de bienvenida y sonidos estacionales
├── lib/
│   ├── config/              Tema, temporada y formato de métricas
│   ├── domain/              Entidad VideoPost y contratos
│   ├── infrastructure/      Datasources, modelos, repositorio y almacenamiento
│   ├── presentation/        Provider, pantallas y widgets
│   └── shared/              Datos estáticos de publicaciones locales
├── test/                    Pruebas de widget y unitarias
├── pubspec.yaml             SDK, paquetes y recursos Flutter
└── README.md                Presentación y evidencias de la práctica
~~~

La carpeta **assets/videos/** está declarada en pubspec.yaml y se referencia desde los posts locales, pero no existe en el checkout revisado. No se añadieron archivos ni una carpeta vacía para esta documentación.

## Organización del código

### Inicio de la aplicación

**lib/main.dart** inicializa el almacenamiento local, determina la temporada, solicita sincronizar el icono nativo y registra un DiscoverProvider con tres repositorios:

- **Para ti:** CloudinaryVideoDatasource.
- **Cerca de ti:** PixabayVideoDatasource.
- **Descubrir:** PexelsVideoDatasource.

### Presentación

- **presentation/providers/discover_provider.dart** mantiene las listas de videos, favoritos, estados de carga, refresco y paginación; delega la obtención de publicaciones en repositorios.
- **presentation/screens/splash/** presenta la bienvenida antes de navegar al contenido.
- **presentation/screens/discover/** implementa el selector de temporada, las cuatro páginas y el gesto de navegación horizontal entre secciones.
- **presentation/widgets/video/** contiene el reproductor a pantalla completa y su fondo visual.
- **presentation/widgets/shared/** reúne el feed vertical, los controles y la navegación inferior.
- **presentation/widgets/favorites/** muestra la lista de favoritos persistidos.

### Dominio

- **domain/entities/video_post.dart** define la publicación de video y su serialización.
- **domain/datasources/video_posts_datasource.dart** y **domain/repositories/video_posts_repository.dart** declaran contratos para las fuentes y el repositorio.

### Infraestructura

- **infrastructure/datasources/** contiene las fuentes Cloudinary, Pixabay y Pexels, el datasource local y LocalStorageService.
- **infrastructure/models/local_video_model.dart** convierte los mapas de publicaciones locales en entidades.
- **infrastructure/repositories/video_posts_repository_impl.dart** delega la carga a un datasource.
- **LocalStorageService** usa SharedPreferences y una caché en memoria para favoritos y videos vistos.

La implementación principal usa datos remotos. Cloudinary entrega un catálogo de URLs de demostración. Pixabay y Pexels permiten consultar sus endpoints si se les proporciona una clave; su argumento apiKey tiene valor inicial vacío y main.dart no les pasa claves, por lo que la configuración actual devuelve los catálogos estáticos de ejemplo. El datasource local y los ocho posts locales existen en código, pero no son los repositorios registrados en main.dart.

### Configuración y recursos

- **config/theme/** define los cuatro temas y selecciona una temporada automáticamente según la fecha; permite también elegirla desde la interfaz.
- **config/helpers/** contiene el cálculo aleatorio de métricas y el formato abreviado de números.
- **android/app/** integra MainActivity, DateChangeReceiver y aliases de icono estacionales.
- **assets/images/** contiene cinco imágenes; **assets/sounds/** contiene cuatro MP3. Ambos grupos están declarados en pubspec.yaml.
- **architecture/** incluye dos diagramas de arquitectura en PNG y sus fuentes HTML/JSON. El diagrama de Provider local representa una propuesta inicial; el diagrama Clean Code describe la separación usada en la app.

## Dependencias principales

| Paquete | Responsabilidad en el código |
|---|---|
| provider | Inyección de estado reactivo con ChangeNotifierProvider |
| video_player | Control y reproducción de videos locales o de red |
| audioplayers | Reproducción de los sonidos declarados |
| dio | Cliente HTTP para los datasources remotos |
| shared_preferences | Persistencia local de favoritos e historial |
| animate_do | Transiciones de la pantalla de bienvenida |
| intl | Formateo internacionalizado |
| cupertino_icons | Iconografía complementaria |

Flutter y flutter_test provienen del SDK. flutter_lints está en dependencias de desarrollo. Las versiones están fijadas por **pubspec.yaml** y **pubspec.lock**.

## Instalación, ejecución y Android

Desde la raíz del repositorio:

~~~powershell
cd Practica_04/tok_tik
flutter pub get
flutter run
~~~

Para compilar Android en modo debug:

~~~powershell
flutter build apk --debug
~~~

La configuración inspeccionada usa JDK 17, Android Gradle Plugin 9.1.0, Kotlin 2.4.0 y Gradle 9.3.1. El identificador Android definido es **com.example.tok_tik**. Consulta [appetize/INSTRUCCIONES.md](appetize/INSTRUCCIONES.md) para subir y compartir un APK de demostración.

## Pruebas y evidencias

**test/widget_test.dart** contiene cuatro casos: renderizado del tema, límites de métricas generadas, serialización de VideoPost y operaciones de favoritos/videos vistos. La existencia del código de prueba no indica que se haya ejecutado ni aprobado en esta actualización.

El [README](README.md#evidencias-de-funcionamiento) inserta las siete capturas existentes de **appetize/imagenes/**, con descripciones asociadas a su contenido:

1. Captura de pantalla 2026-10-19 130343.png — feed Para ti y reproducción.
2. Captura de pantalla 2026-10-19 130356.png — selector de temporada, Halloween.
3. Captura de pantalla 2026-10-19 130407.png — tema San Valentín.
4. Captura de pantalla 2026-10-19 130427.png — confirmación de silencio.
5. Captura de pantalla 2026-10-19 130436.png — me gusta y contadores.
6. Captura de pantalla 2026-10-19 130446.png — publicación en Favoritos.
7. Captura de pantalla 2026-10-19 130513.png — accesos TokTik en el lanzador Android.

La evidencia visual muestra una sesión de Appetize.io con Pixel 7 y Android 13. No demuestra por sí sola que todos los flujos funcionen en cualquier dispositivo o que la demo siga accesible.

## Limitaciones conocidas

- Los MP4 locales declarados no están en el checkout ni se empaquetaron. Los posts locales hacen referencia a **assets/videos/1.mp4** hasta **assets/videos/8.mp4**.
- Los feeds iniciales de la app son remotos. La reproducción requiere conectividad y disponibilidad de las URLs configuradas en los catálogos de ejemplo.
- Pixabay y Pexels tienen modo de consulta con API key opcional, pero la inicialización actual no proporciona esas claves.
- El enlace de Appetize puede depender de permisos, sesión y disponibilidad del build.
- No se ejecutaron pruebas automatizadas ni una sesión de Appetize como parte de esta actualización documental.

## Grabaciones complementarias enlazadas previamente

Se conservaron como enlaces simples las dos grabaciones que ya referenciaba el README anterior. El acceso depende de los permisos de Google Drive:

- [Video de iconos y temas estacionales](https://drive.google.com/file/d/1pktKYKD_96SOT14M8g2yRO8dK22xWaOl/view?usp=drive_link)
- [Video de funcionamiento de la aplicación](https://drive.google.com/file/d/1LMcr7uFxUAw2bBKPkDPzLeyVZGv8ncGF/view?usp=drive_link)

## Referencias del repositorio

- [Diagrama de arquitectura Clean Code (PNG)](architecture/diagrama_clean_code.png)
- [Fuente HTML del diagrama Clean Code](architecture/diagrama_clean_code.html)
- [Diagrama inicial con Provider local (PNG)](architecture/diagrama_provider_local.png)
- [Fuente HTML del diagrama inicial](architecture/diagrama_provider_local.html)
- [Instrucciones de Appetize.io](appetize/INSTRUCCIONES.md)
- [README de Appetize.io](appetize/README.md)