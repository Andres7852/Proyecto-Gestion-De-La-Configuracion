# Banco MVP — Plataforma Web & API Backend (Monorepo con Submódulos)

## 🚀 Guía Rápida

### Clonación del Repositorio
Para clonar este monorepo asegurando la descarga automática de sus submódulos (`frontend` y `backend`), ejecuta:

```powershell
git clone --recurse-submodules https://github.com/Andres7852/Proyecto-Gestion-De-La-Configuracion.git
```

*(Si ya lo clonaste sin submódulos, inicialízalos con `git submodule update --init --recursive`)*.

---

### Paso 1: Iniciar el Backend API (Base de Datos Local Cero-Configuración)

Abre una terminal en la raíz de tu proyecto:

```powershell
cd backend
npm install
npm test
npm run typecheck
npm run dev
```

El backend se iniciará en `http://localhost:3000`. Al arrancar por primera vez, creará e inicializará automáticamente la base de datos local embebida (`PGlite`) ejecutando los esquemas, tablas, tipos y funciones bancarias almacenadas en `db/`.

- **Documentación interactiva Swagger (OpenAPI 3.0):** Puedes consultar y probar todos los endpoints en vivo accediendo a `http://localhost:3000/api-docs` (o el JSON crudo en `http://localhost:3000/api-docs.json`).

*(Opcional)* Si prefieres utilizar un servidor PostgreSQL local ya existente en tu equipo, puedes crear un archivo `.env` en `backend/` definiendo `DATABASE_URL=postgresql://usuario:password@localhost:5432/nombre_bd`.

---

### Paso 2: Iniciar la Aplicación Web

Abre una segunda terminal:

```powershell
cd frontend
npm install
npm run typecheck
npm run dev
```

La aplicación web se abrirá en `http://localhost:5173`.

---

## 📁 Estructura del Monorepo

```
your-project/
├── .gitmodules            Definición de submódulos Git
├── db/                    Scripts SQL de estructura bancaria (Schema, Funciones, Seed)
├── backend/               [Submódulo Git] Node.js + Express + TypeScript + Swagger
│   ├── tsconfig.json
│   ├── src/
│   │   ├── index.ts       Punto de entrada del servidor API e inicializador de BD
│   │   ├── swagger.ts     Configuración OpenAPI 3.0 y Swagger UI
│   │   ├── middleware.ts  Validación de tokens de sesión JWT
│   │   ├── domain/        ← Lógica pura de dominio (sin BD ni HTTP)
│   │   ├── routes/        Rutas HTTP (Express) e integración local
│   │   └── repos/         Manejador de base de datos local (db.ts)
│   └── tests/             Suite de 33 pruebas unitarias de dominio
└── frontend/              [Submódulo Git] React 18 + Vite 6 + TypeScript + Playwright
    ├── index.html         Estructura base HTML5 y fuentes Google
    ├── package.json
    ├── playwright.config.ts
    ├── e2e/               Pruebas E2E de flujos críticos con Playwright
    └── src/
        ├── index.css      Sistema de diseño Glassmorphic & Dark Mode
        ├── App.tsx        Navegación principal y autenticación
        ├── components/    Componentes UI (Dashboard, Transferencias, Tarjetas, Créditos, etc.)
        └── lib/           Cliente API y gestión de sesiones locales (auth.ts)
```

### La Carpeta Domain (Lógica de Dominio en Backend)

| Archivo | Paradigma | Qué hace |
|---|---|---|
| `tipos.ts` | Tipado estático | Union types, discriminated unions |
| `Dinero.ts` | OOP — Value Object | Inmutable, en centavos enteros. Nunca float. |
| `saldo.ts` | Funcional | `reduce` sobre el ledger. Incluye la versión imperativa para comparar. |
| `amortizacion.ts` | Funcional | Sistema francés. Dos versiones: `reduce` y recursión de cola. |
| `reglas.ts` | Declarativo | Motor de reglas como datos. |
| `scoring.ts` | Declarativo | Factores ponderados como configuración. |
| `luhn.ts` | Funcional | Validación de tarjetas con algoritmo de Luhn. |

---

## 🛠️ Comandos de Uso Frecuente

### En la carpeta `backend/`:
```powershell
npm run dev        # Iniciar servidor backend con hot-reload (puerto 3000)
npm test           # Ejecutar los 33 tests de dominio
npm run typecheck  # Validar tipos TypeScript
```

### En la carpeta `frontend/`:
```powershell
npm run dev           # Iniciar servidor web de desarrollo (puerto 5173)
npm run typecheck     # Validar tipos TypeScript
npm run test:e2e      # Ejecutar las pruebas E2E con Playwright (Headless)
npm run test:e2e:ui   # Abrir la interfaz interactiva gráfica de Playwright
npm run test:e2e:headed # Ejecutar las pruebas viendo el navegador en tiempo real
npm run build         # Generar paquete de producción en frontend/dist
```

---

## ❓ Solución de Problemas Frecuentes

| Síntoma | Causa casi siempre | Solución |
|---|---|---|
| `Network request failed` en la web | El servidor `backend` no está corriendo | Asegúrate de haber ejecutado `npm run dev` dentro de `backend/` |
| `listen EADDRINUSE :::3000` | El puerto 3000 ya está ocupado | Cierra el proceso anterior o finaliza Node en el Administrador de tareas |

---

## 📋 Historias de Usuario y Responsables
La documentación completa de las **10 Historias de Usuario (HU)** con sus respectivos responsables del equipo y criterios de aceptación en formato Gherkin se encuentra en el archivo:
👉 **[HISTORIAS_DE_USUARIO.md](./HISTORIAS_DE_USUARIO.md)**.
