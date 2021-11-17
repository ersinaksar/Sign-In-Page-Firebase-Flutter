//singletonları eklememiz lazım
import 'package:get_it/get_it.dart';
import 'package:sign_in_page_firebase/repository/user_repository.dart';
import 'package:sign_in_page_firebase/services/fake_auth_service.dart';
import 'package:sign_in_page_firebase/services/firestore_db_service.dart';

GetIt locator =
    GetIt(); //global locator nesnesi oluşturduk her yerden ulaşabilmek için

void setupLocator() {
  locator.registerLazySingleton(() => FakeAuthenticationService());
  locator.registerLazySingleton(() => FireStoreDBService());
  //locator.registerLazySingleton(() => FirebaseStorageService());
  locator.registerLazySingleton(() => UserRepository());
}
