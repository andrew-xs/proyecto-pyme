diff --git a/apps/api/Dockerfile b/apps/api/Dockerfile
new file mode 100644
index 0000000000000000000000000000000000000000..2d8bfe2f146829b5970d3715d1e1325cdb2f08c3
--- /dev/null
+++ b/apps/api/Dockerfile
@@ -0,0 +1,31 @@
+FROM node:20-alpine AS deps
+WORKDIR /app
+RUN corepack enable
+COPY package.json pnpm-workspace.yaml ./
+COPY apps/api/package.json apps/api/package.json
+COPY packages/shared/package.json packages/shared/package.json
+RUN pnpm install --no-frozen-lockfile
+
+FROM node:20-alpine AS build
+WORKDIR /app
+RUN corepack enable
+COPY --from=deps /app/node_modules ./node_modules
+COPY --from=deps /app/apps/api/node_modules ./apps/api/node_modules
+COPY --from=deps /app/packages/shared/node_modules ./packages/shared/node_modules
+COPY package.json pnpm-workspace.yaml ./
+COPY apps/api ./apps/api
+COPY packages/shared ./packages/shared
+RUN pnpm --filter @cumplepyme/api prisma:generate
+RUN pnpm --filter @cumplepyme/api build
+
+FROM node:20-alpine AS runner
+WORKDIR /app
+ENV NODE_ENV=production
+RUN addgroup -S app && adduser -S app -G app
+COPY --from=build /app/apps/api/dist ./dist
+COPY --from=build /app/apps/api/package.json ./package.json
+COPY --from=build /app/node_modules ./node_modules
+COPY --from=build /app/apps/api/node_modules ./apps/api/node_modules
+USER app
+EXPOSE 3001
+CMD ["node", "dist/main.js"]
