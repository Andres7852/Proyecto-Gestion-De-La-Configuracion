<#
.SYNOPSIS
    Script de despliegue y verificación automatizada en Minikube (Compañero 3).
.DESCRIPTION
    Aplica los manifiestos de Kubernetes, espera a que los Pods estén Ready y abre los servicios.
#>

Write-Host "=== 1. Verificando estado de Minikube y Contexto ===" -ForegroundColor Cyan
minikube status
kubectl config current-context

Write-Host "`n=== 2. Aplicando Manifiestos de Kubernetes (Namespace, Secrets, BD, Backend, Frontend) ===" -ForegroundColor Cyan
kubectl apply -k k8s/

Write-Host "`n=== 3. Esperando que los despliegues estén Listos (Ready) ===" -ForegroundColor Cyan
kubectl rollout status deployment/banco-postgres -n banco-mvp --timeout=120s
kubectl rollout status deployment/banco-backend -n banco-mvp --timeout=120s
kubectl rollout status deployment/banco-frontend -n banco-mvp --timeout=120s

Write-Host "`n=== 4. Estado de Recursos en el Namespace 'banco-mvp' ===" -ForegroundColor Green
kubectl get pods,svc,pvc,secret,configmap -n banco-mvp

Write-Host "`n=== 5. URL de Acceso en Minikube ===" -ForegroundColor Yellow
Write-Host "Ejecuta en una terminal aparte para abrir el Frontend:" -ForegroundColor White
Write-Host "minikube service banco-frontend-svc -n banco-mvp" -ForegroundColor Green
Write-Host "Para el Backend Swagger:" -ForegroundColor White
Write-Host "minikube service banco-backend-svc -n banco-mvp" -ForegroundColor Green
