# 📋 Documentación de Historias de Usuario (HU) — Banco MVP

> **Proyecto Semestral: Gestión de la Configuración — Segunda Entrega**  
> Este documento registra las Historias de Usuario desarrolladas para la plataforma Banco MVP, asignando explícitamente a cada estudiante del equipo la responsabilidad sobre un conjunto de funcionalidades, tal como lo exige la rúbrica de evaluación.

---

## 👥 Integrantes del Equipo y Responsabilidades

| Integrante | Rol Principal | Historias de Usuario Asignadas |
| :--- | :--- | :--- |
| **Juan Fernando Castañeda** | Fullstack & Testing E2E | HU-01, HU-07, HU-10 |
| **Andrés Ortega** | Backend & Arquitectura API | HU-03, HU-04, HU-09 |
| **Tomás Buriticá** | Frontend & Servicios Financieros | HU-02, HU-05, HU-06, HU-08 |

---

## 📊 Matriz Resumen de Historias de Usuario

| ID | Historia de Usuario | Responsable | Módulo / Componente | Estado |
| :---: | :--- | :--- | :--- | :---: |
| **HU-01** | Registro y Autenticación de Usuarios | Juan Fernando Castañeda | Frontend (`LoginView`, `RegisterView`) / Backend (`/auth`) | ✅ Entregada |
| **HU-02** | Dashboard y Consulta de Cuentas en Tiempo Real | Tomás Buriticá | Frontend (`DashboardView`) / Backend (`/cuentas/me`) | ✅ Entregada |
| **HU-03** | Transferencias Inmediatas entre Cuentas | Andrés Ortega | Frontend (`TransferenciasView`) / Backend (`/transferencias`) | ✅ Entregada |
| **HU-04** | Depósitos y Retiros hacia la Caja del Sistema | Andrés Ortega | Frontend (`DepositoRetiroView`) / Backend (`/transferencias/recarga`, `/retiro`) | ✅ Entregada |
| **HU-05** | Emisión y Validación de Tarjetas (Algoritmo de Luhn) | Tomás Buriticá | Frontend (`TarjetasView`) / Backend (`/tarjetas`, `domain/luhn.ts`) | ✅ Entregada |
| **HU-06** | Cajitas de Ahorro y Gestión de Metas Financieras | Tomás Buriticá | Frontend (`CajitasView`) / Backend (`/cajitas`) | ✅ Entregada |
| **HU-07** | Simulador y Solicitud de Crédito (Sistema Francés) | Juan Fernando Castañeda | Frontend (`CreditosView`) / Backend (`domain/amortizacion.ts`, `/creditos`) | ✅ Entregada |
| **HU-08** | Notificaciones Transaccionales y de Sistema | Tomás Buriticá | Frontend (`NotificacionesView`) / Backend (`/notificaciones`) | ✅ Entregada |
| **HU-09** | Documentación Técnica de API con Swagger / OpenAPI | Andrés Ortega | Backend (`src/swagger.ts`, `/api-docs`) | ✅ Entregada |
| **HU-10** | Automatización de Pruebas E2E con Playwright | Juan Fernando Castañeda | Frontend (`playwright.config.ts`, `e2e/*.spec.ts`) | ✅ Entregada |

---

## 📝 Detalle de Historias de Usuario y Criterios de Aceptación

---

### HU-01: Registro y Autenticación de Usuarios
* **Responsable:** Juan Fernando Castañeda
* **Descripción:**
  * **Como** nuevo usuario del banco,
  * **quiero** crear una cuenta con mi correo, nombre y contraseña, e iniciar sesión de forma segura,
  * **para** acceder a mis productos financieros en la plataforma digital.
* **Criterios de Aceptación:**
  * **Dado** un usuario no registrado, **cuando** ingresa nombre completo, correo único y contraseña de al menos 6 caracteres y pulsa "Registrarme", **entonces** el sistema crea su usuario con hash seguro (bcrypt), le asigna una cuenta bancaria inicial, emite una tarjeta de débito y abre automáticamente su sesión mediante token JWT.
  * **Dado** un usuario registrado, **cuando** ingresa sus credenciales correctas en el formulario de login, **entonces** el sistema valida las credenciales y le otorga acceso al Dashboard.
  * **Dado** un usuario que ingresa una contraseña incorrecta o un correo no registrado, **cuando** envía el formulario, **entonces** el sistema muestra un mensaje de error claro sin exponer detalles técnicos sensibles.

---

