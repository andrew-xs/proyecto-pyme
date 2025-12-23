diff --git a/apps/api/prisma/migrations/20241221000300_requirements_docs_exports/migration.sql b/apps/api/prisma/migrations/20241221000300_requirements_docs_exports/migration.sql
new file mode 100644
index 0000000000000000000000000000000000000000..c47ee17577d81d41931796c13e2ada20fe636ab8
--- /dev/null
+++ b/apps/api/prisma/migrations/20241221000300_requirements_docs_exports/migration.sql
@@ -0,0 +1,102 @@
+CREATE TYPE "RequirementStatus" AS ENUM ('NOT_STARTED', 'IN_PROGRESS', 'DONE', 'EXPIRED', 'NOT_APPLICABLE');
+
+CREATE TABLE "requirement_templates" (
+    "id" TEXT NOT NULL,
+    "code" TEXT NOT NULL,
+    "title" TEXT NOT NULL,
+    "description" TEXT NOT NULL,
+    "module" "Module" NOT NULL,
+    "applicableProfiles" "Profile"[],
+    "reminderDays" INTEGER[] DEFAULT ARRAY[30,7,1,0]::INTEGER[],
+    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
+
+    CONSTRAINT "requirement_templates_pkey" PRIMARY KEY ("id")
+);
+
+CREATE TABLE "requirement_instances" (
+    "id" TEXT NOT NULL,
+    "localId" TEXT NOT NULL,
+    "templateId" TEXT NOT NULL,
+    "status" "RequirementStatus" NOT NULL DEFAULT 'NOT_STARTED',
+    "dueDate" TIMESTAMP(3),
+    "assigneeId" TEXT,
+    "notes" TEXT,
+    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
+    "completedAt" TIMESTAMP(3),
+
+    CONSTRAINT "requirement_instances_pkey" PRIMARY KEY ("id")
+);
+
+CREATE TABLE "documents" (
+    "id" TEXT NOT NULL,
+    "localId" TEXT NOT NULL,
+    "uploadedBy" TEXT,
+    "type" TEXT NOT NULL,
+    "fileKey" TEXT NOT NULL,
+    "fileName" TEXT NOT NULL,
+    "mimeType" TEXT NOT NULL,
+    "sizeBytes" INTEGER NOT NULL,
+    "issueDate" TIMESTAMP(3),
+    "expiryDate" TIMESTAMP(3),
+    "isCurrent" BOOLEAN NOT NULL DEFAULT true,
+    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
+
+    CONSTRAINT "documents_pkey" PRIMARY KEY ("id")
+);
+
+CREATE TABLE "requirement_documents" (
+    "requirementInstanceId" TEXT NOT NULL,
+    "documentId" TEXT NOT NULL,
+
+    CONSTRAINT "requirement_documents_pkey" PRIMARY KEY ("requirementInstanceId","documentId")
+);
+
+CREATE TABLE "exports" (
+    "id" TEXT NOT NULL,
+    "localId" TEXT NOT NULL,
+    "type" TEXT NOT NULL,
+    "fileKey" TEXT NOT NULL,
+    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
+
+    CONSTRAINT "exports_pkey" PRIMARY KEY ("id")
+);
+
+CREATE TABLE "notification_log" (
+    "id" TEXT NOT NULL,
+    "requirementInstanceId" TEXT NOT NULL,
+    "daysBefore" INTEGER NOT NULL,
+    "targetDate" TIMESTAMP(3) NOT NULL,
+    "sentAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
+
+    CONSTRAINT "notification_log_pkey" PRIMARY KEY ("id")
+);
+
+CREATE UNIQUE INDEX "requirement_templates_code_key" ON "requirement_templates"("code");
+
+CREATE INDEX "requirement_instances_localId_status_idx" ON "requirement_instances"("localId", "status");
+
+CREATE INDEX "requirement_instances_localId_dueDate_idx" ON "requirement_instances"("localId", "dueDate");
+
+CREATE INDEX "documents_localId_type_idx" ON "documents"("localId", "type");
+
+CREATE INDEX "documents_localId_expiryDate_idx" ON "documents"("localId", "expiryDate");
+
+CREATE UNIQUE INDEX "notification_log_requirementInstanceId_daysBefore_targetDate_key" ON "notification_log"("requirementInstanceId", "daysBefore", "targetDate");
+
+ALTER TABLE "requirement_instances" ADD CONSTRAINT "requirement_instances_localId_fkey" FOREIGN KEY ("localId") REFERENCES "locals"("id") ON DELETE CASCADE ON UPDATE CASCADE;
+
+ALTER TABLE "requirement_instances" ADD CONSTRAINT "requirement_instances_templateId_fkey" FOREIGN KEY ("templateId") REFERENCES "requirement_templates"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
+
+ALTER TABLE "requirement_instances" ADD CONSTRAINT "requirement_instances_assigneeId_fkey" FOREIGN KEY ("assigneeId") REFERENCES "users"("id") ON DELETE SET NULL ON UPDATE CASCADE;
+
+ALTER TABLE "documents" ADD CONSTRAINT "documents_localId_fkey" FOREIGN KEY ("localId") REFERENCES "locals"("id") ON DELETE CASCADE ON UPDATE CASCADE;
+
+ALTER TABLE "documents" ADD CONSTRAINT "documents_uploadedBy_fkey" FOREIGN KEY ("uploadedBy") REFERENCES "users"("id") ON DELETE SET NULL ON UPDATE CASCADE;
+
+ALTER TABLE "requirement_documents" ADD CONSTRAINT "requirement_documents_requirementInstanceId_fkey" FOREIGN KEY ("requirementInstanceId") REFERENCES "requirement_instances"("id") ON DELETE CASCADE ON UPDATE CASCADE;
+
+ALTER TABLE "requirement_documents" ADD CONSTRAINT "requirement_documents_documentId_fkey" FOREIGN KEY ("documentId") REFERENCES "documents"("id") ON DELETE CASCADE ON UPDATE CASCADE;
+
+ALTER TABLE "exports" ADD CONSTRAINT "exports_localId_fkey" FOREIGN KEY ("localId") REFERENCES "locals"("id") ON DELETE CASCADE ON UPDATE CASCADE;
+
+ALTER TABLE "notification_log" ADD CONSTRAINT "notification_log_requirementInstanceId_fkey" FOREIGN KEY ("requirementInstanceId") REFERENCES "requirement_instances"("id") ON DELETE CASCADE ON UPDATE CASCADE;
