import 'package:couple_jet/ui/reusable/gradient_round_button.dart';
import 'package:couple_jet/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CommentInputContainer extends StatelessWidget {

  final TextEditingController textController;
  final Function() onSendPress;

  const CommentInputContainer({Key? key, required this.textController, required this.onSendPress}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double widthScale = MediaQuery.of(context).size.width / 414;
    final double heightScale = MediaQuery.of(context).size.height / 896;
    return Container(
      padding: EdgeInsets.only(top: 30*heightScale,bottom: 30*heightScale,left: 20*widthScale,right: 20*widthScale),
      decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          borderRadius: BorderRadius.only(topRight: Radius.circular(20*widthScale),topLeft: Radius.circular(20*widthScale))
      ),
      child:Row(
        children: [
          Expanded(
              child: Container(
                padding: EdgeInsets.only(left: 11*widthScale,top: 1*heightScale,bottom: 1*heightScale,right: 11*widthScale),
                decoration: BoxDecoration(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    borderRadius: BorderRadius.all(Radius.circular(18*widthScale))
                ),
                child: Center(
                  child: TextFormField(
                    controller: textController,
                    cursorColor: kTeal,
                    style:GoogleFonts.outfit(fontSize: 15 * widthScale),
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.zero,
                      border: InputBorder.none,
                      hintText: "Max. 5 lines of text",
                      hintStyle: GoogleFonts.outfit(fontSize: 15 * widthScale),
                    ),
                  ),
                ),
              )
          ),
          SizedBox(width: 8*widthScale,),
          GradientRoundButton(
              height: 42,
              width: 42,
              iconSize: 24,
              icon: Icons.send_rounded,
              onPress: onSendPress)
        ],
      )
    );
  }
}
