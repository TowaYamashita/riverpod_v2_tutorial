import 'dart:developer';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:riverpod_v2_tutorial/provider/provider.dart';

part 'combining_request_using_listen_provider.g.dart';

@riverpod
Future<String> combiningRequestUsingListen(
  CombiningRequestUsingListenRef ref,
) async {
  ref.listen(activityProvider, (previous, next) {
    log('[listen] Change from: $previous, next: $next');
    
  });

  ref.listenSelf((previous, next) {
    log('[listenSelf] Change from: $previous, next: $next');
  });

  final data = await ref.watch(activityProvider.future);

  return 'activity: ${data.activity}';
}
