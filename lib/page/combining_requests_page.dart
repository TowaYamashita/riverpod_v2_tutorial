import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_v2_tutorial/provider/combining_request_using_listen_provider.dart';
import 'package:riverpod_v2_tutorial/provider/combining_request_using_read_provider.dart';
import 'package:riverpod_v2_tutorial/provider/combining_request_using_watch_provider.dart';

class CombainingRequestsPage extends StatelessWidget {
  const CombainingRequestsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: const Column(
        children: [
          _Watch(),
          _Listen(),
          _Read(),
        ],
      ),
    );
  }
}

class _Watch extends ConsumerWidget {
  const _Watch({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final value = ref.watch(combiningRequestUsingWatchProvider);

    return switch (value) {
      AsyncValue(:final error?) => Text('Error: $error'),
      AsyncValue(:final valueOrNull?) => Text(valueOrNull),
      _ => const CircularProgressIndicator.adaptive(),
    };
  }
}

class _Listen extends ConsumerWidget {
  const _Listen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final value = ref.watch(combiningRequestUsingListenProvider);

    return switch (value) {
      AsyncValue(:final error?) => Text('Error: $error'),
      AsyncValue(:final valueOrNull?) => Text(valueOrNull),
      _ => const CircularProgressIndicator.adaptive(),
    };
  }
}

class _Read extends ConsumerWidget {
  const _Read({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final value = ref.watch(combiningRequestUsingReadProvider);

    return ElevatedButton(
      onPressed: () async {
        await ref.read(combiningRequestUsingReadProvider.notifier).sync();
      },
      child: Text(value.isNotEmpty ? value : 'tapme'),
    );
  }
}
