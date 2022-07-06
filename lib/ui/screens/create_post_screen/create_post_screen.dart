import 'dart:typed_data';

import 'package:couple_jet/ui/reusable/card_container.dart';
import 'package:couple_jet/ui/reusable/dotted_container.dart';
import 'package:couple_jet/ui/reusable/main_button.dart';
import 'package:couple_jet/ui/reusable/title_text.dart';
import 'package:couple_jet/ui/reusable/top_app_bar.dart';
import 'package:couple_jet/utils/colors.dart';
import 'package:couple_jet/utils/firestore_methods.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

import '../../../utils/image_picker.dart';
import '../bottom_nav_bar/bottom_nav_bar.dart';

class CreatePostScreen extends StatefulWidget {
  String userName, profImage;
  CreatePostScreen({
    Key? key,
    this.userName = "",
    this.profImage = "",
  }) : super(key: key);

  @override
  State<CreatePostScreen> createState() => _CreatePostScreenState();
}

class _CreatePostScreenState extends State<CreatePostScreen> {
  bool _isLoading = false;
  final ImagePicker imagePicker = ImagePicker();
  List<XFile>? imageFileList = [];
  Uint8List? _file;
  TextEditingController _desController = TextEditingController();

  void selectImages() async {
    final List<XFile>? selectedImages = await imagePicker.pickMultiImage();
    if (selectedImages!.isNotEmpty) {
      imageFileList!.addAll(selectedImages);
    }
    print("Image List Length:" + imageFileList!.length.toString());
    setState(() {});
  }

  @override
  void dispose() {
    _desController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double widthScale = MediaQuery.of(context).size.width / 414;
    final double heightScale = MediaQuery.of(context).size.height / 896;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: _isLoading
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircularProgressIndicator.adaptive(),
                Center(
                  child: Text(
                    'Posting',
                    style: GoogleFonts.outfit(
                        fontSize: 15 * widthScale, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            )
          : Column(children: [
              // app bar
              TopAppBar(
                onBackPress: () {
                  Navigator.pop(context);
                },
                title: 'Create post',
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: SizedBox(
                  height: 100,
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: _file == null ? 0 : 1,
                      // itemCount: imageFileList!.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                          margin: EdgeInsets.all(5),
                          height: MediaQuery.of(context).size.height * 0.3,
                          width: MediaQuery.of(context).size.width * 0.2,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Image.memory(_file!),
                            // child: Image.file(
                            //   File(imageFileList![index].path),
                            //   fit: BoxFit.cover,
                            // ),
                          ),
                        );
                      }),
                ),
              ),
              DottedContainer(
                onPress: () async {
                  Uint8List file = await pickImage(ImageSource.gallery);
                  setState(() {
                    _file = file;
                  });
                },
              ),
              // Padding(
              //   padding: EdgeInsets.only(
              //       left: 18.0 * widthScale,
              //       right: 18 * widthScale,
              //       top: 20 * heightScale,
              //       bottom: 5 * heightScale),
              //   child: Row(
              //     children: [

              //     ],
              //   ),
              // ),
              // email pwd container
              CardContainer(
                paddingVertical: 22,
                paddingHorizontal: 22,
                child: Column(children: [
                  TitleText(title: 'Tell your story...'),
                  SizedBox(
                    height: 18 * heightScale,
                  ),
                  Container(
                    padding: EdgeInsets.all(4),
                    decoration: BoxDecoration(
                        color: Theme.of(context).scaffoldBackgroundColor,
                        borderRadius:
                            BorderRadius.all(Radius.circular(10 * widthScale))),
                    child: TextField(
                      controller: _desController,
                      cursorColor: kTeal,
                      style: GoogleFonts.outfit(fontSize: 14 * widthScale),
                      maxLines: 6,
                      decoration: InputDecoration(border: InputBorder.none),
                    ),
                  ),
                  SizedBox(
                    height: 27 * heightScale,
                  ),
                  MainButton(
                    title: 'Post it! (- 1.000 diamonds)',
                    onPress: () async {
                      setState(() {
                        _isLoading = true;
                      });
                      debugPrint('...............');
                      String res = await FireStoreMethods().uploadPost(
                        description: _desController.text,
                        file: _file!,
                        uid: FirebaseAuth.instance.currentUser!.uid,
                        profImage: widget.profImage,
                        username: widget.userName,
                      );
                      if (res == 'success') {
                        setState(() {
                          _isLoading = false;
                        });
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) => BottomNavBar(),
                        ));
                      } else {
                        setState(() {
                          _isLoading = false;
                        });
                        Navigator.of(context).pop();
                        const snackBar = SnackBar(
                          content: Text('Some Error occured!'),
                          duration: Duration(seconds: 5),
                        );
                        Scaffold.of(context).showSnackBar(snackBar);
                      }
                    },
                  ),
                ]),
              ),
            ]),
    );
  }
}
