# URL
https://riverpod.dev/docs/essentials/combining_requests

---

# プロバイダ内から他のプロバイダを監視する

## 基本
- `Ref` を使って、他のプロバイダへアクセスできる

```dart
@riverpod
int example(ExampleRef ref) {
  final otherValue = ref.watch(otherProvider);
  return 0;
}

@riverpod
class Example extends _$Example {
  @override
  int build() {
    final otherValue = ref.watch(otherProvider);
    return 0;
  }
}
```

## ref.watch
- プロバイダーを受け取り、その現在の状態を返す
  - アクセス先のプロバイダーが変更されるたびに、こちらのプロバイダーは無効化され、次のフレームか次の読み込み時に再構築される
- 一般的に、下記の理由から ref.watch を使ったほうが保守しやすいため推奨
  - ロジックは必要なときに自動的に再計算されるため
    -  "反応的 "かつ "宣言的 "になる
  - 更新メカニズムが変更時のような副作用に依存しないため
  
```dart
@riverpod
String userId(UserIdRef ref) {
  return '4d372943-eaa8-4966-88bf-72ded7723771';
}

@riverpod
Future<User> user(UserRef ref) async{
  final userId = ref.watch(userIdProvider);
  final response = await http.get(
    // 省略
  );

  final user = // 省略
  return user;
}
```

## ref.listen
- プロバイダとコールバックを受け取り、プロバイダの状態が変更されるたびにコールバックを呼び出す

```dart
@riverpod
int example(ExampleRef ref) {
  ref.listen(otherProvider, (previous, next) {
    print('Changed from: $previous, next: $next');
  });

  return 0;
}
```

## ref.read
- プロバイダーの現在の状態を取得するだけ
  - ただし、アクセス先のプロバイダの状態が変わっても何もしない
- `ref.watch` を使用できない場所でのみ使用する必要がある
  - 例: Notifier の メソッド内部など

```dart
@riverpod
class MyNotifier extends _$MyNotifier {
  @override
  int build() {
    return 0;
  }

  void increment() {
    ref.read(otherProvider);
  }
}
```