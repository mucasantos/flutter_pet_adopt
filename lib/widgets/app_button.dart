import 'package:flutter/material.dart';
import 'package:flutter_pet_adopt/services/constants.dart';
import 'package:flutter_pet_adopt/view/base_screen.dart';

class AppButton extends StatelessWidget {
  const AppButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        children: [
          Expanded(
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: mainColor,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 50, vertical: 10),
                      textStyle: const TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      )),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const BaseScreen()),
                    );
                  },
                  child: const Text(
                    "Signin",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ))),
        ],
      ),
    );
  }
}
