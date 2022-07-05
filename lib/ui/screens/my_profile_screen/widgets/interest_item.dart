import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class InterestItem extends StatelessWidget {

  final String title;
  final String icon;
  final bool isSelected;
  final double radius;

  const InterestItem({Key? key, required this.title, required this.icon, required this.isSelected, this.radius=5}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double widthScale = MediaQuery.of(context).size.width / 414;
    final double heightScale = MediaQuery.of(context).size.height / 896;
    return Container(
      padding: EdgeInsets.only(top: 4*heightScale,right: 10*widthScale,left: 10*widthScale,bottom:4*heightScale ),
      decoration: BoxDecoration(
        gradient: isSelected ? const LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          stops: [0.0, 1.0],
          colors: [
            Color.fromRGBO(3, 122, 222, 1),
            Color.fromRGBO(3, 229, 183, 1),
          ],
        ):null,
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: BorderRadius.circular(radius * widthScale),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(icon,width: 20*widthScale,height:20*widthScale,color: isSelected ? Colors.white : Theme.of(context).iconTheme.color!,),
          SizedBox(width:8*widthScale),
          Text(title,style:GoogleFonts.outfit(fontSize: 12*widthScale,color: isSelected ? Colors.white : Theme.of(context).iconTheme.color!))
        ],
      ),
    );
  }
}

class Interest{
  String title;
  String icon;
  bool isSelected;

  Interest(this.title, this.icon, this.isSelected);

}
