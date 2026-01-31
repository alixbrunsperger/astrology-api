# Netlify Deployment Guide

This astrology API is now configured to deploy on Netlify as a serverless function.

## Prerequisites

- A Netlify account (free tier works fine)
- Git repository pushed to GitHub, GitLab, or Bitbucket

## Deployment Steps

### Option 1: Deploy via Netlify UI (Recommended)

1. **Connect to Netlify**
   - Go to [Netlify](https://netlify.com) and log in
   - Click "Add new site" → "Import an existing project"
   - Connect your Git provider and select this repository

2. **Configure Build Settings**
   - Build command: `npm install` (already configured in netlify.toml)
   - Publish directory: `.` (already configured)
   - Functions directory: `netlify/functions` (already configured)
   
   These settings are already in `netlify.toml`, so you can leave them empty in the UI.

3. **Deploy**
   - Click "Deploy site"
   - Wait for the build to complete

### Option 2: Deploy via Netlify CLI

```bash
# Install Netlify CLI globally
npm install -g netlify-cli

# Login to Netlify
netlify login

# Initialize and deploy
netlify init

# Or deploy directly
netlify deploy --prod
```

## API Endpoints

Once deployed, your API will be available at:

- `https://your-site-name.netlify.app/` - Welcome message
- `https://your-site-name.netlify.app/horoscope` - Horoscope calculation endpoint

### Example API Call

```bash
curl "https://your-site-name.netlify.app/horoscope?time=1991-07-06T20:50:00.000Z&latitude=41.3874&longitude=2.1686&houseSystem=P"
```

## Configuration Files

- **netlify.toml**: Main Netlify configuration
  - Defines build command
  - Configures functions directory
  - Sets up redirects for clean URLs
  - Includes ephemeris files in the function bundle

- **netlify/functions/api.js**: Serverless function wrapper
  - Wraps the Express app using serverless-http
  - Handles all incoming requests

- **.nvmrc**: Specifies Node.js version (14.x)

## Environment Variables

If you need to add environment variables:

1. Go to Site settings → Build & deploy → Environment
2. Add your variables
3. They will be available as `process.env.VARIABLE_NAME`

## Important Notes

- **Ephemeris Files**: The `eph/` directory containing Swiss Ephemeris data files is automatically included in the deployment via the `included_files` configuration in `netlify.toml`.

- **Serverless Functions**: Netlify Functions have a 10-second execution timeout on the free tier and 26 seconds on paid tiers. If calculations take longer, consider optimization.

- **Cold Starts**: The first request after inactivity may take a few seconds due to function cold start.

## Troubleshooting

### Build failures with sweph package
If you encounter `node-gyp` or `sweph` compilation errors, see [NETLIFY_TROUBLESHOOTING.md](./NETLIFY_TROUBLESHOOTING.md) for detailed solutions.

The repository is configured with:
- Node.js 18.x (for better node-gyp compatibility)
- Python 3.8 (specified in netlify.toml)
- Proper npm configuration for native modules

### Function not working
- Check the Netlify Functions log in the Netlify UI
- Ensure all dependencies are in `package.json` (not devDependencies)
- Verify ephemeris files are included in the bundle

### Missing ephemeris data
- Ensure the `eph/` directory is committed to your repository
- Check that `included_files = ["eph/**"]` is in `netlify.toml`

For more troubleshooting help, see [NETLIFY_TROUBLESHOOTING.md](./NETLIFY_TROUBLESHOOTING.md)

## Local Testing with Netlify CLI

```bash
# Install dependencies
npm install

# Test locally with Netlify Dev
netlify dev

# This will start a local server at http://localhost:8888
```

## Monitoring

- View function logs: Netlify dashboard → Functions → Function logs
- Monitor usage: Netlify dashboard → Functions → Usage statistics

## Support

For issues specific to this API, check the main README.md.
For Netlify-specific issues, see [Netlify Documentation](https://docs.netlify.com/).
