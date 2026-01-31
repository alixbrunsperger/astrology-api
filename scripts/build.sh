#!/bin/bash
set -e

echo "Installing dependencies..."
npm install

# Check if we're in a Netlify environment
if [ "$NETLIFY" = "true" ]; then
  echo "Detected Netlify environment"
  echo "Attempting to rebuild sweph for Lambda runtime..."
  
  # Try to install with specific target
  cd node_modules/sweph
  npm run install || true
  cd ../..
fi

echo "Build complete!"
