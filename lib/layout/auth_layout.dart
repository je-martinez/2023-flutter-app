import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';

import '../utils/utils.dart';

class AuthLayout extends StatefulWidget {
  const AuthLayout({super.key});

  @override
  State<AuthLayout> createState() => _AuthLayoutState();
}

class _AuthLayoutState extends State<AuthLayout> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
        body: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: size.width),
            // ignore: prefer_const_constructors
            child: Padding(
              padding: const EdgeInsets.all(30),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                            padding: EdgeInsets.only(bottom: 30),
                            child: _Titles(
                              title: loginTitle,
                              subtitle: loginSubtitle,
                            ))),
                    LoginForm()
                  ]),
            )));
  }
}

class _Titles extends StatelessWidget {
  final String title;
  final String subtitle;
  const _Titles({required this.title, required this.subtitle, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 45,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          subtitle,
          style: const TextStyle(
              fontSize: 16, color: Colors.grey, fontWeight: FontWeight.w700),
        )
      ],
    );
  }
}

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  static String username = "username";
  static String password = "password";

  final authForm = fb.group({
    username: ["", Validators.email, Validators.required],
    password: ["", Validators.email, Validators.required]
  });

  void onSubmit() {
    if (authForm.valid) {
      //Do Stuff
    }
  }

  @override
  Widget build(BuildContext context) {
    return ReactiveForm(
        formGroup: authForm,
        child: Column(
          children: [
            ReactiveTextField(
              decoration:
                  const InputDecoration(hintText: "Please type your username"),
              formControlName: username,
              validationMessages: {
                'required': (error) => "Username is a required field"
              },
            ),
            ReactiveTextField(
              decoration:
                  const InputDecoration(hintText: "Please type your password"),
              formControlName: password,
              validationMessages: {
                'required': (error) => "Password is a required field."
              },
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                  padding: const EdgeInsets.only(top: 15),
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ButtonStyle(
                        shape: MaterialStateProperty.all(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25)))),
                    child: Padding(
                        padding: const EdgeInsets.all(9),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: const [
                            Text(loginButtonTitle),
                            SizedBox(
                              width: 15,
                            ),
                            Icon(
                              Icons.arrow_forward,
                              size: 24.0,
                            ),
                          ],
                        )),
                  )),
            )
          ],
        ));
  }
}
