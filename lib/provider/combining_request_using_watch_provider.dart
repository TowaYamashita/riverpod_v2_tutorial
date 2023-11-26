import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:riverpod_v2_tutorial/provider/provider.dart';

part 'combining_request_using_watch_provider.g.dart';

@riverpod
Future<String> combiningRequestUsingWatch(
    CombiningRequestUsingWatchRef ref) async {
  final data = await ref.watch(activityProvider.future);

  return 'activity: ${data.activity}';
}
