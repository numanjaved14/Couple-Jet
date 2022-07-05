import 'package:couple_jet/ui/reusable/card_container.dart';
import 'package:couple_jet/ui/reusable/main_button.dart';
import 'package:couple_jet/ui/reusable/title_text.dart';
import 'package:couple_jet/ui/reusable/top_app_bar.dart';
import 'package:couple_jet/ui/screens/my_profile_screen/widgets/gender_card.dart';
import 'package:couple_jet/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'widgets/slider_theme.dart';
import 'widgets/sub_text.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool distanceStatus = false;
  bool interestStatus = false;
  bool gendersStatus = false;
  bool notificationStatus = false;

  double sliderVal = 20.0;

  bool isMale = true;
  bool isFemale = false;
  bool isTrans = false;

  @override
  Widget build(BuildContext context) {
    final double widthScale = MediaQuery.of(context).size.width / 414;
    final double heightScale = MediaQuery.of(context).size.height / 896;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Column(children: [
        // app bar
        TopAppBar(
          onBackPress: () {
            Navigator.pop(context);
          },
          title: 'Settings',
        ),
        // email pwd container
        Expanded(child:SingleChildScrollView(
          child: Column(
            children: [
              CardContainer(
                paddingVertical: 22,
                paddingHorizontal: 22,
                child: Column(children: [
                  TitleText(title: 'Filter'),
                  SizedBox(
                    height: 18 * heightScale,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SubText(text: 'Distance'),
                      SubText(text: '75km'),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 4*heightScale),
                    child: SliderTheme(
                      data: SliderThemeData(
                          trackShape: GradientRectSliderTrackShape(darkenInactive: false),
                          inactiveTrackColor: Color.fromRGBO(240, 241, 245, 1),
                          activeTrackColor: Color.fromRGBO(240, 241, 245, 1),
                          overlayShape: SliderComponentShape.noOverlay,
                          thumbColor: kTeal,
                      ),
                      child: Slider(
                        onChanged: (val) {
                          setState(() {
                            sliderVal = val;
                          });
                        },
                        value: sliderVal,
                        max: 100,
                        min: 0,
                        inactiveColor: Color.fromRGBO(240, 241, 245, 1),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SubText(text: '5km'),
                      SubText(text: '150km'),
                    ],
                  ),
                  SizedBox(height: 25*heightScale,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SubText(text: 'Filter by ditance'),
                      Row(
                        children: [
                          SubText(text: 'Disabled'),
                          SizedBox(
                            height: 12*widthScale,
                            width: 45*widthScale,
                            child: Switch(
                                value: distanceStatus,
                                activeThumbImage: AssetImage('images/icons/switch_thumb.png'),
                                inactiveThumbImage: AssetImage('images/icons/switch_thumb.png'),
                                inactiveTrackColor: Color.fromRGBO(240, 241, 245, 1),
                                activeTrackColor: Color.fromRGBO(240, 241, 245, 1),
                                onChanged: (val) {
                                  setState(() {
                                    distanceStatus = val;
                                  });
                                }),
                          ),
                        ],
                      )
                    ],
                  ),
                  SizedBox(height: 20*heightScale,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SubText(text: 'Filter by interests'),
                      Row(
                        children: [
                          SubText(text: 'Disabled'),
                          SizedBox(
                            height: 12*widthScale,
                            width: 45*widthScale,
                            child: Switch(
                                value: interestStatus,
                                activeThumbImage: AssetImage('images/icons/switch_thumb.png'),
                                inactiveThumbImage: AssetImage('images/icons/switch_thumb.png'),
                                inactiveTrackColor: Color.fromRGBO(240, 241, 245, 1),
                                activeTrackColor: Color.fromRGBO(240, 241, 245, 1),
                                onChanged: (val) {
                                  setState(() {
                                    interestStatus = val;
                                  });
                                }),
                          ),
                        ],
                      )
                    ],
                  ),
                  SizedBox(height: 2*heightScale,),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Only people with min. one shared interest are shown',
                      style: GoogleFonts.outfit(fontSize: 12 * widthScale,),
                    ),
                  ),
                  SizedBox(height: 24*heightScale,),
                  Align( alignment: Alignment.centerLeft,child: SubText(text: 'Show following gender:')),
                  SizedBox(height: 8*heightScale,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GenderCard(
                        gender: 'Male',
                        icon: Icons.male_rounded,
                        isSelected: isMale,
                        onTap: () {
                          setState(() {
                            isMale = true;
                            isTrans = false;
                            isFemale = false;
                          });
                        },
                      ),
                      SizedBox(
                        width: 15 * widthScale,
                      ),
                      GenderCard(
                        gender: 'Female',
                        icon: Icons.female_rounded,
                        isSelected: isFemale,
                        onTap: () {
                          setState(() {
                            isFemale = true;
                            isTrans = false;
                            isMale = false;
                          });
                        },
                      ),
                      SizedBox(
                        width: 15 * widthScale,
                      ),
                      GenderCard(
                        gender: 'Trans',
                        icon: Icons.transgender_rounded,
                        isSelected: isTrans,
                        onTap: () {
                          print('called');
                          setState(() {
                            isTrans = true;
                            isMale = false;
                            isFemale = false;
                          });
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: 18*heightScale,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SubText(text: 'Show myself to those genders only'),
                      Row(
                        children: [
                          SubText(text: 'True'),
                          SizedBox(
                            height: 12*widthScale,
                            width: 45*widthScale,
                            child: Switch(
                                value: gendersStatus,
                                activeThumbImage: AssetImage('images/icons/switch_thumb.png'),
                                inactiveThumbImage: AssetImage('images/icons/switch_thumb.png'),
                                inactiveTrackColor: Color.fromRGBO(240, 241, 245, 1),
                                activeTrackColor: Color.fromRGBO(240, 241, 245, 1),
                                onChanged: (val) {
                                  setState(() {
                                    gendersStatus = val;
                                  });
                                }),
                          ),
                        ],
                      )
                    ],
                  ),
                  SizedBox(
                    height: 24 * heightScale,
                  ),
                  MainButton(title: 'Save', onPress: () {})
                ]),
              ),
              CardContainer(
                  paddingVertical: 22,
                  paddingHorizontal: 22,
                  marginVertical: 0,
                  child: Column(children: [
                    TitleText(title: 'Filter'),
                    SizedBox(
                      height: 4 * heightScale,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SubText(text: 'Push-Notifications'),
                        Row(
                          children: [
                            SubText(text: 'Enabled'),
                            SizedBox(
                              height: 12*widthScale,
                              width: 45*widthScale,
                              child: Switch(
                                  value: notificationStatus,
                                  activeThumbImage: AssetImage('images/icons/switch_thumb.png'),
                                  inactiveThumbImage: AssetImage('images/icons/switch_thumb.png'),
                                  inactiveTrackColor: Color.fromRGBO(240, 241, 245, 1),
                                  activeTrackColor: Color.fromRGBO(240, 241, 245, 1),
                                  onChanged: (val) {
                                    setState(() {
                                      notificationStatus = val;
                                    });
                                  }),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 22*heightScale,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SubText(text: 'FAQ & Suppport'),
                        Icon(Icons.arrow_forward_rounded),
                      ],
                    ),
                    SizedBox(height: 22*heightScale,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SubText(text: 'Privacy Policies'),
                        Icon(Icons.arrow_forward_rounded),
                      ],
                    ),
                    SizedBox(height: 22*heightScale,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SubText(text: 'Terms and conditions'),
                        Icon(Icons.arrow_forward_rounded),
                      ],
                    ),
                    SizedBox(height: 24*heightScale,),
                    Text(
                      'Delete account',
                      style: GoogleFonts.outfit(fontSize: 12 * widthScale,color: Colors.red),
                    )
                  ])),
              SizedBox(height: 22*heightScale,),
            ],
          ),
        )
        )]),
    );
  }
}
