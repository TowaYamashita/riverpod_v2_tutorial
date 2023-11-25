# URL
https://riverpod.dev/docs/essentials/side_effects

---

# riverpod_generator 構文 (Notifier)

```dart
// サンプル
@riverpod
class MyNotifier extends _$MyNotifier {
  @override
  Result build() {
     <your logic here>
  }
}
```

## アノテーション
[一つ前のメモ](1_first_request.md) でも同じことを書いているので省略

## Notifier
- サンプルにおける `class MyNotifier extends _$MyNotifier` の部分
- Notifier とは、状態を変更するためのパブリックAPIが公開されたプロバイダのこと

### 注意点
- 組み込みのプロパティ以外のパブリックプロパティを持つべきではない 
  - 組み込みのプロパティ以外のパブリックプロパティが変更されたとしても、プロバイダを使う側はそれを知る手段がないため
- Notifier のコンストラクタにロジックを含めるべきではない
  - 例: 初期化処理
  - そういった処理は、`build()` 内に書く

## build
- サンプルにおける `build()` の部分
- 初期化処理を書く
- `build()` は直接呼び出すべきではない


# ref.invalidateSelf
- プロバイダの状態を無効にし、リフレッシュさせる。
- リフレッシュは即時ではなく、次の読み取りまたは次のフレームまで遅延される
- invalidateSelfを複数回呼び出すと、プロバイダは1回だけリフレッシュされる
- invalidateSelfを呼び出すと、プロバイダは直ちに破棄される

> https://pub.dev/documentation/hooks_riverpod/latest/hooks_riverpod/Ref/invalidateSelf.html

# future
- Notifier 内で AsyncLoading ではない状態を読み取ることができる
  - 以前の状態が「エラー」の際に `future` を使うと、エラーが投げられる

```dart
Future<void> addTodo(Todo todo) async {
  await http.post(
    Uri.https('your_api.com', '/todos'),
    headers: {'Content-Type': 'application/json'},
    body: jsonEncode(todo.toJson()),
  );

  final previousState = await future;
}
```

> https://pub.dev/documentation/hooks_riverpod/latest/hooks_riverpod/AsyncNotifier/future.html