# Netlify Deployment Troubleshooting

## ⚠️ IMPORTANT: Netlify Not Recommended for This API

Due to native module issues (GLIBC mismatch), **we recommend using Railway or Vercel instead**:

- **[Railway (Easiest) →](./RAILWAY_DEPLOYMENT.md)**
- **[Vercel (Free Tier) →](./VERCEL_DEPLOYMENT.md)**
- **[All Deployment Options →](./DEPLOYMENT_OPTIONS.md)**

See [NATIVE_MODULE_ISSUE.md](./NATIVE_MODULE_ISSUE.md) for technical details.

---

## Common Issues and Solutions

*(For reference if you still want to try Netlify)*

### ❌ Issue: GLIBC Version Mismatch (Runtime Error)

**Error Message:**
```
Error: /lib64/libm.so.6: version `GLIBC_2.38' not found
(required by /var/task/node_modules/sweph/build/Release/sweph.node)
```

**Root Cause:**
- Build environment (Ubuntu): GLIBC 2.38
- Runtime environment (AWS Lambda): GLIBC 2.27
- Native module compiled for newer GLIBC won't run on older version

**✅ Solution:**
**Switch to a different deployment platform:**

1. **Railway (Recommended)** - Zero config, works perfectly
   - [Railway Deployment Guide](./RAILWAY_DEPLOYMENT.md)

2. **Vercel** - Free tier, good native module support
   - [Vercel Deployment Guide](./VERCEL_DEPLOYMENT.md)

3. **See all options** - Compare platforms
   - [Deployment Options Comparison](./DEPLOYMENT_OPTIONS.md)

**Why this is hard to fix on Netlify:**
- Would require Docker-based Netlify Functions (complex setup)
- Or rewriting the entire app without native modules (massive effort)
- Other platforms handle this issue automatically

---

### ❌ Issue: `sweph` Package Build Failure (node-gyp error) - SOLVED

**Error Message:**
```
ValueError: invalid mode: 'rU' while trying to load binding.gyp
gyp ERR! configure error
npm ERR! sweph@2.10.0-5 install: `node-gyp rebuild`
```

**Root Cause:**
The `sweph` package contains native C++ code that needs to be compiled during installation using `node-gyp`. This error occurs due to Python version incompatibility between Node.js 14 and newer Python versions (3.11+) on Netlify's build servers.

**✅ Solution:**
This issue has been fixed by:

1. **Updated Node.js version** to 18 (from 14)
   - Files updated: `.nvmrc`, `package.json` engines field
   - Node 18 includes a newer version of node-gyp that's compatible with newer Python versions

2. **Specified Python version** in `netlify.toml`
   - Added `PYTHON_VERSION = "3.8"` to ensure consistent build environment

3. **Added `.npmrc` configuration**
   - Ensures npm builds native modules from source correctly

**Files Modified:**
- `.nvmrc` → Changed from `14` to `18`
- `package.json` → Changed engines.node from `>=14.x` to `>=18.x`
- `netlify.toml` → Added `[build.environment]` section with Python and Node versions
- `.npmrc` → New file to configure npm for native module builds

**Verification:**
After these changes, your deployment should succeed. The build logs should show:
```
Installing dependencies using Node.js v18.x
Successfully compiled native modules
```

---

## Other Potential Issues

### ❌ Issue: Function Timeout

**Error Message:**
```
Task timed out after 10.00 seconds
```

**Solution:**
- Free tier: 10-second timeout (upgrade to Pro for 26 seconds)
- Optimize your calculations if they take too long
- Consider caching frequently requested calculations

### ❌ Issue: Ephemeris Files Not Found

**Error Message:**
```
Error: Swiss Ephemeris file not found
```

**Solution:**
1. Ensure `eph/` directory is committed to your repository (not in .gitignore)
2. Verify `netlify.toml` includes:
   ```toml
   [functions]
   included_files = ["eph/**"]
   ```
3. Check deployment logs to confirm files are being bundled

### ❌ Issue: Cold Start Latency

**Symptom:**
First request after inactivity takes 3-5 seconds

**Solution:**
- This is normal for serverless functions
- Consider implementing a health check ping every 5-10 minutes
- Or upgrade to Netlify's paid tier for better cold start performance

### ❌ Issue: CORS Errors

**Error Message:**
```
Access to fetch at 'https://your-site.netlify.app' from origin 'https://example.com' 
has been blocked by CORS policy
```

**Solution:**
Your app already has CORS enabled in `app.js`:
```javascript
app.use(cors())
```

If you need to restrict origins:
```javascript
app.use(cors({
  origin: ['https://example.com', 'https://another-site.com']
}))
```

### ❌ Issue: Missing Dependencies

**Error Message:**
```
Cannot find module 'package-name'
```

**Solution:**
1. Ensure all dependencies are in `package.json` under `dependencies` (not `devDependencies`)
2. Run `npm install` locally to update `package-lock.json`
3. Commit both `package.json` and `package-lock.json`
4. Redeploy

---

## Debugging Tips

### 1. Check Build Logs
- Go to Netlify Dashboard → Site → Deploys
- Click on the failed deployment
- Review the full build log

### 2. Check Function Logs
- Go to Netlify Dashboard → Functions
- Click on your function
- View real-time logs

### 3. Test Locally with Netlify CLI
```bash
# Install Netlify CLI
npm install -g netlify-cli

