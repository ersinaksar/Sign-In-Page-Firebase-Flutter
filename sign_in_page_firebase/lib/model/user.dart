import 'dart:math';
import 'package:flutter/cupertino.dart';

class User {
  String
      firstname; //final diye tanımlarsak illa olması gerekiyo ve değiştirlemez o yüzden profil fotosunu vs final tanımlamayacağız
  String lastname;

  //süslü parantez koyulunca isimlendşrilmiş constructer oluyor
  User({@required this.firstname, @required this.lastname});

  //sirestroe dan veri çekerkende okurkende maplaeri kullanıyoruz
  Map<String, dynamic> toMap() {
    //var olan nesneyi map e dönüştürüyuor
    return {
      "firstname": firstname,
      "lastname": lastname,
    };
  }

  //isimlendirilmiş constructor bize user nesenesi döndürüyor
  User.fromMap(Map<String, dynamic> map)
      : firstname = map["firstname"],
        lastname = map["lastname"];

  @override
  String toString() {
    return 'User{firstname: $firstname, lastname: $lastname}';
  }
}
