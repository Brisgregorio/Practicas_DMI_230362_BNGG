# Práctica 04 – TokTik

**TokTik** es una aplicación móvil de videos verticales desarrollada con Flutter. Su interfaz organiza publicaciones en feeds temáticos, permite interactuar con ellas y adapta su presentación a temporadas del año.

| Dato | Información |
|---|---|
| Materia | Desarrollo Móvil Integral (DMI) |
| Estudiante | Bruno Gregorio (230362) |
| Carrera | Ingeniería en Desarrollo y Gestión de Software |
| Docente | MTI Marco A. Ramírez Hernández |
| Periodo | Septiembre–diciembre de 2026 |
## Descripción y objetivo académico

La práctica consiste en construir una experiencia móvil de reproducción de videos breves y explorar, mediante Flutter y Dart, la composición de interfaces, la gestión reactiva del estado, la separación de responsabilidades por capas y el almacenamiento local de preferencias e interacciones.

## Características implementadas

- Reproducción de videos en pantalla completa, en bucle, con desplazamiento vertical entre publicaciones.
- Feeds **Para ti**, **Cerca de ti** y **Descubrir**, además de la sección **Favoritos**.
- Controles de reproducción, me gusta, favoritos y silencio de audio.
- Persistencia local de favoritos y videos vistos mediante SharedPreferences.
- Actualización del feed y carga adicional al avanzar por las publicaciones.
- Temas de temporada **Normal**, **San Valentín**, **Halloween** y **Navidad**, con selector manual y detección por fecha.
- Sonidos y logotipos asociados a las temporadas; cambio del icono de aplicación mediante configuración nativa Android.
## Evidencias
## Videos de evidencia

