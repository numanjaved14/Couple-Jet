import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:couple_jet/ui/reusable/gradient_points_container.dart';
import 'package:couple_jet/ui/reusable/gradient_round_button.dart';
import 'package:couple_jet/ui/reusable/profile_image.dart';
import 'package:couple_jet/ui/reusable/search_field.dart';
import 'package:couple_jet/ui/screens/profile_screen/profile_screen.dart';
import 'package:couple_jet/utils/colors.dart';
import 'package:couple_jet/utils/constant.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../helpers/ad_manager.dart';
import 'widgets/feed_list_item.dart';

class FeedScreen extends StatelessWidget {
  FeedScreen({Key? key}) : super(key: key) {
    adManager.addAds(false, false, true);
  }

  final adManager = AdManager();

  final TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    if (Theme.of(context).scaffoldBackgroundColor == kLightBg) {
      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
    } else {
      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
    }
    final double widthScale = MediaQuery.of(context).size.width / 414;
    final double heightScale = MediaQuery.of(context).size.height / 896;
    return Scaffold(
      body: StreamBuilder<DocumentSnapshot>(
          stream: FirebaseFirestore.instance
              .collection("users")
              .doc(FirebaseAuth.instance.currentUser!.uid)
              .snapshots(),
          builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
            if (snapshot.hasData) {
              Map<String, dynamic> data =
                  snapshot.data!.data() as Map<String, dynamic>;
              return Column(
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
                            GradientPointsContainer(
                                points: data['reward'].toString()),
                            SizedBox(
                              width: 5 * widthScale,
                            ),
                            GradientRoundButton(
                              icon: Icons.add_rounded,
                              onPress: () {
                                adManager.showRewardedAd();
                              },
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
                                  profileImg: data['imageLink'],
                                  onPress: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                ProfileScreen()));
                                  }),
                            ),
                            Image.asset(
                              Theme.of(context).scaffoldBackgroundColor ==
                                      kLightBg
                                  ? 'images/icons/notification.png'
                                  : 'images/icons/notification_black.png',
                              width: 20 * widthScale,
                              height: 20 * widthScale,
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        left: 18 * widthScale,
                        right: 22 * widthScale,
                        bottom: 12 * heightScale),
                    child: SearchField(
                        hint: "Suche nach einem User oder Thema...",
                        textController: searchController),
                  ),
                  StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection("posts")
                          .snapshots(),
                      builder: (context,
                          AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                              snapshot) {
                        if (snapshot.hasData) {
                          return Expanded(
                            child: ListView.builder(
                                padding: EdgeInsets.only(
                                  top: 12 * heightScale,
                                  bottom: 36 * heightScale,
                                ),
                                itemCount: snapshot.data!.docs.length,
                                shrinkWrap: true,
                                itemBuilder: (context, index) {
                                  return FeedListItem(
                                    snap: snapshot.data!.docs[index].data(),
                                  );
                                }),
                          );
                        } else if (snapshot.hasError) {
                          return const Center(
                            child: Text("No Post"),
                          );
                        }
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }),
                ],
              );
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          }),
    );
  }
}
