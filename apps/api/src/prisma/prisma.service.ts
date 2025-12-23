diff --git a/apps/api/src/prisma/prisma.service.ts b/apps/api/src/prisma/prisma.service.ts
new file mode 100644
index 0000000000000000000000000000000000000000..d86f65db13da288366c6bd719f180d86915dc15b
--- /dev/null
+++ b/apps/api/src/prisma/prisma.service.ts
@@ -0,0 +1,13 @@
+import { Injectable, OnModuleDestroy, OnModuleInit } from "@nestjs/common";
+import { PrismaClient } from "@prisma/client";
+
+@Injectable()
+export class PrismaService extends PrismaClient implements OnModuleInit, OnModuleDestroy {
+  async onModuleInit() {
+    await this.$connect();
+  }
+
+  async onModuleDestroy() {
+    await this.$disconnect();
+  }
+}
