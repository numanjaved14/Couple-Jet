import 'package:couple_jet/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MainButton extends StatelessWidget {
  final String title;
  final Function() onPress;

  const MainButton({Key? key, required this.title, required this.onPress}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double widthScale = MediaQuery.of(context).size.width / 414;
    final double heightScale = MediaQuery.of(context).size.height / 896;
    return Container(
      width: double.infinity,
      // height: 50 * heightScale,
      padding: EdgeInsets.only(top: 2*heightScale,bottom: 2*heightScale),
      decoration: BoxDecoration(
        // boxShadow: [BoxShadow(color: Colors.black26, offset: Offset(0, 4), blurRadius: 5.0)],
        gradient: const LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          stops: [0.0, 1.0],
          colors: [
            kBlue,
            kTeal
          ],
        ),
        borderRadius: BorderRadius.circular(10 * widthScale),
      ),
      child: ElevatedButton(
        onPressed: onPress,
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.zero,
          primary: Colors.transparent,
          shadowColor: Colors.transparent,
          onSurface: Colors.transparent,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10 * widthScale))),
        ),
        child: Text(
          title,
          style: GoogleFonts.outfit(fontWeight: FontWeight.normal, fontSize: 15 * widthScale,color: Colors.white),
        ),
      ),
    );
  }
}
