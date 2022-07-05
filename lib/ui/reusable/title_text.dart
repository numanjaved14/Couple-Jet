import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TitleText extends StatelessWidget {

  final String title;

  const TitleText({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double widthScale = MediaQuery.of(context).size.width / 414;
    return Text(
      title,
      style: GoogleFonts.outfit(fontSize: 24 * widthScale,fontWeight: FontWeight.w300),
    );
  }
}
