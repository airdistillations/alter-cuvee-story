#!/usr/bin/env bash
# Re-encrypt the pitch deck after editing alter-cuvee-pitch.html.
# Usage: ./encrypt.sh
#
# Requires: Node.js. The first run downloads staticrypt via npx.
# The password is read from the STATICRYPT_PASSWORD env var if set,
# otherwise it defaults to the one baked in here.
#
# NB: the salt is fixed in .staticrypt.json, so "remember me" stays
# consistent across re-encrypts.

set -euo pipefail
cd "$(dirname "$0")"

PASSWORD="${STATICRYPT_PASSWORD:-altermethode}"

# 1. Copy source → index.html (staticrypt overwrites its input file in place with -d .)
cp alter-cuvee-pitch.html index.html

# 2. Encrypt
npx -y staticrypt@latest index.html \
  -p "$PASSWORD" \
  --short \
  -t staticrypt-template.html \
  --template-title "ALTER Cuvée — Private viewing" \
  --template-instructions "This link has been shared with you privately. Enter the password to open the investor one-pager." \
  --template-button "Enter" \
  --template-placeholder "Password" \
  --template-error "Incorrect password" \
  --template-remember "Remember on this device" \
  --template-color-primary "#1F1913" \
  --template-color-secondary "#FBF8F2" \
  -d .

echo "✔  index.html re-encrypted."
echo "   Commit and push to publish."
