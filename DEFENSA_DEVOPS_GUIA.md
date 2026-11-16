# 📋 GUÍA DE DEFENSA FINAL DEVOPS — BANCO MVP

Este documento contiene el guión detallado, la asignación de roles entre los 3 integrantes, los tiempos y los comandos paso a paso para obtener la calificación máxima (**5.0 / Nivel 4 Excelente**) en cada criterio de la rúbrica.

---

## 👥 Roles del Equipo (3 Integrantes)

| Rol | Integrante | Responsabilidad Técnica Principal | Criterios Rúbrica |
| :--- | :--- | :--- | :--- |
| **Integrante 1 (Tú)** | **Lead de Arquitectura, CI/CD & Seguridad** | Pitch inicial, Repositorio Git, Pipeline GitHub Actions (Tests & Fallo Controlado), Manifiestos K8s, Secrets y ConfigMaps. *(Cero uso de Docker local)*. | P1, P2, D1, D2, D7 |
| **Integrante 2** | **Lead de Contenerización & Artefactos** | Pitch técnico, Dockerfiles optimizados, Build & Tags semánticos, Publicación en DockerHub y trazabilidad commit→imagen. | P3, D3, D6 |
| **Integrante 3** | **Lead de Infraestructura & Operaciones** | Despliegue en Minikube (PVC, Probes), Demostración E2E (UI→API→BD), Observabilidad en vivo (`kubectl logs`, `describe`) y Simulación de Fallo/Recuperación. | P4, D4, D5, D8, D9 |

---

## 🎤 PARTE I: ELEVATOR PITCH (4 a 5 Minutos · 20%)

### Minuto 0:00 - 01:30 | Integrante 1 — Problema, Motivación y Propuesta de Valor (P1, P2)
* **Problema real:** "En la banca digital tradicional, más del 40% de los incidentes en producción se deben a inconsistencias contables en cálculos de saldos, reglas de crédito opacas y pipelines frágiles de despliegue donde un error rompe la disponibilidad del servicio."
* **Solución (Banco MVP):** "Diseñamos una plataforma financiera nativa digital con arquitectura orientada al dominio en TypeScript. Cuenta con un motor inmutable de dinero en centavos enteros para evitar errores de coma flotante, sistema francés de amortización, evaluación de scoring declarativo y un módulo de cajitas de ahorro seguras."
* **Alcance:** "Frontend reactivo en React 18, API REST documentada en OpenAPI/Swagger y persistencia relacional estricta en PostgreSQL con modelo de ledger contable transaccional."

### Minuto 01:30 - 03:00 | Integrante 2 — Justificación Técnica y Prácticas DevOps (P3)
* **¿Por qué DevOps?:** "Para garantizar que cada regla financiera sea inviolable, adoptamos una cadena de entrega continua automatizada. Ninguna línea de código llega a producción sin pasar una batería de 33 pruebas unitarias de dominio."
* **Contenedores inmutables:** "Empaquetamos el frontend con Nginx multi-stage (reduciendo la superficie de ataque y tamaño) y el backend en Node Alpine. Las imágenes se etiquetan semánticamente (`v1.0.0` y SHA del commit) y se publican automáticamente en DockerHub, desacoplando el entorno de desarrollo del de producción."
* **Decisiones y compromisos:** "Priorizamos la inmutabilidad de los artefactos y el control de dependencias para asegurar reproducibilidad absoluta en cualquier entorno."

### Minuto 03:00 - 04:30 | Integrante 3 — Infraestructura, Resiliencia y GitOps (P3, P4)
* **Kubernetes en Minikube:** "Orquestamos la solución en Kubernetes utilizando manifiestos declarativos organizados con Kustomize. Separamos configuración mediante ConfigMaps y credenciales con Secrets."
* **Disponibilidad y persistencia:** "El backend cuenta con réplicas y probes de salud (`liveness` y `readiness`). PostgreSQL cuenta con almacenamiento persistente desacoplado (PVC) garantizando cero pérdida de transacciones bancarias ante reinicios de pods."
* **Cierre del Pitch:** "A continuación, demostraremos la cadena completa desde el commit en Git, ejecución de CI, artefactos en DockerHub, hasta el despliegue y flujo bancario en vivo en Minikube."

---

## 💻 PARTE II: DEMOSTRACIÓN TÉCNICA (15 a 20 Minutos · 80%)

### 1. Arquitectura y Repositorio Git (2 min) — Integrante 1 (D1)
1. Mostrar la estructura del repositorio en GitHub:
   * Submódulos o estructura limpia `backend/`, `frontend/`, `k8s/`, `.github/workflows/`.
   * Mostrar el historial de commits trazable y ramas.
   * Mostrar el archivo `LEEME.md` y la reproducibilidad del entorno.

