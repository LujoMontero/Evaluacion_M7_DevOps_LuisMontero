<div align="center">

# 🚢 PortTrack — Despliegue Continuo y Monitoreo

### Java · Docker · Kubernetes · Helm · GitHub Actions · Prometheus · Grafana

![Java](https://img.shields.io/badge/Java_17-ED8B00?style=for-the-badge&logo=openjdk&logoColor=white)
![Docker](https://img.shields.io/badge/Docker-2496ED?style=for-the-badge&logo=docker&logoColor=white)
![Kubernetes](https://img.shields.io/badge/Kubernetes-326CE5?style=for-the-badge&logo=kubernetes&logoColor=white)
![Helm](https://img.shields.io/badge/Helm-0F1689?style=for-the-badge&logo=helm&logoColor=white)
![GitHub Actions](https://img.shields.io/badge/GitHub_Actions-2088FF?style=for-the-badge&logo=githubactions&logoColor=white)
![Prometheus](https://img.shields.io/badge/Prometheus-E6522C?style=for-the-badge&logo=prometheus&logoColor=white)
![Grafana](https://img.shields.io/badge/Grafana-F46800?style=for-the-badge&logo=grafana&logoColor=white)

</div>

---

## 📌 ¿Qué hace este proyecto?

**PortTrack** es una plataforma de coordinación portuaria que permite a las autoridades gestionar y monitorear el flujo de embarcaciones en tiempo real. Este repositorio implementa la **estrategia completa de Despliegue Continuo (CD) y Monitoreo**: Docker, Kubernetes con Helm, pipeline GitHub Actions con rollback automático y alertas ChatOps vía Slack.

---

## 🏗️ Estructura del proyecto

```
Evaluacion_M7_DevOps_LuisMontero/
├── app/
│   └── Main.java                  # Aplicación Java principal
├── Dockerfile                     # Imagen Docker con OpenJDK
├── helm-chart/
│   ├── Chart.yaml                 # Metadata del chart
│   ├── values.yaml                # Configuración de despliegue
│   └── templates/
│       ├── deployment.yaml        # Definición del pod K8s
│       └── service.yaml           # Exposición del servicio
└── .github/
    └── workflows/
        └── deploy.yml             # Pipeline CI/CD completo
```

---

## 🚀 Ejecutar el proyecto

### Localmente (Java)
```bash
javac app/Main.java
java -cp app Main
```

### Docker
```bash
# Construir imagen
docker build -t porttrack .

# Ejecutar contenedor
docker run porttrack
```

### Kubernetes + Helm
```bash
# Instalar en el clúster
helm install porttrack ./helm-chart

# Verificar estado
kubectl get pods
kubectl get svc

# Rollback en caso de error
helm rollback porttrack
```

---

## 🔁 Pipeline CI/CD — GitHub Actions

El pipeline se activa automáticamente con cada `push` a `main`:

```yaml
name: PortTrack CD Pipeline

on:
  push:
    branches: [main]

jobs:
  build-and-deploy:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3

      - name: Build Docker image
        run: docker build -t ghcr.io/lujomontero/porttrack:latest .

      - name: Push a GHCR
        run: docker push ghcr.io/lujomontero/porttrack:latest

      - name: Deploy con Helm en K8s
        run: |
          echo "${{ secrets.KUBECONFIG_DATA }}" | base64 -d > kubeconfig.yml
          helm upgrade --install porttrack ./helm-chart \
            --set image.tag=latest \
            --kubeconfig kubeconfig.yml

      - name: Notificar a Slack
        uses: slackapi/slack-github-action@v1
        with:
          payload: '{"text":"✅ PortTrack desplegado correctamente en producción"}'
        env:
          SLACK_WEBHOOK_URL: ${{ secrets.SLACK_WEBHOOK }}
```

---

## 🌍 Entornos definidos

| Entorno | Propósito |
|---|---|
| `DEV` | Pruebas locales e integración del desarrollador |
| `STAGING` | Validación previa a producción |
| `TEST` | Suite de pruebas automáticas |
| `PRD` | Producción en clúster Kubernetes |

---

## 🔄 Estrategia de despliegue — Rolling Update

Se usa **Rolling Update** para garantizar disponibilidad continua durante deploys:

```
Pod v1 ──▶ Pod v1 (activo)
           Pod v2 (nuevo) ──▶ Pod v2 (activo) ──▶ Pod v1 eliminado
```

**Rollback automático ante fallo:**
```bash
helm rollback porttrack    # Restaura la versión anterior del chart
```

---

## 📊 Monitoreo con Prometheus + Grafana

```
App ──▶ Prometheus (métricas) ──▶ Grafana (dashboards)
                    │
                    ▼
             Alertmanager ──▶ Slack (notificaciones)
```

**Métricas monitoreadas:** CPU, memoria, latencia, errores HTTP 5xx, disponibilidad de pods

**Dashboards disponibles en:** `http://localhost:3000/grafana`

**Alertas configuradas:**
- 🔴 Caída de pods
- 🟡 CPU > 80%
- 🟠 Errores HTTP 5xx
- 🔴 Latencia > 1 segundo

---

## 🤖 ChatOps — Notificaciones Slack

El pipeline envía notificaciones automáticas a Slack en cada despliegue:

- ✅ Deploy exitoso → notificación verde
- ❌ Deploy fallido → alerta roja con link al log
- 🔄 Rollback ejecutado → notificación de restauración

---

## 🔐 Seguridad del pipeline

- Credenciales almacenadas como **GitHub Secrets** (nunca en código)
- `KUBECONFIG_DATA`: configuración del clúster en base64
- `SLACK_WEBHOOK`: URL de notificaciones
- Solo se usan **actions verificadas** de GitHub Marketplace

---

## 📄 Documentación completa

Disponible en: [`Despliegue_M7_DevOps_LuisMontero.pdf`](./Despliegue_M7_DevOps_LuisMontero.pdf)

---

## 👨‍💻 Autor

**Luis Montero** · Especialización DevOps · 2025  
[GitHub](https://github.com/LujoMontero) · [LinkedIn](https://www.linkedin.com/in/luis-montero-if/)
