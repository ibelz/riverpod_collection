import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'main.g.dart';

// Sample by Rémi Rousselet
// see https://www.youtube.com/watch?v=BJtQ0dfI-RA

void main() {
  runApp(
    const ProviderScope(
      child: MaterialApp(
        home: MyApp(),
      ),
    ),
  );
}

@Riverpod(keepAlive: true)
Future<List<String>> fetchItems(ref, int page) async {
  if (page > 2) {
    return ['a', 'b'];
  }

  await Future.delayed(const Duration(seconds: 3));

  return List.generate(50, (index) => '$page $index');
}

class MyApp extends ConsumerWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TEST'),
      ),
      body: ListView.builder(itemBuilder: (context, index) {
        final page = index ~/ 50;

        final itemIndex = index % 50;

        final itemsFuture = ref.watch(fetchItemsProvider(page));

        return itemsFuture.when(
            error: (err, st) => Text(err.toString()),
            loading: () {
              if (itemIndex != 0) return null;

              return const Text('loading...');
            },
            data: (items) {
              if (itemIndex >= items.length) return null;

              return Text(items[itemIndex]);
            });
      }),
    );
  }
}
