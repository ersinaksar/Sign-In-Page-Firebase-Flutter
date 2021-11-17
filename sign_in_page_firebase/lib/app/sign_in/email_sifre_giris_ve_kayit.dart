import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:sign_in_page_firebase/app/hata_exception.dart';
import 'package:sign_in_page_firebase/common_widget/platform_duyarli_alert_dialog.dart';
import 'package:sign_in_page_firebase/common_widget/social_log_in_button.dart';
import 'package:sign_in_page_firebase/model/user.dart';
import 'package:sign_in_page_firebase/viewmodel/user_model.dart';

enum FormType { Register, LogIn }

class EmailveSifreLoginPage extends StatefulWidget {
  @override
  _EmailveSifreLoginPageState createState() => _EmailveSifreLoginPageState();
}

class _EmailveSifreLoginPageState extends State<EmailveSifreLoginPage> {
  String _firstname, _lastname;
  String _butonText, _linkText;
  var _formType = FormType.LogIn;
  final _formKey = GlobalKey<FormState>();
  final Firestore _firestore = Firestore.instance;
  String nameHataMesaji;
  String surnameHataMesaji;

  void _formSubmit() async {
    _formKey.currentState.save();
    //debugPrint("email : " + _email + "şifre: " + _sifre);
    final _userModel = Provider.of<UserModel>(context,
        listen:
            false); //burayı user modelimize erişmej için yapıyoruz //bunu yapma amacımız main de ağacmızın içine koyduğumuz nesneyi elde etmek

    if (_formType == FormType.LogIn) {
      try {
        print("user oluştur");
        print("First Name: " + _firstname);
        print("Last Name: " + _lastname);

        _addData(_firstname, _lastname);
        /*
        User _girisYapanUser =
            await _userModel.signInWithEmailandPassword(_firstname, _lastname);
        User _olusturulanUser = await _userModel.createUserWithFirstansLastName(
            _firstname, _lastname);
        if (_olusturulanUser != null)
          print("Oturm açan user id: " + _olusturulanUser.firstname.toString());
        */

      } on PlatformException catch (e) {
        PlatformDuyarliAlertDialog(
          baslik: "Kullanıcı Oluşturma Hata",
          icerik: Hatalar.goster(e.code),
          anaButonYazisi: "Tamam",
        ).goster(context);
      }
      var sonuc = _inputKontrol(_firstname, _lastname);
      print("sonuc: " + sonuc.toString());
      if (sonuc == false) {
        if (nameHataMesaji != null) {
          PlatformDuyarliAlertDialog(
            baslik: "Error while creating First Name",
            icerik: nameHataMesaji,
            anaButonYazisi: "Ok",
          ).goster(context);
        }
        if (surnameHataMesaji != null) {
          PlatformDuyarliAlertDialog(
            baslik: "Error while creating Last Name",
            icerik: surnameHataMesaji,
            anaButonYazisi: "Ok",
          ).goster(context);
        }
      }
      /*PlatformDuyarliAlertDialog(
        baslik: "Kullanıcı Oluşturma Hata",
        icerik: "Hatalar.goster(e.code)",
        anaButonYazisi: "Tamam",
      ).goster(context);*/
    }
  }

  bool _inputKontrol(String firstname, String lastname) {
    var sonuc = true;
    var name = validateStructure(firstname);
    var surname = validateStructure(lastname);
    if (name == false) {
      nameHataMesaji = "latin characters ONLY (lowercase and uppercase)";
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

  void _addData(_firstname, _lastname) {
    Map<String, dynamic> addUser = Map();
    addUser["name"] = _firstname;
    addUser["surname"] = _lastname;
    _firestore
        .collection("users")
        .document("user")
        .setData(addUser)
        .then((value) => debugPrint("user added"));
  }

  void _degistir() {
    setState(() {
      _formType =
          _formType == FormType.LogIn ? FormType.Register : FormType.LogIn;
    });
  }

  @override
  Widget build(BuildContext context) {
    //_butonText = _formType == FormType.LogIn ? "Giriş Yap " : "Kayıt Ol";
    //_linkText = _formType == FormType.LogIn ? "Hesabınız Yok Mu? Kayıt Olun" : "Hesabınız Var Mı? Giriş Yapın";

    final _userModel = Provider.of<UserModel>(context);

    if (_userModel.user != null) {
      Future.delayed(Duration(milliseconds: 1), () {
        Navigator.of(context).popUntil(ModalRoute.withName("/"));
      });
    }

    return Scaffold(
        appBar: AppBar(
          title: Text("One Page Application"),
        ),
        body: _userModel.state == ViewState.Idle
            ? SingleChildScrollView(
                //elemanlar ekrana sığmazsa aşağı yukarı gitmemizi sağlıyor
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: <Widget>[
                        TextFormField(
                          //initialValue: "First name",
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            errorText: _userModel.nameHataMesaji != null
                                ? _userModel.nameHataMesaji
                                : null,
                            prefixIcon: Icon(Icons.mail),
                            hintText: "First name",
                            labelText: "First name",
                            border: OutlineInputBorder(),
                          ),
                          onSaved: (String girilenEmail) {
                            _firstname = girilenEmail;
                          },
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        TextFormField(
                          //initialValue: "Last name",
                          decoration: InputDecoration(
                            errorText: _userModel.surnameHataMesaji != null
                                ? _userModel.surnameHataMesaji
                                : null,
                            prefixIcon: Icon(Icons.mail),
                            hintText: "Last name",
                            labelText: "Last name",
                            border: OutlineInputBorder(),
                          ),
                          onSaved: (String girilenSifre) {
                            _lastname = girilenSifre;
                          },
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        SocialLoginButton(
                          butonText: "Button",
                          butonColor: Theme.of(context).primaryColor,
                          radius: 10,
                          onPressed: () =>
                              _formSubmit(), //() => bu bu on prest tetiklendiği an bu _formSubmit(context) fonksiyonunu çalıştır demek
                        ),
                      ],
                    ),
                  ),
                ),
              )
            : Center(
                child: CircularProgressIndicator(),
              ));
  }
}
