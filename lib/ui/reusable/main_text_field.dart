import 'package:couple_jet/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTextField extends StatefulWidget {

  final String hint;
  final bool isPassword;
  final TextEditingController textController;
  final IconData prefixIcon;
  final bool isEnabled;
  String? Function(String?)? validator;
   CustomTextField({Key? key, this.validator,this.isPassword = false, required this.hint, required this.textController,
    required this.prefixIcon, this.isEnabled=true}) : super(key: key);

  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {

  bool isHidden = true;

  @override
  Widget build(BuildContext context) {
    final double widthScale = MediaQuery.of(context).size.width / 414;
    final double heightScale = MediaQuery.of(context).size.height / 896;
    return Container(
      padding: EdgeInsets.only(left: 15*widthScale,top: 1*heightScale,bottom: 1*heightScale,right: 15*widthScale),
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: BorderRadius.all(Radius.circular(10*widthScale))
      ),
      child: Center(
        child: TextFormField(
      validator: widget.validator,
          controller: widget.textController,
          enabled: widget.isEnabled,
          textAlignVertical: TextAlignVertical.center,
          cursorColor: kTeal,
          style:GoogleFonts.outfit(fontSize: 15 * widthScale),
          decoration: InputDecoration(
            contentPadding: EdgeInsets.zero,
            border: InputBorder.none,
            hintText: widget.hint,
            hintStyle: GoogleFonts.outfit(fontSize: 15 * widthScale),
            prefixIcon: Icon(widget.prefixIcon,size: 24*widthScale,color: Theme.of(context).iconTheme.color,),
            suffixIcon: widget.isPassword ? IconButton(
              onPressed: _toggleVisibility,
              splashRadius: 24,
              icon: isHidden
                  ? Icon(Icons.visibility_rounded,size: 24*widthScale,color: Theme.of(context).iconTheme.color,)
                  : Icon(Icons.visibility_off_rounded,size: 24*widthScale,color: Theme.of(context).iconTheme.color,)
            ) : null,
          ),
          obscureText: widget.isPassword ? isHidden : false,
        ),
      ),
    );
  }

  _toggleVisibility() {
    setState(() {
      isHidden = !isHidden;
    });
  }
}
