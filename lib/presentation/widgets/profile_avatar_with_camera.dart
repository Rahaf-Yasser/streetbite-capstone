import 'package:flutter/material.dart';
import 'package:flutter_app/core/theme/app_theme.dart';
import 'package:flutter_app/presentation/widgets/profile_avatar.dart';
import 'package:flutter_app/l10n/app_localizations.dart';

class ProfileAvatarWithCamera extends StatelessWidget {
  final String? photoBase64;
  final double size;
  final bool isBusy;
  final VoidCallback onCameraTap;

  const ProfileAvatarWithCamera({
    super.key,
    required this.photoBase64,
    required this.size,
    required this.isBusy,
    required this.onCameraTap,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return SizedBox(
      width: size,
      height: size,
      child: Stack(
        children: [
          Positioned.fill(
            child: ProfileAvatar(photoBase64: photoBase64, size: size),
          ),
          if (isBusy)
            const Positioned.fill(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.black38,
                ),
                child: Center(
                  child: CircularProgressIndicator(color: Colors.white),
                ),
              ),
            ),
          PositionedDirectional(
            bottom: 0,
            end: 0,
            child: Tooltip(
              message: l10n.changePhotoTooltip,
              child: Material(
                color: AppTheme.primary,
                shape: const CircleBorder(),
                child: InkWell(
                  customBorder: const CircleBorder(),
                  onTap: isBusy ? null : onCameraTap,
                  child: const Padding(
                    padding: EdgeInsets.all(8),
                    child: Icon(Icons.camera_alt, size: 20, color: Colors.white),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}