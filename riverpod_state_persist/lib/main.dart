import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'main.g.dart';

void main() {
  runApp(
    const ProviderScope(
      child: MaterialApp(
        home: HomeView(),
      ),
    ),
  );
}

const String stateKey = 'counterState';

@Riverpod(keepAlive: true)
Future<SharedPreferences> sharedPref(SharedPrefRef ref) {
  return SharedPreferences.getInstance();
}

@riverpod
class Counter extends _$Counter {
  @override
  FutureOr<int> build() async {
    final persistedState = await readState();
    return persistedState ?? 0;
  }

  Future<void> increment() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      return state.requireValue + 1;
    });
    persistState();
  }

  void reset() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      return 0;
    });
    persistState();
  }

  Future<int?> readState() async {
    debugPrint('Read State');
    final prefs = await ref.read(sharedPrefProvider.future);

    return prefs.getInt(stateKey);
  }

  Future<void> persistState() async {
    debugPrint('Persist State');
    final prefs = await ref.read(sharedPrefProvider.future);

    // prefs.setString(stateKey, jsonEncode(state.toJson()));
    prefs.setInt(stateKey, state.requireValue);
    debugPrint('Persist State $stateKey: $state');
  }
}

class HomeView extends ConsumerWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final counter = ref.watch(counterProvider);
    final incrementIsLoading = ref.watch(counterProvider.select((p) => p.isLoading));

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            counter.when(
              // skipLoadingOnReload: true,
              loading: () => const Text('Loading...'),
              error: (err, stack) => Text('Error: $err'),
              data: (counter) => Text(
                '$counter',
                style: Theme.of(context).textTheme.headlineLarge,
              ),
            ),
            TextButton(
              onPressed: () => ref.read(counterProvider.notifier).reset(),
              child: const Text('Reset'),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: incrementIsLoading ? Colors.grey : Colors.blue,
        onPressed: incrementIsLoading ? null : () => ref.read(counterProvider.notifier).increment(),
        child: const Icon(
          Icons.add,
        ),
      ),
    );
  }
}
