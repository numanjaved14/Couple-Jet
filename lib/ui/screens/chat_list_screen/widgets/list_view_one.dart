import 'package:couple_jet/ui/screens/ad_center_screen/ad_center_screen.dart';
import 'package:couple_jet/ui/screens/ad_center_screen/widgets/points_container.dart';
import 'package:couple_jet/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

class ListViewOne extends StatefulWidget {
  const ListViewOne({Key? key}) : super(key: key);

  @override
  _ListViewOneState createState() => _ListViewOneState();
}

class _ListViewOneState extends State<ListViewOne> {

  final ScrollController _scrollController = ScrollController();
  double margin = 20;
  double radius = 25;

  @override
  Widget build(BuildContext context) {
    final double widthScale = MediaQuery.of(context).size.width / 414;
    final double heightScale = MediaQuery.of(context).size.height / 896;
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      // Provide an optional curve to make the animation feel smoother.
      curve: Curves.fastOutSlowIn,
      margin: EdgeInsets.only(left: margin * widthScale),
      height: 176 * heightScale,
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          stops: [0.0, 1.0],
          colors: [kBlue, kTeal],
        ),
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(radius * widthScale),
            bottomLeft: Radius.circular(radius * widthScale)),
      ),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(left: 20.0 * widthScale, top: 9 * heightScale),
            child: Row(
              children: [
                Text(
                  'People who want to get to know you',
                  style: GoogleFonts.outfit(fontSize: 15 * widthScale, color: Colors.white),
                ),
                Icon(
                  Icons.arrow_forward_rounded,
                  color: Colors.white,
                  size: 20 * widthScale,
                )
              ],
            ),
          ),
          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: NotificationListener<ScrollUpdateNotification>(
                    onNotification: (ScrollNotification scrollNotification) {
                      if (_scrollController.position.userScrollDirection ==
                          ScrollDirection.reverse) {
                        setState(() {
                          margin = 0;
                          radius = 0;
                        });
                      } else {
                        if (_scrollController.position.userScrollDirection == ScrollDirection.forward) {
                          setState(() {
                            margin = 20;
                            radius = 25;
                          });
                        }
                      }

                      return true;
                    },
                    child: ListView.builder(
                      controller: _scrollController,
                        padding: EdgeInsets.only(left: 10 * widthScale, top: 11 * heightScale, bottom: 14 * heightScale),
                        scrollDirection: Axis.horizontal,
                        itemCount: 5,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: (){
                              pushNewScreen(
                                context,
                                screen: const AddCenterScreen(),
                                withNavBar: false, // OPTIONAL VALUE. True by default.
                                //pageTransitionAnimation: PageTransitionAnimation.cupertino,
                              );
                            },
                            child: Container(
                              margin: EdgeInsets.only(right: 10 * widthScale),
                              height: 125 * widthScale,
                              width: 100 * widthScale,
                              decoration: BoxDecoration(
                                // boxShadow: [BoxShadow(color: Colors.black26, offset: Offset(0, 4), blurRadius: 5.0)],
                                color: Theme.of(context).primaryColor,
                                borderRadius: BorderRadius.all(Radius.circular(18 * widthScale)),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.lock_rounded,
                                    size: 35 * widthScale,
                                  ),
                                  SizedBox(
                                    height: 10 * heightScale,
                                  ),
                                  const PointsContainer(
                                    color: "red",
                                    text: '-150',
                                  )
                                ],
                              ),
                            ),
                          );
                        }),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
