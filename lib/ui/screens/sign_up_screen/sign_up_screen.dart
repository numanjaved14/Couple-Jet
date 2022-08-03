import 'dart:typed_data';

import 'package:couple_jet/ui/reusable/card_container.dart';
import 'package:couple_jet/ui/reusable/main_button.dart';
import 'package:couple_jet/ui/reusable/main_text_field.dart';
import 'package:couple_jet/ui/reusable/social_login_button.dart';
import 'package:couple_jet/ui/reusable/title_text.dart';
import 'package:couple_jet/ui/reusable/top_app_bar.dart';
import 'package:couple_jet/ui/screens/bottom_nav_bar/bottom_nav_bar.dart';
import 'package:couple_jet/utils/authutils.dart';
import 'package:couple_jet/utils/colors.dart';
import 'package:couple_jet/utils/constant.dart';
import 'package:couple_jet/utils/customdialog.dart';
import 'package:couple_jet/utils/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:image_picker/image_picker.dart';

class SignUpScreen extends StatefulWidget {
  SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController emailController = TextEditingController();

  final TextEditingController pwdController = TextEditingController();

  final TextEditingController rePwdController = TextEditingController();

  final TextEditingController dobController = TextEditingController();

  final TextEditingController userController = TextEditingController();

  final formKey = GlobalKey<FormState>();
  Uint8List? _image;
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    final double widthScale = MediaQuery.of(context).size.width / 414;
    final double heightScale = MediaQuery.of(context).size.height / 896;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // app bar & email pwd container
            Column(
              children: [
                // app bar
                TopAppBar(
                  onBackPress: () {
                    Navigator.pop(context);
                  },
                  title: 'Sign up',
                ),
                // email pwd container
                CardContainer(
                    child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      const TitleText(title: "Welcome back!"),
                      SizedBox(
                        height: 15 * heightScale,
                      ),
                      Stack(
                        children: [
                          _image != null
                              ? CircleAvatar(
                                  radius: 59,
                                  backgroundImage: MemoryImage(_image!))
                              : CircleAvatar(
                                  radius: 59,
                                  backgroundImage: NetworkImage(
                                      'https://static.remove.bg/remove-bg-web/a6eefcd21dff1bbc2448264c32f7b48d7380cb17/assets/start_remove-c851bdf8d3127a24e2d137a55b1b427378cd17385b01aec6e59d5d4b5f39d2ec.png'),
                                ),
                          Positioned(
                              bottom: -10,
                              left: 70,
                              child: IconButton(
                                  onPressed: () => selectImage(),
                                  icon: Icon(
                                    Icons.add_a_photo,
                                    color: Colors.white,
                                  )))
                        ],
                      ),
                      SizedBox(
                        height: 23,
                      ),
                      CustomTextField(
                          validator: requiredValidator,
                          hint: "UserName",
                          textController: userController,
                          prefixIcon: Icons.person),
                      SizedBox(
                        height: 15 * heightScale,
                      ),
                      CustomTextField(
                          validator: emailValidator,
                          hint: "E-Mail Address",
                          textController: emailController,
                          prefixIcon: Icons.alternate_email_rounded),
                      SizedBox(
                        height: 18 * heightScale,
                      ),
                      CustomTextField(
                        hint: "Password",
                        validator: passwordValidator,
                        textController: pwdController,
                        prefixIcon: Icons.lock_rounded,
                        isPassword: true,
                      ),
                      SizedBox(
                        height: 18 * heightScale,
                      ),
                      CustomTextField(
                        hint: "Repeat password",
                        textController: rePwdController,
                        prefixIcon: Icons.lock_rounded,
                        isPassword: true,
                      ),
                      SizedBox(
                        height: 18 * heightScale,
                      ),
                      GestureDetector(
                        onTap: () {
                          onDobTap(context);
                        },
                        child: CustomTextField(
                          validator: requiredValidator,
                          hint: "Date of birth",
                          textController: dobController,
                          prefixIcon: Icons.cake_rounded,
                          isEnabled: false,
                        ),
                      ),
                      SizedBox(
                        height: 35 * heightScale,
                      ),
                      MainButton(
                        title: "Sign up and let's get started",
                        onPress: () {
                          if (formKey.currentState!.validate()) {
                            Customdialog.showDialogBox(context);
                            AuthUtils().registerUser(
                                userController.text,
                                emailController.text,
                                pwdController.text,
                                _image!,
                                "Male",
                                dobController.text,
                                context);
                          }
//                               Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) =>  SignUpNextScreen()), (route) => false);
                        },
                      )
                    ],
                  ),
                )),
              ],
            ),
            // social login container
            Container(
              padding: EdgeInsets.only(
                  top: 25 * heightScale, bottom: 32 * heightScale),
              decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(20 * widthScale),
                      topLeft: Radius.circular(20 * widthScale))),
              child: Column(
                children: [
                  const TitleText(title: 'Sign up with social accounts:'),
                  SizedBox(
                    height: 25 * heightScale,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SocialLoginButton(
                        onTap: () async {
                          await AuthUtils().signInWithGoogle();
                          AuthUtils().socialLoginUser(context);
                          // Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => SignUpNextScreen()), (route) => false);
                        },
                        type: SocialBtnType.google,
                      ),
                      SizedBox(
                        width: 10 * widthScale,
                      ),
                      SocialLoginButton(
                        onTap: () async {
                          await AuthUtils().signInWithFacebook();
                          AuthUtils().socialLoginUser(context);
                        },
                        type: SocialBtnType.facebook,
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  onDobTap(BuildContext context) {
    DatePicker.showDatePicker(context,
        showTitleActions: true,
        theme: DatePickerTheme(
          backgroundColor: Theme.of(context).primaryColor,
          itemStyle: TextStyle(color: Theme.of(context).iconTheme.color),
          cancelStyle: TextStyle(
              color: Theme.of(context).iconTheme.color!.withOpacity(0.5)),
          doneStyle: const TextStyle(color: kTeal),
        ),
        minTime: DateTime(1900, 3, 5),
        maxTime: DateTime.now(), onChanged: (date) {
      dobController.text = date.toString();
    }, onConfirm: (date) {
      dobController.text = date.toString();
    }, currentTime: DateTime.now(), locale: LocaleType.en);
  }

  // void registerUser() async {
  //   setState(() {
  //     _isLoading = true;
  //   });
  //   String res = await AuthUtils().signUpUser(
  //       reward: 0,
  //       email: emailController.text,
  //       status: "online",
  //       searchName: searchName(userController.text),
  //       dateofbirth: dobController.text,
  //       pass: pwdController.text,
  //       username: userController.text,
  //       file: _image!);
  //   print(res);
  //   setState(() {
  //     _isLoading = false;
  //   });
  //   if (res != 'sucess') {
  //     Customdialog.showInSnackBar(res, context);
  //   } else {
  //     Navigator.pushAndRemoveUntil(context,
  //         MaterialPageRoute(builder: (_) => BottomNavBar()), (route) => false);
  //   }
  // }

  selectImage() async {
    Uint8List ui = await pickImage(ImageSource.gallery);
    setState(() {
      _image = ui;
    });
  }

  //Search user
  //Search Users
  searchName(String name) {
    List<String> caseSearchList = [];
    String temp = "";
    for (int i = 0; i < name.length; i++) {
      temp = temp + name[i].toLowerCase();
      caseSearchList.add(temp);
    }
    return caseSearchList;
  }
}
