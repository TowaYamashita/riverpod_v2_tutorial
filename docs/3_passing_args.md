# URL
https://riverpod.dev/docs/essentials/passing_args

---

# 引数付きプロバイダ

## 定義方法

```dart
Result myFunction(MyFunctionRef ref, String argument) {
  <your logic here>
}
```

```dart
@riverpod
class MyNotifier extends _$MyNotifier {

  // Notifier の場合は、引数を build() に渡す
  // 任意の型の引数を複数個渡せたり、名前付き引数にもできる
  @override
  Result build(String argument) {
     <your logic here>
  }
}
```

## 引数の渡し方

```dart
// 引数付きプロバイダの場合
final result1 = ref.watch(myFunctionProvider('arg'));

// 引数付きNotifierの場合
final result2 = ref.watch(MyNotifierProvider('args'));
```

## 注意点
- 引数ごとにキャッシュされる
- 引数が等しいかどうかは、引数の == 演算子に依存している

### 例: プロバイダの引数として新しいオブジェクトを直接インスタンス化して渡した場合

```dart
// NG
// ['recreational', 'cooking'] == ['recreational', 'cooking'] が false であるため、
// ネットワーク要求の無限ループが発生し、ユーザーに進行状況インジケータが永久に表示されてしまう
ref.watch(activityProvider(['recreational', 'cooking']))；

// GOOD1: const list にする
ref.watch(activityProvider(const ['recreational', 'cooking']))；

// GOOD2: == をオーバーライドしたクラスを作成して、それを引数として渡す
final args = EqualableList(['recreational', 'cooking']);
ref.watch(activityProvider(args))；
```
