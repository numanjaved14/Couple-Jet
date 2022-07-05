import 'package:couple_jet/ui/reusable/card_container.dart';
import 'package:couple_jet/ui/reusable/gradient_points_container.dart';
import 'package:couple_jet/ui/reusable/title_text.dart';
import 'package:couple_jet/ui/reusable/top_app_bar.dart';
import 'package:couple_jet/ui/screens/settings_screen/widgets/sub_text.dart';
import 'package:couple_jet/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'widgets/points_container.dart';

class AddCenterScreen extends StatelessWidget {
  const AddCenterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double widthScale = MediaQuery.of(context).size.width / 414;
    final double heightScale = MediaQuery.of(context).size.height / 896;
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Column(children: [
          // app bar
          TopAppBar(
            onBackPress: () {
              Navigator.pop(context);
            },
            title: 'Adcenter',
          ),
          // email pwd container
          Expanded(child:SingleChildScrollView(
            child: Column(
              children: [
                CardContainer(
                  child: Column(children: [
                    TitleText(title: "Your Balance"),
                    SizedBox(
                      height: 8 * heightScale
                    ),
                    GradientPointsContainer(points: "1500"),
                    SizedBox(
                        height: 24 * heightScale
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SubText(text: 'Daily Check-In'),
                        PointsContainer(text: "+ 100",color: "blue",)
                      ],
                    ),
                    SizedBox(
                        height: 14 * heightScale
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SubText(text: 'Rewared Ad'),
                        PointsContainer(text: "+ 100",color: "blue",)
                      ],
                    )
                  ]),
                ),

                CardContainer(
                  marginVertical: 0,
                  child: Column(children: [
                    TitleText(title: "Limits"),
                    SizedBox(
                        height: 8 * heightScale
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        PointsContainer(text: "17 Swipes left",color: "black",),
                        PointsContainer(text: "+ 50 Swipes | - 50",color: "red",)
                      ],
                    ),
                    SizedBox(
                        height: 10 * heightScale
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        PointsContainer(text: "20 Messages left",color: "black",),
                        PointsContainer(text: "+ 50 Swipes | - 100",color: "red",)
                      ],
                    )
                  ]),
                ),

                CardContainer(
                  child: Column(children: [
                    TitleText(title: "Why so many ads?"),
                    SizedBox(
                        height: 8 * heightScale
                    ),
                    Text("First of all - thank you for using this app!\n\n"

                        "Unlike other dating platforms, we want to be 100%"
                        "free to use - and that includes 'premium' features"
                        "like a chat as well as revealing liked people.\n\n"

                        "However, goodwill alone does not cover the costs of"
                        "this app. This includes not only development costs, but"
                        "also the pure operation of this app. Your data costs us"
                        "money. Your pictures, your chats and your posts."
                        "We understand that you don't want to spend money "
                        "on a dating app where no one can promise you"
                        "success. This is exactly why we finance ourselves"
                       "through advertising.",
                    textAlign: TextAlign.center,
                      style: GoogleFonts.outfit(fontSize: 15 * widthScale,color: Theme.of(context).textTheme.bodyText1!.color),
                    )
                  ]),
                ),
              ],
            ),
          ),)
        ]));
  }
}
