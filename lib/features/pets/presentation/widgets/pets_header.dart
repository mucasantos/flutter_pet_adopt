import 'package:flutter/material.dart';
import 'package:flutter_pet_adopt/app_data/constants.dart';

class PetsHeader extends StatelessWidget {
  const PetsHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Good Morning!',
          style: TextStyle(
            color: mainColor,
            fontWeight: FontWeight.w700,
          ),
        ),
        Text(
          'Samuel Santos',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w400,
            fontSize: 16,
          ),
        ),
      ],
    );
  }
}
