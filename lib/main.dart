import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/presentation/blocs/favourites/favourites_cubit.dart';
import 'package:flutter_app/presentation/blocs/orders/orders_bloc.dart';
import 'package:flutter_app/presentation/screens/cart_screen.dart';
import 'package:flutter_app/presentation/screens/orders_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_app/l10n/app_localizations.dart';
import 'package:flutter_app/core/theme/theme.dart';
import 'package:flutter_app/core/theme/util.dart';
import 'package:flutter_app/domain/entities/meal.dart';
import 'package:flutter_app/injection.dart';

import 'package:flutter_app/presentation/blocs/auth/auth_cubit.dart';
import 'package:flutter_app/presentation/blocs/locale/locale_cubit.dart';
import 'package:flutter_app/presentation/blocs/cart/cart_bloc.dart';
import 'package:flutter_app/presentation/blocs/theme/theme_bloc.dart';
import 'package:flutter_app/presentation/blocs/theme/theme_state.dart';

import 'package:flutter_app/presentation/screens/profile_screen.dart';
import 'package:flutter_app/presentation/screens/splash_screen.dart';
import 'package:flutter_app/presentation/screens/main_shell.dart';
import 'package:flutter_app/presentation/screens/meal_details_screen.dart';
import 'package:flutter_app/presentation/screens/vendor_map_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  await setupDependencies();

  // Read the saved language before the first frame, so the app never
  // flashes English before switching to Arabic.
  await getIt<LocaleCubit>().loadSavedLocale();

  runApp(const StreetBiteApp());
}

class StreetBiteApp extends StatelessWidget {
  const StreetBiteApp({super.key});

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = createTextTheme(
      context,
      'Inter',
      'Inter',
    );

    final MaterialTheme materialTheme = MaterialTheme(textTheme);

    return MultiBlocProvider(
      providers: [
        // Authentication state
        BlocProvider<AuthCubit>(
          create: (_) => getIt<AuthCubit>(),
        ),

        // App language (the single language system)
        BlocProvider<LocaleCubit>.value(
          value: getIt<LocaleCubit>(),
        ),

        // Theme management
        BlocProvider<ThemeBloc>(
          create: (_) => ThemeBloc(),
        ),

        // Cart
        BlocProvider<CartBloc>(
          create: (_) => CartBloc(),
        ),
            BlocProvider(create: (_) => OrdersBloc()),

        BlocProvider<FavouritesCubit>(
          create: (_) => getIt<FavouritesCubit>(),
        ),
      ],
      child: BlocBuilder<LocaleCubit, Locale>(
        builder: (context, locale) {
          return BlocBuilder<ThemeBloc, ThemeState>(
            builder: (context, themeState) {
              return MaterialApp(
                title: 'StreetBite',
                debugShowCheckedModeBanner: false,

                // Localization
                locale: locale,
                onGenerateTitle: (context) =>
                    AppLocalizations.of(context)?.appName ?? 'StreetBite',
                localizationsDelegates:
                    AppLocalizations.localizationsDelegates,
                supportedLocales: AppLocalizations.supportedLocales,

                // Theme switching
                theme: materialTheme.light(),
                darkTheme: materialTheme.dark(),
                themeMode: themeState.themeMode,

                // Named routes
                onGenerateRoute: _onGenerateRoute,

                // Authentication flow starts at the splash screen
                home: const SplashScreen(),
              );
            },
          );
        },
      ),
    );
  }

  Route<dynamic> _onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/home':
        return MaterialPageRoute<dynamic>(
          builder: (_) => const MainShell(),
        );

      case '/meal-details':
        final Meal meal = settings.arguments as Meal;

        return MaterialPageRoute<dynamic>(
          builder: (_) => MealDetailsScreen(meal: meal),
        );

      case '/cart':
      return MaterialPageRoute<dynamic>(
        builder: (_) => const CartScreen(),
      );
      
      case '/vendor-map':
        return MaterialPageRoute<dynamic>(
          builder: (_) => const VendorMapScreen(),
        );
      case  '/orders':        return MaterialPageRoute<dynamic>(
          builder:  (_) => const OrdersScreen(),
      );
 

      default:
        return MaterialPageRoute<dynamic>(
          builder: (_) => const MainShell(),
        );
    }
  }
}