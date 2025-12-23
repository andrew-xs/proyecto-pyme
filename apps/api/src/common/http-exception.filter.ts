diff --git a/apps/api/src/common/http-exception.filter.ts b/apps/api/src/common/http-exception.filter.ts
new file mode 100644
index 0000000000000000000000000000000000000000..36e2b05bd7303460df6dfdd4daeb581bf219f11b
--- /dev/null
+++ b/apps/api/src/common/http-exception.filter.ts
@@ -0,0 +1,40 @@
+import {
+  ArgumentsHost,
+  Catch,
+  ExceptionFilter,
+  HttpException,
+  HttpStatus,
+  Logger
+} from "@nestjs/common";
+import { Request, Response } from "express";
+
+@Catch()
+export class HttpExceptionFilter implements ExceptionFilter {
+  private readonly logger = new Logger(HttpExceptionFilter.name);
+
+  catch(exception: unknown, host: ArgumentsHost) {
+    const ctx = host.switchToHttp();
+    const response = ctx.getResponse<Response>();
+    const request = ctx.getRequest<Request>();
+
+    const status =
+      exception instanceof HttpException ? exception.getStatus() : HttpStatus.INTERNAL_SERVER_ERROR;
+    const message =
+      exception instanceof HttpException ? exception.getResponse() : "Internal server error";
+
+    const log = {
+      method: request.method,
+      path: request.url,
+      status,
+      message
+    };
+    this.logger.error(JSON.stringify(log));
+
+    response.status(status).json({
+      statusCode: status,
+      message,
+      path: request.url,
+      timestamp: new Date().toISOString()
+    });
+  }
+}
