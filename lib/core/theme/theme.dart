import "package:flutter/material.dart";

class MaterialTheme {
  final TextTheme textTheme;

  const MaterialTheme(this.textTheme);

  static ColorScheme lightScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xff006d3d),
      surfaceTint: Color(0xff006d3d),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xff00c874),
      onPrimaryContainer: Color(0xff004d29),
      secondary: Color(0xff50625c),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xffe5f9f1),
      onSecondaryContainer: Color(0xff61736d),
      tertiary: Color(0xff5b5f64),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xffdbdee4),
      onTertiaryContainer: Color(0xff5e6267),
      error: Color(0xff9f3f37),
      onError: Color(0xffffffff),
      errorContainer: Color(0xffff897d),
      onErrorContainer: Color(0xff76211c),
      surface: Color(0xfffcf8f8),
      onSurface: Color(0xff1c1b1b),
      onSurfaceVariant: Color(0xff3c4a3f),
      outline: Color(0xff6c7b6e),
      outlineVariant: Color(0xffbbcbbc),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff313030),
      inversePrimary: Color(0xff3be18a),
      primaryFixed: Color(0xff60fea4),
      onPrimaryFixed: Color(0xff00210f),
      primaryFixedDim: Color(0xff3be18a),
      onPrimaryFixedVariant: Color(0xff00522c),
      secondaryFixed: Color(0xffd3e7df),
      onSecondaryFixed: Color(0xff0e1f1a),
      secondaryFixedDim: Color(0xffb7cbc3),
      onSecondaryFixedVariant: Color(0xff394a45),
      tertiaryFixed: Color(0xffe0e3e9),
      onTertiaryFixed: Color(0xff181c20),
      tertiaryFixedDim: Color(0xffc3c7cc),
      onTertiaryFixedVariant: Color(0xff43474c),
      surfaceDim: Color(0xffddd9d9),
      surfaceBright: Color(0xfffcf8f8),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xfff6f3f2),
      surfaceContainer: Color(0xfff1edec),
      surfaceContainerHigh: Color(0xffebe7e7),
      surfaceContainerHighest: Color(0xffe5e2e1),
    );
  }

  ThemeData light() {
    return theme(lightScheme());
  }

  static ColorScheme lightMediumContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xff003f21),
      surfaceTint: Color(0xff006d3d),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xff007e47),
      onPrimaryContainer: Color(0xffffffff),
      secondary: Color(0xff283a34),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xff5f716b),
      onSecondaryContainer: Color(0xffffffff),
      tertiary: Color(0xff33373b),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xff6a6d73),
      onTertiaryContainer: Color(0xffffffff),
      error: Color(0xff691814),
      onError: Color(0xffffffff),
      errorContainer: Color(0xffb24e45),
      onErrorContainer: Color(0xffffffff),
      surface: Color(0xfffcf8f8),
      onSurface: Color(0xff111111),
      onSurfaceVariant: Color(0xff2c392f),
      outline: Color(0xff48564a),
      outlineVariant: Color(0xff627164),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff313030),
      inversePrimary: Color(0xff3be18a),
      primaryFixed: Color(0xff007e47),
      onPrimaryFixed: Color(0xffffffff),
      primaryFixedDim: Color(0xff006236),
      onPrimaryFixedVariant: Color(0xffffffff),
      secondaryFixed: Color(0xff5f716b),
      onSecondaryFixed: Color(0xffffffff),
      secondaryFixedDim: Color(0xff475853),
      onSecondaryFixedVariant: Color(0xffffffff),
      tertiaryFixed: Color(0xff6a6d73),
      onTertiaryFixed: Color(0xffffffff),
      tertiaryFixedDim: Color(0xff51555a),
      onTertiaryFixedVariant: Color(0xffffffff),
      surfaceDim: Color(0xffc9c6c5),
      surfaceBright: Color(0xfffcf8f8),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xfff6f3f2),
      surfaceContainer: Color(0xffebe7e7),
      surfaceContainerHigh: Color(0xffdfdcdb),
      surfaceContainerHighest: Color(0xffd4d1d0),
    );
  }

  ThemeData lightMediumContrast() {
    return theme(lightMediumContrastScheme());
  }

  static ColorScheme lightHighContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xff00341a),
      surfaceTint: Color(0xff006d3d),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xff00552e),
      onPrimaryContainer: Color(0xffffffff),
      secondary: Color(0xff1e2f2a),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xff3b4d47),
      onSecondaryContainer: Color(0xffffffff),
      tertiary: Color(0xff282c31),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xff46494e),
      onTertiaryContainer: Color(0xffffffff),
      error: Color(0xff5b0d0b),
      onError: Color(0xffffffff),
      errorContainer: Color(0xff832b25),
      onErrorContainer: Color(0xffffffff),
      surface: Color(0xfffcf8f8),
      onSurface: Color(0xff000000),
      onSurfaceVariant: Color(0xff000000),
      outline: Color(0xff222f25),
      outlineVariant: Color(0xff3e4d41),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff313030),
      inversePrimary: Color(0xff3be18a),
      primaryFixed: Color(0xff00552e),
      onPrimaryFixed: Color(0xffffffff),
      primaryFixedDim: Color(0xff003b1e),
      onPrimaryFixedVariant: Color(0xffffffff),
      secondaryFixed: Color(0xff3b4d47),
      onSecondaryFixed: Color(0xffffffff),
      secondaryFixedDim: Color(0xff253631),
      onSecondaryFixedVariant: Color(0xffffffff),
      tertiaryFixed: Color(0xff46494e),
      onTertiaryFixed: Color(0xffffffff),
      tertiaryFixedDim: Color(0xff2f3338),
      onTertiaryFixedVariant: Color(0xffffffff),
      surfaceDim: Color(0xffbbb8b7),
      surfaceBright: Color(0xfffcf8f8),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xfff4f0ef),
      surfaceContainer: Color(0xffe5e2e1),
      surfaceContainerHigh: Color(0xffd7d4d3),
      surfaceContainerHighest: Color(0xffc9c6c5),
    );
  }

  ThemeData lightHighContrast() {
    return theme(lightHighContrastScheme());
  }

  static ColorScheme darkScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xff41e58d),
      surfaceTint: Color(0xff3be18a),
      onPrimary: Color(0xff00391d),
      primaryContainer: Color(0xff00c874),
      onPrimaryContainer: Color(0xff004d29),
      secondary: Color(0xffffffff),
      onSecondary: Color(0xff23342f),
      secondaryContainer: Color(0xffd3e7df),
      onSecondaryContainer: Color(0xff566862),
      tertiary: Color(0xfff9faff),
      onTertiary: Color(0xff2d3135),
      tertiaryContainer: Color(0xffdbdee4),
      onTertiaryContainer: Color(0xff5e6267),
      error: Color(0xffffb4ab),
      onError: Color(0xff61120f),
      errorContainer: Color(0xffff897d),
      onErrorContainer: Color(0xff76211c),
      surface: Color(0xff141313),
      onSurface: Color(0xffe5e2e1),
      onSurfaceVariant: Color(0xffbbcbbc),
      outline: Color(0xff859587),
      outlineVariant: Color(0xff3c4a3f),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffe5e2e1),
      inversePrimary: Color(0xff006d3d),
      primaryFixed: Color(0xff60fea4),
      onPrimaryFixed: Color(0xff00210f),
      primaryFixedDim: Color(0xff3be18a),
      onPrimaryFixedVariant: Color(0xff00522c),
      secondaryFixed: Color(0xffd3e7df),
      onSecondaryFixed: Color(0xff0e1f1a),
      secondaryFixedDim: Color(0xffb7cbc3),
      onSecondaryFixedVariant: Color(0xff394a45),
      tertiaryFixed: Color(0xffe0e3e9),
      onTertiaryFixed: Color(0xff181c20),
      tertiaryFixedDim: Color(0xffc3c7cc),
      onTertiaryFixedVariant: Color(0xff43474c),
      surfaceDim: Color(0xff141313),
      surfaceBright: Color(0xff3a3939),
      surfaceContainerLowest: Color(0xff0e0e0e),
      surfaceContainerLow: Color(0xff1c1b1b),
      surfaceContainer: Color(0xff201f1f),
      surfaceContainerHigh: Color(0xff2a2a2a),
      surfaceContainerHighest: Color(0xff353434),
    );
  }

  ThemeData dark() {
    return theme(darkScheme());
  }

  static ColorScheme darkMediumContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xff59f89e),
      surfaceTint: Color(0xff3be18a),
      onPrimary: Color(0xff002d16),
      primaryContainer: Color(0xff00c874),
      onPrimaryContainer: Color(0xff002a14),
      secondary: Color(0xffffffff),
      onSecondary: Color(0xff23342f),
      secondaryContainer: Color(0xffd3e7df),
      onSecondaryContainer: Color(0xff3a4c46),
      tertiary: Color(0xfff9faff),
      onTertiary: Color(0xff2d3135),
      tertiaryContainer: Color(0xffdbdee4),
      onTertiaryContainer: Color(0xff42464a),
      error: Color(0xffffd2cc),
      onError: Color(0xff510506),
      errorContainer: Color(0xffff897d),
      onErrorContainer: Color(0xff4a0103),
      surface: Color(0xff141313),
      onSurface: Color(0xffffffff),
      onSurfaceVariant: Color(0xffd1e0d1),
      outline: Color(0xffa6b6a8),
      outlineVariant: Color(0xff859487),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffe5e2e1),
      inversePrimary: Color(0xff00532d),
      primaryFixed: Color(0xff60fea4),
      onPrimaryFixed: Color(0xff001508),
      primaryFixedDim: Color(0xff3be18a),
      onPrimaryFixedVariant: Color(0xff003f21),
      secondaryFixed: Color(0xffd3e7df),
      onSecondaryFixed: Color(0xff041410),
      secondaryFixedDim: Color(0xffb7cbc3),
      onSecondaryFixedVariant: Color(0xff283a34),
      tertiaryFixed: Color(0xffe0e3e9),
      onTertiaryFixed: Color(0xff0d1216),
      tertiaryFixedDim: Color(0xffc3c7cc),
      onTertiaryFixedVariant: Color(0xff33373b),
      surfaceDim: Color(0xff141313),
      surfaceBright: Color(0xff454444),
      surfaceContainerLowest: Color(0xff070707),
      surfaceContainerLow: Color(0xff1e1d1d),
      surfaceContainer: Color(0xff282828),
      surfaceContainerHigh: Color(0xff333232),
      surfaceContainerHighest: Color(0xff3e3d3d),
    );
  }

  ThemeData darkMediumContrast() {
    return theme(darkMediumContrastScheme());
  }

  static ColorScheme darkHighContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xffbeffcf),
      surfaceTint: Color(0xff3be18a),
      onPrimary: Color(0xff000000),
      primaryContainer: Color(0xff35dd86),
      onPrimaryContainer: Color(0xff000f05),
      secondary: Color(0xffffffff),
      onSecondary: Color(0xff000000),
      secondaryContainer: Color(0xffd3e7df),
      onSecondaryContainer: Color(0xff1c2d28),
      tertiary: Color(0xfff9faff),
      onTertiary: Color(0xff000000),
      tertiaryContainer: Color(0xffdbdee4),
      onTertiaryContainer: Color(0xff23272c),
      error: Color(0xffffece9),
      onError: Color(0xff000000),
      errorContainer: Color(0xffffaea5),
      onErrorContainer: Color(0xff220001),
      surface: Color(0xff141313),
      onSurface: Color(0xffffffff),
      onSurfaceVariant: Color(0xffffffff),
      outline: Color(0xffe4f4e5),
      outlineVariant: Color(0xffb7c7b8),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffe5e2e1),
      inversePrimary: Color(0xff00532d),
      primaryFixed: Color(0xff60fea4),
      onPrimaryFixed: Color(0xff000000),
      primaryFixedDim: Color(0xff3be18a),
      onPrimaryFixedVariant: Color(0xff001508),
      secondaryFixed: Color(0xffd3e7df),
      onSecondaryFixed: Color(0xff000000),
      secondaryFixedDim: Color(0xffb7cbc3),
      onSecondaryFixedVariant: Color(0xff041410),
      tertiaryFixed: Color(0xffe0e3e9),
      onTertiaryFixed: Color(0xff000000),
      tertiaryFixedDim: Color(0xffc3c7cc),
      onTertiaryFixedVariant: Color(0xff0d1216),
      surfaceDim: Color(0xff141313),
      surfaceBright: Color(0xff51504f),
      surfaceContainerLowest: Color(0xff000000),
      surfaceContainerLow: Color(0xff201f1f),
      surfaceContainer: Color(0xff313030),
      surfaceContainerHigh: Color(0xff3c3b3b),
      surfaceContainerHighest: Color(0xff474646),
    );
  }

  ThemeData darkHighContrast() {
    return theme(darkHighContrastScheme());
  }


  ThemeData theme(ColorScheme colorScheme) => ThemeData(
     useMaterial3: true,
     brightness: colorScheme.brightness,
     colorScheme: colorScheme,
     textTheme: textTheme.apply(
       bodyColor: colorScheme.onSurface,
       displayColor: colorScheme.onSurface,
     ),
     scaffoldBackgroundColor: colorScheme.background,
     canvasColor: colorScheme.surface,
  );

  /// Yellow
  static const yellow = ExtendedColor(
    seed: Color(0xffffa800),
    value: Color(0xffffa800),
    light: ColorFamily(
      color: Color(0xff835400),
      onColor: Color(0xffffffff),
      colorContainer: Color(0xffffa800),
      onColorContainer: Color(0xff684200),
    ),
    lightMediumContrast: ColorFamily(
      color: Color(0xff835400),
      onColor: Color(0xffffffff),
      colorContainer: Color(0xffffa800),
      onColorContainer: Color(0xff684200),
    ),
    lightHighContrast: ColorFamily(
      color: Color(0xff835400),
      onColor: Color(0xffffffff),
      colorContainer: Color(0xffffa800),
      onColorContainer: Color(0xff684200),
    ),
    dark: ColorFamily(
      color: Color(0xffffce8f),
      onColor: Color(0xff462b00),
      colorContainer: Color(0xffffa800),
      onColorContainer: Color(0xff684200),
    ),
    darkMediumContrast: ColorFamily(
      color: Color(0xffffce8f),
      onColor: Color(0xff462b00),
      colorContainer: Color(0xffffa800),
      onColorContainer: Color(0xff684200),
    ),
    darkHighContrast: ColorFamily(
      color: Color(0xffffce8f),
      onColor: Color(0xff462b00),
      colorContainer: Color(0xffffa800),
      onColorContainer: Color(0xff684200),
    ),
  );

  /// Black
  static const black = ExtendedColor(
    seed: Color(0xff000000),
    value: Color(0xff000000),
    light: ColorFamily(
      color: Color(0xff000000),
      onColor: Color(0xffffffff),
      colorContainer: Color(0xff1b1b1b),
      onColorContainer: Color(0xff848484),
    ),
    lightMediumContrast: ColorFamily(
      color: Color(0xff000000),
      onColor: Color(0xffffffff),
      colorContainer: Color(0xff1b1b1b),
      onColorContainer: Color(0xff848484),
    ),
    lightHighContrast: ColorFamily(
      color: Color(0xff000000),
      onColor: Color(0xffffffff),
      colorContainer: Color(0xff1b1b1b),
      onColorContainer: Color(0xff848484),
    ),
    dark: ColorFamily(
      color: Color(0xffc6c6c6),
      onColor: Color(0xff303030),
      colorContainer: Color(0xff000000),
      onColorContainer: Color(0xff757575),
    ),
    darkMediumContrast: ColorFamily(
      color: Color(0xffc6c6c6),
      onColor: Color(0xff303030),
      colorContainer: Color(0xff000000),
      onColorContainer: Color(0xff757575),
    ),
    darkHighContrast: ColorFamily(
      color: Color(0xffc6c6c6),
      onColor: Color(0xff303030),
      colorContainer: Color(0xff000000),
      onColorContainer: Color(0xff757575),
    ),
  );


  List<ExtendedColor> get extendedColors => [
    yellow,
    black,
  ];
}

class ExtendedColor {
  final Color seed, value;
  final ColorFamily light;
  final ColorFamily lightHighContrast;
  final ColorFamily lightMediumContrast;
  final ColorFamily dark;
  final ColorFamily darkHighContrast;
  final ColorFamily darkMediumContrast;

  const ExtendedColor({
    required this.seed,
    required this.value,
    required this.light,
    required this.lightHighContrast,
    required this.lightMediumContrast,
    required this.dark,
    required this.darkHighContrast,
    required this.darkMediumContrast,
  });
}

class ColorFamily {
  const ColorFamily({
    required this.color,
    required this.onColor,
    required this.colorContainer,
    required this.onColorContainer,
  });

  final Color color;
  final Color onColor;
  final Color colorContainer;
  final Color onColorContainer;
}
