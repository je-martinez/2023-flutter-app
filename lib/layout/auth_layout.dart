import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:reactive_forms/reactive_forms.dart';

import '../utils/utils.dart';
import '../widgets/widgets.dart';

GoogleSignIn _googleSignIn = GoogleSignIn(
  // Optional clientId
  // clientId: '479882132969-9i9aqik3jfjd7qhci1nqf0bm2g71rm1u.apps.googleusercontent.com',
  scopes: <String>[
    'email',
    'https://www.googleapis.com/auth/contacts.readonly',
  ],
);

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
              child: const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
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
                  hintText: "Username", errorStyle: GoogleFonts.poppins()),
              style: GoogleFonts.poppins(),
              formControlName: username,
              validationMessages: {
                'email': (error) => "$usernameFormValue is not a valid email",
                'required': (error) => "Username is a required field"
              },
            ),
            ReactiveTextField(
              decoration: InputDecoration(
                  hintText: "Password", errorStyle: GoogleFonts.poppins()),
              formControlName: password,
              style: GoogleFonts.poppins(),
              obscureText: true,
              enableSuggestions: false,
              autocorrect: false,
              validationMessages: {
                'required': (error) => "Password is a required field."
              },
            ),
            Padding(
                padding: const EdgeInsets.only(top: 15),
                child: ElevatedButton(
                  onPressed: () {},
                  style: ButtonStyle(
                      minimumSize:
                          MaterialStateProperty.all(const Size(300, 30)),
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5)))),
                  child: Padding(
                      padding: const EdgeInsets.all(9),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            loginButtonTitle,
                            style: GoogleFonts.poppins(
                                fontSize: 16, fontWeight: FontWeight.w600),
                          ),
                        ],
                      )),
                )),
          ],
        ));
  }
}

class _SignInOptions extends StatelessWidget {
  const _SignInOptions({Key? key}) : super(key: key);

  Future<void> _handleSignIn() async {
    try {
      await _googleSignIn.signIn();
    } catch (error) {
      print(error);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton(
          onPressed: _handleSignIn,
          style: ButtonStyle(
              minimumSize: MaterialStateProperty.all(const Size(300, 30)),
              shape: MaterialStateProperty.all(RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5)))),
          child: Padding(
              padding: const EdgeInsets.all(9),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const FaIcon(
                    FontAwesomeIcons.google,
                    color: Colors.white,
                    size: 15,
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  Text(
                    signInWithGoogleButton,
                    style: GoogleFonts.poppins(
                        fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                ],
              )),
        ),
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 20),
          child: CustomDivider(),
        ),
      ],
    );
  }
}
