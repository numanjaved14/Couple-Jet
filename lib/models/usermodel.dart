import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String id;
  String Email;
  String UserName;
  String imageLink;
  String DOB;
  int reward;
  String status;
  String searchName;
  String gender;

  UserModel(
      {required this.id,
      required this.Email,
      required this.imageLink,
      required this.DOB,
      required this.reward,
      required this.gender,
      required this.searchName,
      required this.status,
      required this.UserName});

  ///Converting OBject into Json Object
  Map<String, dynamic> toJson() => {
        'UserName': UserName,
        'Email': Email,
        'imageLink': imageLink,
        'DOB': DOB,
        'reward': reward,
        'gender': gender,
        'searchName': searchName,
        'id': id,
        'status': status
      };

  ///
  static UserModel fromSnap(DocumentSnapshot snaps) {
    var snapshot = snaps.data() as Map<String, dynamic>;

    return UserModel(
      UserName: snapshot['UserName'],
      Email: snapshot['Email'],
      imageLink: snapshot['imageLink'],
      DOB: snapshot['DOB'],
      reward: snapshot['reward'],
      gender: snapshot['gender'],
      searchName: snapshot['searchName'],
      id: snapshot['id'],
      status: snapshot['status'],
    );
  }
}
