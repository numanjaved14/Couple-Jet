

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SearchField extends StatelessWidget {

  final String hint;
  final TextEditingController textController;
  void Function(String)? onChanged;
   SearchField({Key? key,this.onChanged,required this.hint, required this.textController}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double widthScale = MediaQuery.of(context).size.width / 414;
    final double heightScale = MediaQuery.of(context).size.height / 896;
    return Container(
      padding: EdgeInsets.only(left: 15*widthScale,top: 4*heightScale,bottom: 4*heightScale,right: 15*widthScale),
      decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          borderRadius: BorderRadius.all(Radius.circular(36*widthScale))
      ),
      child: Center(
        child: TextFormField(
          controller: textController,
          textAlignVertical: TextAlignVertical.center,
          style: GoogleFonts.outfit(fontSize: 15 * widthScale),
          decoration: InputDecoration(
            contentPadding: EdgeInsets.zero,
            border: InputBorder.none,
            hintText: hint,
            hintStyle: GoogleFonts.outfit(fontSize: 15 * widthScale),
              suffixIcon: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.search_rounded,color: Colors.grey,),
                SizedBox(width: 10*widthScale,),
                Icon(Icons.qr_code_rounded,color: Colors.grey,)
              ],
            )
          ),
          onChanged: onChanged,
        ),
      ),
    );
  }
}
