import 'package:flutter/material.dart';
import 'package:flutter_pet_adopt/services/constants.dart';

class AppButton extends StatelessWidget {
  const AppButton({
    super.key,
    this.title,
    required this.onclick,
  });

 final String? title;
 final VoidCallback onclick;
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
                  onPressed: onclick,
                  child:  Text(
                    title ?? "Login",
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w400
                    ),
                  ))),
        ],
      ),
    );
  }
}
