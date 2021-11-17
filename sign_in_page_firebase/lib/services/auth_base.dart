//abstract yapınca currentUser methodunun için yazamıyoruz şu anda belli değil abstract yapınca hata vermiyor methodumuzu soyut yapmış oluyoruz

import 'package:sign_in_page_firebase/model/user.dart';

abstract class AuthBase {
  //Future<User> currentUser(); //o anki kullanıcıyı alabileceğimiz bir methot
  Future<User> createUserWithFirstansLastName(String email, String sifre);
}
