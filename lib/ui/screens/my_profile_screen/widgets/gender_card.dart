import 'package:couple_jet/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class GenderCard extends StatelessWidget {

  final IconData icon;
  final String gender;
  final bool isSelected;
  final Function() onTap;

  const GenderCard({Key? key, required this.icon, required this.gender, required this.isSelected, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double widthScale = MediaQuery.of(context).size.width / 414;
    final double heightScale = MediaQuery.of(context).size.height / 896;
    return GestureDetector(
      onTap: onTap,
      child: Stack(
        alignment: Alignment.topRight,
        children: [
          Container(
            width: 60*widthScale,
            height: 60*widthScale,
            margin: EdgeInsets.only(right: 8*widthScale,top: 8*widthScale),
            decoration: BoxDecoration(
              gradient: isSelected ? LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.bottomRight,
                stops: [0.0, 1.0],
                colors: [
                  Color.fromRGBO(3, 122, 222, 1),
                  Color.fromRGBO(3, 229, 183, 1),
                ],
              ) : null,
              color: kLightBg,
              borderRadius: BorderRadius.circular(12 * widthScale),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(icon,size: 30*widthScale,color: isSelected ? Colors.white : Colors.black,),
                Text(gender,style: GoogleFonts.outfit(fontSize: 12 * widthScale,fontWeight: FontWeight.w300,color: isSelected ? Colors.white : Colors.black),)
              ],
            ),
          ),
          Container(
            width: 20*widthScale,
            height: 20*widthScale,
            padding: EdgeInsets.all(1*widthScale),
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle
            ),
            child: Container(
              decoration: BoxDecoration(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  shape: BoxShape.circle
              ),
              child: isSelected ? Center(
                child: Icon(
                  Icons.check_rounded,size: 14*widthScale,
                ),
              ) : Container(),
            ),
          )
        ],
      ),
    );
  }
}
