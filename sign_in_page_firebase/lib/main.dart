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
        title: "Kampanya Bende",
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.purple,
        ),
        home: EmailveSifreLoginPage(),
      ),
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({Key key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final Firestore _firestore = Firestore.instance;
  //String errorMessage = "upper letters";
  String _firstname, _lastname;
  String errorMessage = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("First Page"),
      ),
      body: Center(
        child: Column(
          children: [
            TextFormField(
              //initialValue: "First name",
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                errorText: errorMessage != null ? errorMessage : null,
                prefixIcon: Icon(Icons.mail),
                hintText: "First name",
                labelText: "First name",
                border: OutlineInputBorder(),
              ),
              onSaved: (String girilenEmail) {
                _firstname = girilenEmail;
                print("girilen email kısmı " + _firstname);
              },
            ),
            RaisedButton(
              child: Text("Add Data"),
              color: Colors.deepPurple,
              onPressed: _formSubmit,
            ),
            RaisedButton(
              child: Text("Add Data"),
              color: Colors.deepPurple,
              onPressed: _addData,
            )
          ],
        ),
      ),
    );
  }

  void _formSubmit() {
    print("girşlen veri " + _firstname.toString());
  }

  void _errorMessage() {
    errorMessage = "eroros";
  }

  void _addData() {
    Map<String, dynamic> addUser = Map();
    addUser["name"] = "ersin2";
    addUser["surname"] = "aksar3";
    _firestore
        .collection("users")
        .document("ersin_aksar2")
        .setData(addUser)
        .then((value) => debugPrint("user added"));
  }
}
