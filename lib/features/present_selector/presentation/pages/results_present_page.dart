import 'package:christmas/features/present_selector/presentation/providers/llm_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lottie/lottie.dart';
import 'package:christmas/features/present_selector/presentation/widgets/build_gift_list.dart';

class ResultsPresentPage extends ConsumerWidget {
  final String prompt;
  const ResultsPresentPage({
    super.key,
    required this.prompt,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final llmResponse = ref.watch(llmResponseProvider(prompt));

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: Theme.of(context).colorScheme.background,
            expandedHeight: 50.0,
            floating: false,
            pinned: true,
            flexibleSpace: const FlexibleSpaceBar(
              title: Text(
                'Geschenkideen',
                style: TextStyle(
                    fontSize: 17.5,
                    fontWeight: FontWeight.w600,
                    color: Colors.white),
              ),
            ),
          ),
          // testing design with mocked response
          // buildGiftList(context, llmResponseMock),
          llmResponse.when(
            data: (answer) => buildGiftList(context, answer),
            loading: () => SliverToBoxAdapter(
                child: LottieBuilder.asset('./assets/lottie/present.json')),
            error: (err, _) => SliverToBoxAdapter(child: Text('Fehler: $err')),
          ),
        ],
      ),
    );
  }
}
