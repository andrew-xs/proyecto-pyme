diff --git a/apps/api/src/app.module.ts b/apps/api/src/app.module.ts
new file mode 100644
index 0000000000000000000000000000000000000000..ad55ab44158bb9f00251ca660592597be1c87ff8
--- /dev/null
+++ b/apps/api/src/app.module.ts
@@ -0,0 +1,37 @@
+import { Module } from "@nestjs/common";
+import { ConfigModule } from "@nestjs/config";
+import { validateEnv } from "./config/env";
+import { HealthController } from "./health.controller";
+import { PrismaModule } from "./prisma/prisma.module";
+import { AuthModule } from "./auth/auth.module";
+import { CompaniesModule } from "./companies/companies.module";
+import { LocalsModule } from "./locals/locals.module";
+import { AuditModule } from "./audit/audit.module";
+import { RequirementsModule } from "./requirements/requirements.module";
+import { DocumentsModule } from "./documents/documents.module";
+import { ExportsModule } from "./exports/exports.module";
+import { ScheduleModule } from "@nestjs/schedule";
+import { NotificationsModule } from "./notifications/notifications.module";
+import { HealthService } from "./health.service";
+
+@Module({
+  imports: [
+    ConfigModule.forRoot({
+      isGlobal: true,
+      validate: validateEnv
+    }),
+    ScheduleModule.forRoot(),
+    PrismaModule,
+    AuthModule,
+    CompaniesModule,
+    LocalsModule,
+    AuditModule,
+    RequirementsModule,
+    DocumentsModule,
+    ExportsModule,
+    NotificationsModule
+  ],
+  controllers: [HealthController],
+  providers: [HealthService]
+})
+export class AppModule {}
