import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_v2_tutorial/model/todo.dart';
import 'package:riverpod_v2_tutorial/provider/todo_list_provider.dart';

class SideEffectsPage extends StatelessWidget {
  const SideEffectsPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: const _TodoList(),
      persistentFooterButtons: const [
        _Example(),
      ],
    );
  }
}

class _TodoList extends ConsumerWidget {
  const _TodoList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todoList = ref.watch(todoListProvider);

    return todoList.when(
      loading: () => const Center(child: CircularProgressIndicator.adaptive()),
      error: (_, __) => const Center(child: Text('error!')),
      data: (d) {
        return ListView.builder(
          itemBuilder: (_, index) {
            final todo = d.elementAt(index);
            return ListTile(
              title: Text(todo.todo),
              subtitle: Text('user: ${todo.userId}'),
              tileColor: todo.completed ? Colors.grey : null,
            );
          },
          itemCount: d.length,
        );
      },
    );
  }
}

class _Example extends ConsumerStatefulWidget {
  const _Example({Key? key}) : super(key: key);

  @override
  ConsumerState<_Example> createState() => _ExampleState();
}

class _ExampleState extends ConsumerState<_Example> {
  Future<void>? _pendingAddTodo;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _pendingAddTodo,
      builder: (_, snapshot) {
        final isErrored = snapshot.hasError &&
            snapshot.connectionState != ConnectionState.waiting;

        return Row(
          children: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: isErrored ? Colors.red : null,
              ),
              onPressed: () {
                final future = ref.read(todoListProvider.notifier).addTodo(
                      Todo(todo: 'this is a new todo', userId: 1),
                    );
                setState(() {
                  _pendingAddTodo = future;
                });
              },
              child: const Text('Add Todo'),
            ),
            if (snapshot.connectionState == ConnectionState.waiting) ...[
              const SizedBox(
                width: 8,
              ),
              const CircularProgressIndicator.adaptive(),
            ],
          ],
        );
      },
    );
  }
}
