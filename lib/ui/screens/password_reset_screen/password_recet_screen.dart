import 'package:couple_jet/ui/reusable/card_container.dart';
import 'package:couple_jet/ui/reusable/main_button.dart';
import 'package:couple_jet/ui/reusable/main_text_field.dart';
import 'package:couple_jet/ui/reusable/title_text.dart';
import 'package:couple_jet/ui/reusable/top_app_bar.dart';
import 'package:couple_jet/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

class PasswordResetScreen extends StatelessWidget {

  PasswordResetScreen({Key? key}) : super(key: key);

  final TextEditingController emailController = TextEditingController();
  final TextEditingController dobController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final double widthScale = MediaQuery.of(context).size.width / 414;
    final double heightScale = MediaQuery.of(context).size.height / 896;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          // app bar
          TopAppBar(
            onBackPress: (){
              Navigator.pop(context);
            },
            title: 'Password-reset',
          ),
          // email dob container
          CardContainer(
              child: Column(
                children: [
                  const TitleText(title: "Shit happens..."),
                  SizedBox(height: 15*heightScale,),
                  CustomTextField(
                      hint: "E-Mail Address",
                      textController: emailController,
                      prefixIcon: Icons.alternate_email_rounded
                  ),
                  SizedBox(height: 21*heightScale,),
                  GestureDetector(
                    onTap: (){onDobTap(context);},
                    child: CustomTextField(
                      hint: "Date of birth",
                      textController: dobController,
                      prefixIcon: Icons.cake_rounded,
                      isEnabled: false,
                    ),
                  ),
                  SizedBox(height: 35*heightScale,),
                  MainButton(
                    title: "Send reset-link",
                    onPress: (){},
                  )
                ],
              )
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
