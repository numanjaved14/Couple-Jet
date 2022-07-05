
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SubText extends StatelessWidget {

  final String text;

  const SubText({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double widthScale = MediaQuery.of(context).size.width / 414;
    return Text(
      text,
      style: GoogleFonts.outfit(fontSize: 15 * widthScale),
    );
  }
}
