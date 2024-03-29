import 'package:flutter/material.dart';

import 'package:flutter_pet_adopt/services/constants.dart';
import 'package:flutter_pet_adopt/view/base_screen.dart';
import 'package:flutter_pet_adopt/view/signup_screen.dart';
import 'package:flutter_pet_adopt/widgets/app_button.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: ConstrainedBox(
          constraints:
              BoxConstraints(maxHeight: MediaQuery.of(context).size.height),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              const SizedBox(
                height: 20,
              ),
              Expanded(
                flex: 2,
                child: Column(
                  children: [
                    const SizedBox(
                      height: 30,
                    ),
                    Image.asset(
                      dogAnimaOne,
                    ),
                    const Expanded(
                      child: Text(
                        "Adopt Me",
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 255, 135, 171),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 3,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(left: 16.0),
                      child: Text(
                        "Email or Phone number",
                        style: titleStyle,
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.all(16.0),
                      child: TextField(
                        decoration: textFieldDecoration,
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(left: 16.0),
                      child: Text(
                        "Password",
                        style: titleStyle,
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.all(16.0),
                      child: TextField(
                        decoration: textFieldDecoration,
                      ),
                    ),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(right: 16.0, bottom: 16),
                          child: Text(
                            "Forgot Password?",
                            style: titleStyle,
                          ),
                        ),
                      ],
                    ),
                    AppButton(
                      onclick: () async {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const BaseScreen()),
                        );
                      },
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 1,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        'OR',
                        style: titleStyleOr,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(faceImage),
                        Image.asset(googleImage),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Don't have an account?"),
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const SignupScreen()),
                            );
                          },
                          child: const Text(
                            'Signup',
                            style: TextStyle(
                              color: mainColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              )
            ],
          ),
        ),
      ),
    );
  }
}
