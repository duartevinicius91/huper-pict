@echo off
REM Script para executar o projeto PICT localmente
REM Execute com: run.bat

echo 🚀 Iniciando o projeto PICT...

echo.
echo 🔍 Verificando pré-requisitos...

REM Verificar Java
java -version >nul 2>&1
if %errorlevel% neq 0 (
    echo ❌ Java não encontrado. Instale Java 21 ou superior.
    pause
    exit /b 1
)
echo ✅ Java encontrado

REM Verificar Node.js
node --version >nul 2>&1
if %errorlevel% neq 0 (
    echo ❌ Node.js não encontrado. Instale Node.js.
    pause
    exit /b 1
)
echo ✅ Node.js encontrado

REM Verificar npm
npm --version >nul 2>&1
if %errorlevel% neq 0 (
    echo ❌ npm não encontrado.
    pause
    exit /b 1
)
echo ✅ npm encontrado

REM Verificar Docker
docker --version >nul 2>&1
if %errorlevel% neq 0 (
    echo ❌ Docker não encontrado. Instale Docker Desktop.
    pause
    exit /b 1
)
echo ✅ Docker encontrado

echo.
echo 🔧 Configurando banco de dados...

REM Iniciar banco de dados
cd pict-backend\src\docker
echo 🐘 Iniciando PostgreSQL e serviços auxiliares...
docker-compose up -d postgres keycloak

REM Aguardar o banco estar pronto
echo ⏳ Aguardando banco de dados ficar pronto...
timeout /t 10 /nobreak >nul

cd ..\..\..

echo.
echo 🔧 Instalando dependências...

REM Instalar dependências do admin
echo 📦 Instalando dependências do Admin...
cd pict-admin
call npm install
cd ..

REM Instalar dependências da landing page
echo 📦 Instalando dependências da Landing Page...
cd pict-landing-page
call npm install
cd ..

echo.
echo 🚀 Iniciando serviços...

REM Iniciar Backend
echo 🔧 Iniciando Backend (Spring Boot)...
start "Backend - Spring Boot (Porta 8080)" cmd /k "cd pict-backend && gradlew.bat bootRun"

REM Aguardar um pouco para o backend inicializar
timeout /t 5 /nobreak >nul

REM Iniciar Admin
echo 🎨 Iniciando Admin (React)...
start "Admin - React (Porta 5174)" cmd /k "cd pict-admin && npm run dev"

REM Iniciar Landing Page
echo 🌐 Iniciando Landing Page (React)...
start "Landing Page - React (Porta 5173)" cmd /k "cd pict-landing-page && npm run dev"

echo.
echo 🎉 Todos os serviços foram iniciados!
echo.
echo 📋 URLs dos serviços:
echo    • Backend: http://localhost:8080/api
echo    • Admin: http://localhost:5174
echo    • Landing Page: http://localhost:5173
echo    • Keycloak: http://localhost:7080
echo    • CompreFace UI: http://localhost:8000
echo.
echo 🛑 Para parar os serviços:
echo    • Feche as janelas do CMD que foram abertas
echo    • Execute: docker-compose down (na pasta pict-backend\src\docker)
echo.
echo 📚 Documentação da API:
echo    • Swagger UI: http://localhost:8080/api/swagger-ui.html
echo.
echo ⏳ Aguarde alguns segundos para todos os serviços ficarem prontos...
echo.
pause
