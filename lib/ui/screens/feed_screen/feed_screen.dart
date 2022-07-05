import 'package:couple_jet/ui/reusable/gradient_points_container.dart';
import 'package:couple_jet/ui/reusable/gradient_round_button.dart';
import 'package:couple_jet/ui/reusable/profile_image.dart';
import 'package:couple_jet/ui/reusable/search_field.dart';
import 'package:couple_jet/ui/screens/profile_screen/profile_screen.dart';
import 'package:couple_jet/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'widgets/feed_list_item.dart';

class FeedScreen extends StatelessWidget {
  FeedScreen({Key? key}) : super(key: key);

  final TextEditingController searchController = TextEditingController();

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
        children: [
          Padding(
            padding: EdgeInsets.only(
                top: 49 * heightScale,
                left: 18 * widthScale,
                right: 22 * widthScale,
                bottom: 31 * heightScale),
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
          Padding(
            padding: EdgeInsets.only(left: 18 * widthScale, right: 22 * widthScale,bottom: 12*heightScale),
            child: SearchField(
                hint: "Suche nach einem User oder Thema...", textController: searchController),
          ),
          Expanded(
              child: ListView.builder(
                padding: EdgeInsets.only(top: 12*heightScale,bottom: 36*heightScale,),
                  itemCount: 5,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return FeedListItem();
                  }),
          ),

        ],
      ),
    );
  }
}
