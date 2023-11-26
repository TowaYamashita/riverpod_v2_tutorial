import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_v2_tutorial/provider/activity_with_type_provider.dart';

class PassingArgsPage extends ConsumerWidget {
  const PassingArgsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final recreational = ref.watch(
      activityWithTypeProvider('recreational'),
    );
    final cooking = ref.watch(
      activityWithTypeProvider('cooking'),
    );

    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(recreational.valueOrNull?.activity ?? ''),
            Text(cooking.valueOrNull?.activity ?? ''),
          ],
        ),
      ),
    );
  }
}
