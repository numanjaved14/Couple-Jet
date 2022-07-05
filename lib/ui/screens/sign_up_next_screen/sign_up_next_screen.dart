import 'dart:io';
import 'package:couple_jet/utils/constant.dart';
import 'package:couple_jet/utils/customdialog.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:couple_jet/ui/reusable/card_container.dart';
import 'package:couple_jet/ui/reusable/main_button.dart';
import 'package:couple_jet/ui/reusable/title_text.dart';
import 'package:couple_jet/ui/reusable/top_app_bar.dart';
import 'package:couple_jet/ui/screens/bottom_nav_bar/bottom_nav_bar.dart';
import 'package:couple_jet/utils/colors.dart';
import 'package:couple_jet/utils/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';

class SignUpNextScreen extends StatefulWidget {

  SignUpNextScreen({Key? key}) : super(key: key);

  @override
  State<SignUpNextScreen> createState() => _SignUpNextScreenState();
}

class _SignUpNextScreenState extends State<SignUpNextScreen> {
  File? imageUrl;

  String? imageLink;

  final ImagePicker _picker = ImagePicker();

  void addImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      imageUrl = File(image!.path);
    });
  }

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
                title: 'Sign up',
              ),
              // email pwd container
              CardContainer(
                  child: Column(
                    children: [
                      const TitleText(title: "Welcome!"),
                      SizedBox(height: 15*heightScale,),
                      Text(
                        "Let's setup your profile! First you need anice profile pic - let's go!",
                        textAlign: TextAlign.center,
                        style: kNormalGreyText(context),),
                  SizedBox(height: 56*heightScale,),
                  Container(
                    width: 150*widthScale,
                    height: 150*widthScale,
                    decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.centerLeft,
                          end: Alignment.bottomRight,
                          stops: [0.0, 1.0],
                          colors: [
                            kBlue,
                            kTeal,
                          ],
                        ),
                        shape: BoxShape.circle,
                      boxShadow: [BoxShadow(color: Colors.black12, offset: Offset(0, 4), blurRadius: 12.0)],
                    ),
                    child: InkWell(
                      onTap: addImage,
                      child:imageUrl==null? Container(
                        margin: EdgeInsets.all(12*widthScale),
                        decoration: BoxDecoration(
                            color: Theme.of(context).scaffoldBackgroundColor,
                            shape: BoxShape.circle
                        ),
                        child: Icon(Icons.add_photo_alternate_rounded,size: 35*widthScale,)
                        ,
                      ):Container(
                        margin: EdgeInsets.all(12*widthScale),
                        decoration: BoxDecoration(
                            color: Theme.of(context).scaffoldBackgroundColor,
                            shape: BoxShape.circle
                       ,image: DecorationImage(image: FileImage(imageUrl!),fit: BoxFit.fill)
                        ),
                      ),
                    ),
                  ),
                      SizedBox(height: 64*heightScale,),
                    ],
                  )
              ),
            ],
          ),
          // social login container
          Container(
            padding: EdgeInsets.only(top: 24*heightScale,bottom: 24*heightScale,left: 42*widthScale,right: 42*widthScale),
            decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.only(topRight: Radius.circular(20*widthScale),topLeft: Radius.circular(20*widthScale))
            ),
            child: MainButton(
              title: "Next step",
              onPress: (){

                if(imageUrl==null){
               Customdialog().showInSnackBar("Please select image", context);
             }
             else{
               Customdialog.showDialogBox(context);
               uploadImageToFirebase().then((value) {
                 Customdialog.closeDialog(context);
            firebaseFirestore.collection("users").doc(firebaseAuth.currentUser!.uid).update({
              "imageLink":imageLink
            }).whenComplete(() {

Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_)=>BottomNavBar()), (route) => false);
            });
               });
             }
                },
            ),
          )
        ],
      ),
    );
  }
  Future uploadImageToFirebase() async {
    File? fileName = imageUrl;
    var uuid = Uuid();
    firebase_storage.Reference firebaseStorageRef = firebase_storage
        .FirebaseStorage.instance
        .ref()
        .child('profile/images+${uuid.v4()}');
    firebase_storage.UploadTask uploadTask =
    firebaseStorageRef.putFile(fileName!);
    firebase_storage.TaskSnapshot taskSnapshot =
    await uploadTask.whenComplete(() async {
      print(fileName);
      String img = await uploadTask.snapshot.ref.getDownloadURL();
      setState(() {
        imageLink = img;
      });
    });
  }
}
