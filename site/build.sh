#!/usr/bin/env bash
# osakenomitai.com に配るファイルを dist/ に組み立てる。
#   site/build.sh <オサケノミタイの場所> <サケノツマミの場所>
# 公開してはいけないもの（設計メモ、ルール、ツール類、git）は除く。
set -euo pipefail
O="${1:?オサケノミタイの場所}"; S="${2:?サケノツマミの場所}"
OUT="$(cd "$(dirname "$0")/.." && pwd)/dist"
rm -rf "$OUT"; mkdir -p "$OUT/sakenotsumami"
COMMON=(--exclude .git --exclude .github --exclude .gitignore --exclude .claude --exclude CLAUDE.md --exclude README.md --exclude .DS_Store --exclude node_modules)
rsync -a "${COMMON[@]}" --exclude site --exclude dist --exclude design --exclude firebase.json --exclude .firebaserc --exclude firestore.rules "$O"/ "$OUT"/
rsync -a "${COMMON[@]}" --exclude tools --exclude brand --exclude firestore.rules --exclude images/raw --exclude images/PROMPTS.md "$S"/ "$OUT/sakenotsumami"/
echo "dist: $(find "$OUT" -type f | wc -l | tr -d ' ') files"
