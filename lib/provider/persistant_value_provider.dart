import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'persistant_value_provider.g.dart';

@Riverpod(keepAlive: true)
class PersistantValue extends _$PersistantValue {
  @override
  int build() {
    return 0;
  }

  void increment() {
    state = state + 1;
  }
}