- [Video de evidencia 1 – Demostración de TokTik](https://drive.google.com/file/d/1pktKYKD_96SOT14M8g2yRO8dK22xWaOl/view?usp=drive_link)
- [Video de evidencia 2 – Demostración de TokTik](https://drive.google.com/file/d/1LMcr7uFxUAw2bBKPkDPzLeyVZGv8ncGF/view?usp=drive_link)
## Tecnologías

| Tecnología | Uso en el proyecto |
|---|---|
| Flutter y Dart | Interfaz y lógica de la aplicación |
| Provider | Estado de los feeds y comunicación con la interfaz |
| video_player | Reproducción de video |
| audioplayers | Audio de bienvenida y de temporada |
| Dio | Solicitudes HTTP en las fuentes que reciben una clave API |
| shared_preferences | Persistencia de favoritos y videos vistos |
| animate_do | Animaciones de interfaz |
| intl | Formateo de valores |
| Android, Gradle y Kotlin | Integración nativa para Android e iconos de temporada |

## Arquitectura y organización

El código de aplicación está en **lib/** y separa presentación, dominio e infraestructura. La configuración compartida de temas y formatos está en **config/**; los datos locales de ejemplo están en **shared/**. La integración Android, recursos multimedia, pruebas y diagramas se mantienen en sus carpetas respectivas.

El diagrama de arquitectura y las responsabilidades de cada carpeta se explican en [DOCUMENTACION.md](DOCUMENTACION.md). También se conservan los diagramas fuente en [architecture/](architecture/).

## Instalación y ejecución local

Requisitos: Flutter instalado y un dispositivo Android, emulador o plataforma compatible disponible.

Desde la raíz del repositorio:

~~~powershell
cd Practica_04/tok_tik
flutter pub get
flutter run
~~~

Para compilar el APK de depuración:

~~~powershell
flutter build apk --debug
~~~

## Demo en línea

**[Probar TokTik en Appetize.io](https://appetize.io/app/b_6lzqh4lz6dezayfkoazk6bhyci)** permite abrir la aplicación Android desde el navegador cuando el enlace y sus permisos están disponibles. Las capturas de evidencia de esta práctica muestran la aplicación abierta en Appetize.io; no implican que se hayan verificado todas las funciones ni garantizan la disponibilidad futura del servicio.

Consulta la [documentación complementaria](DOCUMENTACION.md) y las [instrucciones de Appetize](appetize/INSTRUCCIONES.md).

## Evidencias de funcionamiento

Las siguientes siete capturas originales están en **appetize/imagenes/**. Corresponden a una sesión de Appetize.io con un dispositivo Pixel 7 y Android 13, y muestran diferentes estados de TokTik.

Las imágenes se muestran a un ancho moderado, conservan su proporción y enlazan al archivo original para consultar los detalles.

<table>
  <tr>
    <td width="50%" valign="top">
      <a href="appetize/imagenes/Captura%20de%20pantalla%202026-10-19%20130343.png"><img src="appetize/imagenes/Captura%20de%20pantalla%202026-10-19%20130343.png" alt="Feed Para ti, reproducción y navegación" width="350" style="max-width:100%; height:auto;"></a>
      <p><strong>Captura de pantalla 2026-10-19 130343.png</strong><br>La pantalla principal muestra el feed Para ti con una publicación en reproducción, sus datos, controles laterales y navegación inferior.</p>
    </td>
    <td width="50%" valign="top">
      <a href="appetize/imagenes/Captura%20de%20pantalla%202026-10-19%20130356.png"><img src="appetize/imagenes/Captura%20de%20pantalla%202026-10-19%20130356.png" alt="Selector de temporada con Halloween seleccionado" width="350" style="max-width:100%; height:auto;"></a>
      <p><strong>Captura de pantalla 2026-10-19 130356.png</strong><br>El selector permite elegir entre Normal, San Valentín, Halloween y Navidad; Halloween aparece seleccionado.</p>
    </td>
  </tr>
  <tr>
    <td width="50%" valign="top">
      <a href="appetize/imagenes/Captura%20de%20pantalla%202026-10-19%20130407.png"><img src="appetize/imagenes/Captura%20de%20pantalla%202026-10-19%20130407.png" alt="Feed con tema de San Valentín" width="350" style="max-width:100%; height:auto;"></a>
      <p><strong>Captura de pantalla 2026-10-19 130407.png</strong><br>El feed presenta el acento visual de San Valentín mientras se reproduce una publicación.</p>
    </td>
    <td width="50%" valign="top">
      <a href="appetize/imagenes/Captura%20de%20pantalla%202026-10-19%20130427.png"><img src="appetize/imagenes/Captura%20de%20pantalla%202026-10-19%20130427.png" alt="Confirmación de audio silenciado" width="350" style="max-width:100%; height:auto;"></a>
      <p><strong>Captura de pantalla 2026-10-19 130427.png</strong><br>La notificación «Audio silenciado» confirma visualmente el estado del control de silencio.</p>
    </td>
  </tr>
  <tr>
    <td width="50%" valign="top">
      <a href="appetize/imagenes/Captura%20de%20pantalla%202026-10-19%20130436.png"><img src="appetize/imagenes/Captura%20de%20pantalla%202026-10-19%20130436.png" alt="Publicación con me gusta y contadores" width="350" style="max-width:100%; height:auto;"></a>
      <p><strong>Captura de pantalla 2026-10-19 130436.png</strong><br>Se observa otra publicación en reproducción con el botón de me gusta activado y sus contadores visibles.</p>
    </td>
    <td width="50%" valign="top">
      <a href="appetize/imagenes/Captura%20de%20pantalla%202026-10-19%20130446.png"><img src="appetize/imagenes/Captura%20de%20pantalla%202026-10-19%20130446.png" alt="Sección Favoritos con una publicación" width="350" style="max-width:100%; height:auto;"></a>
      <p><strong>Captura de pantalla 2026-10-19 130446.png</strong><br>La sección Favoritos muestra una publicación guardada.</p>
    </td>
  </tr>
  <tr>
    <td width="50%" valign="top">
      <a href="appetize/imagenes/Captura%20de%20pantalla%202026-10-19%20130513.png"><img src="appetize/imagenes/Captura%20de%20pantalla%202026-10-19%20130513.png" alt="Accesos TokTik en el cajón de aplicaciones Android" width="350" style="max-width:100%; height:auto;"></a>
      <p><strong>Captura de pantalla 2026-10-19 130513.png</strong><br>El cajón de aplicaciones de Android muestra dos accesos TokTik con iconos distintos; el proyecto contiene aliases nativos de icono para las temporadas.</p>
    </td>
    <td width="50%"></td>
  </tr>
</table>

## Pruebas automatizadas disponibles

El proyecto incluye pruebas de widget y unitarias en **test/widget_test.dart** para el tema, la generación de métricas, la serialización de VideoPost y la persistencia de favoritos y vistos. Estas pruebas no se ejecutaron durante esta actualización documental.

## Limitaciones conocidas

- No hay videos MP4 en el checkout. Aunque pubspec.yaml declara assets/videos/ y local_video_posts.dart referencia ocho archivos, esos recursos no están presentes. La aplicación principal inicializa feeds remotos; su reproducción depende de la conexión y de que las URLs de ejemplo sigan disponibles.
- Pixabay y Pexels admiten una clave API opcional, pero main.dart crea esos datasources sin pasarla; en esa configuración usan sus catálogos de ejemplo. No se encontraron claves API en la configuración de inicio inspeccionada.
- El enlace de Appetize depende de que la aplicación siga disponible y de los permisos de acceso de la cuenta o compilación.
- No se modificaron ni verificaron desde este trabajo las grabaciones enlazadas en Google Drive; las capturas anteriores son la evidencia visual incluida directamente en este README.

## Autor

**Bruno Gregorio — matrícula 230362**
**Desarrollo Móvil Integral · Ingeniería en Desarrollo y Gestión de Software**
