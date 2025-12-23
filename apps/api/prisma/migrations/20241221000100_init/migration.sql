diff --git a/apps/api/prisma/migrations/20241221000100_init/migration.sql b/apps/api/prisma/migrations/20241221000100_init/migration.sql
new file mode 100644
index 0000000000000000000000000000000000000000..aa7c0b364014bfcd0b2dc428c5007fa9232c8700
--- /dev/null
+++ b/apps/api/prisma/migrations/20241221000100_init/migration.sql
@@ -0,0 +1,10 @@
+CREATE TABLE "comunas" (
+    "id" SERIAL NOT NULL,
+    "name" TEXT NOT NULL,
+    "region" TEXT NOT NULL DEFAULT 'Biobío',
+    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
+
+    CONSTRAINT "comunas_pkey" PRIMARY KEY ("id")
+);
+
+CREATE UNIQUE INDEX "comunas_name_key" ON "comunas"("name");
