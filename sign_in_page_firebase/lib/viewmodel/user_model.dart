import 'dart:io';

import 'package:flutter/material.dart';
import 'package:sign_in_page_firebase/locator.dart';
import 'package:sign_in_page_firebase/model/user.dart';
import 'package:sign_in_page_firebase/repository/user_repository.dart';
import 'package:sign_in_page_firebase/services/auth_base.dart';

enum ViewState { Idle, Busy }

//isteklerimizi repository e gönderdiğimi yer
class UserModel with ChangeNotifier implements AuthBase {
  ViewState _state = ViewState.Idle;
  UserRepository _userRepository = locator<UserRepository>();
  User _user;
  String nameHataMesaji;
  String surnameHataMesaji;

  String emailHataMesaji;
  String sifreHataMesaji;

  User get user => _user;

  ViewState get state => _state;

  set state(ViewState value) {
    _state = value;
    notifyListeners(); //viewstate i dinliyor oradaki idle yada busy değişirse tekrar gidip arayüze bilgi veriyor build metodunu değiştirmesi için
  }

  //buradan ne zaman bir nesne üretilirse current useri çağırıp acaba kullanıcı var  mı yok mu onun kontrolünü yapabiliyoruz
  UserModel() {}

  @override
  Future<User> signInWithEmailandPassword(String email, String sifre) async {
    try {
      if (_emailSifreKontrol(email, sifre)) {
        state = ViewState.Busy;
        _user = await _userRepository.signInWithEmailandPassword(email, sifre);
        return _user;
      } else
        return null;
    } finally {
      state = ViewState.Idle;
    }
  }

  bool _emailSifreKontrol(String email, String sifre) {
    var sonuc = true;

    if (sifre.length < 6) {
      sifreHataMesaji = "En az 6 karakter olmalı";
      sonuc = false;
    } else
      sifreHataMesaji = null;
    if (!email.contains("@")) {
      emailHataMesaji = "Geçersiz email adresi";
      sonuc = false;
    } else
      emailHataMesaji = null;

    return sonuc;
  }

  @override
  Future<User> createUserWithFirstansLastName(
      String firstname, String lastname) async {
    if (_inputKontrol(firstname, lastname)) {
      try {
        state = ViewState.Busy;
        _user = await _userRepository.createUserWithFirstansLastName(
            firstname, lastname);

        return _user;
      } finally {
        state = ViewState.Idle;
      }
    } else
      return null;
  }

  bool _inputKontrol(String firstname, String lastname) {
    var sonuc = true;
    var name = validateStructure(firstname);
    var surname = validateStructure(lastname);
    if (name == false) {
      surnameHataMesaji = "latin characters ONLY (lowercase and uppercase)";
      sonuc = false;
    } else if (surname == false) {
      surnameHataMesaji = "latin characters ONLY (lowercase and uppercase)";
      sonuc = false;
    } else {
      sonuc = true;
    }
    return sonuc;
  }

  bool validateStructure(String value) {
    String pattern1 = r'^(?=.*?[!@#\$&*~]).{8,}$';
    String pattern2 = r'^(?=.*?[0-9])';
    //String pattern3 = r'^(?=.*?[!@#\$&*~]).{8,}$';
    RegExp regExp1 = new RegExp(pattern1);
    RegExp regExp2 = new RegExp(pattern2);
    if (regExp1.hasMatch(value) == true) {
      return false;
    } else if (regExp2.hasMatch(value) == true) {
      return false;
    } else {
      return true;
    }
    //return regExp.hasMatch(value);
  }
}
