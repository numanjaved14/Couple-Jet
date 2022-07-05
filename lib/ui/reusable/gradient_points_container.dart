import 'package:couple_jet/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class GradientPointsContainer extends StatelessWidget {

  final String points;
  final double? width;
  final double? height;

  const GradientPointsContainer({Key? key, required this.points, this.width, this.height}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double widthScale = MediaQuery.of(context).size.width / 414;
    final double heightScale = MediaQuery.of(context).size.height / 896;
    return Container(
      padding: EdgeInsets.only(top: 4*heightScale,right: 15*widthScale,left: 15*widthScale,bottom:4*heightScale ),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          stops: [0.0, 1.0],
          colors: [
            kBlue,
            kTeal
          ],
        ),
        borderRadius: BorderRadius.circular(20 * widthScale),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.diamond_rounded,size: 24*widthScale,color: Colors.white,),
          SizedBox(width:10*widthScale),
          Text(points,style:GoogleFonts.outfit(fontWeight: FontWeight.bold,fontSize: 16*widthScale,color: Colors.white))
        ],
      ),
    );
  }
}
