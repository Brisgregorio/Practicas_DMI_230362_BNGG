# cinemapedia_230362

**Autora:** Brisa Nallely Garcia Gregorio  
**Matrícula:** 230362  
**Identificador personal:** BNGG

## Descripción
Cinemapedia es una aplicación móvil desarrollada en Flutter para explorar películas, consultar estrenos, descubrir títulos populares y revisar información cinematográfica. La aplicación utiliza The Movie Database (TMDB) como fuente de información.

## Identidad visual
La interfaz tiene una identidad propia basada en azul profundo, morado y violeta. Incluye tarjetas redondeadas, degradados, elementos luminosos y un icono exclusivo de Cinemapedia.

## Requisitos implementados
- Menú hamburguesa con navegación lateral que también se abre deslizando desde el borde izquierdo.
- Acceso de ajustes (engranaje) que abre un selector modal de país e idioma de las películas.
- Icono personalizado de la aplicación y marca Cinemapedia_230362 visible en la navegación y el detalle.
- Carrusel de películas con desplazamiento táctil.
- Las flechas semitransparentes avanzan una película con un toque; doble toque salta al final o, si ya está al final, vuelve al inicio.
- Si falla la carga del carrusel, se muestra un mensaje y una opción para volver a intentar.
- Mensajes al llegar al principio y al final del carrusel.
- El país elegido actualiza la región e idioma de las peticiones a TMDB, la clasificación mostrada y el idioma de toda la interfaz.
- La interfaz está traducida al español, inglés, portugués, alemán, árabe y japonés mediante recursos ARB de Flutter.
- El país seleccionado se conserva entre ejecuciones; la selección de Egipto activa la disposición RTL de Flutter.
- Calificación numérica y estrella visual.
- Clasificación por país con bandera, idioma y referencia de clasificación.
- Diseño personalizado en tonos azules y morados.
- Gestos táctiles mediante `GestureDetector` y desplazamiento del carrusel.

## Países incluidos
| Continente | País |
|---|---|
| América del Norte | México |
| América del Norte | Estados Unidos |
| América del Sur | Brasil |
| Europa | Alemania |
| África | Egipto |
| Asia | Japón |
| Oceanía | Australia |

**Importante sobre las clasificaciones:** el listado general de TMDB no proporciona necesariamente la certificación oficial de cada película para todos los países. Esta versión muestra una referencia orientativa basada en el indicador de contenido adulto de TMDB y el país seleccionado. Los valores con asterisco no son una certificación oficial.

## Tecnologías
- Flutter y Dart
- Material 3
- Riverpod
- GoRouter
- Dio
- The Movie Database (TMDB)
- flutter_dotenv
- card_swiper
- animate_do

## Requisitos previos
- Flutter SDK compatible con el proyecto.
- Dart SDK indicado en `pubspec.yaml`.
- Android Studio o Visual Studio Code.
- Emulador Android o dispositivo físico.
- API Key de TMDB.

## Instalación
1. Descomprimir el proyecto.
2. Abrir una terminal en la carpeta `cinemapedia_230362`.
3. Instalar dependencias:

   ```bash
   flutter pub get
   ```

4. Copiar `.env.template` y crear un archivo llamado `.env`.
5. Agregar la API Key de TMDB:

   ```env
   THE_MOVIEDB_KEY=TU_API_KEY
   ```

6. Ejecutar la aplicación:

   ```bash
   flutter run
   ```

## Cómo obtener la API Key
1. Crear una cuenta en [The Movie Database](https://www.themoviedb.org/).
2. Entrar a la configuración de la cuenta y solicitar una API Key.
3. Copiar la clave en el archivo `.env`.

No subir el archivo `.env` a repositorios públicos. El archivo `.env.template` sirve como referencia y no contiene credenciales.

## Gestos y comportamiento del carrusel
- Deslizar horizontalmente permite recorrer las películas.
- Tocar una flecha avanza o retrocede una película; tocarla dos veces va al final del carrusel, o al inicio si ya estaba al final.
- Al llegar a la primera película se muestra el mensaje de inicio de lista.
- Al llegar a la última película se muestra el mensaje de final de lista.
- Tocar una tarjeta abre el detalle de la película.
- El selector modal de país actualiza la bandera, el idioma/región de las peticiones y la referencia de clasificación mostrada en las tarjetas.
- El mismo selector también cambia la locale de la interfaz y guarda el código del país con `shared_preferences`. La locale de interfaz usa el idioma base del país (por ejemplo, `en-US` y `en-AU` usan inglés); las peticiones TMDB mantienen el idioma y la región completos.

## Estructura principal
```text
lib/
├── config/
│   ├── constants/
│   ├── router/
│   └── theme/
├── domain/
│   ├── datasources/
│   ├── entities/
│   └── repositories/
├── infrastructure/
│   ├── datasources/
│   ├── mappers/
│   ├── models/
│   └── repositories/
├── presentation/
│   ├── delegates/
│   ├── providers/
│   ├── screens/
│   └── widgets/
└── main.dart
```

## Datos académicos
**Proyecto:** cinemapedia_230362  
**Alumna:** Brisa Nallely Garcia Gregorio  
**Matrícula:** 230362  
**Clave:** BNGG
