import 'package:couple_jet/utils/colors.dart';
import 'package:flutter/material.dart';

class GradientMask extends StatelessWidget {

  final Widget child;

  const GradientMask({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (bounds) => const LinearGradient(
        colors: [
          kBlue,
          kTeal,
        ],
        tileMode: TileMode.mirror,
      ).createShader(bounds),
      child: child,
    );
  }
}