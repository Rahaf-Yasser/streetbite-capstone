import 'package:flutter/material.dart';
import 'package:flutter_app/core/navigation/fade_route.dart';
import 'package:flutter_app/injection.dart';
import 'package:flutter_app/presentation/blocs/auth/auth_cubit.dart';
import 'package:flutter_app/presentation/blocs/profile/profile_cubit.dart';
import 'package:flutter_app/presentation/blocs/profile/profile_state.dart';
import 'package:flutter_app/presentation/screens/settings_screen.dart';
import 'package:flutter_app/presentation/screens/splash_screen.dart';
import 'package:flutter_app/presentation/widgets/coming_soon_dialog.dart';
import 'package:flutter_app/presentation/widgets/info_row.dart';
import 'package:flutter_app/presentation/widgets/logout_confirmation_dialog.dart';
import 'package:flutter_app/presentation/widgets/profile_avatar_with_camera.dart';
import 'package:flutter_app/presentation/widgets/profile_menu_tile.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_app/presentation/blocs/favourites/favourites_cubit.dart';
import 'package:flutter_app/presentation/blocs/order_history/order_history_cubit.dart';
import 'package:flutter_app/presentation/widgets/favourites_section.dart';
import 'package:flutter_app/presentation/widgets/order_history_section.dart';


class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

        return MultiBlocProvider(
      providers: [
        BlocProvider<ProfileCubit>(
          create: (_) => getIt<ProfileCubit>()..load(),
        ),
        BlocProvider<FavouritesCubit>(
          create: (_) => getIt<FavouritesCubit>()..load(),
        ),
        BlocProvider<OrderHistoryCubit>(
          create: (_) => getIt<OrderHistoryCubit>()..load(),
        ),
      ],
      child: Scaffold(
        appBar: AppBar(title: Text(l10n.profileTooltip)),
        body: BlocListener<ProfileCubit, ProfileState>(
          listenWhen: (previous, current) =>
              previous.photoError != current.photoError &&
              current.photoError != null,
          listener: (context, state) {
            final message = state.photoError == PhotoError.pickFailed
                ? l10n.photoPickError
                : l10n.photoUpdateError;
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(message)));
          },
          child: BlocBuilder<ProfileCubit, ProfileState>(
            builder: (context, state) {
              if (state.status == ProfileStatus.failure) {
                return Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(l10n.profileLoadError),
                      const SizedBox(height: 12),
                      ElevatedButton(
                        onPressed: () => context.read<ProfileCubit>().load(),
                        child: Text(l10n.retryButton),
                      ),
                    ],
                  ),
                );
              }
              final profile = state.profile;
              if (profile == null) {
                return const Center(child: CircularProgressIndicator());
              }

              // RESPONSIVE: sizes come from the screen width via MediaQuery,
              // and the content is capped so it stays readable on tablets.
              final width = MediaQuery.sizeOf(context).width;
              final avatarSize = (width * 0.28).clamp(80.0, 140.0);

              return Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 600),
                  child: ListView(
                    padding: EdgeInsets.all(width * 0.06),
                    children: [
                      Align(
                        alignment: AlignmentDirectional.centerStart,
                        child: ProfileAvatarWithCamera(
                          photoBase64: profile.photoBase64,
                          size: avatarSize,
                          isBusy: state.isUpdatingPhoto,
                          onCameraTap: () =>
                              context.read<ProfileCubit>().changePhoto(),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        profile.fullName,
                        style: Theme.of(context)
                            .textTheme
                            .headlineSmall
                            ?.copyWith(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 4),
                      Text(profile.email),
                      const SizedBox(height: 16),
                      const SizedBox(height: 24),
                      const FavouritesSection(),
                      const SizedBox(height: 24),
                      const OrderHistorySection(),
                      const SizedBox(height: 16),
                      ProfileMenuTile(
                        icon: Icons.tune,
                        label: l10n.settingsLabel,
                        onTap: () => Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => const SettingsScreen(),
                          ),
                        ),
                      ),
                      ProfileMenuTile(
                        icon: Icons.chat_bubble_outline,
                        label: l10n.contactUsLabel,
                        onTap: () => showComingSoonDialog(context),
                      ),
                      ProfileMenuTile(
                        icon: Icons.info_outline,
                        label: l10n.helpCenterLabel,
                        onTap: () => showComingSoonDialog(context),
                      ),
                      ProfileMenuTile(
                        icon: Icons.logout,
                        label: l10n.logOutLabel,
                        color: Colors.red,
                        onTap: () async {
                          final authCubit = context.read<AuthCubit>();
                          final navigator = Navigator.of(context);
                          final confirmed =
                              await showLogoutConfirmationDialog(context);
                          if (!confirmed) return;
                          // Leave this screen first, then sign out, so the
                          // profile stream is closed before the session ends.
                          navigator.pushAndRemoveUntil(
                            fadeRoute(const SplashScreen()),
                            (route) => false,
                          );
                          await authCubit.logOut();
                        },
                      ),
                      const SizedBox(height: 24),
                      Text(
                        l10n.deviceInfoTitle,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const SizedBox(height: 8),
                      if (state.device != null) ...[
                        InfoRow(
                          label: l10n.deviceModelLabel,
                          value: state.device!.model,
                        ),
                        InfoRow(
                          label: l10n.osVersionLabel,
                          value: state.device!.osVersion,
                        ),
                      ] else if (state.deviceFailed)
                        Text(l10n.deviceInfoError),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}