# URL
https://riverpod.dev/docs/essentials/websockets_sync

---

# オブジェクトを同期的に返す
- プロバイダを定義する際に、Future<T> とか Stream<T> でなければ、AsyncValue に変換されない

```dart
@riverpod
int synchronousExample(SynchronousExampleRef ref) {
  return 0;
}
```


# Stream
- Riverpodは当然Streamオブジェクトをサポートしており、Futuresと同様に、AsyncValueに変換される

```dart
@riverpod
Stream<int> streamExample(StreamExampleRef ref) async* {
  for (var i = 0; i < 42; i++) {
    yield i;
    await Future<void>.delayed(const Duration(seconds: 1));
  }
}
```

# AsyncValue への変換を無効にする
- `Raw` で戻り値の型をラップすることで、StreamsとFuturesをAsyncValueに変換しなくなる
  - 一般的に、AsyncValue への変換を無効にすることは推奨されない

```dart
// 従来
// final AsyncValue<int> value = ref.watch(normalStreamProvider);
@riverpod
Stream<int> normalStream(RawStreamRef ref) {
  return const Stream<int>.empty();
}

// Raw で囲んだ場合
// final Stream<int> value = ref.watch(rawStreamProvider);
@riverpod
Raw<Stream<int>> rawStream(RawStreamRef ref) {
  return const Stream<int>.empty();
}
```

## 注意点
- `Raw<T>` は `T` を「Riverpodで処理すべきではない」とマークするためのアノテーションであり、 これは `T` への型エイリアスであり、実行時には何の効果もない。これはメタデータとしてのみ使用される。

> https://pub.dev/documentation/riverpod_annotation/latest/riverpod_annotation/Raw.html