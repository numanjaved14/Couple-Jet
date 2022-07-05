import 'package:couple_jet/ui/reusable/card_container.dart';
import 'package:couple_jet/ui/reusable/dotted_container.dart';
import 'package:couple_jet/ui/reusable/gradient_round_button.dart';
import 'package:couple_jet/ui/reusable/main_button.dart';
import 'package:couple_jet/ui/reusable/main_text_field.dart';
import 'package:couple_jet/ui/reusable/title_text.dart';
import 'package:couple_jet/ui/reusable/top_app_bar.dart';
import 'package:couple_jet/ui/screens/my_profile_screen/widgets/gender_card.dart';
import 'package:couple_jet/ui/screens/my_profile_screen/widgets/interest_item.dart';
import 'package:couple_jet/ui/reusable/picture_container.dart';
import 'package:couple_jet/utils/colors.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:google_fonts/google_fonts.dart';

class MyProfileScreen extends StatefulWidget {
  const MyProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<MyProfileScreen> {

  final TextEditingController emailController = TextEditingController();
  final TextEditingController pwdController = TextEditingController();
  final TextEditingController dobController = TextEditingController();

  bool isMale = true;
  bool isFemale = false;
  bool isTrans = false;
  
  List<Interest> interests = [
    Interest('Travelling','images/icons/travel.png',true),
    Interest('Netflix','images/icons/netflix.png',true),
    Interest('Paint','images/icons/paint.png',false),
  ];

  @override
  Widget build(BuildContext context) {
    final double widthScale = MediaQuery.of(context).size.width / 414;
    final double heightScale = MediaQuery.of(context).size.height / 896;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Column(
        children: [
          // app bar
          TopAppBar(
            onBackPress: (){
              Navigator.pop(context);
            },
            title: 'My Profile',
          ),

          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(left:18.0*widthScale,right: 18*widthScale,top: 20*heightScale,bottom: 5*heightScale),
                    child: Row(
                      children: [
                        PictureContainer(
                          image: 'images/dummy_profile.png',
                          onDelPress: (){},
                        ),
                        PictureContainer(
                          image: 'images/dummy_profile3.png',
                          onDelPress: (){},
                        ),
                        DottedContainer(
                          onPress: (){},
                        )
                      ],
                    ),
                  ),
                  CardContainer(
                      child: Column(
                        children: [
                          TitleText(title: "Yup, that's me:"),
                          SizedBox(height: 18*heightScale,),
                          CustomTextField(
                              hint: "Max Mustermann",
                              textController: emailController,
                              prefixIcon: Icons.person_rounded
                          ),
                          SizedBox(height: 18*heightScale,),
                          CustomTextField(
                            hint: "ZIP-Code",
                            textController: pwdController,
                            prefixIcon: Icons.location_on_rounded,
                          ),
                          SizedBox(height: 18*heightScale,),
                          GestureDetector(
                            onTap: (){onDobTap(context);},
                            child: CustomTextField(
                              hint: "Date of birth",
                              textController: dobController,
                              prefixIcon: Icons.cake_rounded,
                              isEnabled: false,
                            ),
                          ),

                          Padding(
                            padding: EdgeInsets.only(bottom:10*heightScale,top: 17*heightScale),
                            child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text('My gender:',style: GoogleFonts.outfit(fontSize: 15 * widthScale))),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              GenderCard(
                                  gender: 'Male',
                                  icon: Icons.male_rounded,
                                  isSelected: isMale,
                                  onTap: (){
                                    setState(() {
                                      isMale = true;
                                      isTrans = false;
                                      isFemale = false;
                                    });
                                  },
                              ),
                              SizedBox(width: 15*widthScale,),
                              GenderCard(
                                  gender: 'Female',
                                  icon: Icons.female_rounded,
                                  isSelected: isFemale,
                                  onTap: (){
                                    setState(() {
                                      isFemale = true;
                                      isTrans = false;
                                      isMale = false;
                                    });
                                  },
                              ),
                              SizedBox(width: 15*widthScale,),
                              GenderCard(
                                  gender: 'Trans',
                                  icon: Icons.transgender_rounded,
                                  isSelected: isTrans,
                                  onTap: (){
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
                          Padding(
                            padding: EdgeInsets.only(bottom:10*heightScale,top: 21*heightScale),
                            child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text('Interests (max. 10):',style: GoogleFonts.outfit(fontSize: 15 * widthScale))),
                          ),
                          Wrap(
                            crossAxisAlignment: WrapCrossAlignment.center,
                            direction: Axis.horizontal,
                            runSpacing: 10.0 * heightScale,
                            spacing: 12.0 * widthScale,
                            alignment: WrapAlignment.start,
                            children: interests.map((e) => GestureDetector(
                              onTap: (){
                                print('called');
                                setState(() {
                                  e.isSelected = !e.isSelected;
                                });
                              },
                              child: InterestItem(
                                  title: e.title,
                                  icon: e.icon,
                                  isSelected: e.isSelected
                              ),
                            ) ).toList(),
                          ),
                          SizedBox(height: 65*heightScale,),
                          MainButton(
                            title: "Save",
                            onPress: (){Navigator.pop(context);},
                          )
                        ],
                      )
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  onDobTap(BuildContext context){
    DatePicker.showDatePicker(context,
        showTitleActions: true,
        theme: DatePickerTheme(
          backgroundColor: Theme.of(context).primaryColor,
          itemStyle: TextStyle(
              color: Theme.of(context).iconTheme.color
          ),
          cancelStyle: TextStyle(
              color: Theme.of(context).iconTheme.color!.withOpacity(0.5)
          ),
          doneStyle: const TextStyle(
              color: kTeal
          ),
        ),
        minTime: DateTime(2018, 3, 5),
        maxTime: DateTime(2019, 6, 7),
        onChanged: (date) {
          dobController.text = date.toString();
        }, onConfirm: (date) {
          dobController.text = date.toString();
        }, currentTime: DateTime.now(), locale: LocaleType.en);
  }

}
