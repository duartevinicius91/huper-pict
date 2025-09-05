#!/bin/bash

# Script para executar o projeto PICT localmente
# Execute com: ./run.sh

echo "🚀 Iniciando o projeto PICT..."

# Verificar pré-requisitos
echo "🔍 Verificando pré-requisitos..."

# Verificar Java
if ! command -v java &> /dev/null; then
    echo "❌ Java não encontrado. Instale Java 21 ou superior."
    exit 1
fi
echo "✅ Java encontrado: $(java -version 2>&1 | head -n 1)"

# Verificar Node.js
if ! command -v node &> /dev/null; then
    echo "❌ Node.js não encontrado. Instale Node.js."
    exit 1
fi
echo "✅ Node.js encontrado: $(node --version)"

# Verificar npm
if ! command -v npm &> /dev/null; then
    echo "❌ npm não encontrado."
    exit 1
fi
echo "✅ npm encontrado: $(npm --version)"

# Verificar Docker
if ! command -v docker &> /dev/null; then
    echo "❌ Docker não encontrado. Instale Docker."
    exit 1
fi
echo "✅ Docker encontrado: $(docker --version)"

echo ""
echo "🔧 Configurando banco de dados..."

# Iniciar banco de dados
cd pict-backend/src/docker
echo "🐘 Iniciando PostgreSQL e serviços auxiliares..."
docker-compose up -d postgres keycloak

# Aguardar o banco estar pronto
echo "⏳ Aguardando banco de dados ficar pronto..."
sleep 10

cd ../../..

echo ""
echo "🔧 Instalando dependências..."

# Instalar dependências do admin
echo "📦 Instalando dependências do Admin..."
cd pict-admin
npm install
cd ..

# Instalar dependências da landing page
echo "📦 Instalando dependências da Landing Page..."
cd pict-landing-page
npm install
cd ..

echo ""
echo "🚀 Iniciando serviços..."

# Função para limpar processos ao sair
cleanup() {
    echo ""
    echo "🛑 Parando serviços..."
    pkill -f "gradle.*bootRun" 2>/dev/null || true
    pkill -f "npm.*dev" 2>/dev/null || true
    echo "✅ Serviços parados."
    exit 0
}

# Capturar Ctrl+C
trap cleanup SIGINT

# Iniciar Backend
echo "🔧 Iniciando Backend (Spring Boot)..."
cd pict-backend
./gradlew bootRun &
BACKEND_PID=$!
cd ..

# Aguardar um pouco para o backend inicializar
sleep 5

# Iniciar Admin
echo "🎨 Iniciando Admin (React)..."
cd pict-admin
npm run dev &
ADMIN_PID=$!
cd ..

# Iniciar Landing Page
echo "🌐 Iniciando Landing Page (React)..."
cd pict-landing-page
npm run dev &
LANDING_PID=$!
cd ..

echo ""
echo "🎉 Todos os serviços foram iniciados!"
echo ""
echo "📋 URLs dos serviços:"
echo "   • Backend: http://localhost:8080/api"
echo "   • Admin: http://localhost:5174"
echo "   • Landing Page: http://localhost:5173"
echo "   • Keycloak: http://localhost:7080"
echo "   • CompreFace UI: http://localhost:8000"
echo ""
echo "🛑 Para parar os serviços:"
echo "   • Pressione Ctrl+C"
echo "   • Execute: docker-compose down (na pasta pict-backend/src/docker)"
echo ""
echo "📚 Documentação da API:"
echo "   • Swagger UI: http://localhost:8080/api/swagger-ui.html"
echo ""
echo "⏳ Aguarde alguns segundos para todos os serviços ficarem prontos..."
echo ""

# Aguardar indefinidamente
wait
