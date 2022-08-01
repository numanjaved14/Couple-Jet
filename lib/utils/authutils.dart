import 'dart:typed_data';

import 'package:couple_jet/models/usermodel.dart';
import 'package:couple_jet/utils/storage_methods.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../ui/screens/bottom_nav_bar/bottom_nav_bar.dart';
import 'constant.dart';
import 'constants.dart';
import 'customdialog.dart';
import 'package:flutter/material.dart';

class AuthUtils {
  Future<UserCredential> signInWithGoogle() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    final GoogleSignInAuthentication googleAuth =
        await googleUser!.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  Future<UserCredential> facbookLogin() async {
    final LoginResult result = await FacebookAuth.instance.login();
    final AuthCredential facebookCredential =
        FacebookAuthProvider.credential(result.accessToken!.token);
    return await FirebaseAuth.instance.signInWithCredential(facebookCredential);
  }

  socialLoginUser(BuildContext context) async {
    String userName = firebaseAuth.currentUser!.displayName.toString();
    String email = firebaseAuth.currentUser!.email.toString();
    String dob = "";
    String gender = "";
    String phoneNumber = firebaseAuth.currentUser!.phoneNumber.toString();
    String imageLink = firebaseAuth.currentUser!.photoURL.toString();
    try {
      await firebaseFirestore
          .collection('users')
          .doc(firebaseAuth.currentUser!.uid)
          .set({
        "id": firebaseAuth.currentUser!.uid,
        'UserName': userName,
        'Email': email,
        "DOB": dob,
        "imageLink": imageLink,
        "searchName": searchName(userName),
        "status": "offline",
        "reward": 0,
        // 'Password':password
      }).then((value) {
        Customdialog.showInSnackBar("Logged in", context);
        // Provider.of<CircularProgressProvider>(context,listen: false).setValue(false);
        Customdialog.closeDialog(context);
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (_) => BottomNavBar()),
            (route) => false);
      });
    } on FirebaseAuthException catch (e) {
      Navigator.pop(context);
      Customdialog.showBox(context, e.toString());
    }
  }

  Future<UserCredential?> signInWithFacebook() async {
    try {
      final AccessToken accessToken =
          (await FacebookAuth.instance.login()) as AccessToken;

      // Create a credential from the access token
      final OAuthCredential credential = FacebookAuthProvider.credential(
        accessToken.token,
      );
      // Once signed in, return the UserCredential
      return await FirebaseAuth.instance.signInWithCredential(credential);
    } catch (e) {
      // handle the FacebookAuthException
    } on FirebaseAuthException catch (e) {
      // handle the FirebaseAuthException
    } finally {}
    return null;
  }

  registerUser(
    String name,
    String email,
    String password,
    Uint8List file,
    String dateOfBirth,
    BuildContext context,
  ) async {
    try {
      await firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) async {
        String imageLink = await StorageMethods()
            .uploadImageToStorage('ProfilePics', file, false);

        firebaseFirestore
            .collection('users')
            .doc(firebaseAuth.currentUser!.uid)
            .set({
          "id": firebaseAuth.currentUser!.uid,
          'UserName': name,
          'Email': email,
          "DOB": dateOfBirth,
          // "Phone Number":phoneNumber,
          "imageLink": imageLink,
          "searchName": searchName(name),
          "status": "offline",
          "reward": 0
          // 'Password':password
        }).whenComplete(() {
          // Customdialog.closeDialog(context);
          Navigator.of(context).pop();
          print(
              "--------------------------------------------------------------------------------------------------------");
          print(
              "------------------------------------------------------------------------");

          print(
              "--------------------------------------------------------------------------------------------------------");
          print(
              "------------------------------------------------------------------------");

          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => BottomNavBar()),
              (route) => false);
        });
      }).catchError((onError) {
        throw onError;
      });
    } on FirebaseAuthException catch (e) {
      Navigator.pop(context);

      Customdialog.showBox(context, e.toString());
    }
  }

  Future<String> loginUpUser({
    required String email,
    required String pass,
  }) async {
    String res = 'Some error occured';
    try {
      if (email.isNotEmpty || pass.isNotEmpty) {
        await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: email, password: pass);

        res = 'sucess';
      }
    } on FirebaseException catch (e) {
      if (e == 'WrongEmail') {
        print(e.message);
      }
      if (e == 'WrongPassword') {
        print(e.message);
      }
    } catch (e) {
      res = e.toString();
    }
    return res;
  }

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
//Search User

//Register
  // Future<String> signUpUser({
  //   required String email,
  //   required String pass,
  //   required String dateofbirth,
  //   required String username,
  //   required String status,
  //   required final searchName,
  //   String? gender,
  //   required int reward,
  //   required Uint8List file,
  // }) async {
  //   String res = 'Some error occured';
  //   try {
  //     if (email.isNotEmpty ||
  //         pass.isNotEmpty ||
  //         dateofbirth.isNotEmpty ||
  //         username.isNotEmpty) {
  //       UserCredential cred = await FirebaseAuth.instance
  //           .createUserWithEmailAndPassword(email: email, password: pass);
  //       String imageLink = await StorageMethods()
  //           .uploadImageToStorage('ProfilePics', file, false);
  //       //Add User to the database with modal
  //       UserModel userModel = UserModel(
  //           UserName: username,
  //           id: cred.user!.uid,
  //           Email: email,
  //           imageLink: imageLink,
  //           status: "online",
  //           DOB: dateofbirth,
  //           gender: gender!,
  //           reward: reward,
  //           searchName: searchName);
  //       await firebaseFirestore
  //           .collection('users')
  //           .doc(cred.user!.uid)
  //           .set(userModel.toJson());
  //       res = 'sucess';
  //     }
  //   } catch (e) {
  //     res = e.toString();
  //   }
  //   return res;
  // }
}
