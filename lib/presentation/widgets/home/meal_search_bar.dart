import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_app/core/l10n/app_localizations_extension.dart';
import 'package:flutter_app/presentation/blocs/home/home_cubit.dart';

class MealSearchBar extends StatefulWidget {
  const MealSearchBar({super.key});

  @override
  State<MealSearchBar> createState() => _MealSearchBarState();
}

class _MealSearchBarState extends State<MealSearchBar> {
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onChanged(String value) {
    setState(() {});
    context.read<HomeCubit>().search(value);
  }

  void _clear() {
    _controller.clear();
    _onChanged('');
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 4),
      child: SearchBar(
        controller: _controller,
        onChanged: _onChanged,
        backgroundColor: WidgetStateProperty.all(
          theme.colorScheme.surfaceContainerHigh,
        ),
        elevation: const WidgetStatePropertyAll(0),
        hintText: context.l10n.searchHint,
        hintStyle: WidgetStateProperty.all(
          TextStyle(color: theme.colorScheme.onSurfaceVariant),
        ),
        leading: Padding(
          padding: const EdgeInsets.only(left: 12),
          child: Icon(
            Icons.search_rounded,
            color: theme.colorScheme.onSurfaceVariant,
          ),
        ),
        trailing: [
          if (_controller.text.isNotEmpty)
            IconButton(
              icon: const Icon(Icons.close_rounded),
              onPressed: _clear,
            ),
        ],
        padding: const WidgetStatePropertyAll(
          EdgeInsets.symmetric(horizontal: 6, vertical: 6),
        ),
        shape: WidgetStateProperty.all(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
        ),
      ),
    );
  }
}