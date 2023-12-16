# URL
https://riverpod.dev/docs/essentials/auto_dispose

---

# AutoDispose を無効にする方法

- riverpod_generator を使って生成される Provider, Notifier は基本的には AutoDispose になる
  - Provider または Notifier を監視しているリスナーがすべて無効になったら状態が破棄される
- `@Riverpod(keepAlive: true)` といったアノテーションを付与することで、AutoDispose 扱いにならなくなる

```dart
@Riverpod(keepAlive: true)
int example(ExampleRef ref){
  return 0;
}
```

> Provider および Notifier がパラメータを受け取る場合は AutoDispose にすることを推奨
>> そうしないと、パラメータの組み合わせごとに状態が生成され、メモリリークが発生する恐れがあるため

# 状態を破棄する際に何か実行したい場合は？

- `ref.onDispose()` に状態が破棄された際に実行したい処理を渡してあげるとよい。

```dart
@riverpod
Stream<int> example(ExampleRef ref){
  final controller = StreamController();

  // この Provider の状態が破棄された際に実行する処理
  ref.onDispose((){
    print('exec: onDispose');
    controller.close();
  });

  // この Provider を監視している最後のリスナーが削除された際に実行する処理
  ref.onCancel((){
    print('exec: onCancel');
  });

  // onCancel が呼び出された後に新しいリスナーが追加された際に実行する処理
  ref.onResume((){
    print('exec: onResume');
  });

  return controller.stream;
}
```

> ref.onDispose は何度でも呼び出せるため、使い捨て可能なオブジェクト1つにつき、ref.onDispose を一回呼び出すことを推奨
>> こうすることで、使い捨て可能なオブジェクトなのに使い捨て処理をしていないことに気づきやすくなる

# 状態を強制的に破棄したい場合は？

- ref.invalidate を使うことで、現在のプロバイダの状態が破棄される
  - Provider または Notifier が監視されれば、新しい状態が作成され、そうでなければ破棄される
- ref.invalidateSelf を使うことで、現在のプロバイダの状態が破棄される
  - 監視されていてもいなくても、新しい状態が作成される

```dart
class MyWidget extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ElevatedButton(
      onPressed: () {
        // someProvider で管理している状態を無効化する
        ref.invalidate(someProvider);
      },
      child: const Text('dispose a provider'),
    );
  }
}
```

- パラメータを受け取る Provider または Notifier を無効化する場合は、特定のパラメータの組み合わせだけ無効化するかすべてのパラメータの組み合わせを無効化するか選べる

```dart
@riverpod
String label(LabelRef ref, String userName) {
  return 'Hello $userName';
}

// ...

void onTap() {
  // すべてのパラメータの組み合わせを無効化
  ref.invalidate(labelProvider);

  // 特定のパラメータの組み合わせだけ無効化
  ref.invalidate(labelProvider('John'));
}
```

# 特定の条件のときだけ状態を破棄するようにするには？

- AutoDispose が有効になっている Provider または Notifier 内で ref.keepAlive を使うことで、状態の自動破棄を停止するかどうかを決定できる

```dart
@riverpod
Future<String> example(ExampleRef ref){
  final response = http.get(Uri.parse('https://example.com'));

  // リクエストに成功した場合は、仮にこの Provider を監視しているリスナーがいなくても状態は維持する
  // リクエストに失敗した(=エラーを投げられた)場合は、状態を破棄する
  final canceller = ref.keepAlive();

  if(何かしらの条件){
    // この Provider を監視しているリスナーがいなくなったら状態を破棄する
    canceller.close();
  }

  return response.body;
}
```


# 例: 特定の期間の間を過ぎたら状態を破棄する

```dart
extension CacheForExtension on AutoDisposeRef<Object?> {

  void cacheFor(Duration duration) {
    final link = keepAlive();
    final timer = Timer(duration, link.close);
    onDispose(timer.cancel);
  }
}

@riverpod
Future<Object> example(ExampleRef ref) async {
  /// 5分経過したら状態を破棄する
  ref.cacheFor(const Duration(minutes: 5));

  return http.get(Uri.https('example.com'));
}
```