@echo off
title Despliegue GEACUN a Cloudflare Pages
color 0B
echo ==========================================================
echo 🌊 DESPLIEGUE DE GEACUN A CLOUDFLARE PAGES ($0 / GRATUITO)
echo ==========================================================
echo.

if not exist client\.env (
    echo [!] Creando client\.env desde client\.env.example...
    copy client\.env.example client\.env
    echo [!] Por favor configure VITE_SUPABASE_URL y VITE_SUPABASE_ANON_KEY en client\.env
    notepad client\.env
    pause
    exit /b
)

echo [*] Compilando la aplicacion web para produccion...
call npm --prefix client run build
if %errorlevel% neq 0 (
    echo [!] Error en la compilacion.
    pause
    exit /b %errorlevel%
)

echo.
echo [*] Publicando en Cloudflare Pages mediante Wrangler...
call npx --prefix client wrangler pages deploy client\dist --project-name geacun

echo.
echo [V] Despliegue completado con exito.
pause
