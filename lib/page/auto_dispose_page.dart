import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_v2_tutorial/provider/cache_provider.dart';
import 'package:riverpod_v2_tutorial/provider/persistant_value_provider.dart';

class AutoDisposePage extends ConsumerWidget {
  const AutoDisposePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          OutlinedButton(
            // ボタンタップでカウントアップ
            onPressed: () {
              ref.read(persistantValueProvider.notifier).increment();
            },
            // ボタン長押しでカウントを初期化
            onLongPress: () {
              ref.invalidate(persistantValueProvider);
            },
            // persistantValueProvider は 監視しているリスナーがなくても状態が破棄されないため、アプリケーションを切るするまではずっと値を保持し続ける
            child: Text('count: ${ref.watch(persistantValueProvider)}'),
          ),
          // この画面を開いて1分間以内であれば、状態が保持される
          // (例: この画面を開く -> 「data: ~」と表示されるまで待つ -> 表示されたらすぐに一つ前の画面に戻ってからこの画面に戻ってくる -> 状態が保持されているため「loading...」が表示されない)
          ref.watch(cacheProvider).when(
                loading: () => const Text('loading...'),
                error: (error, stackTrace) => Text('error: ${error.toString()}, stackTrace: ${stackTrace.toString()}'),
                data: (data) => Text('data: ${data.toString()}'),
              ),
        ],
      ),
    );
  }
}