### HU-02: Dashboard y Consulta de Cuentas en Tiempo Real
* **Responsable:** Tomás Buriticá
* **Descripción:**
  * **Como** cliente bancario,
  * **quiero** visualizar el saldo total disponible, mi número de cuenta y el resumen de mis productos en una sola pantalla,
  * **para** tener visibilidad inmediata de mi situación financiera.
* **Criterios de Aceptación:**
  * **Dado** un cliente autenticado en el sistema, **cuando** accede a la vista principal ("Inicio"), **entonces** observa su saldo disponible, saldo contable, tipo de cuenta y su tarjeta de débito activa.
  * **Dado** el visor de saldo en el Dashboard, **cuando** el usuario pulsa el icono del ojo ("Ocultar/Mostrar saldo"), **entonces** la cifra alterna entre su valor real y asteriscos para mayor privacidad.
  * **Dado** un cliente con transacciones recientes, **cuando** consulta el panel inferior, **entonces** se listan los últimos movimientos con monto, fecha y estado.

---

### HU-03: Transferencias Inmediatas entre Cuentas
* **Responsable:** Andrés Ortega
* **Descripción:**
  * **Como** titular de una cuenta bancaria,
  * **quiero** transferir fondos a otra cuenta ingresando el número de cuenta de destino,
  * **para** enviar dinero a terceros de forma inmediata y confiable.
* **Criterios de Aceptación:**
  * **Dado** un número de cuenta destino ingresado, **cuando** el usuario pulsa "Buscar", **entonces** el sistema consulta la base de datos y muestra el nombre del titular para confirmación previa.
  * **Dado** que la cuenta origen tiene fondos suficientes, **cuando** se confirma la transferencia, **entonces** el backend ejecuta una transacción atómica que debita de la cuenta origen, acredita en la cuenta destino e inserta los registros correspondientes en el ledger contable.
  * **Dado** que el usuario intenta transferir más dinero del saldo disponible o a su propia cuenta, **cuando** intenta procesar la operación, **entonces** el backend rechaza la transacción con un mensaje explicativo y no se altera ningún saldo.

---

### HU-04: Depósitos y Retiros hacia la Caja del Sistema
* **Responsable:** Andrés Ortega
* **Descripción:**
  * **Como** cliente de Banco MVP,
  * **quiero** recargar saldo a mi cuenta o retirar dinero en efectivo mediante la caja general del sistema,
  * **para** alimentar mi cuenta para pruebas o retirar excedentes de liquidez.
* **Criterios de Aceptación:**
  * **Dado** un monto positivo ingresado en la sección de Recarga, **cuando** el usuario confirma la operación, **entonces** el backend debita de la cuenta maestra del sistema (`SYS-0000000001`) y acredita inmediatamente en la cuenta del usuario.
  * **Dado** un monto para retiro, **cuando** el saldo disponible del usuario es suficiente, **entonces** se transfiere a la cuenta del sistema y el saldo disponible del cliente disminuye en tiempo real.

---

### HU-05: Emisión y Validación de Tarjetas (Algoritmo de Luhn)
* **Responsable:** Tomás Buriticá
* **Descripción:**
  * **Como** cliente bancario,
  * **quiero** solicitar tarjetas de débito o crédito asociadas a mis cuentas,
  * **para** disponer de medios de pago físicos y virtuales seguros.
* **Criterios de Aceptación:**
  * **Dado** un usuario que solicita una nueva tarjeta, **cuando** el sistema genera la tarjeta, **entonces** el número se construye y valida matemáticamente mediante el **Algoritmo de Luhn** (módulo 10).
  * **Dado** el panel de "Mis Tarjetas", **cuando** el cliente ingresa, **entonces** puede visualizar el tipo de tarjeta (Débito/Crédito), los últimos 4 dígitos, fecha de vencimiento y estado (ACTIVE/FROZEN).

---

### HU-06: Cajitas de Ahorro y Gestión de Metas Financieras
* **Responsable:** Tomás Buriticá
* **Descripción:**
  * **Como** ahorrador disciplinado,
  * **quiero** crear bolsillos o "cajitas" de ahorro con metas específicas y transferir fondos hacia ellas,
  * **para** separar mi dinero según propósitos personales sin mezclarlo con mi saldo corriente.
* **Criterios de Aceptación:**
  * **Dado** el formulario de "Crear Nueva Cajita", **cuando** el usuario ingresa un nombre (ej. "Vacaciones") y una meta opcional, **entonces** se crea una subcuenta de ahorro vinculada al usuario.
  * **Dado** una cajita existente y saldo disponible en la cuenta principal, **cuando** el cliente transfiere un monto a la cajita, **entonces** el dinero se bloquea de la cuenta principal y aumenta el balance de la cajita mostrando la barra de progreso hacia la meta.
  * **Dado** dinero en una cajita, **cuando** el cliente pulsa "Retirar a Cuenta", **entonces** los fondos retornan de forma inmediata a la cuenta principal.

