diff --git a/apps/api/prisma/seed.ts b/apps/api/prisma/seed.ts
new file mode 100644
index 0000000000000000000000000000000000000000..63a3a99f2dc2262d82ed73146e2965da9ca192e2
--- /dev/null
+++ b/apps/api/prisma/seed.ts
@@ -0,0 +1,102 @@
+import { PrismaClient } from "@prisma/client";
+
+const prisma = new PrismaClient();
+
+async function main() {
+  await prisma.comuna.createMany({
+    data: [
+      { name: "Tomé", region: "Biobío" },
+      { name: "Penco", region: "Biobío" },
+      { name: "Lirquén", region: "Biobío" },
+      { name: "Concepción", region: "Biobío" },
+      { name: "Talcahuano", region: "Biobío" },
+      { name: "San Pedro de la Paz", region: "Biobío" }
+    ],
+    skipDuplicates: true
+  });
+
+  await prisma.requirementTemplate.createMany({
+    data: [
+      {
+        code: "BASE_SII",
+        title: "Inicio de actividades SII",
+        description: "Debe existir inicio de actividades en el SII.",
+        module: "BASE",
+        applicableProfiles: ["P1", "P2", "P3", "P4"]
+      },
+      {
+        code: "BASE_PATENTE",
+        title: "Patente municipal vigente",
+        description: "Patente municipal vigente para operar.",
+        module: "BASE",
+        applicableProfiles: ["P1", "P2", "P3", "P4"]
+      },
+      {
+        code: "BASE_CONTRATO",
+        title: "Contrato de arriendo / título de dominio",
+        description: "Documento que acredita el uso del local.",
+        module: "BASE",
+        applicableProfiles: ["P1", "P2", "P3", "P4"]
+      },
+      {
+        code: "BASE_DOM",
+        title: "Antecedente DOM (si aplica)",
+        description: "Antecedentes de uso de suelo o destino cuando aplique.",
+        module: "BASE",
+        applicableProfiles: ["P1", "P2", "P3", "P4"]
+      },
+      {
+        code: "SANITARIO_AUT",
+        title: "Autorización sanitaria alimentos",
+        description: "Autorización sanitaria vigente para alimentos.",
+        module: "SANITARIO",
+        applicableProfiles: ["P2", "P4"]
+      },
+      {
+        code: "TRANSPORTE_PERMISO",
+        title: "Permiso de circulación vigente",
+        description: "Permiso anual para transporte remunerado.",
+        module: "TRANSPORTE",
+        applicableProfiles: ["P3"]
+      },
+      {
+        code: "TRANSPORTE_REVISION",
+        title: "Revisión técnica vigente",
+        description: "Revisión técnica del vehículo.",
+        module: "TRANSPORTE",
+        applicableProfiles: ["P3"]
+      },
+      {
+        code: "TRANSPORTE_SOAP",
+        title: "Seguro obligatorio SOAP vigente",
+        description: "Seguro obligatorio del vehículo.",
+        module: "TRANSPORTE",
+        applicableProfiles: ["P3"]
+      },
+      {
+        code: "DOM_RECEPCION",
+        title: "Recepción definitiva / regularización",
+        description: "Recepción definitiva o regularización de obras.",
+        module: "DOM",
+        applicableProfiles: ["P4"]
+      },
+      {
+        code: "DOM_DESTINO",
+        title: "Cambio de destino aprobado",
+        description: "Cambio de destino aprobado por la DOM.",
+        module: "DOM",
+        applicableProfiles: ["P4"]
+      }
+    ],
+    skipDuplicates: true
+  });
+}
+
+main()
+  .then(() => prisma.$disconnect())
+  .catch((error) => {
+    console.error(error);
+    return prisma.$disconnect().finally(() => {
+      process.exit(1);
+    });
+  });
