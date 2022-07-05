import 'package:couple_jet/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/services.dart';

class TopAppBar extends StatelessWidget {

  final Function() onBackPress;
  final String title;

  const TopAppBar({Key? key, required this.onBackPress, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double widthScale = MediaQuery.of(context).size.width/414;
    final double heightScale = MediaQuery.of(context).size.height/896;
    return Container(
      width: double.infinity,
      height: 106*heightScale,
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
        borderRadius: BorderRadius.only(bottomRight: Radius.circular(20*widthScale),bottomLeft: Radius.circular(20*widthScale)),
        // boxShadow: [
        //   BoxShadow(
        //     color: Color.fromRGBO(0, 0, 0, 0.1),
        //     offset: Offset(0,1),
        //     blurRadius: 12,
        //     spreadRadius: 1
        //   )
        // ]
      ),
      child: Padding(
        padding: EdgeInsets.only(top: 31*heightScale),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            IconButton(onPressed: onBackPress, icon: Icon(Icons.arrow_back_rounded,size: 24*widthScale,)),
            Text(title,style: GoogleFonts.outfit(fontWeight: FontWeight.bold,fontSize: 16*widthScale),),
            IconButton(onPressed: (){}, icon: Icon(Icons.arrow_back_rounded,size: 24*widthScale,color: Colors.transparent,)),
          ],
        ),
      ),
    );
  }
}