# Run locally
netlify dev

# Test your endpoints
curl http://localhost:8888/horoscope?time=1991-07-06T20:50:00.000Z&latitude=41.3874&longitude=2.1686&houseSystem=P
```

### 4. Enable Detailed Logging
In `app.js`, the Morgan logger is already configured. To see more details, you can temporarily change it to:
```javascript
app.use(morgan('combined'))
```

### 5. Check Netlify Build Image
Netlify uses Ubuntu-based build images. If you need specific system dependencies:
- Add them to `netlify.toml`:
  ```toml
  [build]
    command = "apt-get update && apt-get install -y build-essential python3-dev && npm install"
  ```

---

## Getting Help

### Check These First:
1. ✅ Node version is 18.x (check `.nvmrc` and `package.json`)
2. ✅ Python version is specified in `netlify.toml` (3.8)
3. ✅ All dependencies are in `package.json`
4. ✅ Ephemeris files are committed to repository
5. ✅ `netlify.toml` is properly configured

### Still Having Issues?

**Netlify Community:**
- [Netlify Support Forums](https://answers.netlify.com/)
- [Netlify Status](https://www.netlifystatus.com/)

**Package-Specific Issues:**
- [sweph on npm](https://www.npmjs.com/package/sweph)
- [Swiss Ephemeris Documentation](https://www.astro.com/swisseph/)

**Review Documentation:**
- [NETLIFY_DEPLOYMENT.md](./NETLIFY_DEPLOYMENT.md) - Full deployment guide
- [DEPLOYMENT_CHECKLIST.md](./DEPLOYMENT_CHECKLIST.md) - Pre-deployment checklist
- [QUICK_DEPLOY.md](./QUICK_DEPLOY.md) - Quick deployment steps

---

## Build Environment Specifications

### Current Configuration:
- **Node.js:** 18.x (LTS)
- **Python:** 3.8
- **npm:** Bundled with Node.js 18
- **node-gyp:** Bundled with npm (Node 18 compatible version)
- **Operating System:** Ubuntu (Netlify build image)

### Native Module Compilation:
The `sweph` package requires:
- C++ compiler (provided by Netlify build environment)
- Python (specified in `netlify.toml`)
- node-gyp (provided by npm with Node 18)
- Build tools (provided by Netlify build environment)

All of these are now properly configured in your repository.

---

## Success Indicators

When your deployment succeeds, you should see:

✅ Build logs show:
```
8:xx:xx PM: Installing dependencies
8:xx:xx PM: > sweph@2.10.0-5 install
8:xx:xx PM: > node-gyp rebuild
8:xx:xx PM: make: Entering directory '/opt/build/repo/node_modules/sweph/build'
8:xx:xx PM: CXX(target) Release/obj.target/sweph/src/sweph.o
8:xx:xx PM: SOLINK_MODULE(target) Release/obj.target/sweph.node
8:xx:xx PM: COPY Release/sweph.node
8:xx:xx PM: make: Leaving directory '/opt/build/repo/node_modules/sweph/build'
```

✅ Function deployment successful:
```
Functions bundled successfully
```

✅ API responds:
```bash
curl https://your-site.netlify.app/
# Response: {"message":"Welcome to Astrology api!"}
```
