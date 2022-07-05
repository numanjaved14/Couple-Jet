import 'package:flutter/material.dart';

class CardContainer extends StatelessWidget {

  final Widget child;
  final double cornerRadius;
  final double paddingHorizontal;
  final double paddingVertical;
  final double marginHorizontal;
  final double marginVertical;

  const CardContainer({Key? key, required this.child, this.cornerRadius = 25, this.paddingHorizontal = 22, this.paddingVertical = 25, this.marginHorizontal=20, this.marginVertical=20}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double widthScale = MediaQuery.of(context).size.width / 414;
    final double heightScale = MediaQuery.of(context).size.height / 896;
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(vertical: marginVertical*widthScale,horizontal: marginHorizontal*widthScale),
      padding: EdgeInsets.symmetric(horizontal:paddingHorizontal*widthScale, vertical: paddingVertical*widthScale),
      decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          borderRadius: BorderRadius.all(Radius.circular(cornerRadius*widthScale))
      ),
      child: child,
    );
  }
}
