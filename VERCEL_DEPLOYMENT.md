# Vercel Deployment Guide

Vercel is recommended for this astrology API because it handles native Node.js modules (like `sweph`) better than Netlify.

## Quick Deploy (5 minutes)

### Step 1: Create Vercel Configuration

The `vercel.json` file is already created for you.

### Step 2: Deploy

**Option A: Via Vercel Dashboard (Easiest)**
1. Go to [vercel.com](https://vercel.com)
2. Sign up/login
3. Click "Add New Project"
4. Import your Git repository
5. Click "Deploy" (Vercel auto-detects settings)

**Option B: Via Vercel CLI**
```bash
# Install Vercel CLI
npm install -g vercel

# Deploy
vercel

# Deploy to production
vercel --prod
```

### Step 3: Test

Your API will be live at: `https://your-project.vercel.app`

Test it:
```bash
curl "https://your-project.vercel.app/horoscope?time=1991-07-06T20:50:00.000Z&latitude=41.3874&longitude=2.1686&houseSystem=P"
```

## Configuration Details

### vercel.json
```json
{
  "version": 2,
  "builds": [
    {
      "src": "index.js",
      "use": "@vercel/node",
      "config": {
        "includeFiles": ["eph/**"]
      }
    }
  ],
  "routes": [
    {
      "src": "/(.*)",
      "dest": "/index.js"
    }
  ]
}
```

This configuration:
- Uses Vercel's Node.js runtime
- Includes ephemeris data files
- Routes all requests to your Express app

## How It Works

1. **Build Phase**: Vercel compiles the `sweph` native module in a Lambda-compatible environment
2. **Runtime**: The compiled module runs correctly on Vercel's serverless functions
3. **Result**: No GLIBC mismatch issues!

## Environment Variables

If you need to add environment variables:
1. Go to Project Settings → Environment Variables
2. Add your variables
3. Redeploy

## Advantages Over Netlify

- ✅ Better native module support
- ✅ Build environment matches runtime
- ✅ No GLIBC issues
- ✅ Similar workflow
- ✅ Free tier available

## Limitations

### Function Timeout
- **Free tier**: 10 seconds
- **Pro tier**: 60 seconds

Your astrology calculations should complete well within these limits.

### Function Size
- Max: 50 MB compressed

Your app with dependencies and ephemeris files is well under this limit.

## Troubleshooting

### Build Fails
Check the build logs in Vercel dashboard. Common issues:
- Missing dependencies in `package.json`
- Node version incompatibility

### Native Module Still Fails
If you still get errors:
1. Check that Node version is 18.x (in `package.json`)
2. Ensure `vercel.json` includes ephemeris files
3. Try deploying via CLI: `vercel --prod`

### Function Timeout
If calculations take too long:
- Consider caching results
- Optimize calculations
- Upgrade to Pro tier for 60s timeout

## Local Testing

Test your app locally before deploying:

```bash
# Install Vercel CLI
npm install -g vercel

# Run locally
vercel dev

# Your API will be available at http://localhost:3000
```

## Monitoring

- **View logs**: Vercel Dashboard → Your Project → Functions
- **Monitor usage**: Dashboard → Usage
- **Set up alerts**: Dashboard → Settings → Notifications

## Continuous Deployment

Once connected to Git:
1. Push to your repository
2. Vercel automatically deploys
3. Preview deployments for branches
4. Production deployment for main branch

## Custom Domain

1. Go to Project Settings → Domains
2. Add your custom domain
3. Configure DNS as instructed
4. SSL certificate is automatic

## Comparison: Netlify vs Vercel for This Project

| Feature | Netlify | Vercel |
|---------|---------|--------|
| Native Modules | ❌ GLIBC issues | ✅ Works |
| Setup | Easy | Easy |
| Free Tier | ✅ Yes | ✅ Yes |
| Build Time | ~2 min | ~2 min |
| Function Timeout | 10s | 10s (Free), 60s (Pro) |
| **Recommended for this API** | ❌ No | ✅ **Yes** |

## Migration from Netlify

If you already tried Netlify:
1. Remove Netlify-specific files (netlify.toml, netlify/functions/)
2. Add vercel.json
3. Deploy to Vercel
4. Update any documentation/URLs

## Cost Estimate

**Free Tier (Hobby):**
- 100 GB bandwidth
- 100 GB-Hrs serverless function execution
- Unlimited deployments
- **Good for**: Development, low-traffic APIs

**Pro Tier ($20/month per user):**
- 1 TB bandwidth
- 1000 GB-Hrs serverless function execution
- 60s function timeout
- Priority support
- **Good for**: Production APIs with moderate traffic

## Support

- [Vercel Documentation](https://vercel.com/docs)
- [Vercel Community](https://github.com/vercel/vercel/discussions)
- [Vercel Discord](https://vercel.com/discord)

## Next Steps

1. Create `vercel.json` (instructions below)
2. Deploy to Vercel
3. Test your API
4. Update README with Vercel URL
5. (Optional) Configure custom domain

---

## Ready to Deploy!

This is the recommended deployment method for your astrology API with native modules.
