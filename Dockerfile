# ── Stage 1: Builder ──────────────────────────────────────────────────────────
# Install dependencies and build the static site (if using a build step)
FROM node:20-alpine AS builder

WORKDIR /app

# Copy only package files first (layer caching)
COPY package*.json ./
RUN npm ci --omit=dev

# Copy site source and build
COPY site/ ./site/
# If you have a build step (e.g. Vite, Next, Hugo), run it here:
# RUN npm run build

# ── Stage 2: Runtime ──────────────────────────────────────────────────────────
# Minimal nginx image — final image stays under ~25MB
FROM nginx:1.25-alpine AS runtime

# Remove default nginx config
RUN rm /etc/nginx/conf.d/default.conf

# Copy custom nginx config
COPY nginx.conf /etc/nginx/conf.d/app.conf

# Copy built static files from builder stage
COPY --from=builder /app/site /usr/share/nginx/html

# Expose port 8080 (Fly.io default)
EXPOSE 8080

CMD ["nginx", "-g", "daemon off;"]
