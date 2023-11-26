import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'stream_example_provider.g.dart';

@riverpod
Stream<int> streamExample(StreamExampleRef ref) async* {
  for (var i = 0; i < 42; i++) {
    yield i;
    await Future<void>.delayed(const Duration(seconds: 1));
  }
}
