import 'package:couple_jet/ui/reusable/card_container.dart';
import 'package:couple_jet/ui/reusable/post_image_slider.dart';
import 'package:couple_jet/ui/reusable/profile_image.dart';
import 'package:couple_jet/utils/firestore_methods.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FeedListItem extends StatelessWidget {
  var snap;
  FeedListItem({
    Key? key,
    required this.snap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double widthScale = MediaQuery.of(context).size.width / 414;
    final double heightScale = MediaQuery.of(context).size.height / 896;
    return CardContainer(
        paddingHorizontal: 8,
        paddingVertical: 8,
        marginVertical: 5,
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(
                  top: 7 * heightScale,
                  left: 12 * widthScale,
                  right: 12 * widthScale),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      ProfileImage(
                        radius: 17.5,
                        profileImg: snap['profImage'].toString(),
                        onPress: () {},
                      ),
                      SizedBox(
                        width: 10 * widthScale,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            snap['username'].toString(),
                            style: GoogleFonts.outfit(
                                fontSize: 15 * widthScale,
                                fontWeight: FontWeight.bold),
                          ),
                          // Text(snap['datePublished'].toString(),
                          //     style: GoogleFonts.outfit(
                          //         fontSize: 10 * widthScale,
                          //         color: Theme.of(context)
                          //             .iconTheme
                          //             .color!
                          //             .withOpacity(0.7)))
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
            PostImageSlider(
              imgList: [
                snap['postUrl'].toString(),
              ],
              likeCount: snap['likes'].length,
              onLikeTap: () {
              },
            ),
            Padding(
              padding: EdgeInsets.only(
                  top: 11 * heightScale,
                  left: 10 * widthScale,
                  right: 10 * widthScale),
              child: Text(
                snap['description'].toString(),
                style: GoogleFonts.outfit(
                    fontSize: 12 * widthScale,
                    color: Theme.of(context).iconTheme.color!.withOpacity(0.7)),
              ),
            )
          ],
        ));
  }
}
