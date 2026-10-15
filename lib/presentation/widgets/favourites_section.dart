import 'package:flutter/material.dart';
import 'package:flutter_app/domain/entities/favourite_entity.dart';
import 'package:flutter_app/presentation/blocs/favourites/favourites_cubit.dart';
import 'package:flutter_app/presentation/blocs/live_list/live_list_state.dart';
import 'package:flutter_app/presentation/widgets/live_list_view.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_app/l10n/app_localizations.dart';

class FavouritesSection extends StatelessWidget {
  const FavouritesSection({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final colorScheme = Theme.of(context).colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          l10n.favouritesTitle,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const SizedBox(height: 8),
        BlocBuilder<FavouritesCubit, LiveListState<FavouriteEntity>>(
          builder: (context, state) => LiveListView<FavouriteEntity>(
            state: state,
            onRetry: () => context.read<FavouritesCubit>().load(),
            emptyMessage: l10n.noFavourites,
            itemBuilder: (favourite) => ListTile(
              contentPadding: EdgeInsets.zero,
              leading: Icon(
                Icons.favorite,
                color: colorScheme.primary,
              ),
              title: Text(favourite.name),
              subtitle: favourite.subtitle == null
                  ? null
                  : Text(favourite.subtitle!),
            ),
          ),
        ),
      ],
    );
  }
}
