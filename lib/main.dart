import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_v2_tutorial/provider/provider.dart';

void main() {
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends ConsumerStatefulWidget {
  const MyHomePage({
    super.key,
    required this.title,
  });

  final String title;

  @override
  ConsumerState<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends ConsumerState<MyHomePage> {
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
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
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
