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

## 📂 Estructura del proyecto

Evaluacion_M7_DevOps_LuisMontero/
├── app/
│ └── Main.java # Aplicación Java simple
├── Dockerfile # Imagen Docker con OpenJDK
├── README.md # Este documento
├── helm-chart/
│ ├── Chart.yaml # Metadata de Helm
│ ├── values.yaml # Configuraciones
│ └── templates/
│ ├── deployment.yaml # Despliegue K8s
│ └── service.yaml # Exposición del servicio
└── .github/
└── workflows/
└── deploy.yml # GitHub Actions Workflow

yaml

---

## 🧪 Cómo ejecutar

### 🔧 Localmente (Java)

```bash
javac app/Main.java
java -cp app Main
```

---



