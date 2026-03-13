# BytePulse — Tech News Site

A static tech news blog deployed on Netlify with automatic GitHub CI/CD. Every push to `main` triggers an instant redeploy. The site is served globally via Netlify's CDN covering US, UK, and EU automatically.

---

## Tech Stack

| Layer | Tool |
|---|---|
| Site | Static HTML + CSS (single file) |
| Hosting | Netlify (free tier) |
| CI/CD | GitHub → Netlify (auto-deploy on push) |
| Monetisation | Monetag Smartlink |

---

## Project Structure

```
your-repo/
├── site/
│   └── index.html           # The full site (HTML + CSS + JS)
├── Dockerfile               # nginx-based Docker image (optional)
├── nginx.conf               # nginx config (optional)
└── README.md
```

---

## How Deployment Works

1. You push code to the `main` branch on GitHub
2. Netlify detects the push automatically
3. Netlify pulls the `site/` folder and publishes it
4. Site is live globally within seconds

No build step, no Docker, no CLI needed.

---

## Netlify Setup (already done)

- Connected GitHub repo to Netlify
- Publish directory set to `site`
- Auto-deploy on every push to `main` enabled
- Free global CDN active (US, UK, EU covered)

---

## Adding Your Monetag Smartlink

Open `site/index.html` and find every instance of:

```
YOUR_MONETAG_SMARTLINK_URL_HERE
```

Replace all 14 occurrences with your actual Monetag smartlink URL. Every clickable element on the page routes through it including article cards, buttons, the ad banner, and the newsletter subscribe button.

---

## Making Changes

To update the site:

```bash
# Edit site/index.html
git add .
git commit -m "Update content"
git push origin main
```

Netlify will automatically redeploy within 30 seconds.

---

## Live Site

Your site is live at your Netlify URL. To find it:
1. Go to [netlify.com](https://netlify.com)
2. Open your site dashboard
3. The URL is shown at the top (e.g. `https://your-site-name.netlify.app`)

You can add a custom domain for free via **Site configuration → Domain management**.
