import 'package:flutter/material.dart';
import 'package:flutter_pet_adopt/services/constants.dart';

class PetInfoContainer extends StatelessWidget {
  const PetInfoContainer({
    super.key,
    required this.info,
    required this.title,
  });

  final String title;
  final String info;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 12,
        horizontal: 18,
      ),
      decoration: const BoxDecoration(
          color: Color.fromARGB(28, 255, 128, 128),
          borderRadius: BorderRadius.all(
            Radius.circular(8),
          )),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: mainColor,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          Text(
            info,
            style: const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w400,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}
