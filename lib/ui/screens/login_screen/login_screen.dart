import 'package:couple_jet/ui/reusable/card_container.dart';
import 'package:couple_jet/ui/reusable/main_button.dart';
import 'package:couple_jet/ui/reusable/main_text_field.dart';
import 'package:couple_jet/ui/reusable/social_login_button.dart';
import 'package:couple_jet/ui/reusable/title_text.dart';
import 'package:couple_jet/ui/reusable/top_app_bar.dart';
import 'package:couple_jet/ui/screens/bottom_nav_bar/bottom_nav_bar.dart';
import 'package:couple_jet/ui/screens/password_reset_screen/password_recet_screen.dart';
import 'package:couple_jet/utils/text_styles.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {

  LoginScreen({Key? key}) : super(key: key);

  final TextEditingController emailController = TextEditingController();
  final TextEditingController pwdController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final double widthScale = MediaQuery.of(context).size.width / 414;
    final double heightScale = MediaQuery.of(context).size.height / 896;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // app bar & email pwd container
          Column(
            children: [
              // app bar
              TopAppBar(
                  onBackPress: (){
                    Navigator.pop(context);
                  },
                  title: 'Login',
              ),
              // email pwd container
              CardContainer(
                  child: Column(
                    children: [
                      const TitleText(title: "Welcome back!"),
                      SizedBox(height: 15*heightScale,),
                      CustomTextField(
                          hint: "E-Mail Address",
                          textController: emailController,
                          prefixIcon: Icons.alternate_email_rounded
                      ),
                      SizedBox(height: 21*heightScale,),
                      CustomTextField(
                          hint: "Password",
                          textController: pwdController,
                          prefixIcon: Icons.lock_rounded,
                          isPassword: true,
                      ),
                      SizedBox(height: 35*heightScale,),
                      MainButton(
                        title: "Login and have fun",
                        onPress: (){Navigator.push(context, MaterialPageRoute(builder: (context) => BottomNavBar()));},
                      )
                    ],
                  )
              ),
              // forgot pwd text
              GestureDetector(
                  onTap: (){ Navigator.push(context, MaterialPageRoute(builder: (context) => PasswordResetScreen()));},
                  child:Text(
                  'Forgot password?',
                  style: kNormalGreyText(context),)
              )
            ],
          ),
          // social login container
          Container(
            padding: EdgeInsets.only(top: 25*heightScale,bottom: 32*heightScale),
            decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.only(topRight: Radius.circular(20*widthScale),topLeft: Radius.circular(20*widthScale))
            ),
            child: Column(
              children: [
                const TitleText(title: 'Login with social accounts:'),
                SizedBox(height: 25*heightScale,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SocialLoginButton(
                      onTap: (){},
                      type: SocialBtnType.google,
                    ),
                    SizedBox(width: 10*widthScale,),
                    SocialLoginButton(
                      onTap: (){},
                      type: SocialBtnType.facebook,
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
