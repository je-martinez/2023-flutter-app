import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomDivider extends StatelessWidget {
  final String textDivider;
  const CustomDivider({this.textDivider = "OR", Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(children: <Widget>[
      const Expanded(
          child: Divider(
        thickness: 2,
      )),
      Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Text(
            textDivider,
            style: GoogleFonts.poppins(
                color: Colors.grey, fontWeight: FontWeight.bold, fontSize: 16),
          )),
      const Expanded(
          child: Divider(
        thickness: 2,
      )),
    ]);
  }
}
