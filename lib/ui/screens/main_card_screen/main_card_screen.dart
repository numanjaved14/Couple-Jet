import 'package:couple_jet/ui/reusable/gradient_points_container.dart';
import 'package:couple_jet/ui/reusable/gradient_round_button.dart';
import 'package:couple_jet/ui/reusable/profile_image.dart';
import 'package:couple_jet/ui/reusable/title_text.dart';
import 'package:couple_jet/ui/screens/profile_screen/profile_screen.dart';
import 'package:couple_jet/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:swipe_cards/swipe_cards.dart';

import 'widgets/swipe_card.dart';

class MainCardSwiperScreen extends StatefulWidget {
  const MainCardSwiperScreen({Key? key}) : super(key: key);

  @override
  State<MainCardSwiperScreen> createState() => _MainCardSwiperScreenState();
}

class _MainCardSwiperScreenState extends State<MainCardSwiperScreen> {

  List<SwipeItem> _swipeItems = [];
  late MatchEngine matchEngine;

  final imgList = ['images/dummy_card0.png','images/dumm_card1.png','images/dummy_card2.png','images/dummy_card3.png','images/dummy_profile.png'];
  bool isStackFinished = false;


  @override
  void initState() {
    for (int i = 0; i < 5; i++) {
      _swipeItems.add(
          SwipeItem(
            content: imgList[i],
          ),
      );
    }

    matchEngine = MatchEngine(swipeItems: _swipeItems);
    super.initState();
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
        body: Column(children: [
          Padding(
            padding: EdgeInsets.only(
                top: 49 * heightScale,
                left: 18 * widthScale,
                right: 22 * widthScale,
                bottom: 20 * heightScale),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const GradientPointsContainer(points: '1,500'),
                    SizedBox(
                      width: 5 * widthScale,
                    ),
                    GradientRoundButton(
                      icon: Icons.add_rounded,
                      onPress: () {},
                    ),
                  ],
                ),
                Stack(
                  alignment: Alignment.topRight,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 6.0),
                      child: ProfileImage(
                          radius: 25 * widthScale,
                          profileImg: 'images/dummy_profile_img1.png',
                          onPress: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => ProfileScreen()));
                          }),
                    ),
                    Image.asset(Theme.of(context).scaffoldBackgroundColor == kLightBg ? 'images/icons/notification.png' : 'images/icons/notification_black.png',width: 20*widthScale,height: 20*widthScale,)
                  ],
                )
              ],
            ),
          ),
          isStackFinished ? const Expanded(
              child: Center(child: TitleText(title:'No more Cards!'))
          ): Expanded(
            child: SwipeCards(
              matchEngine: matchEngine,
              itemBuilder: (BuildContext context, int index) {
                return SwipeCardItem(img: imgList[index],);
              },
              onStackFinished: () {
                setState(() {
                  isStackFinished = true;
                });
              },
              itemChanged: (SwipeItem item, int index) {
              },
              upSwipeAllowed: true,
              fillSpace: true,
            ),
          ),
          SizedBox(height: 36*heightScale,)
        ]));
  }
}

