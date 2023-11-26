import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:riverpod_v2_tutorial/provider/combining_request_using_watch_provider.dart';

part 'combining_request_using_read_provider.g.dart';

@riverpod
class CombiningRequestUsingRead extends _$CombiningRequestUsingRead {
  @override
  String build() {
    return '';
  }

  Future<void> sync() async {
    final activity = await ref.read(combiningRequestUsingWatchProvider.future);
    state = activity;
  }
}
