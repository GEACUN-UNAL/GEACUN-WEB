# GEACUN - Plataforma Web Oficial

**Grupo de Estudio en Acuicultura**  
*Facultad de Medicina Veterinaria y de Zootecnia — Universidad Nacional de Colombia*

---

## 🌊 1. Identidad y Propósito del Proyecto
GEACUN es un espacio académico y científico creado para estudiantes, docentes e investigadores interesados en conocer, aprender y compartir experiencias alrededor de la acuicultura, la ictiología y el bienestar de los ecosistemas acuáticos.

La plataforma centraliza recursos educativos, conferencias audiovisuales, presentaciones magistrales, divulgación de noticias y el cronograma de actividades de la Universidad Nacional de Colombia.

---

## ☁️ 2. Arquitectura de Publicación en la Nube ($0 Mensuales)
La plataforma está diseñada con una arquitectura cloud desacoplada y gratuita:

1. **Frontend:** Alojado en **Cloudflare Pages** sobre una red global CDN con certificado SSL/HTTPS automático, protección contra ataques y disponibilidad 24/7 sin costo alguno.
2. **Base de Datos:** PostgreSQL en la nube mediante **Supabase** (nivel gratuito con 500 MB de base de datos relacional y políticas de seguridad Row Level Security - RLS).
3. **Autenticación:** Supabase Auth gestionando la sesión del administrador con JWT seguro, tokens de actualización y cifrado.
4. **Almacenamiento de Archivos (Storage):** Buckets `geacun-images` y `geacun-slides` en Supabase Storage (1 GB gratuito para PDFs, diapositivas y fotografías).
5. **Código Fuente:** Almacenado en **GitHub** con integración continua para despliegues automáticos ante cada actualización de código.
6. **Modo Local Offline:** Soporte integrado con backend Express y SQLite/JSON persistente para desarrollo sin conexión a internet.

---

## 🎨 3. Paleta de Colores e Identidad Visual
- **Azul Marino (`#0B2545`):** Color institucional principal, solidez y profundidad académica.
- **Azul Oceánico (`#134074` / `#0077B6`):** Para botones, elementos interactivos y fondos de tarjetas.
- **Celeste / Cielo (`#00B4D8` / `#38BDF8`):** Para resaltar textos, insignias y estados activos.
- **Blanco Nieve (`#FFFFFF` / `#F8FAFC`):** Fondo principal de lectura limpia y agradable.
- **Turquesa (`#06D6A0` / `#0EA5E9`):** Detalles visuales, transiciones y elementos bio-acuáticos.

---

## 🏛️ 4. Estructura y Secciones Públicas
1. **Inicio:**
   - **Carrusel de Imágenes:** Transiciones automáticas y manuales con fotografías acuícolas, títulos y botones modificables desde el panel de administración.
   - **Bienvenida Oficial:** Descripción institucional de GEACUN vinculada a la Facultad de Medicina Veterinaria y de Zootecnia de la UNAL.
   - **Accesos Rápidos:** 4 tarjetas interactivas hacia videos, diapositivas, noticias y eventos.
   - **Últimas Novedades:** Noticias recientes con lector modal.
   - **Próximos Eventos:** Resumen cronológico con fecha, hora y ubicación en la UNAL.

2. **Biblioteca Audiovisual:**
   - Reproductor modal para videos de YouTube (soporta enlaces estándar, `youtu.be` y `shorts`).
   - Buscador en tiempo real y filtros temáticos por categorías (*Acuicultura, Anatomía de peces, Fisiología, Nutrición, Sistemas RAS, Sanidad, Reproducción, Calidad del agua, Conservación, Investigación*).

3. **Diapositivas y Material Académico:**
   - Visualizador de PDF integrado en la página mediante visor embebido.
   - Botón de descarga directa con contador persistente de descargas.
   - Filtros por áreas temáticas y buscador.

4. **Noticias y Divulgación Científica:**
   - Publicaciones con imagen de portada, resumen, contenido completo, autor y categoría.
   - Soporte para enlaces externos interactivos y referencias bibliográficas / citas.

5. **Calendario de Eventos:**
   - Vista mensual interactiva en cuadrícula con badges en los días con actividades.
   - Vista de lista completa de actividades.
   - Modal con fecha, horarios, sede, afiche, organizador y enlace de inscripción.

6. **Acerca de GEACUN:**
   - Historia y trayectoria en la Universidad Nacional de Colombia.
   - Misión y Visión con proyección al 2030.
   - Objetivos estratégicos numerados.
   - Áreas de interés y profundización científica.
   - Redes académicas (UNAL, Red Colombiana de Acuicultura, ALAqua, RedSIUN).
   - Galería fotográfica interactiva de actividades con visor lightbox.

