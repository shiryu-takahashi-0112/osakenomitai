// 親のフォルダにあるウェブ版（index.html など）を www/ に写す。
// アプリに入る画面は、ウェブ版と同じファイル。ウェブ版を直したら `npm run sync` で取り込む。
import { cpSync, rmSync, mkdirSync } from 'node:fs';
const root = new URL('../', import.meta.url);
const www = new URL('./www/', import.meta.url);
rmSync(www, { recursive: true, force: true });
mkdirSync(www);
for (const f of ['index.html', 'manifest.webmanifest', 'icons']) {
  cpSync(new URL(f, root), new URL(f, www), { recursive: true });
}
console.log('www/ にウェブ版を写しました');
