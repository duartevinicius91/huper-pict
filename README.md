# 🚀 Scripts para Executar o Projeto PICT

Este projeto contém três componentes principais:
- **Backend**: Spring Boot (Java)
- **Admin**: React (TypeScript)
- **Landing Page**: React (TypeScript)

## 📋 Pré-requisitos

Antes de executar os scripts, certifique-se de ter instalado:

1. **Java 21 ou superior**
   - Verifique com: `java -version`

2. **Node.js**
   - Verifique com: `node --version`

3. **npm** (vem com o Node.js)
   - Verifique com: `npm --version`

## 🖥️ Windows

### Opção 1: Script Batch (Recomendado)
Execute o script batch (mais simples):

```cmd
run.bat
```

### Opção 2: PowerShell
Execute o script PowerShell:

```powershell
.\run.ps1
```

Se você receber um erro de política de execução, execute primeiro:

```powershell
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
```

## 🐧 Linux/macOS

Execute o script bash:

```bash
./run.sh
```

Se o script não for executável, torne-o executável primeiro:

```bash
chmod +x run.sh
```

## 🌐 URLs dos Serviços

Após executar o script, os serviços estarão disponíveis em:

- **Backend**: http://localhost:8080
- **Admin**: http://localhost:5174
- **Landing Page**: http://localhost:5173

## 🛑 Como Parar os Serviços

Para parar todos os serviços, pressione `Ctrl+C` no terminal onde o script está rodando.

## 🔧 O que o Script Faz

1. **Verifica pré-requisitos**: Java e Node.js
2. **Instala dependências**: npm install para os projetos React
3. **Inicia o Backend**: Spring Boot na porta 8080
4. **Inicia o Admin**: React na porta 5174
5. **Inicia a Landing Page**: React na porta 5173
6. **Monitora os serviços**: Verifica se algum serviço para inesperadamente

## 🐛 Solução de Problemas

### Erro de Porta em Uso
Se alguma porta estiver em uso, pare o processo que está usando a porta:

**Windows:**
```powershell
netstat -ano | findstr :8080
taskkill /PID <PID> /F
```

**Linux/macOS:**
```bash
lsof -i :8080
kill -9 <PID>
```

### Erro de Dependências
Se houver problemas com dependências, delete as pastas `node_modules` e execute novamente:

```bash
# Linux/macOS
rm -rf pict-admin/node_modules pict-landing-page/node_modules

# Windows
Remove-Item -Recurse -Force pict-admin/node_modules, pict-landing-page/node_modules
```

### Erro de Gradle
Se houver problemas com o Gradle, execute:

```bash
cd pict-backend
./gradlew clean
./gradlew build
```

## 📝 Logs

Os logs de cada serviço são exibidos no terminal. Se precisar de logs mais detalhados, você pode executar cada serviço separadamente:

**Backend:**
```bash
cd pict-backend
./gradlew bootRun
```

**Admin:**
```bash
cd pict-admin
npm run dev
```

**Landing Page:**
```bash
cd pict-landing-page
npm run dev
```
