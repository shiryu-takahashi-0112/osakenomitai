# オサケノミタイ

## 公開

- 本番は **https://osakenomitai.com/** （2026-09-29に取得。登録はSquarespace、DNSと配信はCloudflareの無料プラン）。
- `/` にオサケノミタイ、`/sakenotsumami/` に姉妹アプリのサケノツマミを置いている。どちらのリポジトリに push しても、`.github/workflows/deploy-site.yml` が2つを組み立てて（`site/build.sh`）Cloudflareに公開する。静的ファイルの配信だけなので、Workersの無料枠は使わない。
- 認証は GitHub Secrets の `CLOUDFLARE_API_TOKEN`・`CLOUDFLARE_ACCOUNT_ID`（両方のリポジトリに登録済み）。
- 公開してはいけないもの（`CLAUDE.md`、`design/`、ルール、ツール類）は `site/build.sh` で除いている。新しく非公開のファイルを置くときは、ここにも足す。
- 旧URL（shiryu-takahashi-0112.github.io/osakenomitai/）も残っているが、開くと新しいURLへ移る。
- www は Cloudflare のリダイレクトルールで osakenomitai.com へ301。アクセス数は Cloudflare Web Analytics（自動設定）。

## ロゴの方針

2026-09-26〜27のロゴ検討で、Shiryuから受けた指摘をまとめる。
ロゴ案を作るときはこの方針に従う。

- **カタカナ表記のシンプルな文字だけにする。** のれん・提灯などの飾りや、文字を囲む面は付けない（「ダサいから」と指示）。
- **書体はゴシック体で、読みやすいものを選ぶ。** 手書き風・ポップ体・筆文字はベースにしない。
- 手描き感を出すときは、書体の形を保ったまま輪郭を少し揺らす程度にとどめる。ただ線を太くするだけの加工は「微妙」と言われたので避ける。
- 文字の一部をモチーフに置き換える仕掛け（ミの波線、ノのとっくりなど）は、一度試したうえでリセットになった。提案するなら別案として出し、基本形には入れない。
- **字間は詰めすぎない。** 2026-09-29に、見た目で均等になるよう字間を詰めた案を「字間が狭すぎて不自然」と言われた。今はフォント本来の字間に0.06文字分を足し、気になる組み合わせだけ少し詰める（ノの左右を5%ずつ、ケとノの間はさらに6%）。文字の大きさの補正はしない。
- 案を見せるときは、実際の表示サイズ（地図の左上 92px、スプラッシュ 150px）でも並べる。

## 文字ロゴ（2026-09-29に差し替え）

- 書体は **Zen Kaku Gothic New の Black** を線に起こしたもの。姉妹アプリのサケノツマミと同じ条件（案D）で作っている。条件は上の「ロゴの方針」のとおり。
- 元のSVGと作り直しの処理は `~/dev/sakenotsumami/brand/osakenomitai-logotype.svg` と `~/dev/sakenotsumami/tools/logotype.py`。
- 共有画像（酒場記録）の描画は、ロゴの縦横比を viewBox から出している。

## シンボルマーク

2026-09-27に、文字ロゴとは別にシンボルマークを作った。

- **形は「ジョッキ型ピン」。** 泡と取っ手のあるジョッキの底が地図ピンの先になっていて、胴にピンの穴がある。
- **太めの線だけで描く（塗りにしない）。** 白い泡・黒一色の塗り案も出したうえで、線の案に決まった。
- 色は黒の線。アプリアイコンでは黄色（`#F2C600`）の地に置く。
- 元のSVGは `index.html` の `.logo-symbol`（viewBox `22 18 60 78`、線幅6）。アイコン画像はこの形を黄色の正方形の中央に84%の大きさで置いて書き出している。

## ロゴの使用箇所

ロゴを差し替えるときは、次の場所をまとめて直す。

| 場所 | ファイル |
|---|---|
| 地図画面の左上 | `index.html` の `.map-logo` |
| 起動時のスプラッシュ画面 | `index.html` の `.splash` 内の `.logo-mark` |
| 個人サイトのProjectページ | `~/dev/shiryutakahashi-site/index.html`（オサケノミタイの `logo-plate`） |
| アプリアイコン（シンボルマーク） | `icons/icon-512.png`・`icons/icon-192.png`・`icons/apple-touch-icon.png`（180px） |
| 地図の左上・スプラッシュのシンボルマーク | `index.html` の `.logo-symbol`（文字ロゴの横・上に添える） |

## Firestoreのルールの反映

`firestore.rules` を `main` に push すると、GitHub Actions（`.github/workflows/firestore-rules.yml`）が Firebase（`osakenomitai-map`）へ自動で公開する。
Firebaseコンソールに貼って「公開」を押す運用は、2026-09-27にやめた（Coworkの自動実行では「公開」を押せず、毎回Shiryuの手が必要だったため）。

- 認証は GitHub Secrets の `FIREBASE_SERVICE_ACCOUNT`（サービスアカウントの鍵JSON）。未登録のあいだ、ワークフローは警告を出して何もせずに終わる。
- 手動で流すときは `gh workflow run firestore-rules.yml`。
- ルールを変えたら、`index.html` 側（`GENRES` など）と食い違っていないかも確認する。
