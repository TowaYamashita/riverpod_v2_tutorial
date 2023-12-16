import 'dart:async';
import 'dart:developer';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:http/http.dart' as http;

part 'cache_provider.g.dart';

@riverpod
Future<Object> cache(CacheRef ref) async {
  final link = ref.keepAlive();
  final timer = Timer(const Duration(minutes: 1), () {
    log('exec: 状態の維持を解除');
    link.close();
  });

  ref.onDispose(() {
    log('exec: 状態の維持を解除するかどうかに関するタイマーを停止');
    timer.cancel();
  });

  ref.onCancel(() {
    log('exec: onCancel');
  });
  ref.onDispose(() {
    log('exec: onDispose');
  });
  ref.onResume(() {
    log('exec: onResume');
  });

  return http.get(Uri.https('example.com'));
}
