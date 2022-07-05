
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';

FirebaseAuth firebaseAuth=FirebaseAuth.instance;
FirebaseFirestore firebaseFirestore=FirebaseFirestore.instance;
var BLACK=Colors.black;

RequiredValidator requiredValidator= RequiredValidator(errorText: "Required");
MultiValidator emailValidator=MultiValidator([
    RequiredValidator(errorText: "Required"),
EmailValidator(errorText: "Please enter correct email")
]
);
final passwordValidator = MultiValidator([
  RequiredValidator(errorText: 'Required'),
  MinLengthValidator(8, errorText: 'password must be at least 8 digits long'),
  PatternValidator(r'(?=.*?[#?!@$%^&*-])', errorText: 'passwords must have at least one special character')
]);