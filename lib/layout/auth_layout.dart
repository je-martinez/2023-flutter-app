import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reactive_forms/reactive_forms.dart';

import '../utils/utils.dart';
import '../widgets/widgets.dart';

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
                    _Titles(
                      title: loginTitle,
                      subtitle: loginSubtitle,
                    ),
                    _SignInOptions(),
                    _LoginForm()
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
    return Align(
        alignment: Alignment.centerLeft,
        child: Padding(
            padding: const EdgeInsets.only(bottom: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.poppins(
                    fontSize: 45,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  subtitle,
                  style: GoogleFonts.poppins(
                      fontSize: 15, fontWeight: FontWeight.w500),
                )
              ],
            )));
  }
}

class _LoginForm extends StatefulWidget {
  const _LoginForm({Key? key}) : super(key: key);

  @override
  State<_LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<_LoginForm> {
  static String username = "username";
  static String password = "password";

  final authForm = fb.group({
    username: ["", Validators.email, Validators.required],
    password: ["", Validators.required]
  });

  String get usernameFormValue {
    return authForm.control(username).value as String;
  }

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
              decoration: InputDecoration(
                  hintText: "Please type your username",
                  errorStyle: GoogleFonts.poppins()),
              style: GoogleFonts.poppins(),
              formControlName: username,
              validationMessages: {
                'email': (error) => "$usernameFormValue is not a valid email",
                'required': (error) => "Username is a required field"
              },
            ),
            ReactiveTextField(
              decoration: InputDecoration(
                  hintText: "Please type your password",
                  errorStyle: GoogleFonts.poppins()),
              formControlName: password,
              style: GoogleFonts.poppins(),
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
                          children: [
                            Text(
                              loginButtonTitle,
                              style: GoogleFonts.poppins(),
                            ),
                            const SizedBox(
                              width: 15,
                            ),
                            const Icon(
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

class _SignInOptions extends StatelessWidget {
  const _SignInOptions({Key? key}) : super(key: key);

  void signInGoogle() {}

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 70.0),
          child: TextButton(
              onPressed: signInGoogle,
              style: ButtonStyle(
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8))),
                  backgroundColor: MaterialStateProperty.all(Colors.blue)),
              child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Align(
                            alignment: Alignment.centerLeft,
                            child: Padding(
                                padding: EdgeInsets.only(right: 15),
                                child: FaIcon(
                                  FontAwesomeIcons.google,
                                  color: Colors.white,
                                  size: 15,
                                ))),
                        Text(
                          signInWithGoogleButton,
                          style: GoogleFonts.poppins(
                              color: Colors.white, fontWeight: FontWeight.w600),
                          textAlign: TextAlign.center,
                        )
                      ]))),
        ),
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 20),
          child: CustomDivider(),
        ),
      ],
    );
  }
}
