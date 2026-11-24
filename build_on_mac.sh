#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "$0")"
if ! command -v xcodegen >/dev/null; then
  echo "Install XcodeGen first: brew install xcodegen" >&2
  exit 1
fi
xcodegen generate --spec project.yml
xcodebuild -project PapayaFarmClassic.xcodeproj -scheme PapayaFarmClassic \
  -configuration Release -sdk iphoneos -destination 'generic/platform=iOS' \
  -derivedDataPath "$PWD/out" CODE_SIGNING_ALLOWED=NO build
mkdir -p dist/Payload
cp -R out/Build/Products/Release-iphoneos/PapayaFarmClassic.app dist/Payload/
(cd dist && /usr/bin/zip -qry PapayaFarmClassic_iOS_unsigned.ipa Payload)
echo "Created: dist/PapayaFarmClassic_iOS_unsigned.ipa"
