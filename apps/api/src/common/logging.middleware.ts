diff --git a/apps/api/src/common/logging.middleware.ts b/apps/api/src/common/logging.middleware.ts
new file mode 100644
index 0000000000000000000000000000000000000000..42fb89e2a01ba577b91c54ce357f6094b2673e98
--- /dev/null
+++ b/apps/api/src/common/logging.middleware.ts
@@ -0,0 +1,22 @@
+import { Injectable, Logger, NestMiddleware } from "@nestjs/common";
+import { Request, Response, NextFunction } from "express";
+
+@Injectable()
+export class LoggingMiddleware implements NestMiddleware {
+  private readonly logger = new Logger("http");
+
+  use(req: Request, res: Response, next: NextFunction) {
+    const start = Date.now();
+    res.on("finish", () => {
+      const durationMs = Date.now() - start;
+      const log = {
+        method: req.method,
+        path: req.originalUrl,
+        statusCode: res.statusCode,
+        durationMs
+      };
+      this.logger.log(JSON.stringify(log));
+    });
+    next();
+  }
+}
