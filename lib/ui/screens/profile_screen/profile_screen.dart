import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:couple_jet/ui/reusable/card_container.dart';
import 'package:couple_jet/ui/reusable/gradient_points_container.dart';
import 'package:couple_jet/ui/reusable/gradient_round_button.dart';
import 'package:couple_jet/ui/reusable/main_button.dart';
import 'package:couple_jet/ui/reusable/post_image_slider.dart';
import 'package:couple_jet/ui/reusable/profile_image.dart';
import 'package:couple_jet/ui/screens/create_post_screen/create_post_screen.dart';
import 'package:couple_jet/ui/screens/my_profile_screen/my_profile_screen.dart';
import 'package:couple_jet/ui/screens/my_profile_screen/widgets/interest_item.dart';
import 'package:couple_jet/ui/screens/settings_screen/settings_screen.dart';
import 'package:couple_jet/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

import '../../../utils/constant.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({Key? key}) : super(key: key);

  final List<Interest> interests = [
    Interest('Travelling', 'images/icons/travel.png', true),
    Interest('Netflix', 'images/icons/netflix.png', true),
  ];

  @override
  Widget build(BuildContext context) {
    var ds;
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
            ),
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
                IconButton(
                  icon: Icon(
                    Icons.tune_rounded,
                    size: 24 * widthScale,
                  ),
                  onPressed: () {
                    pushNewScreen(
                      context,
                      screen: SettingsScreen(),
                      withNavBar: false, // OPTIONAL VALUE. True by default.
                      //pageTransitionAnimation: PageTransitionAnimation.cupertino,
                    );
                  },
                )
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  CardContainer(
                    paddingVertical: 13,
                    paddingHorizontal: 13,
                    child: Stack(
                      children: [
                        Align(
                          alignment: Alignment.center,
                          child: FutureBuilder(
                              future: firebaseFirestore
                                  .collection("users")
                                  .doc(firebaseAuth.currentUser!.uid)
                                  .get(),
                              builder: (BuildContext context,
                                  AsyncSnapshot<DocumentSnapshot> snapshot) {
                                if (snapshot.hasData) {
                                  ds = snapshot.data!;
                                  return Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                        width: 150 * widthScale,
                                        height: 150 * widthScale,
                                        decoration: const BoxDecoration(
                                          gradient: LinearGradient(
                                            begin: Alignment.centerLeft,
                                            end: Alignment.bottomRight,
                                            stops: [0.0, 1.0],
                                            colors: [
                                              kBlue,
                                              kTeal,
                                            ],
                                          ),
                                          shape: BoxShape.circle,
                                          boxShadow: [
                                            BoxShadow(
                                                color: Colors.black12,
                                                offset: Offset(0, 4),
                                                blurRadius: 12.0)
                                          ],
                                        ),
                                        child: Container(
                                          margin:
                                              EdgeInsets.all(12 * widthScale),
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              shape: BoxShape.circle,
                                              image: DecorationImage(
                                                  image: NetworkImage(
                                                      ds.get("imageLink")),
                                                  fit: BoxFit.fill)),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 7 * heightScale,
                                      ),
                                      Text(
                                        ds.get("UserName"),
                                        style: GoogleFonts.outfit(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 25 * widthScale),
                                      ),
                                      Text(
                                        'aus Düsseldorf, DE',
                                        style: GoogleFonts.outfit(
                                            fontSize: 12 * widthScale),
                                      ),
                                      SizedBox(
                                        height: 13 * heightScale,
                                      ),
                                      Wrap(
                                        crossAxisAlignment:
                                            WrapCrossAlignment.center,
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
                                                      radius: 20,
                                                      title: e.title,
                                                      icon: e.icon,
                                                      isSelected: e.isSelected),
                                                ))
                                            .toList(),
                                      ),
                                      SizedBox(
                                        height: 14 * heightScale,
                                      ),
                                    ],
                                  );
                                } else if (snapshot.hasError) {
                                  return Center(
                                      child: Icon(Icons.error_outline));
                                } else {
                                  return Center(
                                      child: CircularProgressIndicator());
                                }
                              }),
                        ),
                        Align(
                          alignment: Alignment.topLeft,
                          child: GestureDetector(
                            onTap: () {
                              pushNewScreen(
                                context,
                                screen: MyProfileScreen(),
                                withNavBar:
                                    false, // OPTIONAL VALUE. True by default.
                                //pageTransitionAnimation: PageTransitionAnimation.cupertino,
                              );
                            },
                            child: Container(
                              padding: EdgeInsets.all(6),
                              decoration: BoxDecoration(
                                  color:
                                      Theme.of(context).scaffoldBackgroundColor,
                                  shape: BoxShape.circle),
                              child: Icon(
                                Icons.edit_rounded,
                                size: 24 * widthScale,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        left: 20 * widthScale, right: 20 * widthScale),
                    child: MainButton(
                      title: 'New social post (- 1.000 diamonds)',
                      onPress: () {
                        pushNewScreen(
                          context,
                          screen: CreatePostScreen(
                            profImage: '',
                            userName: '',
                            // userName: ds.get("UserName") == null
                            //     ? ""
                            //     : ds.get("UserName"),
                            // profImage: ds.get("imageLink") == null
                            //     ? ""
                            //     : ds.get("imageLink"),
                          ),
                          withNavBar: false, // OPTIONAL VALUE. True by default.
                          //pageTransitionAnimation: PageTransitionAnimation.cupertino,
                        );
                      },
                    ),
                  ),
                  CardContainer(
                      paddingHorizontal: 8,
                      paddingVertical: 15,
                      child: Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(
                                left: 12 * widthScale,
                                right: 12 * widthScale,
                                bottom: 12 * heightScale),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    ProfileImage(
                                      radius: 17.5,
                                      profileImg: firebaseAuth
                                          .currentUser!.photoURL
                                          .toString(),
                                      onPress: () {},
                                    ),
                                    SizedBox(
                                      width: 10 * widthScale,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Johanna, 22',
                                          style: GoogleFonts.outfit(
                                              fontSize: 15 * widthScale,
                                              fontWeight: FontWeight.bold),
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => CreatePostScreen(
                                          profImage: '',
                                          userName: '',
                                          // userName: ds.get("UserName") == null
                                          //     ? ""
                                          //     : ds.get("UserName"),
                                          // profImage: ds.get("imageLink") == null
                                          //     ? ""
                                          //     : ds.get("imageLink"),
                                        ),
                                      ),
                                    );
                                  },
                                  child: Icon(
                                    Icons.edit_rounded,
                                    size: 24 * widthScale,
                                  ),
                                )
                              ],
                            ),
                          ),
                          PostImageSlider(
                            imgList: [
                              'images/dummy_post1.png',
                              'images/dummy_post2.png'
                            ],
                            likeCount: 1500,
                            onLikeTap: () {},
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                top: 11 * heightScale,
                                left: 10 * widthScale,
                                right: 10 * widthScale),
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
                          )
                        ],
                      )),
                  SizedBox(
                    height: 36 * heightScale,
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
