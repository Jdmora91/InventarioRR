# RR Joyería Fina y Vintage

Catálogo web estático con tienda pública, panel administrativo, Supabase Database/Auth/Storage y despliegue en Render.

## Preparar Supabase

1. Abrir **SQL Editor** en el proyecto `inventario-rr`.
2. Ejecutar `supabase/migrations/001_secure_catalog.sql`.
3. En **Authentication → Users → Add user**, crear el correo y contraseña de la persona administradora.
4. Desactivar nuevos registros públicos en **Authentication → Sign In / Providers → Email** si no se necesitan.
5. En **Storage → fotos-joyas → Edit bucket** limitar MIME types a `image/jpeg,image/png,image/webp` y el tamaño a 15 MB.

La clave incluida en el frontend es la clave pública/publishable de Supabase. Nunca debe incluirse una `service_role` key.

## Ejecutar localmente

```bash
npx serve .
```

- Catálogo: `http://localhost:3000/`
- Administración: `http://localhost:3000/dashboard.html`

## Desplegar en Render

El archivo `render.yaml` configura un Static Site. En Render, crear un Blueprint desde el repositorio o un Static Site con:

- Branch: `main`
- Build command: vacío
- Publish directory: `.`

## Fotografías

El dashboard acepta hasta 6 fotos por producto. Antes de subir, convierte cada imagen a WebP, la limita a 1600 px y aplica calidad 82% para ahorrar almacenamiento y acelerar el catálogo.
