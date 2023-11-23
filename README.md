# riverpod_v2_tutorial

## Environment
```shell
❯ fvm --version     
2.4.1

❯ fvm flutter doctor
Doctor summary (to see all details, run flutter doctor -v):
[✓] Flutter (Channel stable, 3.16.0, on macOS 14.1.1 23B81 darwin-arm64, locale ja-JP)
[✓] Android toolchain - develop for Android devices (Android SDK version 31.0.0)
[✓] Xcode - develop for iOS and macOS (Xcode 15.0.1)
[✓] Chrome - develop for the web
[✓] Android Studio (version 2022.3)
[✓] VS Code (version 1.84.2)
[✓] Connected device (3 available)
[✓] Network resources

• No issues found!
```

# Setup
- 以下のコマンドを実行して、 使用するFlutterのバージョンの設定やパッケージの取得を行う

```shell
git clone https://github.com/TowaYamashita/riverpod_v2_tutorial.git
cd riverpod_v2_tutorial
fvm install
fvm flutter pub get
```

- VSCode の「実行とデバッグ」タブから、適当なモードを選んで「デバッグの開始」を押下する