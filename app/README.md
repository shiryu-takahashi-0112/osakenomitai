# オサケノミタイ（App Store・Google Play 版）

ウェブ版（このリポジトリの一番上の `index.html`）を、そのままアプリに包んだもの。作りは [Capacitor](https://capacitorjs.com/)。

- アプリの中の画面は、ウェブ版と同じファイル。`npm run sync` で `www/` に写してから、Android・iPhone のプロジェクトに入れる。
- **ウェブ版を直したら、アプリは出し直すまで古いまま。** ストアに出したあとは、直すたびに `npm run sync` して、新しい版を審査に出す。
- アプリのID：`com.osakenomitai.app`
- Google ログインは、アプリの中ではポップアップが使えないので、端末の Google ログイン（`@capacitor-firebase/authentication`）を使う。切り替えは `index.html` の `login()`（`isNativeApp()` のときだけ）。

## フォルダ

| 場所 | 中身 |
|---|---|
| `android/` | Android Studio で開くプロジェクト |
| `ios/` | Xcode で開くプロジェクト（`ios/App/App.xcodeproj`） |
| `assets/` | アイコンと起動画面の元画像。`npx capacitor-assets generate --iconBackgroundColor '#F2C600' --splashBackgroundColor '#ffffff'` で各サイズに書き出す |
| `copy-web.mjs` | ウェブ版を `www/` に写す |
| `android/app/debug.keystore` | 試用版の署名の鍵（どこで作っても同じ SHA-1 になるように、リポジトリに入れている。ストアに出す版の鍵とは別） |

## 試すまでの手順

### 1. Firebase にアプリを登録する（無料・Shiryu）

Firebase のコンソール → プロジェクト `osakenomitai-map` → プロジェクトの設定 → 「アプリを追加」。

**Android**
- パッケージ名：`com.osakenomitai.app`
- SHA-1：`5D:D9:D5:84:7D:65:E4:AE:DE:D0:43:F4:0A:4A:26:9F:38:00:8B:10`（試用版の鍵）
- 出てくる `google-services.json` を `app/android/app/` に置く。

**iPhone**
- バンドルID：`com.osakenomitai.app`
- 出てくる `GoogleService-Info.plist` を Xcode で `App/App/` に入れる（「Copy items if needed」にチェック）。
- `GoogleService-Info.plist` の `REVERSED_CLIENT_ID` の値を、Xcode の App → Info → URL Types に足す（URL Schemes に貼る）。

どちらのファイルも、ウェブ版の `firebaseConfig` と同じく公開してよい値なので、リポジトリに入れてよい。

この設定ファイルが無いと、アプリは起動してすぐ落ちる。

### 2. Android の試用版を入れる

`google-services.json` を入れて push すると、GitHub Actions の「Build Android app (試用版)」が APK を作る。実行結果の「Artifacts」から `osakenomitai-android-apk` をダウンロードし、Android の端末で開くと入る（「提供元不明のアプリ」を許可する）。

Mac で作るときは、Android Studio を入れてから：

```bash
cd app && npm install && npm run android
```

### 3. iPhone で試す（Mac）

Xcode を入れてから：

```bash
cd app && npm install && npm run ios
```

Xcode で App → Signing & Capabilities の Team に自分の Apple ID を選び、iPhone をつないで ▶。無料の Apple ID でも、自分の iPhone には7日間入れられる。

## ストアに出すとき（まだしていない）

- **Google Play**：登録料 25ドル（一度だけ）。個人のアカウントは、公開の前に12人以上で14日間のテストが要る。出すのは APK ではなく AAB（`./gradlew bundleRelease`）。ストアに出す版の署名の鍵は別に作り、なくさないように保管する。
- **App Store**：年 99ドル。ウェブを包んだだけのアプリは断られやすい（審査ガイドライン 4.2）。地図・現在地・ログインがあるので通る見込みはあるが、断られたら、アプリならではの機能（お知らせの通知など）を足す。
- どちらも、プライバシーポリシーのURL、年齢の区分（お酒の情報があるので高め）、スクリーンショットが要る。
- Google ログインがあるので、App Store では「Appleでサインイン」も求められることがある（審査ガイドライン 4.8）。

## アプリの中での違い

- 酒場記録の画像は、アプリの中では共有シートから保存する（「画像を保存」「写真に保存」を選ぶ）。
