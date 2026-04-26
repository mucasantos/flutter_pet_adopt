import 'package:flutter/material.dart';
import 'package:flutter_pet_adopt/app_data/constants.dart';

class PetInfoTile extends StatelessWidget {
  const PetInfoTile({
    super.key,
    required this.info,
    this.title,
  });

  final String? title;
  final String info;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: boxShadow,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (title != null)
            Text(
              title!,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                color: mainColor,
              ),
            ),
          Text(info),
        ],
      ),
    );
  }
}
