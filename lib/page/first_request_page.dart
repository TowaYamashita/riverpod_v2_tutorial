import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_v2_tutorial/provider/provider.dart';

class FirstRequestPage extends ConsumerStatefulWidget {
  const FirstRequestPage({
    super.key,
  });

  @override
  ConsumerState<FirstRequestPage> createState() => _FirstRequestPageState();
}

class _FirstRequestPageState extends ConsumerState<FirstRequestPage> {
  @override
  void initState() {
    super.initState();
    ref.listenManual(activityProvider, (previous, next) {
      final prevText = 'prev: ${previous?.valueOrNull ?? 'none'}';
      final nextText = 'next: ${next.valueOrNull ?? 'none'}';

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('$prevText -> $nextText'),
        ),
      );
    });
  }

  void refresh() {
    ref.invalidate(activityProvider);
  }

  @override
  Widget build(BuildContext context) {
    final activity = ref.watch(activityProvider);

    return Scaffold(
      appBar: AppBar(),
      body: Center(
        // activity の状態(ロード中 or エラー or データ取得)に応じて Widget を出し分ける
        child: switch (activity) {
          AsyncData(:final value) => Text('Activity: ${value.activity}'),
          AsyncError() => const Text('error'),
          _ => const CircularProgressIndicator.adaptive(),
        },

        /// パターンマッチを使わない書き方だと以下のような感じ
        // child: activity.when(
        //   data: (value) => Text('Activity: ${value.activity}'),
        //   error: (_, __) => const Text('error'),
        //   loading: () => const CircularProgressIndicator.adaptive(),
        // ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: refresh,
        child: const Icon(Icons.refresh),
      ),
    );
  }
}
