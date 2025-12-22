diff --git a/infra/init-minio.sh b/infra/init-minio.sh
new file mode 100755
index 0000000000000000000000000000000000000000..447e0ffd75615bc06eaa3d5d824637260ff2f3fe
--- /dev/null
+++ b/infra/init-minio.sh
@@ -0,0 +1,5 @@
+#!/bin/sh
+set -e
+
+mc alias set local http://minio:9000 "${MINIO_ROOT_USER:-minio}" "${MINIO_ROOT_PASSWORD:-minio123}"
+mc mb --ignore-existing local/cumplepyme
