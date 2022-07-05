import 'package:flutter/material.dart';

class SocialLoginButton extends StatelessWidget {

  final Function() onTap;
  final SocialBtnType type;

  const SocialLoginButton({Key? key, required this.onTap, required this.type}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double widthScale = MediaQuery.of(context).size.width / 414;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(8*widthScale),
        decoration: BoxDecoration(
            color: Theme.of(context).scaffoldBackgroundColor,
            borderRadius: BorderRadius.all(Radius.circular(10*widthScale))
        ),
        child: Image.asset(
          type == SocialBtnType.facebook ?
          'images/icons/facebook.png' : 'images/icons/google.png',
          width: 35*widthScale,
          height: 35*widthScale,),
      ),
    );
  }
}

enum SocialBtnType{
  facebook,
  google
}
