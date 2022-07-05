import 'package:couple_jet/ui/reusable/card_container.dart';
import 'package:couple_jet/ui/reusable/gradient_round_button.dart';
import 'package:couple_jet/ui/reusable/post_image_slider.dart';
import 'package:couple_jet/ui/screens/ad_center_screen/widgets/points_container.dart';
import 'package:couple_jet/ui/screens/ext_profile_screen/widgets/profile_image_slider.dart';
import 'package:couple_jet/ui/screens/ext_profile_screen/widgets/profile_top_bar.dart';
import 'package:couple_jet/ui/screens/my_profile_screen/widgets/interest_item.dart';
import 'package:couple_jet/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfileExtScreen extends StatelessWidget {
  ProfileExtScreen({Key? key}) : super(key: key);

  final List<Interest> interests = [
    Interest('Travelling', 'images/icons/travel.png', true),
    Interest('Netflix', 'images/icons/netflix.png', true),
    Interest('Paint', 'images/icons/paint.png', false),
  ];

  @override
  Widget build(BuildContext context) {
    final double widthScale = MediaQuery.of(context).size.width / 414;
    final double heightScale = MediaQuery.of(context).size.height / 896;
    return Scaffold(
      body: Stack(
        children: [
          CustomScrollView(
            slivers: <Widget>[
              SliverAppBar(
                pinned: true,
                snap: false,
                floating: true,
                leading: Container(),
                backgroundColor: Theme.of(context).primaryColor,
                elevation: 0,
                expandedHeight: 346 * heightScale,
                flexibleSpace: FlexibleSpaceBar(
                  //title: Text('SliverAppBar'),
                  background: Stack(
                    children: [
                      ProfileImageSlider(
                        imgList: ['images/dummy_post1.png', 'images/dummy_post2.png'],
                      ),
                      // ProfileAppBar(onBackPress: () {Navigator.pop(context);}, title: "Elisa"),
                    ],
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: CardContainer(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.record_voice_over_rounded,
                            size: 35 * widthScale,
                          ),
                          SizedBox(
                            width: 10 * widthScale,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Name',
                                style: GoogleFonts.outfit(
                                    fontSize: 15 * widthScale, fontWeight: FontWeight.bold),
                              ),
                              Text(
                                'Elisa',
                                style: GoogleFonts.outfit(fontSize: 10 * widthScale),
                              ),
                            ],
                          )
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 8.0 * heightScale),
                        child: Divider(),
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.female_rounded,
                            size: 35 * widthScale,
                          ),
                          SizedBox(
                            width: 10 * widthScale,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Gender',
                                style: GoogleFonts.outfit(
                                    fontSize: 15 * widthScale, fontWeight: FontWeight.bold),
                              ),
                              Text(
                                'Female',
                                style: GoogleFonts.outfit(fontSize: 10 * widthScale),
                              ),
                            ],
                          )
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 8.0 * heightScale),
                        child: Divider(),
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.interests_rounded,
                            size: 35 * widthScale,
                          ),
                          SizedBox(
                            width: 10 * widthScale,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Interests',
                                style: GoogleFonts.outfit(
                                    fontSize: 15 * widthScale, fontWeight: FontWeight.bold),
                              ),
                              Wrap(
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
                            ],
                          )
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 8.0 * heightScale),
                        child: Divider(),
                      ),
                      PostImageSlider(
                        imgList: ['images/dummy_post1.png', 'images/dummy_post2.png'],
                        likeCount: 1500,
                        onLikeTap: () {},
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            top: 11 * heightScale, left: 10 * widthScale, right: 10 * widthScale),
                        child: Text(
                          'Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy'
                          'eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam'
                          'voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita'
                          'kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet.'
                          'Lorem ipsum dolor sit amet, consetetur sadipscing elit.',
                          style: GoogleFonts.outfit(
                            fontSize: 12 * widthScale,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: SizedBox(height: 100*heightScale,),
              )
            ],
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
                padding: EdgeInsets.only(top: 18 * heightScale, bottom: 18 * heightScale),
                decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(20 * widthScale),
                        topLeft: Radius.circular(20 * widthScale))),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(right:15.0*widthScale),
                      child: GradientRoundButton(
                          icon: Icons.close_rounded,
                          width: 60,
                          height: 60,
                          iconSize:40,
                          isRed: true,
                          onPress: (){}
                          ),
                    ),
                    SizedBox(
                      height: 30*heightScale,
                      child: PointsContainer(
                          text: '17 / 25 Swipes',
                          color: "black"
                      ),
                    ),
                    SizedBox(width: 5*widthScale,),
                    GestureDetector(
                      onTap:(){},
                      child: Container(
                        height: 30*heightScale,
                        width: 30*heightScale,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.black,
                        ),
                        child: Icon(Icons.add,color: Colors.white,),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left:15.0*widthScale),
                      child: GradientRoundButton(
                          icon: Icons.check_rounded,
                          width: 60,
                          height: 60,
                          iconSize:40,
                          onPress: (){}
                      ),
                    )
                  ],
                ),
            ),
          ),
          ProfileAppBar(onBackPress: () {Navigator.pop(context);}, title: "Elisa"),
        ],
      ),
    );
  }
}
