import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

TextStyle kNormalGreyText(BuildContext context) => GoogleFonts.outfit(
    fontWeight: FontWeight.normal,
    fontSize: fontSize15(context),
    color: Theme.of(context).textTheme.bodyText1!.color
);

double fontSize15(BuildContext context) => MediaQuery.of(context).size.width/414*15;