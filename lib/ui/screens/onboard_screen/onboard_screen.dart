import 'dart:async';

import 'package:couple_jet/ui/reusable/main_button.dart';
import 'package:couple_jet/ui/screens/bottom_nav_bar/bottom_nav_bar.dart';
import 'package:couple_jet/ui/screens/login_screen/login_screen.dart';
import 'package:couple_jet/ui/screens/sign_up_screen/sign_up_screen.dart';
import 'package:couple_jet/utils/colors.dart';
import 'package:couple_jet/utils/text_styles.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

import '../../../utils/constant.dart';
import 'widgets/gradient_mask.dart';

class OnboardScreen extends StatefulWidget {
  const OnboardScreen({Key? key}) : super(key: key);

  @override
  State<OnboardScreen> createState() => _OnboardScreenState();
}

class _OnboardScreenState extends State<OnboardScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    firebaseAuth.authStateChanges().listen((User? user) {
      if (user == null) {
        // Timer(Duration(seconds: 3),
        //         ()=>Navigator.pushReplacement(context,
        //         MaterialPageRoute(builder:
        //             (context) =>
        //             LoginScreen()
        //         )
        //     )
        // );
      } else {
        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_)=>BottomNavBar()), (route) => false) ;
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    if(Theme.of(context).scaffoldBackgroundColor == kLightBg) {
      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
    }else{
      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
    }
    final double widthScale = MediaQuery.of(context).size.width / 414;
    final double heightScale = MediaQuery.of(context).size.height / 896;
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // animation
          Container(
            margin: EdgeInsets.only(left: 18*widthScale,right: 18*widthScale,top: 54*heightScale),
            width: double.infinity,
            height: 210*heightScale,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(16*widthScale)),
                gradient: const LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.bottomRight,
                  stops: [0.0, 1.0],
                  colors: [
                    kBlue,
                    kTeal
                  ],
                ),
            ),
            child: Lottie.asset('assets/onboard_animation.json'),
          ),
          // text content
          Padding(
            padding: EdgeInsets.only(left: 42*widthScale,right: 42*widthScale),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "CoupleJet",
                  style: GoogleFonts.outfit(color: Theme.of(context).textTheme.bodyText1!.color, fontSize: 24 * widthScale,fontWeight: FontWeight.w300),
                ),
                SizedBox(height: 15*heightScale,),
                Text('Welcome to CoupleJet - your new and innovative Dating-App',textAlign: TextAlign.center ,style: kNormalGreyText(context),),
                Padding(
                  padding: EdgeInsets.only(left: 16*widthScale,right: 16*widthScale,top: 50*heightScale),
                  child: Row(
                    children: [
                      GradientMask(
                        child: Icon(Icons.favorite_rounded,color: Colors.white,size: 26*widthScale),
                      ),
                      SizedBox(width: 20*widthScale,),
                      Text('100% free - only advertisements',style: kNormalGreyText(context),),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 16*widthScale,right: 16*widthScale),
                  child: Row(
                    children: [
                      GradientMask(
                        child: Icon(Icons.favorite_rounded,color: Colors.white,size: 26*widthScale,),
                      ),
                      SizedBox(width: 20*widthScale,),
                      Text('full transparency - discover people',style: kNormalGreyText(context),),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 16*widthScale,right: 16*widthScale),
                  child: Row(
                    children: [
                      GradientMask(
                        child: Icon(Icons.favorite_rounded,color: Colors.white,size: 26*widthScale),
                      ),
                      SizedBox(width: 20*widthScale,),
                      Text('innovative social-feed for interactions',style: kNormalGreyText(context),),
                    ],
                  ),
                )
              ],
            ),
          ),
          // bottom buttons
          Padding(
            padding: EdgeInsets.only(left: 20*widthScale,right: 20*widthScale,bottom: 30*heightScale),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: SizedBox(
                        height: 62*heightScale,
                        child: ElevatedButton(
                          onPressed: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen()));
                          },
                          style: ElevatedButton.styleFrom(
                            primary: Theme.of(context).primaryColor,
                            shadowColor: Colors.transparent,
                            //onSurface: Colors.transparent,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(Radius.circular(10 * widthScale))),
                          ),
                          child: Text(
                            "Login and have fun",
                            style: kNormalGreyText(context),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20*heightScale,),
                MainButton(
                    title: "Sign up and let's get started",
                    onPress: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => SignUpScreen()));
                    },
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
