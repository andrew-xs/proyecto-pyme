diff --git a/apps/api/src/config/env.ts b/apps/api/src/config/env.ts
new file mode 100644
index 0000000000000000000000000000000000000000..c008662b29b8d8cc9b90b9f13d84e12cf9d0f4d6
--- /dev/null
+++ b/apps/api/src/config/env.ts
@@ -0,0 +1,21 @@
+import { z } from "zod";
+
+const envSchema = z.object({
+  APP_PORT: z.coerce.number().default(3001),
+  DATABASE_URL: z.string().min(1),
+  JWT_SECRET: z.string().min(1),
+  S3_ENDPOINT: z.string().min(1),
+  S3_BUCKET: z.string().min(1),
+  S3_ACCESS_KEY: z.string().min(1),
+  S3_SECRET_KEY: z.string().min(1),
+  SMTP_HOST: z.string().min(1),
+  SMTP_PORT: z.coerce.number().default(587),
+  SMTP_USER: z.string().min(1),
+  SMTP_PASS: z.string().min(1),
+  SMTP_FROM: z.string().min(1)
+});
+
+export type EnvVars = z.infer<typeof envSchema>;
+
+export const validateEnv = (config: Record<string, unknown>): EnvVars =>
+  envSchema.parse(config);
