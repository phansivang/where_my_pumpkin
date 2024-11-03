import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/di/main_di.dart';
import '../../../../core/shared/widgets/custom_scaffold.dart';
import '../../../../core/shared/widgets/custom_text.dart';
import '../cubit/cat_cubit.dart';

/// A page class for home page
class HomePage extends StatelessWidget {
  /// Creates an instance of [HomePage]
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<CatCubit>(),
      child: const _HomePageContent(),
    );
  }
}

class _HomePageContent extends StatefulWidget {
  const _HomePageContent();

  @override
  State<_HomePageContent> createState() => __HomePageContentState();
}

class __HomePageContentState extends State<_HomePageContent> {
  late CatCubit catCubit;
  @override
  void initState() {
    super.initState();
    catCubit = BlocProvider.of<CatCubit>(context);
    catCubit.fetchCatFacts();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBar: AppBar(
        title: const CustomText(
          'Cat FactE',
          fontWeight: FontWeight.bold,
        ),
      ),
      body: BlocBuilder<CatCubit, CatState>(
        builder: (context, state) {
          if (state is CatLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is CatLoaded) {
            return ListView.builder(
              itemCount: state.facts.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.pets, size: 12),
                      const SizedBox(width: 8),
                      CustomText('Fact #${index + 1}'),
                    ],
                  ),
                  title: CustomText(state.facts[index].text),
                );
              },
            );
          } else if (state is CatError) {
            return Center(child: CustomText(state.message));
          }
          return Container();
        },
      ),
    );
  }
}
