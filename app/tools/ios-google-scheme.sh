#!/usr/bin/env bash
# GoogleService-Info.plist の REVERSED_CLIENT_ID を、iPhone アプリの URL Types に足す（Google ログインのあとアプリに戻るため）。
# Mac で `bash tools/ios-google-scheme.sh` を実行する。何度実行しても同じ結果になる。
set -euo pipefail
cd "$(dirname "$0")/../ios/App/App"
PB=/usr/libexec/PlistBuddy
[ -f GoogleService-Info.plist ] || { echo "GoogleService-Info.plist が ios/App/App/ にありません"; exit 1; }
ID=$($PB -c "Print :REVERSED_CLIENT_ID" GoogleService-Info.plist)
$PB -c "Delete :CFBundleURLTypes" Info.plist 2>/dev/null || true
$PB -c "Add :CFBundleURLTypes array" Info.plist
$PB -c "Add :CFBundleURLTypes:0 dict" Info.plist
$PB -c "Add :CFBundleURLTypes:0:CFBundleURLSchemes array" Info.plist
$PB -c "Add :CFBundleURLTypes:0:CFBundleURLSchemes:0 string $ID" Info.plist
echo "URL Types に $ID を足しました"
