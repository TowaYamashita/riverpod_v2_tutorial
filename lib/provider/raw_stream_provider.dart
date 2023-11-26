import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'raw_stream_provider.g.dart';

@riverpod
Raw<Stream<int>> rawStream(RawStreamRef ref) {
  return const Stream<int>.empty();
}
