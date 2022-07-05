import 'package:couple_jet/ui/reusable/gradient_round_button.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PictureContainer extends StatelessWidget {

  final Function() onDelPress;
  final String image;
  final String type;

  const PictureContainer({Key? key, required this.onDelPress, required this.image, this.type='profile'}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double widthScale = MediaQuery.of(context).size.width / 414;
    final double heightScale = MediaQuery.of(context).size.height / 896;
    return Stack(
      alignment: Alignment.topCenter,
      children: [
        Container(
          margin: EdgeInsets.only(right: type == 'profile' ? 7*widthScale : 10*widthScale),
          width: 118*widthScale,
          height:  type == 'profile' ? 150*widthScale : 155*heightScale,
          decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(image),
                fit: BoxFit.fill,
              ),
              borderRadius: BorderRadius.all(Radius.circular(25*widthScale))
          ),
        ),
        type == "profile" ? Padding(
          padding: EdgeInsets.only(top:6*heightScale),
          child: GradientRoundButton(
            icon: Icons.delete_rounded,
            onPress: onDelPress,
            iconSize: 15,
          ),
        ) : Padding(
          padding: EdgeInsets.all(4),
          child: GestureDetector(
            onTap: (){},
            onDoubleTap: (){},
            child: Container(
                padding: EdgeInsets.only(right: 15*widthScale),
                decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.4),
                    borderRadius: BorderRadius.all(Radius.circular(30*widthScale))
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    GradientRoundButton(
                        icon: Icons.whatshot_rounded,
                        iconSize: 16*widthScale,
                        onPress: (){}),
                    SizedBox(width: 4*widthScale,),
                    Text('Neu!',style: GoogleFonts.outfit(fontSize: 12*widthScale,color: Colors.white,fontWeight: FontWeight.w600),),
                  ],
                )),
          ),
        ),
      ],
    );
  }
}
