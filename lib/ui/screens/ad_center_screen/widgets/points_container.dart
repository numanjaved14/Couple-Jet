import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PointsContainer extends StatelessWidget {

  final String text;
  final String color;

  const PointsContainer({Key? key, required this.text, required this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double widthScale = MediaQuery.of(context).size.width / 414;
    final double heightScale = MediaQuery.of(context).size.height / 896;
    return Container(
      padding: EdgeInsets.only(top: 4*heightScale,right: 15*widthScale,left: 15*widthScale,bottom:4*heightScale ),
      decoration: BoxDecoration(
        gradient: color == "black" ? null : LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          stops: [0.0, 1.0],
          colors: color == "blue" ? [
            Color.fromRGBO(3, 122, 222, 1),
            Color.fromRGBO(3, 229, 183, 1),
          ] : const [
            Color.fromRGBO(164, 6, 6, 1),
            Color.fromRGBO(217, 131, 36, 1),
          ],
        ),
        color: Colors.black,
        borderRadius: BorderRadius.circular(20 * widthScale),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(text,style:GoogleFonts.outfit(fontSize: 12*widthScale,color: Colors.white)),
          SizedBox(width:4*widthScale),
          color == "black" ? Container() : Icon(Icons.diamond_rounded,size: 18*widthScale,color: Colors.white,),
        ],
      ),
    );
  }
}
