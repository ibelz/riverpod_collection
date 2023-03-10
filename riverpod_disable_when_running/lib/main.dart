import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jumping_dot/jumping_dot.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

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

// extension for possibility 2 (by RandalSchwartz via Discord)
extension ProviderIsLoading<T, AVT extends AsyncValue<T>> on WidgetRef {
  bool isLoading(ProviderListenable<AVT> provider) => watch(provider.select((AVT s) => s.isLoading));
}

@riverpod
class Counter extends _$Counter {
  @override
  FutureOr<int> build() async {
    return 0;
  }

  Future<void> increment() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      await Future.delayed(const Duration(seconds: 1));
      return state.requireValue + 1;
    });
  }
}

class HomeView extends ConsumerWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final counter = ref.watch(counterProvider);

    //possibility 1:
    final incrementIsLoading = ref.watch(counterProvider.select((p) => p.isLoading));

    return Scaffold(
      body: Center(
        child: counter.when(
          // skipLoadingOnReload: true,
          loading: () => const JumpingDots(
            color: Colors.blue,
            radius: 7,
            numberOfDots: 3,
            animationDuration: Duration(milliseconds: 200),
          ),
          error: (err, stack) => Text('Error: $err'),
          data: (counter) => Text(
            '$counter',
            style: Theme.of(context).textTheme.headlineLarge,
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: incrementIsLoading ? Colors.grey : Colors.blue,
        // possibility 2: with extension
        onPressed: ref.isLoading(counterProvider) ? null : () => ref.read(counterProvider.notifier).increment(),
        child: const Icon(
          Icons.add,
        ),
      ),
    );
  }
}
