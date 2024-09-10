import 'package:flutter/material.dart';
import 'package:flutter_pet_adopt/app_data/constants.dart';
import 'package:flutter_pet_adopt/view/login_screen.dart';
import 'package:flutter_pet_adopt/widgets/app_button.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          const SizedBox(
            height: 20,
          ),
          Column(
            children: [
              const SizedBox(
                height: 30,
              ),
              Image.asset(
                dogAnimaOne,
              ),
              const Text(
                "Adopt Me",
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 255, 135, 171),
                ),
              ),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                child: TextField(
                  decoration: textFieldDecoration(label: 'Nome'),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                child: TextField(
                  decoration: textFieldDecoration(label: 'Email'),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                child: TextField(
                  decoration: textFieldDecoration(label: 'Password'),
                ),
              ),
            ],
          ),
          AppButton(
            title: "SignUp",
            onclick: () {},
          ),
          Column(
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
                  const Text("Have an account?"),
                  TextButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const LoginScreen()),
                      );
                    },
                    child: const Text(
                      'Login',
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
          const SizedBox(
            height: 50,
          )
        ],
      ),
    );
  }
}
