# Netlify Deployment Checklist

Use this checklist to ensure your repository is ready for Netlify deployment.

## ✅ Pre-Deployment Checklist

### Required Files
- [x] `netlify.toml` - Netlify configuration file
- [x] `netlify/functions/api.js` - Serverless function wrapper
- [x] `.nvmrc` - Node version specification
- [x] `package.json` - Contains all dependencies including `serverless-http`
- [x] `eph/` directory - Swiss Ephemeris data files

### Configuration
- [x] `serverless-http` installed as a dependency
- [x] Build command configured in `netlify.toml`
- [x] Functions directory specified
- [x] Redirects configured for clean URLs
- [x] Ephemeris files included in function bundle
- [x] `.gitignore` updated to exclude `.netlify` directory

### Git Repository
- [ ] All changes committed to git
- [ ] Repository pushed to GitHub/GitLab/Bitbucket
- [ ] Ephemeris files (`eph/` directory) committed (not in .gitignore)

### Testing (Optional but Recommended)
- [ ] Install Netlify CLI: `npm install -g netlify-cli`
- [ ] Test locally: `npm run netlify:dev`
- [ ] Verify API endpoints work at `http://localhost:8888`

## 🚀 Deployment Steps

1. **Go to Netlify**
   - Visit https://app.netlify.com
   - Click "Add new site" → "Import an existing project"

2. **Connect Repository**
   - Choose your Git provider
   - Select this repository
   - Authorize Netlify access

3. **Configure Site**
   - Site name: Choose a name or use auto-generated
   - Build settings: Leave empty (configured in netlify.toml)
   - Click "Deploy site"

4. **Wait for Build**
   - Monitor build progress in Netlify dashboard
   - Check build logs if any errors occur

5. **Test Deployment**
   - Visit your site URL: `https://your-site-name.netlify.app`
   - Test the horoscope endpoint:
     ```bash
     curl "https://your-site-name.netlify.app/horoscope?time=1991-07-06T20:50:00.000Z&latitude=41.3874&longitude=2.1686&houseSystem=P"
     ```

## 🔧 Post-Deployment

### Custom Domain (Optional)
- [ ] Go to Site settings → Domain management
- [ ] Add your custom domain
- [ ] Configure DNS settings

### Environment Variables (If Needed)
- [ ] Go to Site settings → Build & deploy → Environment
- [ ] Add any required environment variables

### Monitoring
- [ ] Check Functions logs in Netlify dashboard
- [ ] Monitor function execution time and calls
- [ ] Set up any alerts or notifications

## 🐛 Troubleshooting

### Build Fails
- Check Node version matches (14.x or higher)
- Verify all dependencies in package.json
- Review build logs for specific errors

### Function Returns 500 Error
- Check Function logs in Netlify dashboard
- Ensure ephemeris files are included
- Verify serverless-http is installed

### Ephemeris Data Not Found
- Ensure `eph/` directory is committed to git
- Check `included_files = ["eph/**"]` in netlify.toml
- Verify files are being bundled (check deploy logs)

## 📚 Additional Resources

- [Netlify Documentation](https://docs.netlify.com/)
- [Netlify Functions Guide](https://docs.netlify.com/functions/overview/)
- [NETLIFY_DEPLOYMENT.md](./NETLIFY_DEPLOYMENT.md) - Detailed deployment guide

## ✅ Ready to Deploy!

Once all items are checked, your repository is ready for Netlify deployment!
