diff --git a/apps/api/jest.config.cjs b/apps/api/jest.config.cjs
new file mode 100644
index 0000000000000000000000000000000000000000..8354e24609f7bf989380cb07236ab53925ddf3af
--- /dev/null
+++ b/apps/api/jest.config.cjs
@@ -0,0 +1,6 @@
+module.exports = {
+  preset: "ts-jest",
+  testEnvironment: "node",
+  roots: ["<rootDir>/src"],
+  testMatch: ["**/*.spec.ts"]
+};
