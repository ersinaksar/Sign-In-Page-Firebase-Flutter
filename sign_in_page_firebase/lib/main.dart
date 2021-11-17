import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sign_in_page_firebase/app/sign_in/email_sifre_giris_ve_kayit.dart';
import 'package:sign_in_page_firebase/locator.dart';
import 'package:sign_in_page_firebase/viewmodel/user_model.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  setupLocator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => UserModel(), //Ağaca enjekte etmek istediğimiz ınıf
      child: MaterialApp(
        //Bu sınıfın kullanılacağı alt widgetları geçiyoruz
        title: "",
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.purple,
        ),
        home: EmailveSifreLoginPage(),
      ),
    );
  }
}