### 2. CI Automatizada, Pruebas y Fallo Controlado (3 min) — Integrante 1 (D2)
1. Abrir GitHub Actions:
   * Mostrar el workflow `.github/workflows/ci.yml`.
   * Enseñar una ejecución exitosa mostrando la ejecución de los **33 tests unitarios** de dominio y typecheck.
2. **Evidencia clave de fallo controlado (Rúbrica D2: "demuestra cómo un fallo impide avanzar"):**
   * Mostrar la ejecución con fallo provocado (vía parámetro `simulate_failure=true` en workflow_dispatch o en un PR con un test roto).
   * Explicar al evaluador: *"El pipeline detecta el fallo en la fase de pruebas y aborta de inmediato, bloqueando la compilación y publicación de imágenes hacia DockerHub."*

### 3. Docker e Imágenes Publicadas en DockerHub (3 min) — Integrante 2 (D3, D6)
1. Mostrar los Dockerfiles:
   * `backend/Dockerfile` (Node 20 Alpine, buenas prácticas, secretos fuera).
   * `frontend/Dockerfile` (Multi-stage build: etapa 1 Node build, etapa 2 Nginx Alpine).
2. Abrir DockerHub en el navegador:
   * Mostrar los repositorios `usuario/banco-backend` y `usuario/banco-frontend`.
   * Enseñar los tags de versión: `latest`, `v1.0.0` y `sha-<commit>`.
   * **Trazabilidad (D6):** Mostrar que el tag `sha-xxxx` coincide exactamente con el último commit aprobado en GitHub.

### 4. Despliegue Declarativo en Minikube y Salud de Pods (3 min) — Integrante 3 (D4, D7)
1. En la terminal de Minikube:
   ```bash
   minikube status
   kubectl config current-context
   ```
2. Mostrar los manifiestos versionados en `k8s/`:
   * Mostrar `02-secrets.yaml` y explicar que los datos sensibles se gestionan por Secrets y no quemados en código (D7).
   * Mostrar `03-postgres.yaml` destacando el `PersistentVolumeClaim` (PVC).
   * Mostrar `04-backend.yaml` destacando las réplicas, `requests/limits`, y los `livenessProbe` / `readinessProbe`.
3. Verificación de recursos en vivo:
   ```bash
   kubectl get pods,svc,pvc,secret,configmap -n banco-mvp
   ```
   * Explicar que todos los pods están en estado `Running` y listos `(1/1)`.

### 5. Flujo Funcional E2E con Persistencia y Caso de Error (4 min) — Integrante 3 & Integrante 1 (D5)
1. Abrir la interfaz web expuesta por Minikube:
   * Iniciar sesión con un usuario existente o registrar uno nuevo.
2. **Flujo exitoso:**
   * Crear una transferencia bancaria o crear una cajita de ahorro.
   * Mostrar que el balance se actualiza en el Dashboard en tiempo real.
3. **Persistencia real en BD:**
   * Consultar la base de datos dentro del pod para certificar que el dato está físicamente guardado:
     ```bash
     kubectl exec -it deployment/banco-postgres -n banco-mvp -- psql -U banco_user -d banco_mvp -c "SELECT id, balance_cents, updated_at FROM accounts LIMIT 5;"
     ```
4. **Caso de error manejado (Rúbrica D5):**
   * Intentar realizar una transferencia por un monto mayor al saldo disponible o con número de tarjeta inválido (violación de algoritmo de Luhn).
   * Mostrar que la API y la UI rechazan la operación controladamente con mensaje descriptivo de negocio.

### 6. Observabilidad, Diagnóstico e Incidente Controlado (3 min) — Integrante 3 (D8)
1. Consultar logs en tiempo real:
   ```bash
   kubectl logs -f deployment/banco-backend -n banco-mvp --tail=20
   ```
2. Realizar una petición desde la web y ver cómo el log registra la solicitud.
3. **Simulación de Falla y Autorecuperación (Self-Healing):**
   * Forzar la eliminación del pod del backend:
     ```bash
     kubectl delete pod -l app=banco-backend -n banco-mvp
     ```
   * Inmediatamente ejecutar:
     ```bash
     kubectl get pods -n banco-mvp -w
     ```
   * Explicar: *"Kubernetes detecta la divergencia entre el estado deseado (2 réplicas) y el estado actual, recreando automáticamente el pod sin caída del servicio para el usuario."*

### 7. Cierre y Trazabilidad de Extremo a Extremo (2 min) — Integrante 2 & Integrante 1 (D6, D9)
* Conectar en una sola línea la historia:
  `Commit en Git` ➡️ `Pipeline GitHub Actions` ➡️ `Imagen en DockerHub con SHA` ➡️ `Manifiesto K8s` ➡️ `Pod en Minikube`.
* Responder preguntas del docente con seguridad y tranquilidad.
