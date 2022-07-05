import 'package:couple_jet/ui/reusable/profile_image.dart';
import 'package:couple_jet/ui/screens/ad_center_screen/widgets/points_container.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ChatAppBar extends StatelessWidget {

  final String title;
  final String subTitle;
  final String profileImg;
  final String leftMsg;
  final Function() onBackPress;
  final Function() onAddPress;
  final Function() onMorePress;

  const ChatAppBar({Key? key, required this.title, required this.subTitle, required this.profileImg, required this.leftMsg, required this.onBackPress, required this.onAddPress, required this.onMorePress}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double widthScale = MediaQuery.of(context).size.width / 414;
    final double heightScale = MediaQuery.of(context).size.height / 896;
    return Container(
      width: double.infinity,
      height: 106*heightScale,
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
        borderRadius: BorderRadius.only(bottomRight: Radius.circular(20*widthScale),bottomLeft: Radius.circular(20*widthScale)),
        // boxShadow: [
        //   BoxShadow(
        //     color: Color.fromRGBO(0, 0, 0, 0.1),
        //     offset: Offset(0,1),
        //     blurRadius: 12,
        //     spreadRadius: 1
        //   )
        // ]
      ),
      child: Padding(
        padding: EdgeInsets.only(top: 31*heightScale),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              children: [
                IconButton(onPressed: onBackPress, icon: Icon(Icons.arrow_back_rounded,size: 24*widthScale,)),
                ProfileImage(radius: 17.5, profileImg: profileImg, onPress: (){}),
                SizedBox(width: 10*widthScale,),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(title,style: GoogleFonts.outfit(fontWeight: FontWeight.bold,fontSize: 15*widthScale),),
                    Text(subTitle,style: GoogleFonts.outfit(fontSize: 10*widthScale),),
                  ],
                ),
              ],
            ),
            Row(
              children: [
                SizedBox(height: 30*heightScale, child: PointsContainer(text: leftMsg, color: "black")),
                SizedBox(width: 5*widthScale,),
                GestureDetector(
                  onTap: onAddPress,
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
                IconButton(onPressed: (){}, icon: Icon(Icons.more_vert,size: 24*widthScale,)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
