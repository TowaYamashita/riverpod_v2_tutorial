import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_v2_tutorial/page/combining_requests_page.dart';
import 'package:riverpod_v2_tutorial/page/first_request_page.dart';
import 'package:riverpod_v2_tutorial/page/passing_args_page.dart';
import 'package:riverpod_v2_tutorial/page/side_effects_page.dart';
import 'package:riverpod_v2_tutorial/page/websockets_sync_page.dart';

void main() {
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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

class MyHomePage extends StatelessWidget {
  const MyHomePage({
    super.key,
    required this.title,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    final pages = [
      ListTile(
        title: const Text('first_request'),
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => const FirstRequestPage(),
            ),
          );
        },
      ),
      ListTile(
        title: const Text('side_effects'),
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => const SideEffectsPage(),
            ),
          );
        },
      ),
      ListTile(
        title: const Text('passing_args'),
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => const PassingArgsPage(),
            ),
          );
        },
      ),
      ListTile(
        title: const Text('websockets_sync'),
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => const WebsocketsSyncPage(),
            ),
          );
        },
      ),
      ListTile(
        title: const Text('combaining_requests'),
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => const CombainingRequestsPage(),
            ),
          );
        },
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(title),
      ),
      body: ListView.builder(
        itemBuilder: (_, index) => pages.elementAt(index),
        itemCount: pages.length,
      ),
    );
  }
}
