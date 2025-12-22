diff --git a/README.md b/README.md
index 0c1a95444b0ebf36f489a8ff93cf9ec2da1f78ca..5aa4eabcb2250e4c590a46e44d7a915cf395e444 100644
--- a/README.md
+++ b/README.md
@@ -1,2 +1,80 @@
-# proyecto-pyme
-proyecto para pymes
+# CumplePyme (MVP base)
+
+Monorepo PNPM con NestJS (API), Next.js (Web) y Prisma (DB) para el MVP de CumplePyme.
+
+## Requisitos
+- Node.js 20+
+- pnpm 9+
+- Docker (para Postgres/MinIO)
+
+## Setup rápido
+1) Copia variables de entorno:
+```bash
+cp .env.example .env
+```
+
+Revisa `JWT_SECRET`, `SMTP_*` y credenciales de `S3_*` en `.env` para usar valores reales en producción.
+
+2) Instala dependencias:
+```bash
+pnpm install
+```
+
+3) Levanta todo en modo desarrollo (DB + migraciones + seed + API + Web):
+```bash
+pnpm dev
+```
+
+4) El bucket MinIO se crea automáticamente por `infra/init-minio.sh`.
+
+## Comandos útiles
+```bash
+pnpm db:up       # levanta postgres/minio
+pnpm db:down     # baja servicios y elimina volúmenes
+pnpm db:migrate  # aplica migraciones Prisma
+pnpm db:seed     # inserta comunas piloto
+```
+
+## Verificación
+- API: `http://localhost:3001/healthz`
+- Web: `http://localhost:3000`
+
+## Flujo básico MVP
+1) Registra un usuario en `/register`.
+2) Inicia sesión en `/login` (guarda el token en localStorage).
+3) Crea empresa desde `/dashboard`.
+4) Crea locales desde `/dashboard`.
+5) Revisa detalle de local en `/locals/:id`.
+6) En el detalle puedes ver checklist, subir/adjuntar documentos y exportar PDF.
+
+## Runbook (Producción)
+### Variables requeridas
+API:
+- `APP_PORT`, `DATABASE_URL`, `JWT_SECRET`
+- `S3_ENDPOINT`, `S3_BUCKET`, `S3_ACCESS_KEY`, `S3_SECRET_KEY`
+- `SMTP_HOST`, `SMTP_PORT`, `SMTP_USER`, `SMTP_PASS`, `SMTP_FROM`
+
+Web:
+- `NEXT_PUBLIC_API_URL`, `WEB_PORT`
+
+### Migraciones y seed
+```bash
+pnpm db:migrate
+pnpm db:seed
+```
+
+### Docker
+- API: `apps/api/Dockerfile`
+- Web: `apps/web/Dockerfile`
+
+### CI/CD (Render recomendado)
+1) Crea dos servicios en Render (staging y production) para API y Web.
+2) Configura Deploy Hooks y guarda en GitHub Secrets:
+   - `RENDER_STAGING_DEPLOY_HOOK`
+   - `RENDER_PRODUCTION_DEPLOY_HOOK`
+3) Push a `main` despliega staging (workflow `deploy-staging.yml`).
+4) Crear tag `vX.Y.Z` despliega producción (workflow `deploy-production.yml`).
+
+### Observabilidad mínima
+- Logs estructurados JSON en API (middleware + filtros).
+- `/healthz` verifica DB y bucket S3.
