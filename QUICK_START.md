# 🚀 Quick Start - Deploy Your Astrology API

## ⚠️ Important
Netlify doesn't work due to native module issues. Use Railway or Vercel instead.

---

## Option 1: Railway (Recommended)

**Easiest deployment, native modules work perfectly**

### Deploy in 2 minutes:
1. Go to [railway.app](https://railway.app)
2. Click "Start a New Project"
3. Connect your GitHub repo
4. Click "Deploy"
5. Done! ✅

**Cost:** ~$5-10/month  
**Guide:** [RAILWAY_DEPLOYMENT.md](./RAILWAY_DEPLOYMENT.md)

---

## Option 2: Vercel

**Free tier available, good native module support**

### Deploy in 5 minutes:
1. Make sure `vercel.json` is committed (✅ already created)
2. Go to [vercel.com](https://vercel.com)
3. Import your GitHub repo
4. Click "Deploy"
5. Done! ✅

**Cost:** Free tier available  
**Guide:** [VERCEL_DEPLOYMENT.md](./VERCEL_DEPLOYMENT.md)

---

## Why Not Netlify?

Native module (sweph) has GLIBC version mismatch between build and runtime.

**Details:** [NATIVE_MODULE_ISSUE.md](./NATIVE_MODULE_ISSUE.md)

---

## After Deployment

Test your API:
```bash
curl "https://your-app-url.com/horoscope?time=1991-07-06T20:50:00.000Z&latitude=41.3874&longitude=2.1686&houseSystem=P"
```

Should return horoscope calculation data.

---

## Need More Info?

- **Compare platforms:** [DEPLOYMENT_OPTIONS.md](./DEPLOYMENT_OPTIONS.md)
- **What happened:** [WHAT_HAPPENED.md](./WHAT_HAPPENED.md)
- **Railway guide:** [RAILWAY_DEPLOYMENT.md](./RAILWAY_DEPLOYMENT.md)
- **Vercel guide:** [VERCEL_DEPLOYMENT.md](./VERCEL_DEPLOYMENT.md)

---

## TL;DR

1. **Choose:** Railway (easy, $5-10/mo) or Vercel (free)
2. **Deploy:** Follow guide above
3. **Test:** API endpoint
4. **Done!** ✅

**Recommended:** Start with Railway for simplest experience.
