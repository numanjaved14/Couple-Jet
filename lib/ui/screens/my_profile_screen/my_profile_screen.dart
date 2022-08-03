import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:couple_jet/ui/reusable/card_container.dart';
import 'package:couple_jet/ui/reusable/dotted_container.dart';
import 'package:couple_jet/ui/reusable/main_button.dart';
import 'package:couple_jet/ui/reusable/main_text_field.dart';
import 'package:couple_jet/ui/reusable/title_text.dart';
import 'package:couple_jet/ui/reusable/top_app_bar.dart';
import 'package:couple_jet/ui/screens/my_profile_screen/widgets/gender_card.dart';
import 'package:couple_jet/ui/screens/my_profile_screen/widgets/interest_item.dart';
import 'package:couple_jet/ui/reusable/picture_container.dart';
import 'package:couple_jet/utils/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:countries_utils/countries_utils.dart';
import 'package:intl/intl.dart';
import 'package:regexed_validator/regexed_validator.dart';

import '../../../utils/authutils.dart';
import '../../../utils/constant.dart';
import '../../../utils/customdialog.dart';

class MyProfileScreen extends StatefulWidget {
  const MyProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<MyProfileScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController zipController = TextEditingController();
  final TextEditingController dobController = TextEditingController();

  bool isMale = false;
  bool isFemale = false;
  bool isTrans = false;

  int age = 0;

  String? gender;

  List<Interest> interests = [
    Interest('Travelling', 'images/icons/travel.png', true),
    Interest('Netflix', 'images/icons/netflix.png', true),
    Interest('Paint', 'images/icons/paint.png', false),
  ];

  final List<Country> countries = Countries.all();

  String? selectedCountry;

  List selectedInterests = [];

  var userData = {};

  bool _isLoading = false;

