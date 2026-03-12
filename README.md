# Fly.io Multi-Region CI/CD — Setup Guide

## Prerequisites
- [Fly.io account](https://fly.io) (free tier works)
- [flyctl CLI](https://fly.io/docs/hands-on/install-flyctl/) installed locally
- GitHub repository with this code

---

## Step 1 — Create three Fly.io apps (one per region)

```bash
# Login
flyctl auth login

# Create US app
flyctl apps create your-app-name-us --machines

# Create UK app
flyctl apps create your-app-name-uk --machines

# Create EU app
flyctl apps create your-app-name-eu --machines
```

---

## Step 2 — Get your Fly.io API token

```bash
flyctl auth token
```

Copy the token — you'll need it in the next step.

---

## Step 3 — Add GitHub Secrets

In your GitHub repo go to **Settings → Secrets and variables → Actions** and add:

| Secret name       | Value                          |
|-------------------|-------------------------------|
| `FLY_API_TOKEN`   | Your Fly.io API token          |
| `FLY_APP_NAME`    | Your base app name (e.g. `mysite`) |

> The workflow automatically appends `-us`, `-uk`, `-eu` to your base name.

---

## Step 4 — Add your static site files

Place your HTML/CSS/JS files inside the `site/` folder.

If you have a build step (Vite, Next.js, etc.), edit the `Dockerfile` builder stage to run `npm run build` and copy from `dist/` instead of `site/`.

---

## Step 5 — Push and deploy

```bash
git add .
git commit -m "Initial deploy"
git push origin main
```

GitHub Actions will:
1. Build the multi-stage Docker image
2. Push to Fly.io's private registry
3. Deploy to US, UK, and EU in parallel
4. Run health checks on all three regions

---

## Deployed URLs

| Region | URL |
|--------|-----|
| US     | `https://your-app-name-us.fly.dev` |
| UK     | `https://your-app-name-uk.fly.dev` |
| EU     | `https://your-app-name-eu.fly.dev` |

---

## Image size

The multi-stage build keeps the final image small:
- Builder stage (Node 20 Alpine): ~170MB — discarded after build
- Runtime stage (nginx Alpine): ~25MB — this is what gets deployed

---

## Scaling up

To add more machines per region:

```bash
flyctl scale count 2 --app your-app-name-us --region iad
```

To add an extra EU location (e.g. Frankfurt):

```bash
flyctl regions add fra --app your-app-name-eu
```
