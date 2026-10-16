import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_app/presentation/widgets/home/meal_grid_sliver.dart';
import 'package:flutter_app/presentation/widgets/home/meal_search_bar.dart';
import 'package:flutter_app/core/l10n/app_localizations_extension.dart';
import 'package:flutter_app/domain/usecases/get_categories.dart';
import 'package:flutter_app/domain/usecases/get_meals.dart';
import 'package:flutter_app/injection.dart';
import 'package:flutter_app/presentation/blocs/cart/cart_bloc.dart';
import 'package:flutter_app/presentation/blocs/home/home_cubit.dart';
import 'package:flutter_app/presentation/blocs/home/home_state.dart';
import 'package:flutter_app/presentation/blocs/theme/theme_bloc.dart';
import 'package:flutter_app/presentation/blocs/theme/theme_event.dart';
import 'package:flutter_app/presentation/blocs/theme/theme_state.dart';
import 'package:flutter_app/presentation/widgets/home/banner_carousel.dart';
import 'package:flutter_app/presentation/widgets/home/cart_app_bar_action.dart';
import 'package:flutter_app/presentation/widgets/home/categories_section.dart';
import 'package:flutter_app/presentation/widgets/home/home_error_view.dart';
import 'package:flutter_app/presentation/widgets/home/home_loading_view.dart';
import 'package:flutter_app/presentation/widgets/home/hot_offers_section.dart';
import 'package:flutter_app/presentation/widgets/home/section_header.dart';
import 'package:flutter_app/presentation/widgets/profile_icon_button.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => HomeCubit(
        getMeals: getIt<GetMeals>(),
        getCachedMeals: getIt<GetCachedMeals>(),
        getCategories: getIt<GetCategories>(),
      )..loadInitial(),
      child: const _HomeView(),
    );
  }
}

class _HomeView extends StatelessWidget {
  const _HomeView();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      buildWhen: (previous, current) =>
          previous.status != current.status ||
          previous.meals != current.meals ||
          previous.isRefreshing != current.isRefreshing ||
          previous.categoryStatus != current.categoryStatus ||
          previous.categories != current.categories ||
          previous.searchQuery != current.searchQuery  ||  
          previous.categoryStatus != current.categoryStatus ||
          previous.categories != current.categories ||
          previous.searchQuery != current.searchQuery,
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Theme.of(context).colorScheme.surface,
          appBar: _HomeAppBar(),
          body: _HomeBody(state: state),
        );
      },
    );
  }
}

class _HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = context.l10n;
    return AppBar(
      toolbarHeight: kToolbarHeight,
      automaticallyImplyLeading: false,
      titleSpacing: 16,
      backgroundColor: theme.colorScheme.surface,
      surfaceTintColor: Colors.transparent,
      elevation: 0,
      scrolledUnderElevation: 0,
      title: Row(
        children: [
          Icon(
            Icons.location_on_rounded,
            color: theme.colorScheme.primaryContainer,
            size: 22,
          ),
          const SizedBox(width: 6),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  l10n.deliverTo,
                  style: theme.textTheme.labelSmall?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
                Text(
                  l10n.currentLocation,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: theme.textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.w700,
                    color: theme.colorScheme.onSurface,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      actions: [
        BlocBuilder<ThemeBloc, ThemeState>(
          builder: (context, themeState) {
            final bool isDark = themeState.isDark ||
                (themeState.themeMode == ThemeMode.system &&
                    View.of(context).platformDispatcher.platformBrightness ==
                        Brightness.dark);
            return IconButton(
              icon: Icon(
                isDark ? Icons.light_mode_outlined : Icons.dark_mode_outlined,
                color: theme.colorScheme.onSurface,
              ),
              tooltip: l10n.toggleTheme,
              onPressed: () {
                context.read<ThemeBloc>().add(const ToggleThemeEvent());
              },
            );
          },
        ),
        IconButton(
          icon: Icon(
            Icons.map_outlined,
            color: theme.colorScheme.onSurface,
          ),
          tooltip: l10n.nearbyVendors,
          onPressed: () => Navigator.of(context).pushNamed('/vendor-map'),
        ),
        CartAppBarAction(
          onTap: () {
            Navigator.of(context).pushNamed('/cart');
            final cart = context.read<CartBloc>();
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(l10n.cartSummary(cart.state.totalQuantity)),
                behavior: SnackBarBehavior.floating,
              ),
            );
          },
        ),
        const ProfileIconButton(),
        const SizedBox(width: 4),
      ],
    );
  }
}

class _HomeBody extends StatelessWidget {
  final HomeState state;

  const _HomeBody({required this.state});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = context.l10n;

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
        child: Text(
          l10n.noMeals,
          style: theme.textTheme.bodyLarge,
        ),
      );
    }

    return RefreshIndicator(
      color: theme.colorScheme.primaryContainer,
      onRefresh: () => context.read<HomeCubit>().refresh(),
      child: CustomScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
                slivers: [
          const SliverToBoxAdapter(child: MealSearchBar()),
          if (state.isSearching) ...[
            if (state.searchResults.isEmpty)
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
              MealGridSliver(meals: state.searchResults),
          ] else ...[
            const SliverToBoxAdapter(child: SizedBox(height: 8)),
            SliverToBoxAdapter(
              child: CategoriesSection(categories: state.categories),
            ),
            const SliverToBoxAdapter(child: SizedBox(height: 4)),
            SliverToBoxAdapter(
              child: SectionHeader(
                title: l10n.featuredTitle,
                actionLabel: l10n.viewAll,
                onActionTap: () {},
              ),
            ),
            SliverToBoxAdapter(
              child: BannerCarousel(meals: state.bannerMeals),
            ),
            SliverToBoxAdapter(
              child: SectionHeader(
                title: l10n.hotOffersTitle,
                actionLabel: l10n.viewAll,
                onActionTap: () {},
              ),
            ),
            SliverToBoxAdapter(
              child: HotOffersSection(meals: state.hotOffers),
            ),
            SliverToBoxAdapter(
              child: SectionHeader(
                title: l10n.popularTitle,
                actionLabel: l10n.viewAll,
                onActionTap: () {},
              ),
            ),
            MealGridSliver(meals: state.meals),
          ],
          if (state.isRefreshing)
            const SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.only(bottom: 16),
                child: Center(
                  child: SizedBox(
                    width: 22,
                    height: 22,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
