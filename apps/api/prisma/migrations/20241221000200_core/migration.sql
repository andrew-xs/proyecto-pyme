diff --git a/apps/api/prisma/migrations/20241221000200_core/migration.sql b/apps/api/prisma/migrations/20241221000200_core/migration.sql
new file mode 100644
index 0000000000000000000000000000000000000000..d6d9ed49a4b5a358c5859a1b87e2d550c0dbaa5c
--- /dev/null
+++ b/apps/api/prisma/migrations/20241221000200_core/migration.sql
@@ -0,0 +1,86 @@
+CREATE TYPE "Role" AS ENUM ('OWNER', 'MANAGER', 'MEMBER');
+
+CREATE TYPE "Profile" AS ENUM ('P1', 'P2', 'P3', 'P4');
+
+CREATE TYPE "Module" AS ENUM ('BASE', 'DOM', 'SANITARIO', 'TRANSPORTE');
+
+CREATE TABLE "users" (
+    "id" TEXT NOT NULL,
+    "email" TEXT NOT NULL,
+    "passwordHash" TEXT NOT NULL,
+    "name" TEXT NOT NULL,
+    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
+
+    CONSTRAINT "users_pkey" PRIMARY KEY ("id")
+);
+
+CREATE TABLE "companies" (
+    "id" TEXT NOT NULL,
+    "name" TEXT NOT NULL,
+    "rut" TEXT,
+    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
+
+    CONSTRAINT "companies_pkey" PRIMARY KEY ("id")
+);
+
+CREATE TABLE "company_members" (
+    "id" TEXT NOT NULL,
+    "companyId" TEXT NOT NULL,
+    "userId" TEXT NOT NULL,
+    "role" "Role" NOT NULL,
+    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
+
+    CONSTRAINT "company_members_pkey" PRIMARY KEY ("id")
+);
+
+CREATE TABLE "locals" (
+    "id" TEXT NOT NULL,
+    "companyId" TEXT NOT NULL,
+    "comunaId" INTEGER NOT NULL,
+    "name" TEXT NOT NULL,
+    "address" TEXT NOT NULL,
+    "profile" "Profile" NOT NULL,
+    "modules" "Module"[],
+    "onboardingAnswer" JSONB NOT NULL,
+    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
+
+    CONSTRAINT "locals_pkey" PRIMARY KEY ("id")
+);
+
+CREATE TABLE "audit_events" (
+    "id" TEXT NOT NULL,
+    "companyId" TEXT NOT NULL,
+    "userId" TEXT,
+    "localId" TEXT,
+    "actionType" TEXT NOT NULL,
+    "entityType" TEXT NOT NULL,
+    "entityId" TEXT,
+    "metadata" JSONB,
+    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
+
+    CONSTRAINT "audit_events_pkey" PRIMARY KEY ("id")
+);
+
+CREATE UNIQUE INDEX "users_email_key" ON "users"("email");
+
+CREATE UNIQUE INDEX "company_members_companyId_userId_key" ON "company_members"("companyId", "userId");
+
+CREATE INDEX "locals_companyId_idx" ON "locals"("companyId");
+
+CREATE INDEX "audit_events_companyId_createdAt_idx" ON "audit_events"("companyId", "createdAt");
+
+CREATE INDEX "audit_events_localId_createdAt_idx" ON "audit_events"("localId", "createdAt");
+
+ALTER TABLE "company_members" ADD CONSTRAINT "company_members_companyId_fkey" FOREIGN KEY ("companyId") REFERENCES "companies"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
+
+ALTER TABLE "company_members" ADD CONSTRAINT "company_members_userId_fkey" FOREIGN KEY ("userId") REFERENCES "users"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
+
+ALTER TABLE "locals" ADD CONSTRAINT "locals_companyId_fkey" FOREIGN KEY ("companyId") REFERENCES "companies"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
+
+ALTER TABLE "locals" ADD CONSTRAINT "locals_comunaId_fkey" FOREIGN KEY ("comunaId") REFERENCES "comunas"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
+
+ALTER TABLE "audit_events" ADD CONSTRAINT "audit_events_companyId_fkey" FOREIGN KEY ("companyId") REFERENCES "companies"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
+
+ALTER TABLE "audit_events" ADD CONSTRAINT "audit_events_userId_fkey" FOREIGN KEY ("userId") REFERENCES "users"("id") ON DELETE SET NULL ON UPDATE CASCADE;
+
+ALTER TABLE "audit_events" ADD CONSTRAINT "audit_events_localId_fkey" FOREIGN KEY ("localId") REFERENCES "locals"("id") ON DELETE SET NULL ON UPDATE CASCADE;
