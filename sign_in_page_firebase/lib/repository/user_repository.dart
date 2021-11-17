import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:sign_in_page_firebase/locator.dart';
import 'package:sign_in_page_firebase/model/user.dart';
import 'package:sign_in_page_firebase/services/auth_base.dart';
import 'package:sign_in_page_firebase/services/fake_auth_service.dart';
import 'package:sign_in_page_firebase/services/firestore_db_service.dart';

enum AppMode { DEBUG, RELEASE }

// VERİLERİN VERİ TABANINDAN  YA DA BAŞKA YERLERDEN GETİRİLEREK BİRLEŞTİRİLMESİ YA DA DOĞRUDAN GERİ GÖNDERİLMESİ İŞLEMLERİ
//ullanıcı ile ilgili işlemlerin yapılacağı hangi kaynakların seçileceği ve gerekli mantıkların kurulacağı yer
//AuthBase deki metotların burada olması için imlement ediyoruz
class UserRepository implements AuthBase {
  //FirebaseAuthService _firebaseAuthService = locator<FirebaseAuthService>();
  FakeAuthenticationService _fakeAuthenticationService =
      locator<FakeAuthenticationService>();
  FireStoreDBService _firestoreDBService = locator<FireStoreDBService>();
  //FirebaseStorageService _firebaseStorageService = locator<FirebaseStorageService>();

  //AppMode appMode = AppMode.DEBUG;
  AppMode appMode = AppMode.RELEASE;
  List<User> tumKullaniciListesi = [];
  //List<Restoran> tumRestoranBilgilerimListesi = [];
  Map<String, String> kullaniciToken = Map<String, String>();

  //RestoranHesapOnayBelgeleri currentRestoranBelgeleri;

  @override
  Future<User> createUserRestoranWithEmailandPassword(
      String email, String sifre, int seviye) async {
    if (appMode == AppMode.DEBUG) {
      return await _fakeAuthenticationService.createUserWithFirstansLastName(
          email, sifre);
    }
  }

  @override
  Future<User> signInWithEmailandPassword(String email, String sifre) async {
    if (appMode == AppMode.DEBUG) {
      print("signInWithEmailandPassword");
      addData(email);
      return await _fakeAuthenticationService.signInWithEmailandPassword(
          email, sifre);
    }
  }

  Future<bool> addData(String email) async {
    if (appMode == AppMode.DEBUG) {
      //return true;
      print("addData");
      return _firestoreDBService.addData(email);
    } else {
      return _firestoreDBService.addData(email);
    }
  }

  @override
  Future<User> createUserWithFirstansLastName(
      String email, String sifre) async {
    if (appMode == AppMode.DEBUG) {
      print("signInWithEmailandPassword");
      await addData(email);
      return await _fakeAuthenticationService.signInWithEmailandPassword(
          email, sifre);
    }
  }
}
