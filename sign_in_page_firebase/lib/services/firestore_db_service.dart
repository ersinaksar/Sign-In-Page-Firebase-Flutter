import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:sign_in_page_firebase/model/user.dart';
import 'package:sign_in_page_firebase/services/database_base.dart';

//implemen ederek bu somut sınıfı soyut sınıftan türettik
class FireStoreDBService implements DBBase {
  final Firestore _firebaseDB = Firestore.instance;

  @override
  Future<bool> saveUser(User user) async {
    DocumentSnapshot _okunanUser =
        await Firestore.instance.document("users/${user.firstname}").get();

    if (_okunanUser.data == null) {
      await _firebaseDB
          .collection("users")
          .document(user.firstname)
          .setData(user.toMap());
      return true;
    } else {
      return true;
    }

  }


  Future<bool> addData(String name) async {
    Map<String, dynamic> userData = Map();
    userData["userName"] = name;
    print("addData");
    await _firebaseDB
        .collection("users")
        .document("data")
        .setData(userData)
        .then((v) => debugPrint("userdata eklendi "));
    return true;
  }








}