---

### HU-07: Simulador y Solicitud de Crédito (Sistema Francés)
* **Responsable:** Juan Fernando Castañeda
* **Descripción:**
  * **Como** cliente interesado en financiamiento,
  * **quiero** simular préstamos calculando las cuotas mensuales bajo el sistema de amortización francés y solicitar desembolsos evaluados por un motor de scoring,
  * **para** conocer con exactitud cuánto pagaré cada mes y acceder a crédito responsable.
* **Criterios de Aceptación:**
  * **Dado** un monto, plazo en meses y tasa de interés, **cuando** el usuario pulsa "Calcular Amortización", **entonces** el motor de cálculo funcional genera la cuota fija mensual y la tabla detallada desglosando abono a capital, interés decreciente y saldo final exacto en cero.
  * **Dado** una solicitud formal de crédito, **cuando** el usuario envía sus ingresos y datos laborales, **entonces** el motor de scoring evalúa las reglas de negocio (endeudamiento < 30%, antigüedad mínima) y aprueba o rechaza el desembolso con su respectivo motivo.

---

### HU-08: Centro de Notificaciones Transaccionales y de Sistema
* **Responsable:** Tomás Buriticá
* **Descripción:**
  * **Como** usuario del banco,
  * **quiero** recibir notificaciones de eventos clave (bienvenida, transferencias recibidas, pagos de créditos),
  * **para** mantenerme informado de cualquier actividad en mi cuenta.
* **Criterios de Aceptación:**
  * **Dado** un evento transaccional, **cuando** se procesa en el backend, **entonces** se inserta un registro en la tabla `notifications` y la campana en la barra superior muestra el contador de notificaciones no leídas.
  * **Dado** el listado de notificaciones, **cuando** el usuario hace clic en "Marcar todas como leídas", **entonces** se actualiza su estado `read_at` y el contador se reinicia a cero.

---

### HU-09: Documentación Técnica de API con Swagger / OpenAPI
* **Responsable:** Andrés Ortega
* **Descripción:**
  * **Como** desarrollador, arquitecto o docente evaluador,
  * **quiero** contar con una especificación interactiva OpenAPI 3.0 accesible vía navegador web en `/api-docs`,
  * **para** consultar, inspeccionar y probar los 24 endpoints del backend de manera autónoma.
* **Criterios de Aceptación:**
  * **Dado** el servidor backend en ejecución en el puerto 3000, **cuando** se navega a `http://localhost:3000/api-docs`, **entonces** se renderiza la interfaz gráfica de Swagger UI con todos los módulos y modelos de datos.
  * **Dado** el botón "Authorize" en Swagger UI, **cuando** el evaluador ingresa un token JWT válido, **entonces** puede ejecutar peticiones a rutas protegidas (`/cuentas/me`, `/transferencias`, etc.) directamente desde la interfaz.
  * **Dado** el endpoint `GET /api-docs.json`, **cuando** es consumido por herramientas externas o linters, **entonces** retorna la especificación OpenAPI 3.0 en formato JSON válido.

---

### HU-10: Automatización de Pruebas E2E con Playwright
* **Responsable:** Juan Fernando Castañeda
* **Descripción:**
  * **Como** equipo de aseguramiento de calidad (QA) y entrega continua,
  * **quiero** disponer de una suite automatizada de pruebas end-to-end con Playwright para los flujos críticos del sistema,
  * **para** garantizar que los despliegues y nuevas funcionalidades no rompan la experiencia de usuario ni la comunicación frontend-backend.
* **Criterios de Aceptación:**
  * **Dado** el comando `npm run test:e2e` en la carpeta `frontend/`, **cuando** se ejecuta, **entonces** Playwright orquesta el levantamiento del backend y frontend, y corre sin errores los 7 tests automatizados en modo headless.
  * **Dado** el flujo de autenticación (`auth.spec.ts`), **cuando** se ejecuta la prueba, **entonces** valida el formulario de inicio de sesión, la navegación a registro, la creación de cuenta única, el acceso al Dashboard, el cierre de sesión y el inicio de sesión posterior.
  * **Dado** el flujo de crédito y navegación (`creditos.spec.ts` y `navegacion.spec.ts`), **cuando** se ejecutan, **entonces** verifican el cálculo de amortización francesa y el renderizado correcto de transferencias, tarjetas y cajitas.
