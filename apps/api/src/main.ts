diff --git a/apps/api/src/main.ts b/apps/api/src/main.ts
new file mode 100644
index 0000000000000000000000000000000000000000..e7f77d958b6d97028bfc2804cf2ab733c375a55a
--- /dev/null
+++ b/apps/api/src/main.ts
@@ -0,0 +1,17 @@
+import "reflect-metadata";
+import { NestFactory } from "@nestjs/core";
+import { AppModule } from "./app.module";
+import { HttpExceptionFilter } from "./common/http-exception.filter";
+import { LoggingMiddleware } from "./common/logging.middleware";
+
+async function bootstrap() {
+  const app = await NestFactory.create(AppModule);
+  app.enableCors();
+  app.useGlobalFilters(new HttpExceptionFilter());
+  const loggerMiddleware = new LoggingMiddleware();
+  app.use(loggerMiddleware.use.bind(loggerMiddleware));
+  const port = process.env.APP_PORT ? Number(process.env.APP_PORT) : 3001;
+  await app.listen(port);
+}
+
+bootstrap();
