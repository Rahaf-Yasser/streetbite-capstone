import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:streetbite/core/theme/theme.dart';
import 'package:streetbite/core/theme/util.dart';
import 'package:streetbite/domain/entities/meal.dart';
import 'package:streetbite/injection.dart';
import 'package:streetbite/presentation/blocs/cart/cart_bloc.dart';
import 'package:streetbite/presentation/blocs/locale/locale_bloc.dart';
import 'package:streetbite/presentation/blocs/locale/locale_state.dart';
import 'package:streetbite/presentation/blocs/theme/theme_bloc.dart';
import 'package:streetbite/presentation/blocs/theme/theme_state.dart';
import 'package:streetbite/presentation/screens/home/home_screen.dart';
import 'package:streetbite/presentation/screens/meal_details/meal_details_screen.dart';
import 'package:streetbite/presentation/screens/vendor_map/vendor_map_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupInjection();
  runApp(const StreetBiteApp());
}

class StreetBiteApp extends StatelessWidget {
  const StreetBiteApp({super.key});

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = createTextTheme(context, "Inter", "Inter");
    final MaterialTheme materialTheme = MaterialTheme(textTheme);
    return MultiBlocProvider(
      providers: [
        BlocProvider<ThemeBloc>(
          create: (_) => ThemeBloc(),
        ),
        BlocProvider<LocaleBloc>(
          create: (_) =>
              getIt<LocaleBloc>()..loadSavedLocale(),
        ),
        BlocProvider<CartBloc>(
          create: (_) => CartBloc(),
        ),
      ],
      child: BlocBuilder<LocaleBloc, LocaleState>(
        builder: (context, localeState) {
          return BlocBuilder<ThemeBloc, ThemeState>(
            builder: (context, themeState) {
              return MaterialApp(
                title: 'StreetBite',
                onGenerateTitle: (context) =>
                    AppLocalizations.of(context)?.appTitle ?? 'StreetBite',
                debugShowCheckedModeBanner: false,
                theme: materialTheme.light(),
                darkTheme: materialTheme.dark(),
                themeMode: themeState.themeMode,
                locale: localeState.locale,
                localizationsDelegates: AppLocalizations.localizationsDelegates,
                supportedLocales: AppLocalizations.supportedLocales,
                onGenerateRoute: _onGenerateRoute,
                home: const HomeScreen(),
              );
            },
          );
        },
      ),
    );
  }

  Route<dynamic> _onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/meal-details':
        final Meal meal = settings.arguments as Meal;
        return MaterialPageRoute<dynamic>(
          builder: (_) => MealDetailsScreen(meal: meal),
        );
      case '/vendor-map':
        return MaterialPageRoute<dynamic>(
          builder: (_) => const VendorMapScreen(),
        );
      default:
        return MaterialPageRoute<dynamic>(
          builder: (_) => const HomeScreen(),
        );
    }
  }
}
