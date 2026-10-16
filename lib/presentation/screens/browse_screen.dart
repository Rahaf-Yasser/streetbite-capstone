import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_app/core/l10n/app_localizations_extension.dart';
import 'package:flutter_app/domain/usecases/get_categories.dart';
import 'package:flutter_app/domain/usecases/get_meals.dart';
import 'package:flutter_app/injection.dart';
import 'package:flutter_app/presentation/blocs/home/home_cubit.dart';
import 'package:flutter_app/presentation/blocs/home/home_state.dart';
import 'package:flutter_app/presentation/widgets/home/home_error_view.dart';
import 'package:flutter_app/presentation/widgets/home/home_loading_view.dart';
import 'package:flutter_app/presentation/widgets/home/meal_grid_sliver.dart';
import 'package:flutter_app/presentation/widgets/home/meal_search_bar.dart';

class BrowseScreen extends StatelessWidget {
  const BrowseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => HomeCubit(
        getMeals: getIt<GetMeals>(),
        getCachedMeals: getIt<GetCachedMeals>(),
        getCategories: getIt<GetCategories>(),
      )..loadInitial(),
      child: const _BrowseView(),
    );
  }
}

class _BrowseView extends StatelessWidget {
  const _BrowseView();

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      appBar: AppBar(title: Text(l10n.navBrowse)),
      body: BlocBuilder<HomeCubit, HomeState>(
        buildWhen: (p, c) =>
            p.status != c.status ||
            p.meals != c.meals ||
            p.searchQuery != c.searchQuery,
        builder: (context, state) {
          if ((state.status == HomeStatus.loading ||
                  state.status == HomeStatus.initial) &&
              !state.hasMeals) {
            return const HomeLoadingView();
          }

          if (state.status == HomeStatus.error && !state.hasMeals) {
            return HomeErrorView(
              message: l10n.loadMealsError,
              onRetry: () => context.read<HomeCubit>().refresh(),
            );
          }

          if (!state.hasMeals) {
            return Center(
              child: Text(l10n.noMeals, style: theme.textTheme.bodyLarge),
            );
          }

          return CustomScrollView(
            slivers: [
              const SliverToBoxAdapter(child: MealSearchBar()),
              const SliverToBoxAdapter(child: SizedBox(height: 8)),
              if (state.isSearching && state.searchResults.isEmpty)
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.all(32),
                    child: Center(
                      child: Text(
                        l10n.noSearchResults,
                        style: theme.textTheme.bodyLarge,
                      ),
                    ),
                  ),
                )
              else
                MealGridSliver(
                  meals: state.isSearching ? state.searchResults : state.meals,
                ),
            ],
          );
        },
      ),
    );
  }
}