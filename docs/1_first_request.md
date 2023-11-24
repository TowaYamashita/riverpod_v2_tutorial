# URL
https://riverpod.dev/docs/essentials/first_request

---

# riverpod_generator 構文

```dart
// サンプル
@riverpod
Result myFunction(MyFunctionRef ref) {
  <your logic here>
}
```

## アノテーション
- サンプルにおける `@riverpod` の部分
- すべてのプロバイダーには、@riverpod または @Riverpod() を付ける必要がある
- このアノテーションは、グローバル関数またはクラスに付けることができ、アノテーションを通してプロバイダを設定することができる
  - 例: `@Riverpod(keepAlive: true)` と記述することで、auto-dispose を無効にすることができる

## 関数
- サンプルにおける `myFunction` の部分
- アノテーションされた関数の名前は、プロバイダがどのように相互作用するかを決定する
- プロバイダの名前は、「関数名 + Provider」 にする必要がある
  - 例: サンプルだと、関数名が `myFunction` なので、プロバイダの名前は `myFunctionProvider` となる
- 最初の引数として  `ref` を指定しなければならないが、それ以外は、任意の数の引数を持つことができる
- この関数は、自由に `Future/Stream` を返すこともできる

## ref
- サンプルにおける `MyFunctionRef ref` の部分
- 他のプロバイダーとやり取りするためのオブジェクト
- プロバイダ関数のパラメータまたはノーティファイアのプロパティとして使用します
- ref の型の名前は、「関数名を UpperCamelCase に変換した文字列 + Ref」にする必要がある
  - 例: サンプルだと、関数名が `myFunction` なので、ref の型の名前は `MyFunctionRef` となる

# メモ: ref.listenManual と ref.listen の違い

- どちらもプロバイダを監視して値が変化するたびにコールバックを呼び出すという点では一致している。
- ただし、使う場所とシグネチャが異なる

## ref.listen
- `build()` の中で使う
- ウィジェットがリビルドされ、プロバイダのリッスンを停止した場合、リスナーは自動的に削除される
- モーダルを表示したり、命令的な書き方をする際に便利です。

```dart
void listen<T>(
  ProviderListenable<T> provider,
  void Function(T? previous, T next) listener, {
  void Function(Object error, StackTrace stackTrace)? onError,
});
```

> https://pub.dev/documentation/hooks_riverpod/latest/hooks_riverpod/WidgetRef/listen.html

## ref.listenManual
- State ライフサイクルの中で使う
  - 例: State.initState
  - `listenManual` を `build()` の中で使うのは安全ではない
- listenManualを呼び出すウィジェットが破棄されると、サブスクリプションは自動的に破棄される
  - 例: `State.dispose` 内で `ProviderSubscription.close` を呼び出す必要はない
- fireImmediately は、リスナーが追加されるとすぐに呼び出すかどうかを決定する
  - trueに設定すると、変更が発生する前であっても、プロバイダの現在値でリスナーが即座に呼び出される
  - この機能により、リスナーが確立されたときに、現在の状態に即座に反応することができる

```dart
ProviderSubscription<T> listenManual<T>(
  ProviderListenable<T> provider,
  void Function(T? previous, T next) listener, {
  void Function(Object error, StackTrace stackTrace)? onError,
  bool fireImmediately,
});
```

> https://pub.dev/documentation/hooks_riverpod/latest/hooks_riverpod/WidgetRef/listenManual.html