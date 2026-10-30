# Script de Despliegue Automatizado a Cloudflare Pages para GEACUN
Write-Host "==========================================================" -ForegroundColor Cyan
Write-Host "🌊 DESPLIEGUE DE GEACUN A CLOUDFLARE PAGES ($0 / GRATUITO)" -ForegroundColor Cyan
Write-Host "==========================================================" -ForegroundColor Cyan
Write-Host ""

# 1. Verificar variables en client/.env
$envFile = "client\.env"
if (-not (Test-Path $envFile)) {
    Write-Host "⚠️  No se encontró el archivo client\.env" -ForegroundColor Yellow
    Write-Host "Creando client\.env a partir de client\.env.example..." -ForegroundColor Yellow
    Copy-Item "client\.env.example" "client\.env"
    Write-Host "Por favor edite client\.env y configure sus claves de Supabase antes de continuar." -ForegroundColor Red
    exit 1
}

# 2. Compilar frontend para producción
Write-Host "🔨 Compilando cliente web optimizado con Vite..." -ForegroundColor Green
npm --prefix client run build
if ($LASTEXITCODE -ne 0) {
    Write-Host "❌ Error durante la compilación." -ForegroundColor Red
    exit $LASTEXITCODE
}

# 3. Publicar con Wrangler
Write-Host ""
Write-Host "🚀 Publicando en Cloudflare Pages..." -ForegroundColor Green
npx --prefix client wrangler pages deploy client/dist --project-name geacun

Write-Host ""
Write-Host "✅ Proceso de despliegue finalizado." -ForegroundColor Cyan
