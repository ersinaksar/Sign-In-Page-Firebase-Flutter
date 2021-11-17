import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:sign_in_page_firebase/model/user.dart';
import 'package:sign_in_page_firebase/services/auth_base.dart';

class FakeAuthenticationService implements AuthBase {
  String userID = "12123123131231321312312";
  final Firestore _firestore = Firestore.instance;

  @override
  Future<User> currentUser() async {
    return await Future.value(User(
        firstname: userID,
        lastname:
            "fakeuser@fake.com")); //future uzun sürecek işlem bu uzun sürecek işlemden sonra oluşacak değer de bu => User(userID: userID)
  }

  @override
  Future<bool> signOut() {
    return Future.value(true);
  }

  @override
  Future<User> signInAnonymously() async {
    return await Future.delayed(Duration(seconds: 2),
        () => User(firstname: userID, lastname: "fakeuser@fake.com"));
  }

  @override
  Future<User> signInWithGoogle() async {
    return await Future.delayed(
        Duration(seconds: 2),
        () => User(
            firstname: "google_user_id_213213", lastname: "fakeuser@fake.com"));
  }

  @override
  Future<User> createUserWithFirstansLastName(
      String firstname, String lastname) async {
    _addData();

    return await Future.delayed(Duration(seconds: 2),
        () => User(firstname: firstname, lastname: lastname));
  }

  void _addData() {
    Map<String, dynamic> addUser = Map();
    addUser["name"] = "ersin";
    addUser["surname"] = "aksar";
    _firestore
        .collection("users")
        .document("ersin_aksar")
        .setData(addUser)
        .then((value) => debugPrint("user added"));
  }

  @override
  Future<User> signInWithEmailandPassword(String email, String sifre) async {
    return await Future.delayed(
        Duration(seconds: 2),
        () => User(
            firstname: "signIn_user_id_213213", lastname: "fakeuser@fake.com"));
  }
}
