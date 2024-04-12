import 'package:flutter/material.dart';
import 'package:flutter_pet_adopt/services/api_endpoints.dart';
import 'package:flutter_pet_adopt/services/constants.dart';
import 'package:flutter_pet_adopt/services/http_connect.dart';
import 'package:flutter_pet_adopt/view/base_screen.dart';
import 'package:flutter_pet_adopt/view/signup_screen.dart';
import 'package:flutter_pet_adopt/widgets/app_button.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({
    super.key,
  });

 final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    //Este método é o montar a tela! As variáveis aqui dentro, perdem o valor
    // ao ser recriada!

    return Scaffold(
      body: SingleChildScrollView(
        child: ConstrainedBox(
          constraints:
              BoxConstraints(maxHeight: MediaQuery.of(context).size.height),
          child: Column(
            mainAxisSize: MainAxisSize.min,
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
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: TextField(
                        controller: emailController,
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
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: TextField(
                        controller: passwordController,
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
                        //Posso fazer validacao...
                        Map<String, dynamic> data = await HttpConnect.postData(
                          data: {
                            'email': emailController.text,
                            'password': passwordController.text
                          },
                          endpoint: Endpoints.login,
                        );


                        if (data["statusCode"] != 200) {
                          var snackBar = SnackBar(
                            content: Text(data["data"]['message']),
                          );

                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        } else {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const BaseScreen()),
                          );
                        }
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
