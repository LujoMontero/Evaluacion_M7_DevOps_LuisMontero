# 🚢 PortTrack - Despliegue y Monitoreo Continuo

Plataforma de navegación portuaria desarrollada para PortTrack, que permite a las autoridades portuarias monitorear, coordinar y gestionar el flujo de embarcaciones en tiempo real. Este proyecto implementa una estrategia completa de **Despliegue Continuo (CD)** y **Monitoreo**, con foco en automatización, escalabilidad y resiliencia.

Repositorio del proyecto:  
👉 https://github.com/LujoMontero/Evaluacion_M7_DevOps_LuisMontero

---

## 🎯 Objetivo

Diseñar e implementar una estrategia de **despliegue continuo y monitoreo** para la plataforma PortTrack, asegurando:

- Automatización de procesos de build y release
- Escalabilidad del sistema
- Resiliencia ante fallos y monitoreo proactivo

---

## ✅ Estructura de la solución

### 1️⃣ Estrategia de despliegue continuo (1.5 pts)

- **Tipo de despliegue:**  
  Se utiliza **Rolling Update** para garantizar una transición gradual sin interrupción del servicio. Alternativas como **Canary** pueden implementarse en producción avanzada.

- **Herramienta CI/CD:**  
  Se selecciona **GitHub Actions** por su integración directa con el repositorio, facilidad de configuración y soporte nativo para Docker, Kubernetes y Helm.

- **Rollback ante fallos:**  
  Se utiliza `helm rollback` en caso de errores en producción. El historial de versiones se mantiene en el clúster para restaurar versiones anteriores.

---

### 2️⃣ Configuración de entornos y seguridad (1.5 pts)

- **Entornos definidos:**  
  - `DEV`: pruebas locales y de integración.
  - `STAGING`: entorno de prueba antes de PRD.
  - `TEST`: pruebas automáticas de validación.
  - `PRD`: entorno de producción en Kubernetes.

- **Gestión de credenciales:**  
  Las credenciales y secretos (`KUBECONFIG_DATA`, `SLACK_WEBHOOK`) se almacenan como **Secrets de GitHub** para garantizar seguridad en el pipeline.

- **Seguridad del pipeline:**  
  - Uso de acciones oficiales (verificadas)
  - No se exponen tokens ni datos sensibles
  - Uso de `base64` para cargar configuraciones seguras al clúster

---

### 3️⃣ Monitoreo continuo (1.5 pts)

- **Herramientas utilizadas:**
  - `Prometheus`: recolección de métricas.
  - `Grafana`: visualización con dashboards.
  - `Alertmanager`: alertas por CPU, errores HTTP y caídas.
  - Alternativas: `CloudWatch`, `ELK`.

- **Logs y métricas:**
  - Contenedores envían logs a un stack ELK o a un bucket centralizado.
  - Se recolectan métricas de disponibilidad, uso de recursos y latencia.

- **Alertas configuradas:**
  - Alertas por caída de pods, errores 5xx o alto uso de CPU.
  - Dashboards organizados por microservicio y entorno.

---

### 4️⃣ Automatización y ChatOps (1.5 pts)

- **Slack + GitHub Actions:**
  - Se integra un webhook de Slack para notificar despliegues exitosos o con errores.
  - Slack alerta sobre eventos en producción (éxito o fallo).

- **Flujos de incidentes con ChatOps:**
  - Los equipos reciben notificaciones automáticas para actuar.
  - Puede integrarse `Hubot` o `Teams` para escalar respuestas automáticamente.

---

# 🚀 Evaluación M7 DevOps – Luis Montero

Proyecto de evaluación para el Módulo 7 del curso de DevOps. Este proyecto consiste en una aplicación Java simple desplegada utilizando Docker, Kubernetes (via Helm), y GitHub Actions para CI/CD, con monitoreo y notificaciones integradas.

---

## 📂 Estructura del Proyecto

```
Evaluacion_M7_DevOps_LuisMontero/
├── app/
│   └── Main.java            # Aplicación Java simple
├── Dockerfile               # Imagen Docker con OpenJDK
├── README.md                # Este documento
├── helm-chart/
│   ├── Chart.yaml           # Metadata de Helm
│   ├── values.yaml          # Configuraciones
│   └── templates/
│       ├── deployment.yaml  # Despliegue K8s
│       └── service.yaml     # Exposición del servicio
└── .github/
    └── workflows/
        └── deploy.yml       # GitHub Actions Workflow
```

---

## 🧪 Cómo Ejecutar

### 🔧 Localmente (Java)

```bash
javac app/Main.java
java -cp app Main
```

### 🐳 Docker

```bash
docker build -t porttrack .
docker run porttrack
```

### ☸️ Kubernetes + Helm

```bash
helm install porttrack ./helm-chart
kubectl get pods
kubectl get svc
```

**Rollback en caso de error:**

```bash
helm rollback porttrack
```

---

## 🔁 GitHub Actions CI/CD

El flujo de CI/CD se activa automáticamente al hacer `push` a la rama `main`.

Incluye:

- ✅ Build de imagen Docker
- ✅ Push a GitHub Container Registry (GHCR)
- ✅ Despliegue en clúster Kubernetes usando Helm
- ✅ Notificación a Slack

---

## 📊 Monitoreo y Alertas

- **Prometheus** y **Grafana** recolectan y visualizan métricas.
- Dashboards disponibles en: [`http://localhost:3000/grafana`](http://localhost:3000/grafana)
- Alertas automáticas enviadas a Slack ante errores o uso excesivo de recursos.

---

## 🤖 ChatOps

- Webhook de Slack configurado para enviar notificaciones automáticas.
- Integración futura con **Hubot** para permitir comandos como `deploy` o `rollback` vía chat.

---

## 📄 Licencia

MIT © 2025 Luis Montero