  @override
  void initState() {
    initMethod();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final double widthScale = MediaQuery.of(context).size.width / 414;
    final double heightScale = MediaQuery.of(context).size.height / 896;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator.adaptive(),
            )
          : Column(
              children: [
                // app bar
                TopAppBar(
                  onBackPress: () {
                    Navigator.pop(context);
                  },
                  title: 'My Profile',
                ),

                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                            left: 18.0 * widthScale,
                            right: 18 * widthScale,
                            top: 20 * heightScale,
                            bottom: 5 * heightScale,
                          ),
                          child: Row(
                            children: [
                              PictureContainer(
                                image: 'images/dummy_profile.png',
                                onDelPress: () {},
                              ),
                              PictureContainer(
                                image: 'images/dummy_profile3.png',
                                onDelPress: () {},
                              ),
                              DottedContainer(
                                onPress: () {},
                              )
                            ],
                          ),
                        ),
                        CardContainer(
                          child: Column(
                            children: [
                              TitleText(title: "Yup, that's me:"),
                              SizedBox(
                                height: 18 * heightScale,
                              ),
                              CustomTextField(
                                  hint: "Max Mustermann",
                                  textController: nameController,
                                  prefixIcon: Icons.person_rounded),
                              SizedBox(
                                height: 18 * heightScale,
                              ),
                              CustomTextField(
                                hint: "ZIP-Code",
                                textController: zipController,
                                prefixIcon: Icons.location_on_rounded,
                              ),
                              SizedBox(
                                height: 18 * heightScale,
                              ),
                              GestureDetector(
                                onTap: () {
                                  onDobTap(context);
                                },
                                child: CustomTextField(
                                  hint: "Date of birth",
                                  textController: dobController,
                                  prefixIcon: Icons.cake_rounded,
                                  isEnabled: false,
                                ),
                              ),
                              SizedBox(
                                height: 18 * heightScale,
                              ),
                              CupertinoPicker(
                                  onSelectedItemChanged: (i) {
                                    countries[i];
                                    selectedCountry = countries[i].name;
                                  },
                                  scrollController: FixedExtentScrollController(
                                      initialItem: 10),
                                  offAxisFraction: .1,
                                  diameterRatio: 1.1,
                                  itemExtent: 50.0,
                                  magnification: 1.4,
                                  squeeze: 1.45,
                                  useMagnifier: true,
                                  looping: true,
                                  children: countries
                                      .map(
                                        (country) => Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            Localizations.localeOf(context)
                                                        .languageCode ==
                                                    "en"
                                                ? '${country.name} ${country.flagIcon}'
                                                : '${country.nativeName}  ${country.flagIcon}',
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyText1,
                                          ),
                                        ),
                                      )
                                      .toList()),
                              Padding(
                                padding: EdgeInsets.only(
                                    bottom: 10 * heightScale,
                                    top: 17 * heightScale),
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    'My gender:',
                                    style: GoogleFonts.outfit(
                                        fontSize: 15 * widthScale),
                                  ),
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  GenderCard(
                                    gender: 'Male',
                                    icon: Icons.male_rounded,
                                    isSelected: isMale,
                                    onTap: () {
                                      setState(() {
                                        gender = 'Male';
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
                                        gender = 'Female';

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
                                        gender = 'Trans';

                                        isTrans = true;
                                        isMale = false;
                                        isFemale = false;
                                      });
                                    },
                                  ),
                                ],
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                    bottom: 10 * heightScale,
                                    top: 21 * heightScale),
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    'Interests (min. 2):',
                                    style: GoogleFonts.outfit(
                                        fontSize: 15 * widthScale),
                                  ),
                                ),
                              ),
                              Wrap(
                                crossAxisAlignment: WrapCrossAlignment.center,
                                direction: Axis.horizontal,
                                runSpacing: 10.0 * heightScale,
                                spacing: 12.0 * widthScale,
                                alignment: WrapAlignment.start,
                                children: interests
                                    .map(
                                      (e) => GestureDetector(
                                        onTap: () {
                                          print('called');
                                          selectedInterests.add(e.title);
                                          setState(() {
                                            e.isSelected = !e.isSelected;
                                          });
                                        },
                                        child: InterestItem(
                                          title: e.title,
                                          icon: e.icon,
                                          isSelected: e.isSelected,
                                        ),
                                      ),
                                    )
                                    .toList(),
                              ),
                              SizedBox(
                                height: 65 * heightScale,
                              ),
                              MainButton(
                                title: "Save",
                                onPress: () {
                                  age <= 16
                                      ? () {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            SnackBar(
                                              content: Text(
                                                  'Your age must be more than 16 years!'),
                                              duration: Duration(
                                                seconds: 4,
                                              ),
                                            ),
                                          );
                                        }
                                      : () {
                                          if (validator.postalCode(
                                                  zipController.text) &&
                                              validator.postalCode(
                                                  zipController.text)) {
                                            Customdialog.showDialogBox(context);
                                            AuthUtils().updateUser(
                                              name: nameController.text,
                                              dateOfBirth: dobController.text,
                                              gender: gender!,
                                              ZIP: zipController.text,
                                              country: selectedCountry!,
                                              interests: interests,
                                              context: context,
                                            );
                                          }
                                        };
                                },
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
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
        minTime: DateTime(2018, 3, 5),
        maxTime: DateTime(2019, 6, 7), onChanged: (date) {
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

  initMethod() async {
    setState(() {
      _isLoading = true;
    });
    try {
      var userSnap = await firebaseFirestore
          .collection('users')
          .doc(firebaseAuth.currentUser!.uid)
          .get();

      userData = userSnap.data()!;

      nameController.text = userData['UserName'];

      dobController.text = userData['DOB'];

      age = userData['age'];

      zipController.text = userData['ZIPcode'];

      userData['gender'] == 'Male'
          ? setState(() {
              isTrans = false;
              isMale = true;
              isFemale = false;
            })
          : userData['gender'] == 'Female'
              ? setState(() {
                  isTrans = false;
                  isMale = false;
                  isFemale = true;
                })
              : setState(() {
                  isTrans = true;
                  isMale = false;
                  isFemale = false;
                });

      gender = userData['gender'];

      setState(() {});
    } catch (e) {
      debugPrint(e.toString());
    }
    setState(() {
      _isLoading = false;
    });
  }
}
