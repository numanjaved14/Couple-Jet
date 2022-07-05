import 'package:flutter/material.dart';

class ProfileImage extends StatelessWidget {

  final String profileImg;
  final double radius;
  final Function() onPress;

  const ProfileImage({Key? key, required this.radius, required this.profileImg, required this.onPress}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
      child: CircleAvatar(
        backgroundImage: NetworkImage(profileImg),
        radius: radius,
      ),
    );
    /// use this for network images
    // return GestureDetector(
    //   onTap: onPress,
    //   child: CachedNetworkImage(
    //     imageUrl: profileImg,
    //     imageBuilder: (context, imagerProvider) => CircleAvatar(
    //       backgroundImage: imagerProvider,
    //       radius: radius,
    //     ),
    //     placeholder: (context, url) => Center(
    //       child: CircleAvatar(
    //         backgroundImage: AssetImage("default profile image"),
    //         radius: radius,
    //       ),
    //     ),
    //     errorWidget: (context, url, error) => CircleAvatar(
    //       backgroundImage: AssetImage("default profile image"),
    //       radius: radius,
    //     ),
    //     fit: BoxFit.cover,
    //   ),
    // );
  }
}
