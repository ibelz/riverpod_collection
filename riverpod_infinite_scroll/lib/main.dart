import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'main.g.dart';

// Sample by Rémi Rousselet (enhanced)
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

const itemsPerPage = 20;
const numberOfPages = 10;
const loadingDuration = Duration(seconds: 1);

@Riverpod(keepAlive: true)
Future<List<String>> fetchItems(FetchItemsRef ref, int page) async {
  if (page > numberOfPages) {
    return ['penultimate item', 'last item'];
  }

  await Future.delayed(loadingDuration);

  // random number is only for visualisation that data changes
  final pageRandom = Random().nextInt(1000);

  return List.generate(itemsPerPage, (index) {
    return 'Page ${page + 1} - No ${index + 1} - Random $pageRandom';
  });
}

class MyApp extends ConsumerWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Infinite Scroll Sample'),
        actions: [
          //todo: how to refresh the listview completely (with empty list)?
          IconButton(
            onPressed: () => ref.invalidate(fetchItemsProvider),
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ListView.builder(
          itemBuilder: (context, index) {
            final currentPage = index ~/ itemsPerPage;
            final currentIndexInPage = index % itemsPerPage;

            final previousItemPage = currentIndexInPage == 0 ? currentPage - 1 : currentPage;
            final previousItemIndexInPage = currentIndexInPage == 0 ? itemsPerPage - 1 : currentIndexInPage - 1;

            final itemsFuture = ref.watch(fetchItemsProvider(currentPage));

            return itemsFuture.when(
                error: (err, st) => Text(err.toString()),
                loading: () {
                  if (currentIndexInPage != 0) return null;

                  return const Text('loading...');
                },
                data: (items) {
                  if (currentIndexInPage >= items.length) return null;

                  return Text(items[currentIndexInPage]);
                });
          },
        ),
      ),
    );
  }
}
