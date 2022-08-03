import 'dart:typed_data';

import 'package:couple_jet/ui/reusable/card_container.dart';
import 'package:couple_jet/ui/reusable/main_button.dart';
import 'package:couple_jet/ui/reusable/main_text_field.dart';
import 'package:couple_jet/ui/reusable/social_login_button.dart';
import 'package:couple_jet/ui/reusable/title_text.dart';
import 'package:couple_jet/ui/reusable/top_app_bar.dart';
import 'package:couple_jet/utils/authutils.dart';
import 'package:couple_jet/utils/colors.dart';
import 'package:couple_jet/utils/constant.dart';
import 'package:couple_jet/utils/customdialog.dart';
import 'package:couple_jet/utils/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

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

  var gender = ['Male', 'Female', 'Trans'];

  String dropdownvalue = 'Male';

  int age = 0;

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
                              ),
                            ),
                          ),
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
                      Container(
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black)),
                        margin: EdgeInsets.only(left: 20, right: 20),
                        child: Padding(
                          padding: const EdgeInsets.all(3.0),
                          child: DropdownButtonFormField<String>(
                            isExpanded: true,
                            value: dropdownvalue,
                            items: gender.map((String items) {
                              return DropdownMenuItem(
                                value: items,
                                child: Text(items),
                              );
                            }).toList(),
                            onChanged: (value) {
                              setState(() {
                                value = dropdownvalue;
                              });
                            },
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 35 * heightScale,
                      ),
                      MainButton(
                        title: "Sign up and let's get started",
                        onPress: age <= 16
                            ? () {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                        'Your age must be more than 16 years to sign up!'),
                                    duration: Duration(
                                      seconds: 4,
                                    ),
                                  ),
                                );
                              }
                            : () {
                                if (formKey.currentState!.validate() &&
                                    pwdController.text ==
                                        rePwdController.text &&
                                    emailController.text.isNotEmpty) {
                                  Customdialog.showDialogBox(context);
                                  AuthUtils().registerUser(
                                    context: context,
                                    dateOfBirth: dobController.text,
                                    email: emailController.text,
                                    file: _image!,
                                    gender: dropdownvalue,
                                    name: userController.text,
                                    password: pwdController.text,
                                    age: age,
                                  );
                                }
                              },
                      ),
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
      calculateAge(date);
      dobController.text = DateFormat.yMd().format(date);
    }, onConfirm: (date) {
      dobController.text = DateFormat.yMd().format(date);
    }, currentTime: DateTime.now(), locale: LocaleType.en);
  }

  calculateAge(DateTime birthDate) {
    DateTime currentDate = DateTime.now();
    age = currentDate.year - birthDate.year;
    int month1 = currentDate.month;
    int month2 = birthDate.month;
    if (month2 > month1) {
      age--;
    } else if (month1 == month2) {
      int day1 = currentDate.day;
      int day2 = birthDate.day;
      if (day2 > day1) {
        age--;
      }
    }
    setState(() {
      age;
    });
    debugPrint("....................." + age.toString());
    return age;
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
