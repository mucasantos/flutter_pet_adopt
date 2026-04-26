import 'package:flutter/material.dart';
import 'package:flutter_pet_adopt/app_data/constants.dart';

class ProfileAvatar extends StatelessWidget {
  const ProfileAvatar({
    super.key,
    this.imageUrl,
    this.radius = 46,
  });

  final String? imageUrl;
  final double radius;

  @override
  Widget build(BuildContext context) {
    final trimmedUrl = imageUrl?.trim();
    if (trimmedUrl == null || trimmedUrl.isEmpty) {
      return CircleAvatar(
        radius: radius,
        backgroundColor: const Color(0xFFF9E2EA),
        backgroundImage: const AssetImage(userProfile),
      );
    }

    return CircleAvatar(
      radius: radius,
      backgroundColor: const Color(0xFFF9E2EA),
      backgroundImage: NetworkImage(trimmedUrl),
      onBackgroundImageError: (_, __) {},
      child: const SizedBox.shrink(),
    );
  }
}
