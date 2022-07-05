import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'gradient_round_button.dart';

class PostImageSlider extends StatefulWidget {

  final List<String> imgList;
  final Function() onLikeTap;
  final int likeCount;

  const PostImageSlider({Key? key, required this.onLikeTap, required this.likeCount, required this.imgList}) : super(key: key);

  @override
  _PostImageSliderState createState() => _PostImageSliderState();
}

class _PostImageSliderState extends State<PostImageSlider> {

  int currentPhotoIndex = 0;
  final PageController pageController = PageController(initialPage: 0, viewportFraction: 1, keepPage: true);


  @override
  Widget build(BuildContext context) {
    final double widthScale = MediaQuery.of(context).size.width / 414;
    final double heightScale = MediaQuery.of(context).size.height / 896;
    return SizedBox(
      width: double.infinity,
      height:300*heightScale,
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
                      borderRadius: BorderRadius.all(Radius.circular(16*widthScale))
                  ),
                );
              }),
          Align(
            alignment: Alignment.topRight,
            child: Container(
              margin: EdgeInsets.only(right: 20*widthScale,top: 20*widthScale),
              padding: EdgeInsets.only(left: 10*widthScale,right: 9*widthScale,top: 2*widthScale,bottom: 2*widthScale),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.4),
                  borderRadius: BorderRadius.all(Radius.circular(10*widthScale))
                ),
                child: Text('${(currentPhotoIndex+1)}/${widget.imgList.length}',style: GoogleFonts.outfit(fontSize: 12*widthScale,color: Colors.white),)),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: EdgeInsets.only(bottom: 14*widthScale),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  for (int i = 0; i < widget.imgList.length; i++)
                    pageIndexIndicatorPhoto(currentPhotoIndex == i,widthScale)
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: GestureDetector(
              onTap: widget.onLikeTap,
              onDoubleTap: widget.onLikeTap,
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
                          icon: Icons.favorite_rounded,
                          onPress: (){}),
                      SizedBox(width: 8*widthScale,),
                      Text('${widget.likeCount}',style: GoogleFonts.outfit(fontSize: 12*widthScale,color: Colors.white),),
                    ],
                  )),
            ),
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
