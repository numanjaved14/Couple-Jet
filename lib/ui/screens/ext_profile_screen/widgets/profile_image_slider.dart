import 'package:couple_jet/ui/reusable/gradient_round_button.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';



class ProfileImageSlider extends StatefulWidget {

  final List<String> imgList;

  const ProfileImageSlider({Key? key, required this.imgList}) : super(key: key);

  @override
  _ProfileImageSliderState createState() => _ProfileImageSliderState();
}

class _ProfileImageSliderState extends State<ProfileImageSlider> {

  int currentPhotoIndex = 0;
  final PageController pageController = PageController(initialPage: 0, viewportFraction: 1, keepPage: true);


  @override
  Widget build(BuildContext context) {
    final double widthScale = MediaQuery.of(context).size.width / 414;
    final double heightScale = MediaQuery.of(context).size.height / 896;
    return SizedBox(
      width: double.infinity,
      height:372*heightScale,
      child: Stack(
        children: [
          PageView.builder(
              controller: pageController,
              scrollDirection: Axis.horizontal,
              itemCount: widget.imgList.length,
              onPageChanged: (value){
                setState(() {
                  currentPhotoIndex = value;
                });
              },
              itemBuilder: (context, int index) {
                return Container(
                  decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(widget.imgList[index]),
                        fit: BoxFit.fill,
                      ),
                      borderRadius: BorderRadius.only(bottomLeft: Radius.circular(13*widthScale),bottomRight: Radius.circular(13*widthScale))
                  ),
                );
              }),
          Align(
            alignment: Alignment.bottomLeft,
            child: Container(
                margin: EdgeInsets.only(left: 20*widthScale,bottom: 22*widthScale),
                padding: EdgeInsets.only(right: 15*widthScale),
                decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.4),
                    borderRadius: BorderRadius.all(Radius.circular(30*widthScale))
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    GradientRoundButton(
                        icon: Icons.photo_library_rounded,
                        iconSize: 15,
                        onPress: (){}),
                    SizedBox(width: 8*widthScale,),
                    Text('${(currentPhotoIndex+1)} / ${widget.imgList.length}',style: GoogleFonts.outfit(fontSize: 12*widthScale,color: Colors.white),),
                  ],
                )),
          ),
        ],
      ),
    );
  }

  pageIndexIndicatorPhoto(bool isCurrentPage,double widthScale) {
    return Container(
      height: 6*widthScale,
      width: 6*widthScale,
      margin: EdgeInsets.only(right:6*widthScale,),
      decoration: BoxDecoration(
          color: isCurrentPage ? Colors.white: Colors.white.withOpacity(0.4),
          shape: BoxShape.circle
      ),
    );
  }
}
