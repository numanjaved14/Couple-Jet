
import 'package:couple_jet/utils/colors.dart';
import 'package:flutter/material.dart';

class BottomNavButton extends StatelessWidget {

  final double width;
  final double height;
  final IconData icon;
  final double iconSize;
  final bool isRed;

  const BottomNavButton({Key? key, this.width = 32, this.height = 32, required this.icon, this.iconSize = 24, this.isRed = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double widthScale = MediaQuery.of(context).size.width / 414;
    return Container(
      width: width*widthScale,
      height: height*widthScale,
      decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.bottomRight,
            stops: const [0.0, 1.0],
            colors: isRed ? const [
              kRed,
              kOrange
            ] : const [
              kBlue,
              kTeal
            ],
          ),
          shape: BoxShape.circle
      ),
      child: Icon(icon, color: Colors.white,size: iconSize*widthScale,),
    );
  }
}
