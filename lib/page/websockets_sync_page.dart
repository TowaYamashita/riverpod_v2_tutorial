import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_v2_tutorial/provider/raw_stream_provider.dart';
import 'package:riverpod_v2_tutorial/provider/stream_example_provider.dart';
import 'package:riverpod_v2_tutorial/provider/synchronous_example_provider.dart';

class WebsocketsSyncPage extends StatelessWidget {
  const WebsocketsSyncPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _SynchronousExample(),
            _StreamExample(),
            _RawStream(),
          ],
        ),
      ),
    );
  }
}

class _SynchronousExample extends ConsumerWidget {
  const _SynchronousExample({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final int value = ref.watch(synchronousExampleProvider);

    return Text('$value');
  }
}

class _StreamExample extends ConsumerWidget {
  const _StreamExample({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AsyncValue<int> value = ref.watch(streamExampleProvider);

    return switch (value) {
      AsyncValue(:final error?) => Text('Error: $error'),
      AsyncValue(:final valueOrNull?) => Text('$valueOrNull'),
      _ => const CircularProgressIndicator.adaptive(),
    };
  }
}

class _RawStream extends ConsumerWidget {
  const _RawStream({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final Stream<int> stream = ref.watch(rawStreamProvider);

    return StreamBuilder(
      stream: stream,
      builder: (_, snapshot) {
        return Text('${snapshot.data}');
      },
    );
  }
}
