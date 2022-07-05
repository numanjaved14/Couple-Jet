import 'package:couple_jet/ui/reusable/picture_container.dart';
import 'package:flutter/material.dart';

class ListViewTwo extends StatelessWidget {

  ListViewTwo({Key? key}) : super(key: key);

  final imgList = ['images/dummy_card0.png','images/dumm_card1.png','images/dummy_card2.png','images/dummy_card3.png','images/dummy_profile.png'];

  @override
  Widget build(BuildContext context) {
    final double widthScale = MediaQuery.of(context).size.width / 414;
    final double heightScale = MediaQuery.of(context).size.height / 896;
    return SizedBox(
      height: 155*heightScale,
      child: Row(
        children: [
          Expanded(
              child: ListView.builder(
                  padding: EdgeInsets.only(left: 18 * widthScale),
                  scrollDirection: Axis.horizontal,
                  itemCount: imgList.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return PictureContainer(
                      image: imgList[index],
                      type: 'home',
                      onDelPress: (){},
                    );
                  }),
          ),
        ],
      ),
    );
  }
}