---

## 🔐 5. Panel de Administración Privado
- **Credenciales Iniciales:**
  - **Usuario:** `administrador` (o `administrador@geacun.unal.edu.co`)
  - **Contraseña:** `GEACUN1999`
- **Módulos Administrativos:**
  - **Gestión de Inicio:** Imágenes, textos y enlaces del carrusel; banner de bienvenida.
  - **Gestión de Videos:** Agregar enlaces de YouTube con detección automática de ID y miniatura, editar y eliminar.
  - **Gestión de Diapositivas:** Subir archivos PDF directamente a la nube (Supabase Storage), editar metadatos y eliminar.
  - **Gestión de Noticias:** Redactar publicaciones, subir imagen principal, enlaces externos y bibliografía.
  - **Gestión del Calendario:** Crear eventos, fechas, horarios, sedes, afiches y enlaces de inscripción.
  - **Gestión Institucional:** Editar misión, visión, historia, objetivos y galería fotográfica.
  - **Configuración General:** Cambio seguro de contraseña, datos de contacto, enlaces de redes sociales y copias de seguridad JSON.

> [!IMPORTANT]
> **Doble tipo de actualizaciones:**
> - **Actualizaciones de Contenido:** Al agregar o editar una noticia, video, diapositiva o evento desde el panel de administración, el cambio aparece de inmediato en la página pública para todos los visitantes sin necesidad de volver a desplegar la web.
> - **Actualizaciones de Programación:** Al modificar diseño o código, los cambios se publican automáticamente desde GitHub en Cloudflare Pages.

---

## 🚀 6. Guía de Publicación en Internet ($0 / Gratis)

### Paso 1: Configurar la Base de Datos en Supabase
1. Ingresa a [https://supabase.com](https://supabase.com) y crea una cuenta gratuita.
2. Crea un proyecto llamado `geacun-platform`.
3. Ve a **SQL Editor** en el menú lateral izquierdo de Supabase.
4. Abre el archivo `supabase_schema.sql` ubicado en la raíz de este proyecto, copia todo su contenido, pégalo en el editor SQL de Supabase y presiona **Run**.  
   *(Esto crea automáticamente todas las tablas, las políticas de seguridad RLS, los buckets de almacenamiento `geacun-images` y `geacun-slides`, y carga todos los datos académicos iniciales de GEACUN).*
5. Ve a **Authentication -> Users** en Supabase, haz clic en **Add user -> Create user**:
   - **Email:** `administrador@geacun.unal.edu.co`
   - **Password:** `GEACUN1999`
   - Marca la casilla **Auto Confirm User**.
6. Ve a **Project Settings (engranaje) -> API** y copia:
   - **Project URL** (ej: `https://xyz.supabase.co`)
   - **Project API keys -> `anon` `public`**

### Paso 2: Configurar las Variables de Entorno
Crea un archivo llamado `client/.env` (o edita `client/.env.example`) con tus credenciales:
```env
VITE_SUPABASE_URL=https://tu-proyecto.supabase.co
VITE_SUPABASE_ANON_KEY=tu-clave-anonima-de-supabase
```

### Paso 3: Publicar en Cloudflare Pages

#### Método A (Recomendado con 1 Clic en Windows):
Simplemente ejecuta el archivo:
```powershell
.\deploy-cloudflare.bat
```
*(O ejecuta `deploy-cloudflare.ps1` en PowerShell).*  
Wrangler solicitará inicio de sesión gratuito en Cloudflare una sola vez en el navegador y publicará la web inmediatamente entregándote la URL pública con HTTPS (ej: `https://geacun.pages.dev`).

#### Método B (Despliegue Continuo desde GitHub):
1. Sube el código fuente a tu repositorio de GitHub.
2. En [Cloudflare Dashboard](https://dash.cloudflare.com), ve a **Workers & Pages** -> **Create application** -> **Pages** -> **Connect to Git**.
3. Selecciona tu repositorio de GEACUN.
4. Configuración de construcción:
   - **Framework preset:** `Vite`
   - **Root directory:** `client`
   - **Build command:** `npm run build`
   - **Build output directory:** `dist`
5. En **Environment Variables**, añade:
   - `VITE_SUPABASE_URL`: Tu Project URL de Supabase.
   - `VITE_SUPABASE_ANON_KEY`: Tu clave anon de Supabase.
6. Haz clic en **Save and Deploy**. En menos de 1 minuto tu página estará activa en `https://geacun.pages.dev`.

---

## 💻 7. Ejecución Local (Offline / Desarrollo)
Si deseas ejecutar la plataforma en tu computador sin internet:
```powershell
npm start
```
La plataforma web estará disponible inmediatamente en:  
👉 **http://localhost:5000**
