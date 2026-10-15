import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_app/core/theme/app_theme.dart';

class ProfileAvatar extends StatelessWidget {
  final String? photoBase64;
  final double size;

  const ProfileAvatar({super.key, this.photoBase64, required this.size});

  ImageProvider? _decode() {
    final data = photoBase64;
    if (data == null || data.isEmpty) return null;
    try {
      return MemoryImage(base64Decode(data));
    } catch (_) {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    final image = _decode();
    return CircleAvatar(
      radius: size / 2,
      backgroundColor: AppTheme.lightGreen,
      backgroundImage: image,
      child: image == null
          ? Icon(Icons.person, size: size * 0.5, color: AppTheme.primary)
          : null,
    );
  }
}