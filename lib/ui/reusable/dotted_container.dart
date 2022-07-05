import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';

class DottedContainer extends StatelessWidget {

  final Function() onPress;

  const DottedContainer({Key? key, required this.onPress}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double widthScale = MediaQuery.of(context).size.width / 414;
    final double heightScale = MediaQuery.of(context).size.height / 896;
    return GestureDetector(
      onTap: onPress,
      child: Container(
        margin: EdgeInsets.only(right: 7*widthScale),
        color: Colors.transparent,
        width: 118*widthScale,
        height: 150*widthScale,
        child: DottedBorder(
          color: Theme.of(context).iconTheme.color!,
          borderType: BorderType.RRect,
          radius: Radius.circular(25 * widthScale),
          dashPattern: const [10, 2,],
          strokeWidth: 2,
          child: Container(
              margin: EdgeInsets.all(2 * widthScale),
              padding: EdgeInsets.all(5 * widthScale),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(22 * widthScale)),
              ),
              child: Center(child: Icon(Icons.add_photo_alternate_rounded,size: 35*widthScale,))
          ),
        ),
      ),
    );
  }
}
