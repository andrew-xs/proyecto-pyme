diff --git a/apps/api/src/prisma/prisma.module.ts b/apps/api/src/prisma/prisma.module.ts
new file mode 100644
index 0000000000000000000000000000000000000000..7a94e733261632c360c6b87b5801ea0f37a33ba2
--- /dev/null
+++ b/apps/api/src/prisma/prisma.module.ts
@@ -0,0 +1,9 @@
+import { Global, Module } from "@nestjs/common";
+import { PrismaService } from "./prisma.service";
+
+@Global()
+@Module({
+  providers: [PrismaService],
+  exports: [PrismaService]
+})
+export class PrismaModule {}
