import 'dart:ui';

import 'package:couple_jet/ui/reusable/card_container.dart';
import 'package:couple_jet/ui/reusable/gradient_round_button.dart';
import 'package:couple_jet/ui/reusable/profile_image.dart';
import 'package:couple_jet/ui/screens/ad_center_screen/widgets/points_container.dart';
import 'package:couple_jet/ui/screens/ext_profile_screen/profile_ext_screen.dart';
import 'package:couple_jet/ui/screens/my_profile_screen/widgets/interest_item.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

class SwipeCardItem extends StatelessWidget {

  final String img;

  SwipeCardItem({Key? key, required this.img}) : super(key: key);


  final List<Interest> interests = [
    Interest('Travelling', 'images/icons/travel.png', true),
    Interest('Netflix', 'images/icons/netflix.png', true),
    Interest('Paint', 'images/icons/paint.png', false),
  ];

  @override
  Widget build(BuildContext context) {
    final double widthScale = MediaQuery.of(context).size.width / 414;
    final double heightScale = MediaQuery.of(context).size.height / 896;
    return GestureDetector(
      onTap: (){
        pushNewScreen(
          context,
          screen: ProfileExtScreen(),
          withNavBar: false, // OPTIONAL VALUE. True by default.
          //pageTransitionAnimation: PageTransitionAnimation.cupertino,
        );
        //Navigator.push(context, MaterialPageRoute(builder: (context) => ProfileExtScreen()));
      },
      child: CardContainer(
          marginVertical: 0,
          paddingVertical: 15,
          paddingHorizontal: 10,
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(
                    top: 7 * heightScale, left: 12 * widthScale, right: 12 * widthScale),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        ProfileImage(
                          radius: 17.5,
                          profileImg: 'images/dummy_profile_img1.png',
                          onPress: () {},
                        ),
                        SizedBox(
                          width: 10 * widthScale,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Johanna, 22',style: GoogleFonts.outfit(fontSize: 15*widthScale,fontWeight: FontWeight.bold),),
                            Text('aus Düsseldorf, DE',style: GoogleFonts.outfit(fontSize: 10*widthScale,color: Theme.of(context).iconTheme.color!.withOpacity(0.7)))
                          ],
                        ),
                      ],
                    ),
                    Icon(
                      Icons.visibility_rounded,
                      size: 24 * widthScale,
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 12 * heightScale,
              ),
              Expanded(
                  child: Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(img),
                          fit: BoxFit.fill,
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(13 * widthScale))),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(13 * widthScale),),
                        child: BackdropFilter(
                            filter: ImageFilter.blur(
                              sigmaX: 10.0,
                              sigmaY: 10.0,
                            ),
                            child: Container(
                              width: double.infinity,
                              height: 72 * heightScale,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(13 * widthScale),),
                              ),
                              child: Center(
                                child: Wrap(
                                  crossAxisAlignment: WrapCrossAlignment.center,
                                  direction: Axis.horizontal,
                                  runSpacing: 8.0 * heightScale,
                                  spacing: 8 * widthScale,
                                  alignment: WrapAlignment.start,
                                  children: interests
                                      .map((e) => GestureDetector(
                                    onTap: () {
                                      print('called');
                                    },
                                    child: InterestItem(
                                        title: e.title,
                                        icon: e.icon,
                                        isSelected: e.isSelected),
                                  ))
                                      .toList(),
                                ),
                              ),
                            ))),
                  )
                ],
              )),
              SizedBox(
                height: 16 * heightScale,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.only(right: 15.0 * widthScale),
                    child: GradientRoundButton(
                        icon: Icons.close_rounded,
                        width: 60,
                        height: 60,
                        iconSize: 40,
                        isRed: true,
                        onPress: () {}),
                  ),
                  SizedBox(
                    height: 30 * heightScale,
                    child: PointsContainer(text: '17 / 25 Swipes', color: "black"),
                  ),
                  SizedBox(
                    width: 5 * widthScale,
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      height: 30 * heightScale,
                      width: 30 * heightScale,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.black,
                      ),
                      child: Icon(
                        Icons.add,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 15.0 * widthScale),
                    child: GradientRoundButton(
                        icon: Icons.check_rounded,
                        width: 60,
                        height: 60,
                        iconSize: 40,
                        onPress: () {}),
                  )
                ],
              )
            ],
          )),
    );
  }
}
