# Script para executar o projeto PICT localmente
# Execute com: .\run.ps1

Write-Host "🚀 Iniciando o projeto PICT..." -ForegroundColor Green

# Verificar pré-requisitos
Write-Host "🔍 Verificando pré-requisitos..." -ForegroundColor Yellow

# Verificar Java
try {
    $javaVersion = java -version 2>&1 | Select-String "version"
    Write-Host "✅ Java encontrado: $javaVersion" -ForegroundColor Green
} catch {
    Write-Host "❌ Java não encontrado. Instale Java 21 ou superior." -ForegroundColor Red
    exit 1
}

# Verificar Node.js
try {
    $nodeVersion = node --version
    Write-Host "✅ Node.js encontrado: $nodeVersion" -ForegroundColor Green
} catch {
    Write-Host "❌ Node.js não encontrado. Instale Node.js." -ForegroundColor Red
    exit 1
}

# Verificar npm
try {
    $npmVersion = npm --version
    Write-Host "✅ npm encontrado: $npmVersion" -ForegroundColor Green
} catch {
    Write-Host "❌ npm não encontrado." -ForegroundColor Red
    exit 1
}

# Verificar Docker
try {
    $dockerVersion = docker --version
    Write-Host "✅ Docker encontrado: $dockerVersion" -ForegroundColor Green
} catch {
    Write-Host "❌ Docker não encontrado. Instale Docker Desktop." -ForegroundColor Red
    exit 1
}

Write-Host "`n🔧 Configurando banco de dados..." -ForegroundColor Yellow

# Iniciar banco de dados
Set-Location pict-backend/src/docker
Write-Host "🐘 Iniciando PostgreSQL e serviços auxiliares..." -ForegroundColor Cyan
docker-compose up -d postgres keycloak

# Aguardar o banco estar pronto
Write-Host "⏳ Aguardando banco de dados ficar pronto..." -ForegroundColor Yellow
Start-Sleep -Seconds 10

Set-Location ../../..

Write-Host "`n🔧 Instalando dependências..." -ForegroundColor Yellow

# Instalar dependências do admin
Write-Host "📦 Instalando dependências do Admin..." -ForegroundColor Cyan
Set-Location pict-admin
npm install
Set-Location ..

# Instalar dependências da landing page
Write-Host "📦 Instalando dependências da Landing Page..." -ForegroundColor Cyan
Set-Location pict-landing-page
npm install
Set-Location ..

Write-Host "`n🚀 Iniciando serviços..." -ForegroundColor Yellow

# Função para iniciar serviço em nova janela
function Start-ServiceInNewWindow {
    param($Path, $Command, $Title)
    
    Start-Process powershell -ArgumentList "-NoExit", "-Command", "cd '$Path'; Write-Host '$Title' -ForegroundColor Green; $Command"
}

# Iniciar Backend
Write-Host "🔧 Iniciando Backend (Spring Boot)..." -ForegroundColor Cyan
Start-ServiceInNewWindow -Path "pict-backend" -Command "./gradlew bootRun" -Title "Backend - Spring Boot (Porta 8080)"

# Aguardar um pouco para o backend inicializar
Start-Sleep -Seconds 5

# Iniciar Admin
Write-Host "🎨 Iniciando Admin (React)..." -ForegroundColor Cyan
Start-ServiceInNewWindow -Path "pict-admin" -Command "npm run dev" -Title "Admin - React (Porta 5174)"

# Iniciar Landing Page
Write-Host "🌐 Iniciando Landing Page (React)..." -ForegroundColor Cyan
Start-ServiceInNewWindow -Path "pict-landing-page" -Command "npm run dev" -Title "Landing Page - React (Porta 5173)"

Write-Host "`n🎉 Todos os serviços foram iniciados!" -ForegroundColor Green
Write-Host "`n📋 URLs dos serviços:" -ForegroundColor Yellow
Write-Host "   • Backend: http://localhost:8080/api" -ForegroundColor White
Write-Host "   • Admin: http://localhost:5174" -ForegroundColor White
Write-Host "   • Landing Page: http://localhost:5173" -ForegroundColor White
Write-Host "   • Keycloak: http://localhost:7080" -ForegroundColor White
Write-Host "   • CompreFace UI: http://localhost:8000" -ForegroundColor White

Write-Host "`n🛑 Para parar os serviços:" -ForegroundColor Yellow
Write-Host "   • Feche as janelas do PowerShell que foram abertas" -ForegroundColor White
Write-Host "   • Execute: docker-compose down (na pasta pict-backend/src/docker)" -ForegroundColor White

Write-Host "`n📚 Documentação da API:" -ForegroundColor Yellow
Write-Host "   • Swagger UI: http://localhost:8080/api/swagger-ui.html" -ForegroundColor White

Write-Host "`n⏳ Aguarde alguns segundos para todos os serviços ficarem prontos..." -ForegroundColor Yellow
